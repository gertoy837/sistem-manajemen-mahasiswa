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

-- Insert default admin user
INSERT INTO users (username, password, nama_lengkap, email, role) VALUES
('admin', 'admin123', 'Administrator', 'admin@universitas.ac.id', 'admin'),
('staff', 'staff123', 'Staff Akademik', 'staff@universitas.ac.id', 'staff');
