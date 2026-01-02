-- Sistem Manajemen Mahasiswa
-- Script untuk update tabel jurusan dengan kolom baru

-- Tambahkan kolom kode_jurusan jika belum ada
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'jurusan' AND column_name = 'kode_jurusan') THEN
        ALTER TABLE jurusan ADD COLUMN kode_jurusan VARCHAR(10);
    END IF;
END $$;

-- Tambahkan kolom jenjang jika belum ada
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'jurusan' AND column_name = 'jenjang') THEN
        ALTER TABLE jurusan ADD COLUMN jenjang VARCHAR(10) DEFAULT 'S1';
    END IF;
END $$;

-- Update akreditasi constraint menjadi VARCHAR untuk mendukung nilai seperti 'Unggul', 'Baik Sekali', dll
ALTER TABLE jurusan ALTER COLUMN akreditasi TYPE VARCHAR(20);

-- Update data jurusan yang sudah ada dengan kode
UPDATE jurusan SET kode_jurusan = 'TI' WHERE nama_jurusan ILIKE '%Teknik Informatika%' AND kode_jurusan IS NULL;
UPDATE jurusan SET kode_jurusan = 'SI' WHERE nama_jurusan ILIKE '%Sistem Informasi%' AND kode_jurusan IS NULL;
UPDATE jurusan SET kode_jurusan = 'BD' WHERE nama_jurusan ILIKE '%Bisnis Digital%' AND kode_jurusan IS NULL;
UPDATE jurusan SET kode_jurusan = 'TK' WHERE nama_jurusan ILIKE '%Teknik Komputer%' AND kode_jurusan IS NULL;

-- Set default jenjang untuk data yang sudah ada
UPDATE jurusan SET jenjang = 'S1' WHERE jenjang IS NULL;

-- Tambahkan kolom ke tabel fakultas jika belum ada
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'fakultas' AND column_name = 'kode_fakultas') THEN
        ALTER TABLE fakultas ADD COLUMN kode_fakultas VARCHAR(10);
    END IF;
END $$;

-- Update kode fakultas
UPDATE fakultas SET kode_fakultas = 'FT' WHERE nama_fakultas ILIKE '%Teknik%' AND kode_fakultas IS NULL;
UPDATE fakultas SET kode_fakultas = 'FE' WHERE nama_fakultas ILIKE '%Ekonomi%' AND kode_fakultas IS NULL;
UPDATE fakultas SET kode_fakultas = 'FMIPA' WHERE nama_fakultas ILIKE '%MIPA%' AND kode_fakultas IS NULL;

-- Commit changes
COMMIT;
