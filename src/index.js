/**
 * ebook-donatjs-api
 * Backend microservice: Cloudflare Worker + D1
 *
 * Skenario:
 *  - Metadata ebook & link file (PDF disimpan di GitHub repo) ada di D1.
 *  - Preview bersifat publik (tidak perlu login).
 *  - Untuk download: wajib login Google, lalu isi doa/tanda-donasi (sukarela) via modal QRIS di FE.
 *  - Newsletter subscribe & kontak WA.
 *  - Config tampilan (teks halaman, dll) TIDAK di sini - itu ada di frontend/config.json (DonatJS-core).
 *    Worker ini hanya menyediakan data (ebooks, auth, downloads, subscribers).
 *
 * ENV yang dibutuhkan (wrangler secret put ...):
 *  - JWT_SECRET       : string acak panjang untuk menandatangani token sesi
 *  - GOOGLE_CLIENT_ID : OAuth Client ID dari Google Cloud Console
 * ENV vars biasa (wrangler.toml [vars]):
 *  - ALLOWED_ORIGIN   : origin frontend (mis. https://sismadi.github.io) untuk CORS
 */

const JSON_HEADERS = { "content-type": "application/json; charset=utf-8" };

function corsHeaders(env) {
  return {
    "Access-Control-Allow-Origin": env.ALLOWED_ORIGIN || "*",
    "Access-Control-Allow-Methods": "GET,POST,OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Max-Age": "86400",
  };
}

function json(data, status = 200, env) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { ...JSON_HEADERS, ...corsHeaders(env) },
  });
}

function err(message, status = 400, env) {
  return json({ error: message }, status, env);
}

function uid(prefix = "id") {
  return `${prefix}_${crypto.randomUUID().replace(/-/g, "").slice(0, 20)}`;
}

// ---------- JWT (HS256) helpers, tanpa dependency eksternal ----------
function b64url(bytes) {
  let str = btoa(String.fromCharCode(...new Uint8Array(bytes)));
  return str.replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}
function b64urlToBytes(b64) {
  b64 = b64.replace(/-/g, "+").replace(/_/g, "/");
  while (b64.length % 4) b64 += "=";
  const bin = atob(b64);
  const bytes = new Uint8Array(bin.length);
  for (let i = 0; i < bin.length; i++) bytes[i] = bin.charCodeAt(i);
  return bytes;
}
function textToBytes(str) {
  return new TextEncoder().encode(str);
}
async function hmacKey(secret) {
  return crypto.subtle.importKey(
    "raw",
    textToBytes(secret),
    { name: "HMAC", hash: "SHA-256" },
    false,
    ["sign", "verify"]
  );
}
async function signJwt(payload, secret, expiresInSec = 7 * 24 * 3600) {
  const header = { alg: "HS256", typ: "JWT" };
  const now = Math.floor(Date.now() / 1000);
  const fullPayload = { ...payload, iat: now, exp: now + expiresInSec };
  const encHeader = b64url(textToBytes(JSON.stringify(header)));
  const encPayload = b64url(textToBytes(JSON.stringify(fullPayload)));
  const signingInput = `${encHeader}.${encPayload}`;
  const key = await hmacKey(secret);
  const sig = await crypto.subtle.sign("HMAC", key, textToBytes(signingInput));
  const encSig = b64url(sig);
  return `${signingInput}.${encSig}`;
}
async function verifyJwt(token, secret) {
  const parts = token.split(".");
  if (parts.length !== 3) throw new Error("Token tidak valid");
  const [encHeader, encPayload, encSig] = parts;
  const signingInput = `${encHeader}.${encPayload}`;
  const key = await hmacKey(secret);
  const valid = await crypto.subtle.verify(
    "HMAC",
    key,
    b64urlToBytes(encSig),
    textToBytes(signingInput)
  );
  if (!valid) throw new Error("Tanda tangan token tidak valid");
  const payload = JSON.parse(new TextDecoder().decode(b64urlToBytes(encPayload)));
  if (payload.exp && Math.floor(Date.now() / 1000) > payload.exp) {
    throw new Error("Token kadaluarsa");
  }
  return payload;
}

async function requireAuth(request, env) {
  const authHeader = request.headers.get("Authorization") || "";
  const token = authHeader.startsWith("Bearer ") ? authHeader.slice(7) : null;
  if (!token) throw new Error("NO_TOKEN");
  const payload = await verifyJwt(token, env.JWT_SECRET);
  return payload; // { sub: userId, email, name }
}

// ---------- Verifikasi Google ID Token ----------
// Menggunakan endpoint tokeninfo Google (cukup untuk skala kecil-menengah,
// tanpa perlu implementasi verifikasi JWK/RS256 manual di Worker).
async function verifyGoogleIdToken(idToken, googleClientId) {
  const expectedClientId = String(googleClientId || "").trim();
  if (!expectedClientId) {
    throw new Error(
      "GOOGLE_CLIENT_ID belum di-set di Worker ini (env kosong). Jalankan: wrangler secret put GOOGLE_CLIENT_ID"
    );
  }
  const resp = await fetch(
    `https://oauth2.googleapis.com/tokeninfo?id_token=${encodeURIComponent(idToken)}`
  );
  if (!resp.ok) throw new Error("Token Google tidak valid");
  const data = await resp.json();
  const tokenAud = String(data.aud || "").trim();
  if (tokenAud !== expectedClientId) {
    throw new Error(
      `Client ID tidak cocok (aud token: "${tokenAud.slice(0, 12)}...", diharapkan: "${expectedClientId.slice(0, 12)}...")`
    );
  }
  const now = Math.floor(Date.now() / 1000);
  if (Number(data.exp) < now) throw new Error("Token Google kadaluarsa");
  return {
    sub: data.sub,
    email: data.email,
    name: data.name || data.email,
    picture: data.picture || "",
  };
}

// ---------- Route handlers ----------

async function handleListEbooks(request, env) {
  const url = new URL(request.url);
  const q = (url.searchParams.get("q") || "").trim();
  let stmt;
  if (q) {
    stmt = env.DB.prepare(
      `SELECT id, slug, title, author, description, cover_url, preview_url, pages, tags
       FROM ebooks WHERE published = 1 AND (title LIKE ?1 OR author LIKE ?1 OR tags LIKE ?1)
       ORDER BY created_at DESC`
    ).bind(`%${q}%`);
  } else {
    stmt = env.DB.prepare(
      `SELECT id, slug, title, author, description, cover_url, preview_url, pages, tags
       FROM ebooks WHERE published = 1 ORDER BY created_at DESC`
    );
  }
  const { results } = await stmt.all();
  return json({ ebooks: results }, 200, env);
}

async function handleGetEbook(slug, env) {
  const row = await env.DB.prepare(
    `SELECT id, slug, title, author, description, cover_url, preview_url, pages, tags
     FROM ebooks WHERE slug = ?1 AND published = 1`
  )
    .bind(slug)
    .first();
  if (!row) return err("Ebook tidak ditemukan", 404, env);
  return json({ ebook: row }, 200, env);
}

async function handleGoogleAuth(request, env) {
  const body = await request.json().catch(() => null);
  if (!body || !body.id_token) return err("id_token wajib diisi", 400, env);

  let profile;
  try {
    profile = await verifyGoogleIdToken(body.id_token, env.GOOGLE_CLIENT_ID);
  } catch (e) {
    return err(`Autentikasi Google gagal: ${e.message}`, 401, env);
  }

  let user = await env.DB.prepare(`SELECT * FROM users WHERE google_sub = ?1`)
    .bind(profile.sub)
    .first();

  if (!user) {
    const id = uid("usr");
    await env.DB.prepare(
      `INSERT INTO users (id, google_sub, email, name, picture) VALUES (?1,?2,?3,?4,?5)`
    )
      .bind(id, profile.sub, profile.email, profile.name, profile.picture)
      .run();
    user = { id, google_sub: profile.sub, email: profile.email, name: profile.name, picture: profile.picture };
  } else {
    await env.DB.prepare(
      `UPDATE users SET name = ?2, picture = ?3, email = ?4 WHERE id = ?1`
    )
      .bind(user.id, profile.name, profile.picture, profile.email)
      .run();
  }

  const token = await signJwt({ sub: user.id, email: user.email, name: user.name }, env.JWT_SECRET);
  return json({ token, user: { id: user.id, email: user.email, name: user.name, picture: user.picture } }, 200, env);
}

async function handleMe(request, env) {
  try {
    const payload = await requireAuth(request, env);
    return json({ user: { id: payload.sub, email: payload.email, name: payload.name } }, 200, env);
  } catch (e) {
    return err("Belum login / token tidak valid", 401, env);
  }
}

async function handleDownload(slug, request, env) {
  let payload;
  try {
    payload = await requireAuth(request, env);
  } catch (e) {
    return err("Silakan login dengan Google terlebih dahulu untuk mengunduh.", 401, env);
  }

  const ebook = await env.DB.prepare(
    `SELECT id, slug, title, pdf_url FROM ebooks WHERE slug = ?1 AND published = 1`
  )
    .bind(slug)
    .first();
  if (!ebook) return err("Ebook tidak ditemukan", 404, env);

  const body = await request.json().catch(() => ({}));
  const doaText = (body.doa_text || "").trim();
  const donationNote = (body.donation_note || "").trim();

  // Donasi bersifat sukarela: kita tidak memblokir unduhan berdasarkan status bayar,
  // cukup mencatat niat baik pengguna (doa dan/atau catatan donasi) sebagai jejak.
  await env.DB.prepare(
    `INSERT INTO downloads (id, user_id, ebook_id, doa_text, donation_note) VALUES (?1,?2,?3,?4,?5)`
  )
    .bind(uid("dl"), payload.sub, ebook.id, doaText || null, donationNote || null)
    .run();

  return json({ download_url: ebook.pdf_url, title: ebook.title }, 200, env);
}

async function handleSubscribe(request, env) {
  const body = await request.json().catch(() => null);
  if (!body || !body.email) return err("Email wajib diisi", 400, env);
  const email = String(body.email).trim().toLowerCase();
  const name = (body.name || "").trim();
  const whatsapp = (body.whatsapp || "").trim();
  const source = (body.source || "").trim();

  try {
    await env.DB.prepare(
      `INSERT INTO subscribers (id, email, name, whatsapp, source) VALUES (?1,?2,?3,?4,?5)
       ON CONFLICT(email) DO UPDATE SET name = excluded.name, whatsapp = excluded.whatsapp`
    )
      .bind(uid("sub"), email, name, whatsapp, source)
      .run();
  } catch (e) {
    return err("Gagal menyimpan langganan", 500, env);
  }
  return json({ ok: true }, 200, env);
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    const { pathname } = url;
    const method = request.method;

    if (method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders(env) });
    }

    try {
      if (pathname === "/api/ebooks" && method === "GET") {
        return await handleListEbooks(request, env);
      }

      const ebookDetailMatch = pathname.match(/^\/api\/ebooks\/([^/]+)$/);
      if (ebookDetailMatch && method === "GET") {
        return await handleGetEbook(decodeURIComponent(ebookDetailMatch[1]), env);
      }

      const downloadMatch = pathname.match(/^\/api\/ebooks\/([^/]+)\/download$/);
      if (downloadMatch && method === "POST") {
        return await handleDownload(decodeURIComponent(downloadMatch[1]), request, env);
      }

      if (pathname === "/api/auth/google" && method === "POST") {
        return await handleGoogleAuth(request, env);
      }

      if (pathname === "/api/me" && method === "GET") {
        return await handleMe(request, env);
      }

      if (pathname === "/api/subscribe" && method === "POST") {
        return await handleSubscribe(request, env);
      }

      return err("Not found", 404, env);
    } catch (e) {
      return err(`Internal error: ${e.message}`, 500, env);
    }
  },
};
