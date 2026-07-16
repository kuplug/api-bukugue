-- Contoh data ebook. Ganti pdf_url dengan raw.githubusercontent.com link ke file PDF di repo GitHub-mu.
-- Contoh format raw link:
-- https://raw.githubusercontent.com/sismadi/ebook-files/main/buku-satu.pdf

INSERT INTO ebooks (id, slug, title, author, description, cover_url, pdf_url, preview_url, pages, tags, published)
VALUES
(
  'ebk_001',
  'strategi-catur-pemula',
  'Strategi Catur untuk Pemula',
  'Wawan',
  'Panduan dasar memahami pembukaan, taktik, dan filosofi permainan catur untuk pemula.',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/covers/catur-pemula.png',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/full/strategi-catur-pemula.pdf',
  'https://raw.githubusercontent.com/sismadi/ebook-files/main/preview/strategi-catur-pemula-preview.pdf',
  84,
  '["catur","strategi","pemula"]',
  1
);
