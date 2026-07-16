-- Schema: ebook-donatjs-db
-- Jalankan: wrangler d1 execute ebook-donatjs-db --file=./schema.sql

CREATE TABLE IF NOT EXISTS users (
  id          TEXT PRIMARY KEY,
  google_sub  TEXT UNIQUE NOT NULL,
  email       TEXT NOT NULL,
  name        TEXT,
  picture     TEXT,
  created_at  TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ebooks (
  id           TEXT PRIMARY KEY,
  slug         TEXT UNIQUE NOT NULL,
  title        TEXT NOT NULL,
  author       TEXT,
  description  TEXT,
  cover_url    TEXT,
  pdf_url      TEXT NOT NULL,      -- link file penuh (raw GitHub / release asset)
  preview_url  TEXT,               -- link file preview (opsional, beberapa halaman awal)
  pages        INTEGER,
  tags         TEXT,               -- JSON array string, mis: ["fikih","doa"]
  published    INTEGER DEFAULT 1,
  created_at   TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS downloads (
  id             TEXT PRIMARY KEY,
  user_id        TEXT NOT NULL REFERENCES users(id),
  ebook_id       TEXT NOT NULL REFERENCES ebooks(id),
  doa_text       TEXT,             -- doa/harapan baik yang ditulis pengguna
  donation_note  TEXT,             -- catatan donasi (mis. "sudah scan QRIS", nominal, dsb - self-reported)
  created_at     TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS subscribers (
  id           TEXT PRIMARY KEY,
  email        TEXT UNIQUE NOT NULL,
  name         TEXT,
  whatsapp     TEXT,
  source       TEXT,               -- mis: "ebook_detail:slug-xxx"
  created_at   TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_ebooks_slug ON ebooks(slug);
CREATE INDEX IF NOT EXISTS idx_downloads_user ON downloads(user_id);
CREATE INDEX IF NOT EXISTS idx_downloads_ebook ON downloads(ebook_id);
CREATE INDEX IF NOT EXISTS idx_subscribers_email ON subscribers(email);
