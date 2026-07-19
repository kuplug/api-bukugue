-- seed-inibukugue.sql
-- Konten tambahan untuk "Perpustakaan Kehidupan" (tema inibukugue.com).
-- TIDAK mengubah schema.sql maupun src/index.js — hanya menambah baris data
-- ke tabel `ebooks` yang sudah ada, memakai kolom `tags` (JSON array) supaya
-- cocok dengan pencocokan mood/quiz di frontend (lihat app-bukugue/config.json).
--
-- Jalankan setelah schema.sql & seed.sql:
--   wrangler d1 execute ebook-donatjs-db --file=./seed-inibukugue.sql
--
-- Ganti cover_url / pdf_url / preview_url dengan link raw.githubusercontent.com
-- ke file asli begitu naskah & cover sudah siap.

INSERT INTO ebooks (id, slug, title, author, description, cover_url, pdf_url, preview_url, pages, tags, published)
VALUES
(
  'ebk_101', 'lelah-tapi-harus-terus-jalan', 'Lelah Tapi Harus Terus Jalan', 'Tim inibukugue',
  'Untuk kamu yang capek tapi belum boleh berhenti. Bacaan pendek soal mengakui rasa lelah tanpa merasa gagal.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/lelah-tapi-harus-terus-jalan.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/lelah-tapi-harus-terus-jalan.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/lelah-tapi-harus-terus-jalan-preview.pdf',
  46, '["lelah","burnout","capek","istirahat"]', 1
),
(
  'ebk_102', 'berhenti-sejenak-tidak-apa', 'Berhenti Sejenak, Nggak Apa-Apa', 'Tim inibukugue',
  'Istirahat bukan tanda kalah. Bacaan reflektif untuk yang butuh izin buat jeda sebentar.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/berhenti-sejenak-tidak-apa.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/berhenti-sejenak-tidak-apa.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/berhenti-sejenak-tidak-apa-preview.pdf',
  38, '["lelah","istirahat","self-growth"]', 1
),
(
  'ebk_103', 'tenang-saat-pikiran-berisik', 'Tenang Saat Pikiran Berisik', 'Tim inibukugue',
  'Untuk kamu yang overthinking sampai susah tidur. Latihan kecil menenangkan pikiran yang terus berputar.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/tenang-saat-pikiran-berisik.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/tenang-saat-pikiran-berisik.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/tenang-saat-pikiran-berisik-preview.pdf',
  52, '["cemas","overthinking","anxiety"]', 1
),
(
  'ebk_104', 'besok-belum-tentu-seburuk-itu', 'Besok Belum Tentu Seburuk Itu', 'Tim inibukugue',
  'Khawatir soal masa depan itu wajar. Ini bacaan yang membantumu melihatnya lebih tenang.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/besok-belum-tentu-seburuk-itu.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/besok-belum-tentu-seburuk-itu.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/besok-belum-tentu-seburuk-itu-preview.pdf',
  41, '["cemas","khawatir","masa-depan"]', 1
),
(
  'ebk_105', 'berdamai-dengan-masa-lalu', 'Berdamai dengan Masa Lalu', 'Tim inibukugue',
  'Luka tidak selalu terlihat. Bacaan ini menemani proses berdamai, sedikit demi sedikit.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/berdamai-dengan-masa-lalu.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/berdamai-dengan-masa-lalu.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/berdamai-dengan-masa-lalu-preview.pdf',
  58, '["luka","trauma","kehilangan"]', 1
),
(
  'ebk_106', 'memaafkan-tanpa-melupakan', 'Memaafkan Tanpa Melupakan', 'Tim inibukugue',
  'Memaafkan bukan berarti pura-pura tidak terjadi apa-apa. Bacaan soal memaafkan dengan jujur.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/memaafkan-tanpa-melupakan.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/memaafkan-tanpa-melupakan.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/memaafkan-tanpa-melupakan-preview.pdf',
  49, '["luka","patah-hati","hubungan"]', 1
),
(
  'ebk_107', 'mengapa-allah-mengizinkan-keluargaku-seperti-ini', 'Mengapa Allah Mengizinkan Keluargaku Seperti Ini?', 'Tim inibukugue',
  'Untuk yang tumbuh dari keluarga yang tidak sempurna. Mencari makna tanpa menyalahkan siapa pun.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/mengapa-allah-mengizinkan-keluargaku-seperti-ini.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/mengapa-allah-mengizinkan-keluargaku-seperti-ini.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/mengapa-allah-mengizinkan-keluargaku-seperti-ini-preview.pdf',
  63, '["luka","broken-home","keluarga","iman"]', 1
),
(
  'ebk_108', 'allah-tidak-pernah-membuangmu', 'Allah Tidak Pernah Membuangmu', 'Tim inibukugue',
  'Saat merasa jauh dan sendirian, bacaan ini mengingatkan bahwa kamu tidak pernah benar-benar ditinggalkan.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/allah-tidak-pernah-membuangmu.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/allah-tidak-pernah-membuangmu.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/allah-tidak-pernah-membuangmu-preview.pdf',
  44, '["iman","spiritual","luka"]', 1
),
(
  'ebk_109', 'dekat-lagi-sedikit-demi-sedikit', 'Dekat Lagi, Sedikit demi Sedikit', 'Tim inibukugue',
  'Mendekat itu proses, bukan garis finis. Langkah-langkah kecil memperbaiki hubungan dengan Allah.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/dekat-lagi-sedikit-demi-sedikit.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/dekat-lagi-sedikit-demi-sedikit.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/dekat-lagi-sedikit-demi-sedikit-preview.pdf',
  55, '["iman","ibadah","doa","hijrah"]', 1
),
(
  'ebk_110', 'tuhan-kenapa-hidupku-gini-gini-aja', 'Tuhan, Kenapa Hidupku Gini-Gini Aja?', 'Tim inibukugue',
  'Untuk yang merasa hidupnya jalan di tempat. Mencari makna di tengah rasa hampa.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/tuhan-kenapa-hidupku-gini-gini-aja.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/tuhan-kenapa-hidupku-gini-gini-aja.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/tuhan-kenapa-hidupku-gini-gini-aja-preview.pdf',
  40, '["arah","tujuan-hidup","hampa"]', 1
),
(
  'ebk_111', 'peta-kecil-untuk-yang-tersesat', 'Peta Kecil untuk yang Tersesat', 'Tim inibukugue',
  'Nggak tahu harus mulai dari mana itu wajar. Ini titik awal yang sederhana.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/peta-kecil-untuk-yang-tersesat.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/peta-kecil-untuk-yang-tersesat.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/peta-kecil-untuk-yang-tersesat-preview.pdf',
  47, '["arah","kebingungan","self-growth"]', 1
),
(
  'ebk_112', 'khawatir-masa-depan-baca-buku-ini', 'Khawatir Masa Depan? Baca Buku Ini', 'Tim inibukugue',
  'Belum punya jawaban soal karier itu bukan berarti tertinggal. Bacaan soal karier dan masa depan.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/khawatir-masa-depan-baca-buku-ini.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/khawatir-masa-depan-baca-buku-ini.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/khawatir-masa-depan-baca-buku-ini-preview.pdf',
  50, '["karier","masa-depan","kuliah","khawatir"]', 1
),
(
  'ebk_113', 'gagal-itu-bukan-akhir', 'Gagal Itu Bukan Akhir', 'Tim inibukugue',
  'Kegagalan terasa berat, tapi bukan titik akhir cerita. Bacaan soal bangkit dari kegagalan karier.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/gagal-itu-bukan-akhir.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/gagal-itu-bukan-akhir.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/gagal-itu-bukan-akhir-preview.pdf',
  43, '["karier","kerja","kepercayaan-diri"]', 1
),
(
  'ebk_114', 'mencintai-diri-sendiri-dulu-yuk', 'Mencintai Diri Sendiri Dulu, Yuk!', 'Tim inibukugue',
  'Sebelum sibuk memenuhi ekspektasi orang lain, coba kenali dan terima dirimu dulu.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/mencintai-diri-sendiri-dulu-yuk.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/mencintai-diri-sendiri-dulu-yuk.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/mencintai-diri-sendiri-dulu-yuk-preview.pdf',
  45, '["self-growth","kepercayaan-diri","insecure","minder"]', 1
),
(
  'ebk_115', 'berhenti-membandingkan-diri', 'Berhenti Membandingkan Diri', 'Tim inibukugue',
  'Media sosial bikin gampang minder. Bacaan soal keluar dari kebiasaan membandingkan diri.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/berhenti-membandingkan-diri.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/berhenti-membandingkan-diri.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/berhenti-membandingkan-diri-preview.pdf',
  39, '["insecure","minder","self-growth"]', 1
),
(
  'ebk_116', 'rasulullah-adalah-role-model-gen-z', 'Rasulullah Adalah Role Model Gen Z', 'Tim inibukugue',
  'Keteladanan yang relevan lintas zaman. Membaca kembali akhlak Rasulullah dari sudut pandang Gen Z.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/rasulullah-adalah-role-model-gen-z.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/rasulullah-adalah-role-model-gen-z.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/rasulullah-adalah-role-model-gen-z-preview.pdf',
  67, '["iman","self-growth","arah"]', 1
),
(
  'ebk_117', 'mengelola-uang-tanpa-cemas', 'Mengelola Uang Tanpa Cemas', 'Tim inibukugue',
  'Urusan uang memang bikin kepala penuh. Dasar-dasar mengelola keuangan tanpa panik.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/mengelola-uang-tanpa-cemas.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/mengelola-uang-tanpa-cemas.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/mengelola-uang-tanpa-cemas-preview.pdf',
  56, '["uang","keuangan","rezeki","produktivitas"]', 1
),
(
  'ebk_118', 'tenang-soal-rezeki', 'Tenang Soal Rezeki', 'Tim inibukugue',
  'Menenangkan hati soal rezeki tanpa berhenti berikhtiar. Bacaan singkat soal uang dan ketenangan.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/tenang-soal-rezeki.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/tenang-soal-rezeki.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/tenang-soal-rezeki-preview.pdf',
  35, '["uang","rezeki","iman"]', 1
),
(
  'ebk_119', 'belajar-jadi-orang-tua-yang-cukup-baik', 'Belajar Jadi Orang Tua yang Cukup Baik', 'Tim inibukugue',
  'Nggak perlu langsung sempurna. Bacaan untuk yang sedang belajar jadi orang tua.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/belajar-jadi-orang-tua-yang-cukup-baik.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/belajar-jadi-orang-tua-yang-cukup-baik.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/belajar-jadi-orang-tua-yang-cukup-baik-preview.pdf',
  61, '["parenting","keluarga","anak"]', 1
),
(
  'ebk_120', 'pernikahan-bukan-cerita-sempurna', 'Pernikahan Bukan Cerita Sempurna', 'Tim inibukugue',
  'Pernikahan itu proses dua orang belajar bersama, bukan dongeng tanpa masalah.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/pernikahan-bukan-cerita-sempurna.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/pernikahan-bukan-cerita-sempurna.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/pernikahan-bukan-cerita-sempurna-preview.pdf',
  53, '["pernikahan","hubungan","keluarga"]', 1
),
(
  'ebk_121', 'sahabat-yang-perlahan-menjauh', 'Sahabat yang Perlahan Menjauh', 'Tim inibukugue',
  'Kehilangan sahabat tanpa perpisahan yang jelas itu nyata dan sah untuk disedihkan.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/sahabat-yang-perlahan-menjauh.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/sahabat-yang-perlahan-menjauh.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/sahabat-yang-perlahan-menjauh-preview.pdf',
  37, '["persahabatan","hubungan","kehilangan"]', 1
);
