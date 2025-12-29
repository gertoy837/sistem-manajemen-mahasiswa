# 🎓 UniManage - Sistem Manajemen Mahasiswa

Aplikasi web modern untuk mengelola data mahasiswa dengan fitur autentikasi, dashboard interaktif, dan UI yang responsif.

## ✨ Fitur Utama

- 🔐 **Sistem Login** - Autentikasi user dengan role (admin/staff)
- 📊 **Dashboard Interaktif** - Statistik dan grafik Chart.js
- 👨‍🎓 **CRUD Mahasiswa** - Create, Read, Update, Delete data mahasiswa
- 🔍 **Pencarian** - Cari mahasiswa berdasarkan NIM atau nama
- 🎨 **UI Modern** - TailwindCSS dengan desain yang responsif
- 🗄️ **Database PostgreSQL** - 6 tabel terintegrasi

## 🛠️ Tech Stack

| Layer | Teknologi |
|-------|-----------|
| Backend | Java 17, Jakarta Servlet 6.0 |
| Frontend | JSP, TailwindCSS, Chart.js, Font Awesome |
| Database | PostgreSQL 18 |
| Build Tool | Maven |
| Server | Apache Tomcat 10.1.x |
| JSTL | Jakarta JSTL 3.0 |

## 🏗️ Struktur Database

### 1. Users
| Kolom | Tipe | Deskripsi |
|-------|------|-----------|
| id_user | SERIAL PK | ID unik user |
| username | VARCHAR(50) | Username login |
| password | VARCHAR(255) | Password |
| nama_lengkap | VARCHAR(100) | Nama lengkap |
| email | VARCHAR(100) | Email |
| role | VARCHAR(20) | Role (admin/staff) |

### 2. Fakultas
| Kolom | Tipe | Deskripsi |
|-------|------|-----------|
| id_fakultas | SERIAL PK | ID unik fakultas |
| nama_fakultas | VARCHAR(100) | Nama fakultas |
| dekan | VARCHAR(100) | Nama dekan |
| tahun_berdiri | INT | Tahun berdiri |

### 3. Jurusan
| Kolom | Tipe | Deskripsi |
|-------|------|-----------|
| id_jurusan | SERIAL PK | ID unik jurusan |
| id_fakultas | INT FK | Referensi ke fakultas |
| nama_jurusan | VARCHAR(100) | Nama jurusan |
| ketua_jurusan | VARCHAR(100) | Nama ketua jurusan |
| akreditasi | CHAR(1) | Akreditasi (A/B/C) |

### 4. Dosen
| Kolom | Tipe | Deskripsi |
|-------|------|-----------|
| id_dosen | SERIAL PK | ID unik dosen |
| id_jurusan | INT FK | Referensi ke jurusan |
| nip | VARCHAR(20) | NIP dosen |
| nama_dosen | VARCHAR(100) | Nama dosen |
| email | VARCHAR(100) | Email |
| status | VARCHAR(20) | Status (Aktif/Cuti/Pensiun) |

### 5. Mahasiswa
| Kolom | Tipe | Deskripsi |
|-------|------|-----------|
| id_mahasiswa | SERIAL PK | ID unik mahasiswa |
| id_jurusan | INT FK | Referensi ke jurusan |
| id_dosen | INT FK | Dosen pembimbing |
| nim | VARCHAR(20) | NIM mahasiswa |
| nama_mahasiswa | VARCHAR(100) | Nama mahasiswa |
| email | VARCHAR(100) | Email |
| telepon | VARCHAR(15) | No. telepon |
| alamat | TEXT | Alamat |
| jenis_kelamin | CHAR(1) | L/P |
| tanggal_lahir | DATE | Tanggal lahir |
| tahun_masuk | INT | Tahun masuk |
| semester_aktif | INT | Semester saat ini |
| ipk | DECIMAL(3,2) | IPK |
| status | VARCHAR(20) | Status (Aktif/Cuti/Lulus/DO) |

### 6. Mata Kuliah
| Kolom | Tipe | Deskripsi |
|-------|------|-----------|
| id_matakuliah | SERIAL PK | ID unik matkul |
| id_jurusan | INT FK | Referensi ke jurusan |
| id_dosen | INT FK | Dosen pengampu |
| kode_matakuliah | VARCHAR(10) | Kode matkul |
| nama_matakuliah | VARCHAR(100) | Nama matkul |
| sks | INT | Jumlah SKS |
| semester | INT | Semester |
| jenis | VARCHAR(20) | Wajib/Pilihan |

## 📋 Prerequisites

- **Java JDK 17+**
- **Apache Maven 3.6+**
- **PostgreSQL 12+**
- **Apache Tomcat 10.1+** (Jakarta EE 10)
- **Web Browser** modern

## ⚙️ Instalasi

### 1. Clone Repository
```bash
git clone https://github.com/username/manajemen-mahasiswa.git
cd manajemen-mahasiswa
```

### 2. Setup Database PostgreSQL

```bash
# Windows - buka psql
psql -U postgres

# Jalankan script
\i database/create_tables.sql
```

Atau jalankan manual:
```sql
CREATE DATABASE manajemen_mahasiswa;
\c manajemen_mahasiswa
-- Jalankan isi file create_tables.sql
-- Jalankan isi file create_users.sql
```

### 3. Konfigurasi Database

Edit file `src/main/java/com/universitas/config/DatabaseConfig.java`:

```java
private static final String URL = "jdbc:postgresql://localhost:5432/manajemen_mahasiswa";
private static final String USERNAME = "postgres";
private static final String PASSWORD = "your_password";  // Ganti password
```

### 4. Build Project

```bash
mvn clean package
```

### 5. Deploy ke Tomcat

**Opsi A - Manual Deploy:**
```bash
# Copy WAR ke Tomcat
cp target/manajemen-mahasiswa.war /path/to/tomcat/webapps/
```

**Opsi B - VS Code Community Server Connectors:**
1. Install extension "Community Server Connectors"
2. Add Tomcat server
3. Add Deployment → pilih `target/manajemen-mahasiswa` folder
4. Start Server

### 6. Akses Aplikasi

Buka browser: `http://localhost:8080/manajemen-mahasiswa`

**Login default:**
| Username | Password | Role |
|----------|----------|------|
| admin | admin123 | admin |
| staff | staff123 | staff |

## 📁 Struktur Project

```
manajemen-mahasiswa/
├── database/
│   ├── create_tables.sql       # Script DDL tabel
│   └── create_users.sql        # Script insert users
├── src/main/
│   ├── java/com/universitas/
│   │   ├── config/
│   │   │   └── DatabaseConfig.java
│   │   ├── dao/
│   │   │   ├── MahasiswaDAO.java
│   │   │   ├── JurusanDAO.java
│   │   │   └── UserDAO.java
│   │   ├── filter/
│   │   │   └── AuthFilter.java
│   │   ├── model/
│   │   │   ├── Mahasiswa.java
│   │   │   ├── Jurusan.java
│   │   │   └── User.java
│   │   └── servlet/
│   │       ├── DashboardServlet.java
│   │       ├── LoginServlet.java
│   │       └── MahasiswaServlet.java
│   ├── resources/
│   └── webapp/
│       ├── index.jsp
│       ├── views/
│       │   ├── login.jsp
│       │   ├── dashboard.jsp
│       │   └── mahasiswa/
│       │       ├── list.jsp
│       │       ├── add.jsp
│       │       └── edit.jsp
│       └── WEB-INF/
│           └── web.xml
├── target/
├── pom.xml
├── .gitignore
└── README.md
```

## 🖥️ Screenshots

### Login Page
- Form login dengan validasi
- Pesan error jika login gagal

### Dashboard
- Welcome banner dengan info user
- 4 statistics cards (Total Mahasiswa, Aktif, Cuti, Lulus)
- Grafik distribusi jurusan (Doughnut Chart)
- Grafik status mahasiswa (Bar Chart)
- Quick actions menu
- Tabel mahasiswa terbaru

### Data Mahasiswa
- Tabel data dengan pagination
- Search by NIM/Nama
- Actions: Edit, Delete
- Status badges (Aktif, Cuti, Lulus)
- IPK progress bar

### Form Mahasiswa
- Form responsive dengan validasi
- Dropdown jurusan dinamis
- Date picker untuk tanggal lahir
- Radio button jenis kelamin

## 🔧 Troubleshooting

### ❌ Database Connection Error
```
Cannot invoke "java.sql.Connection.prepareStatement(String)" because "conn" is null
```
**Solusi:**
- Pastikan PostgreSQL running
- Cek password di `DatabaseConfig.java`
- Jika Tomcat di WSL, PostgreSQL di Windows → ubah `localhost` ke IP Windows

### ❌ JSP Not Found (404)
```
JSP file [/views/login.jsp] not found
```
**Solusi:**
- Build ulang: `mvn clean package`
- Redeploy aplikasi ke Tomcat
- Clear browser cache

### ❌ JSTL Tag Error
```
The absolute uri: [http://java.sun.com/jsp/jstl/core] cannot be resolved
```
**Solusi:**
- Untuk Tomcat 10.1+, gunakan URI `jakarta.tags.core`
- Pastikan JSTL 3.0 ada di pom.xml

### ❌ Server Timeout
```
Server Tomcat 10.x did not start within timeout
```
**Solusi:**
- Restart server
- Cek port 8080 tidak digunakan aplikasi lain
- Cek log Tomcat untuk detail error

## 📝 API Endpoints

| Method | URL | Deskripsi |
|--------|-----|-----------|
| GET | `/login` | Halaman login |
| POST | `/login` | Proses login |
| GET | `/logout` | Logout user |
| GET | `/dashboard` | Halaman dashboard |
| GET | `/mahasiswa` | List mahasiswa |
| GET | `/mahasiswa?action=add` | Form tambah |
| POST | `/mahasiswa?action=add` | Simpan mahasiswa baru |
| GET | `/mahasiswa?action=edit&id=X` | Form edit |
| POST | `/mahasiswa?action=edit` | Update mahasiswa |
| GET | `/mahasiswa?action=delete&id=X` | Hapus mahasiswa |
| GET | `/mahasiswa?action=search&keyword=X` | Cari mahasiswa |

## 🚀 Pengembangan Selanjutnya

- [ ] Manajemen Dosen
- [ ] Manajemen Mata Kuliah
- [ ] Manajemen Jurusan & Fakultas
- [ ] Upload foto mahasiswa
- [ ] Export data ke PDF/Excel
- [ ] REST API untuk mobile app
- [ ] Password hashing (BCrypt)
- [ ] Role-based access control

## 👨‍💻 Author

**Mata Kuliah:** Pemrograman Berorientasi Objek (PBO)  
**Semester:** 3  
**Tahun:** 2024/2025

---

**© 2024 UniManage - Sistem Manajemen Mahasiswa**  
*Java 17 • Jakarta EE 10 • PostgreSQL • TailwindCSS*
