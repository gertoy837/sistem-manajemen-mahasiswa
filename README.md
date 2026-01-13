# UniManage - Sistem Manajemen Mahasiswa

![Java](https://img.shields.io/badge/Java-17-orange)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)
![Tomcat](https://img.shields.io/badge/Tomcat-10-red)

Sistem Manajemen Mahasiswa berbasis web yang dikembangkan sebagai proyek tugas akhir mata kuliah **Pemrograman Berorientasi Objek (PBO)** Semester 3.

## 📋 Deskripsi

UniManage adalah aplikasi web untuk mengelola data akademik universitas meliputi:
- Manajemen data mahasiswa
- Manajemen mata kuliah
- Manajemen jurusan dan fakultas
- Dashboard dengan statistik dan visualisasi data

## 🚀 Fitur Utama

- ✅ **CRUD Mahasiswa** - Tambah, lihat, edit, dan hapus data mahasiswa
- ✅ **CRUD Mata Kuliah** - Kelola mata kuliah dengan SKS dan semester
- ✅ **CRUD Jurusan** - Kelola jurusan dan akreditasi
- ✅ **Dashboard Interaktif** - Statistik dan grafik menggunakan Chart.js
- ✅ **Pencarian** - Fitur pencarian data yang responsif
- ✅ **Autentikasi** - Sistem login untuk keamanan data
- ✅ **Responsive Design** - Tampilan yang responsif menggunakan Bootstrap 5

## 🛠️ Technology Stack

| Teknologi | Versi | Keterangan |
|-----------|-------|------------|
| Java | 17 | Backend & Servlet |
| Jakarta EE | 10 | Enterprise Edition |
| PostgreSQL | 15+ | Database |
| Apache Tomcat | 10.1 | Web Server |
| Bootstrap | 5.3 | Frontend Framework |
| Chart.js | 4.x | Visualisasi Data |
| Maven | 3.9+ | Build Tool |

## 📁 Struktur Proyek

```
manajemen-mahasiswa/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/universitas/
│       │       ├── config/         # Konfigurasi database
│       │       ├── dao/            # Data Access Objects
│       │       ├── filter/         # Authentication filter
│       │       ├── model/          # Entity classes
│       │       └── servlet/        # Controller servlets
│       └── webapp/
│           ├── assets/
│           │   ├── css/            # Custom CSS
│           │   └── images/         # Gambar dan screenshot
│           ├── views/
│           │   ├── mahasiswa/      # Views CRUD mahasiswa
│           │   ├── matakuliah/     # Views CRUD mata kuliah
│           │   ├── jurusan/        # Views CRUD jurusan
│           │   ├── login.jsp       # Halaman login
│           │   ├── dashboard.jsp   # Halaman dashboard
│           │   ├── about.jsp       # Halaman about
│           │   └── gallery.jsp     # Halaman gallery
│           ├── WEB-INF/
│           │   └── web.xml         # Konfigurasi servlet
│           └── index.jsp           # Landing page
├── pom.xml                         # Maven configuration
└── README.md
```

## ⚙️ Instalasi & Konfigurasi

### Prasyarat

1. **JDK 17** atau lebih tinggi
2. **Apache Maven** 3.9+
3. **PostgreSQL** 15+
4. **Apache Tomcat** 10.1+

### Langkah Instalasi

1. **Clone repository**
   ```bash
   git clone https://github.com/username/manajemen-mahasiswa.git
   cd manajemen-mahasiswa
   ```

2. **Buat database PostgreSQL**
   ```sql
   CREATE DATABASE unimanage;
   ```

3. **Import skema database**
   ```bash
   psql -U postgres -d unimanage -f database/schema.sql
   ```

4. **Konfigurasi koneksi database**
   
   Edit file `src/main/java/com/universitas/config/DatabaseConfig.java`:
   ```java
   private static final String URL = "jdbc:postgresql://localhost:5432/unimanage";
   private static final String USER = "postgres";
   private static final String PASSWORD = "your_password";
   ```

5. **Build project**
   ```bash
   mvn clean package
   ```

6. **Deploy ke Tomcat**
   ```bash
   cp target/manajemen-mahasiswa.war /path/to/tomcat/webapps/
   ```

7. **Jalankan Tomcat**
   ```bash
   # Linux/Mac
   /path/to/tomcat/bin/startup.sh
   
   # Windows
   /path/to/tomcat/bin/startup.bat
   ```

8. **Akses aplikasi**
   ```
   http://localhost:8080/manajemen-mahasiswa
   ```

## 📊 Skema Database

### Tabel Users
```sql
CREATE TABLE users (
    id_user SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100),
    email VARCHAR(100),
    role VARCHAR(20) DEFAULT 'User'
);
```

### Tabel Fakultas
```sql
CREATE TABLE fakultas (
    id_fakultas SERIAL PRIMARY KEY,
    nama_fakultas VARCHAR(100) NOT NULL,
    dekan VARCHAR(100)
);
```

### Tabel Jurusan
```sql
CREATE TABLE jurusan (
    id_jurusan SERIAL PRIMARY KEY,
    id_fakultas INTEGER REFERENCES fakultas(id_fakultas),
    nama_jurusan VARCHAR(100) NOT NULL,
    ketua_jurusan VARCHAR(100),
    akreditasi VARCHAR(20)
);
```

### Tabel Mahasiswa
```sql
CREATE TABLE mahasiswa (
    id_mahasiswa SERIAL PRIMARY KEY,
    id_jurusan INTEGER REFERENCES jurusan(id_jurusan),
    nim VARCHAR(20) UNIQUE NOT NULL,
    nama_mahasiswa VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telepon VARCHAR(20),
    alamat TEXT,
    jenis_kelamin CHAR(1),
    tanggal_lahir DATE,
    tahun_masuk INTEGER,
    semester_aktif INTEGER DEFAULT 1,
    ipk DECIMAL(3,2) DEFAULT 0.00,
    status VARCHAR(20) DEFAULT 'Aktif'
);
```

### Tabel Mata Kuliah
```sql
CREATE TABLE matakuliah (
    id_matakuliah SERIAL PRIMARY KEY,
    id_jurusan INTEGER REFERENCES jurusan(id_jurusan),
    kode_matakuliah VARCHAR(20) UNIQUE NOT NULL,
    nama_matakuliah VARCHAR(100) NOT NULL,
    sks INTEGER NOT NULL,
    semester INTEGER,
    jenis VARCHAR(20),
    deskripsi TEXT
);
```

## 🔐 Kredensial Default

| Username | Password | Role |
|----------|----------|------|
| admin | admin123 | Admin |

## 👥 Tim Pengembang

| Nama | NIM |
|------|-----|
| Mochammad Mahardika | 0110224040 |
| Fatih Dzakwan Susilo | 0110224103 |
| Nurul Hayatu Suhaila | 0110224125 |
| Muhamad Uulul Azmi | 0110224184 |
| Sulthan Nabil Al Hakim | 0110224234 |

## 📝 Lisensi

Proyek ini dibuat untuk keperluan akademik mata kuliah Pemrograman Berorientasi Objek (PBO) Semester 3.

## 🙏 Acknowledgments

- Dosen Pengampu Mata Kuliah PBO
- Sekolah Tinggi Teknologi Terpadu Nurul Fikri
- Jurusan Teknik Informatika

---

© 2025 UniManage - Tugas PBO Semester 3
