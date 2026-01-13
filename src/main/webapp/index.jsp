<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UniManage - Sistem Manajemen Mahasiswa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <style>
        :root { --primary: #4a6cf7; --primary-dark: #3d5bd9; --secondary: #6c757d; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar { background: #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        .navbar-brand { font-weight: 700; color: var(--primary) !important; }
        .nav-link { font-weight: 500; color: #333 !important; }
        .nav-link:hover { color: var(--primary) !important; }
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .hero-section {
            min-height: 100vh;
            background-color: #4a6cf7;
            position: relative;
        }
        .btn-hero { padding: 12px 32px; font-weight: 600; border-radius: 8px; }
        .btn-light:hover { background-color: #f8f9fa; }
        .feature-card {
            background: #fff; border-radius: 12px; padding: 30px 25px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.06); transition: all 0.3s; border: 1px solid #eee;
            height: 100%;
        }
        .feature-card:hover { transform: translateY(-5px); box-shadow: 0 8px 30px rgba(0,0,0,0.1); }
        .feature-icon {
            width: 70px; height: 70px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.75rem; color: #fff; margin-bottom: 20px;
        }
        .stats-section { background: #f8f9fa; }
        .stat-item h2 { font-size: 2.5rem; font-weight: 700; color: var(--primary); }
        .cta-section { background-color: #4a6cf7; padding: 80px 0; }
        footer { background: #1e293b; color: #fff; padding: 50px 0 25px; }
        footer a { color: rgba(255,255,255,0.7); text-decoration: none; }
        footer a:hover { color: #fff; }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/"><i class="fas fa-graduation-cap me-2"></i>UniManage</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                    <li class="nav-item ms-lg-3"><a class="btn btn-primary px-4" href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt me-2"></i>Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section d-flex align-items-center">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 text-white" data-aos="fade-right">
                    <h1 class="display-4 fw-bold mb-4">Sistem Manajemen Mahasiswa Modern</h1>
                    <p class="lead mb-4 opacity-75">Kelola data mahasiswa, mata kuliah, dan jurusan dengan mudah dan efisien menggunakan platform terintegrasi kami.</p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-light btn-hero"><i class="fas fa-rocket me-2"></i>Mulai Sekarang</a>
                        <a href="${pageContext.request.contextPath}/about" class="btn btn-outline-light btn-hero"><i class="fas fa-info-circle me-2"></i>Pelajari Lebih</a>
                    </div>
                </div>
                <div class="col-lg-6 text-center mt-5 mt-lg-0" data-aos="fade-left">
                    <img src="https://illustrations.popsy.co/white/student-going-to-school.svg" alt="Student" class="img-fluid" style="max-height: 450px;">
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5" id="features">
        <div class="container py-5">
            <div class="text-center mb-5" data-aos="fade-up">
                <h6 class="text-primary fw-bold text-uppercase">Fitur Unggulan</h6>
                <h2 class="display-6 fw-bold">Semua yang Anda Butuhkan</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card text-center">
                        <div class="feature-icon mx-auto" style="background-color: #4a6cf7;"><i class="fas fa-user-graduate"></i></div>
                        <h5 class="fw-bold">Manajemen Mahasiswa</h5>
                        <p class="text-muted">Kelola data mahasiswa dengan lengkap termasuk biodata, status akademik, dan IPK.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card text-center">
                        <div class="feature-icon mx-auto" style="background-color: #10b981;"><i class="fas fa-book"></i></div>
                        <h5 class="fw-bold">Mata Kuliah</h5>
                        <p class="text-muted">Atur mata kuliah, SKS, semester, dan dosen pengampu dengan mudah.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card text-center">
                        <div class="feature-icon mx-auto" style="background-color: #f59e0b;"><i class="fas fa-building"></i></div>
                        <h5 class="fw-bold">Jurusan & Fakultas</h5>
                        <p class="text-muted">Kelola struktur jurusan dan fakultas beserta akreditasinya.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card text-center">
                        <div class="feature-icon mx-auto" style="background-color: #8b5cf6;"><i class="fas fa-chart-pie"></i></div>
                        <h5 class="fw-bold">Dashboard Interaktif</h5>
                        <p class="text-muted">Visualisasi data dengan grafik dan statistik yang informatif.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="500">
                    <div class="feature-card text-center">
                        <div class="feature-icon mx-auto" style="background-color: #ef4444;"><i class="fas fa-search"></i></div>
                        <h5 class="fw-bold">Pencarian Cepat</h5>
                        <p class="text-muted">Temukan data yang Anda cari dengan fitur pencarian yang responsif.</p>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="600">
                    <div class="feature-card text-center">
                        <div class="feature-icon mx-auto" style="background-color: #06b6d4;"><i class="fas fa-shield-alt"></i></div>
                        <h5 class="fw-bold">Keamanan Data</h5>
                        <p class="text-muted">Sistem autentikasi dan otorisasi untuk keamanan data.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section py-5">
        <div class="container py-5">
            <div class="row text-center g-4">
                <div class="col-md-3" data-aos="zoom-in"><div class="stat-item"><h2>500+</h2><p class="text-muted mb-0">Mahasiswa</p></div></div>
                <div class="col-md-3" data-aos="zoom-in" data-aos-delay="100"><div class="stat-item"><h2>50+</h2><p class="text-muted mb-0">Mata Kuliah</p></div></div>
                <div class="col-md-3" data-aos="zoom-in" data-aos-delay="200"><div class="stat-item"><h2>10+</h2><p class="text-muted mb-0">Jurusan</p></div></div>
                <div class="col-md-3" data-aos="zoom-in" data-aos-delay="300"><div class="stat-item"><h2>99%</h2><p class="text-muted mb-0">Uptime</p></div></div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section text-center text-white">
        <div class="container" data-aos="fade-up">
            <h2 class="display-6 fw-bold mb-4">Siap Memulai?</h2>
            <p class="lead mb-4 opacity-75">Bergabunglah dan kelola data akademik dengan lebih efisien</p>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-light btn-hero"><i class="fas fa-arrow-right me-2"></i>Masuk ke Sistem</a>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <h5 class="fw-bold mb-3"><i class="fas fa-graduation-cap me-2"></i>UniManage</h5>
                    <p class="opacity-75">Sistem Manajemen Mahasiswa modern untuk pengelolaan data akademik yang efisien.</p>
                </div>
                <div class="col-lg-2">
                    <h6 class="fw-bold mb-3">Menu</h6>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/about">About</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                    </ul>
                </div>
                <div class="col-lg-3">
                    <h6 class="fw-bold mb-3">Kontak</h6>
                    <ul class="list-unstyled opacity-75">
                        <li class="mb-2"><i class="fas fa-envelope me-2"></i>admin@unimanage.ac.id</li>
                        <li class="mb-2"><i class="fas fa-phone me-2"></i>+62 123 4567 890</li>
                    </ul>
                </div>
            </div>
            <hr class="my-4 opacity-25">
            <div class="text-center opacity-75"><p class="mb-0">&copy; 2025 UniManage - Tugas PBO Semester 3</p></div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>AOS.init({ duration: 800, once: true });</script>
</body>
</html>
