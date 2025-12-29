-- Sistem Manajemen Mahasiswa
-- Database: manajemen_mahasiswa

-- Drop existing tables if they exist (reverse order due to foreign keys)
DROP TABLE IF EXISTS mata_kuliah CASCADE;
DROP TABLE IF EXISTS mahasiswa CASCADE;
DROP TABLE IF EXISTS dosen CASCADE;
DROP TABLE IF EXISTS jurusan CASCADE;
DROP TABLE IF EXISTS fakultas CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- 0. Tabel Users (untuk login)
CREATE TABLE users (
    id_user SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100),
    email VARCHAR(100),
    role VARCHAR(20) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin user
INSERT INTO users (username, password, nama_lengkap, email, role) VALUES
('admin', 'admin123', 'Administrator', 'admin@universitas.ac.id', 'admin'),
('staff', 'staff123', 'Staff Akademik', 'staff@universitas.ac.id', 'staff');

-- 1. Tabel Fakultas
CREATE TABLE fakultas (
    id_fakultas SERIAL PRIMARY KEY,
    nama_fakultas VARCHAR(100) NOT NULL,
    dekan VARCHAR(100),
    tahun_berdiri INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabel Jurusan
CREATE TABLE jurusan (
    id_jurusan SERIAL PRIMARY KEY,
    id_fakultas INTEGER REFERENCES fakultas(id_fakultas) ON DELETE CASCADE,
    nama_jurusan VARCHAR(100) NOT NULL,
    ketua_jurusan VARCHAR(100),
    akreditasi CHAR(1) CHECK (akreditasi IN ('A', 'B', 'C')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabel Dosen
CREATE TABLE dosen (
    id_dosen SERIAL PRIMARY KEY,
    id_jurusan INTEGER REFERENCES jurusan(id_jurusan) ON DELETE CASCADE,
    nip VARCHAR(20) UNIQUE NOT NULL,
    nama_dosen VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telepon VARCHAR(15),
    alamat TEXT,
    jenis_kelamin CHAR(1) CHECK (jenis_kelamin IN ('L', 'P')),
    tanggal_lahir DATE,
    pendidikan_terakhir VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Tabel Mahasiswa
CREATE TABLE mahasiswa (
    id_mahasiswa SERIAL PRIMARY KEY,
    id_jurusan INTEGER REFERENCES jurusan(id_jurusan) ON DELETE CASCADE,
    id_dosen INTEGER REFERENCES dosen(id_dosen), -- Dosen Pembimbing Akademik
    nim VARCHAR(20) UNIQUE NOT NULL,
    nama_mahasiswa VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telepon VARCHAR(15),
    alamat TEXT,
    jenis_kelamin CHAR(1) CHECK (jenis_kelamin IN ('L', 'P')),
    tanggal_lahir DATE,
    tahun_masuk INTEGER,
    semester_aktif INTEGER DEFAULT 1,
    ipk DECIMAL(3,2) DEFAULT 0.00,
    status VARCHAR(20) DEFAULT 'Aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Tabel Mata Kuliah
CREATE TABLE mata_kuliah (
    id_matakuliah SERIAL PRIMARY KEY,
    id_jurusan INTEGER REFERENCES jurusan(id_jurusan) ON DELETE CASCADE,
    id_dosen INTEGER REFERENCES dosen(id_dosen), -- Dosen Pengampu
    kode_matakuliah VARCHAR(10) UNIQUE NOT NULL,
    nama_matakuliah VARCHAR(100) NOT NULL,
    sks INTEGER NOT NULL,
    semester INTEGER,
    jenis VARCHAR(20) DEFAULT 'Wajib', -- Wajib/Pilihan
    deskripsi TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel Users untuk Login
DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
    id_user SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100),
    email VARCHAR(100),
    role VARCHAR(20) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Data Sample
INSERT INTO fakultas (nama_fakultas, dekan, tahun_berdiri) VALUES
('Fakultas Teknik', 'Dr. Ahmad Susanto, M.T.', 2005),
('Fakultas Ekonomi', 'Prof. Dr. Siti Nurhaliza, S.E., M.M.', 2003),
('Fakultas MIPA', 'Dr. Bambang Wijaya, M.Si.', 2008)
ON CONFLICT DO NOTHING;

INSERT INTO jurusan (id_fakultas, nama_jurusan, ketua_jurusan, akreditasi) VALUES
(1, 'Teknik Informatika', 'Dr. Ir. Budi Santoso, M.T.', 'A'),
(1, 'Sistem Informasi', 'Dr. Maya Sari, M.Kom.', 'A'),
(1, 'Bisnis Digital', 'Dr. Andi Pratama, M.M.', 'A')
ON CONFLICT DO NOTHING;

INSERT INTO dosen (id_jurusan, nip, nama_dosen, email, telepon, jenis_kelamin, pendidikan_terakhir) VALUES
(1, '123456789', 'Dr. Ir. Budi Santoso, M.T.', 'budi.santoso@univ.ac.id', '081234567890', 'L', 'S3 Teknik Informatika'),
(2, '123456790', 'Dr. Maya Sari, M.Kom.', 'maya.sari@univ.ac.id', '081234567891', 'P', 'S3 Sistem Informasi'),
(3, '123456791', 'Dr. Andi Pratama, M.M.', 'andi.pratama@univ.ac.id', '081234567892', 'L', 'S3 Bisnis Digital')
ON CONFLICT (nip) DO NOTHING;

INSERT INTO mahasiswa (id_jurusan, id_dosen, nim, nama_mahasiswa, email, telepon, jenis_kelamin, tahun_masuk, semester_aktif) VALUES
(1, 1, '2021001', 'Rizki Pratama', 'rizki.pratama@student.univ.ac.id', '081234567893', 'L', 2021, 7),
(2, 2, '2021002', 'Sari Indah', 'sari.indah@student.univ.ac.id', '081234567894', 'P', 2021, 7),
(3, 3, '2022001', 'Andi Wijaya', 'andi.wijaya@student.univ.ac.id', '081234567895', 'L', 2022, 5),
(1, 1, '2022002', 'Dewi Lestari', 'dewi.lestari@student.univ.ac.id', '081234567896', 'P', 2022, 5),
(2, 2, '2023001', 'Ahmad Fauzi', 'ahmad.fauzi@student.univ.ac.id', '081234567897', 'L', 2023, 3),
(3, 3, '2023002', 'Maya Putri', 'maya.putri@student.univ.ac.id', '081234567898', 'P', 2023, 3)
ON CONFLICT (nim) DO NOTHING;

INSERT INTO mata_kuliah (id_jurusan, id_dosen, kode_matakuliah, nama_matakuliah, sks, semester) VALUES
(1, 1, 'TIF101', 'Algoritma dan Pemrograman', 3, 1),
(1, 1, 'TIF102', 'Struktur Data', 3, 2),
(1, 2, 'TIF201', 'Basis Data', 3, 3),
(1, 2, 'TIF202', 'Pemrograman Web', 3, 4)
ON CONFLICT (kode_matakuliah) DO NOTHING;

-- Insert default admin user
INSERT INTO users (username, password, nama_lengkap, email, role) VALUES
('admin', 'admin123', 'Administrator', 'admin@universitas.ac.id', 'admin'),
('staff', 'staff123', 'Staff Akademik', 'staff@universitas.ac.id', 'staff');
