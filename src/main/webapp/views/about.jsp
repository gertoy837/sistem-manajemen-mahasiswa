<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About - UniManage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <style>
        :root { --primary: #4a6cf7; --primary-dark: #3d5bd9; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar { background: #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        .navbar-brand { font-weight: 700; color: var(--primary) !important; }
        .nav-link { font-weight: 500; color: #333 !important; }
        .nav-link:hover, .nav-link.active { color: var(--primary) !important; }
        .btn-primary { background-color: var(--primary); border-color: var(--primary); }
        .btn-primary:hover { background-color: var(--primary-dark); border-color: var(--primary-dark); }
        .page-header {
            background-color: #4a6cf7;
            padding: 140px 0 80px;
            color: #fff;
        }
        .tech-card {
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
            transition: all 0.3s;
            height: 100%;
            border: 1px solid #eee;
        }
        .tech-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        .tech-icon { width: 55px; height: 55px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 1.4rem; color: #fff; }
        .team-card { 
            background: #fff; 
            border-radius: 12px; 
            overflow: hidden; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.08); 
            transition: all 0.3s; 
            border: 1px solid #eee;
        }
        .team-card:hover { transform: translateY(-5px); box-shadow: 0 10px 30px rgba(0,0,0,0.12); }
        .team-img { 
            height: 180px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
        }
        .team-img i { font-size: 4rem; }
        footer { background: #1e293b; color: #fff; padding: 40px 0; }
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/about">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                    <li class="nav-item ms-lg-3"><a class="btn btn-primary px-4" href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt me-2"></i>Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header text-center">
        <div class="container" data-aos="fade-up">
            <h1 class="display-5 fw-bold">Tentang UniManage</h1>
            <p class="lead opacity-75">Mengenal lebih dekat sistem manajemen mahasiswa kami</p>
        </div>
    </section>

    <!-- About Content -->
    <section class="py-5">
        <div class="container py-4">
            <div class="row align-items-center g-5">
                <div class="col-lg-6" data-aos="fade-right">
                    <img src="https://illustrations.popsy.co/white/remote-work.svg" alt="About" class="img-fluid">
                </div>
                <div class="col-lg-6" data-aos="fade-left">
                    <h6 class="fw-bold text-uppercase" style="color: #4a6cf7;">Tentang Kami</h6>
                    <h2 class="display-6 fw-bold mb-4">Apa itu UniManage?</h2>
                    <p class="text-muted mb-4">UniManage adalah sistem manajemen mahasiswa berbasis web yang dikembangkan sebagai proyek tugas akhir mata kuliah Pemrograman Berorientasi Objek (PBO). Sistem ini dirancang untuk memudahkan pengelolaan data akademik di lingkungan universitas.</p>
                    <div class="row g-3">
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle me-2" style="color: #10b981;"></i>
                                <span>CRUD Mahasiswa</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle me-2" style="color: #10b981;"></i>
                                <span>CRUD Mata Kuliah</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle me-2" style="color: #10b981;"></i>
                                <span>CRUD Jurusan</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle me-2" style="color: #10b981;"></i>
                                <span>Dashboard Interaktif</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Technology Stack -->
    <section class="py-5 bg-light">
        <div class="container py-4">
            <div class="text-center mb-5" data-aos="fade-up">
                <h6 class="fw-bold text-uppercase" style="color: #4a6cf7;">Technology Stack</h6>
                <h2 class="display-6 fw-bold">Teknologi yang Digunakan</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="100">
                    <div class="tech-card text-center">
                        <div class="tech-icon mx-auto mb-3" style="background-color: #f89820;"><i class="fab fa-java"></i></div>
                        <h5 class="fw-bold">Java</h5>
                        <p class="text-muted small mb-0">Backend & Servlet</p>
                    </div>
                </div>
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="200">
                    <div class="tech-card text-center">
                        <div class="tech-icon mx-auto mb-3" style="background-color: #336791;"><i class="fas fa-database"></i></div>
                        <h5 class="fw-bold">PostgreSQL</h5>
                        <p class="text-muted small mb-0">Database</p>
                    </div>
                </div>
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="300">
                    <div class="tech-card text-center">
                        <div class="tech-icon mx-auto mb-3" style="background-color: #7952b3;"><i class="fab fa-bootstrap"></i></div>
                        <h5 class="fw-bold">Bootstrap 5</h5>
                        <p class="text-muted small mb-0">Frontend Framework</p>
                    </div>
                </div>
                <div class="col-md-3" data-aos="fade-up" data-aos-delay="400">
                    <div class="tech-card text-center">
                        <div class="tech-icon mx-auto mb-3" style="background-color: #d33c2b;"><i class="fas fa-server"></i></div>
                        <h5 class="fw-bold">Apache Tomcat</h5>
                        <p class="text-muted small mb-0">Web Server</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Team Section -->
    <section class="py-5">
        <div class="container py-4">
            <div class="text-center mb-5" data-aos="fade-up">
                <h6 class="fw-bold text-uppercase" style="color: #4a6cf7;">Tim Pengembang</h6>
                <h2 class="display-6 fw-bold">Dibuat Oleh</h2>
                <p class="text-muted">Mahasiswa Teknik Informatika Semester 3</p>
            </div>
            <div class="row g-4 justify-content-center">
                <!-- Member 1 -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="team-card">
                        <div class="team-img" style="background-color: #4a6cf7;">
                            <i class="fas fa-user text-white"></i>
                        </div>
                        <div class="p-4 text-center">
                            <h5 class="fw-bold mb-1">Mochammad Mahardika</h5>
                            <p class="text-muted small mb-2">NIM: 0110224040</p>
                        </div>
                    </div>
                </div>
                <!-- Member 2 -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="team-card">
                        <div class="team-img" style="background-color: #10b981;">
                            <i class="fas fa-user text-white"></i>
                        </div>
                        <div class="p-4 text-center">
                            <h5 class="fw-bold mb-1">Fatih Dzakwan Susilo</h5>
                            <p class="text-muted small mb-2">NIM: 0110224103</p>
                        </div>
                    </div>
                </div>
                <!-- Member 3 -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="team-card">
                        <div class="team-img" style="background-color: #f59e0b;">
                            <i class="fas fa-user text-white"></i>
                        </div>
                        <div class="p-4 text-center">
                            <h5 class="fw-bold mb-1">Muhamad Uulul Azmi</h5>
                            <p class="text-muted small mb-2">NIM: 0110224184</p>
                        </div>
                    </div>
                </div>
                <!-- Member 4 -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="team-card">
                        <div class="team-img" style="background-color: #ef4444;">
                            <i class="fas fa-user text-white"></i>
                        </div>
                        <div class="p-4 text-center">
                            <h5 class="fw-bold mb-1">Nurul Hayatu Suhaila</h5>
                            <p class="text-muted small mb-2">NIM: 0110224125</p>
                        </div>
                    </div>
                </div>
                <!-- Member 5 -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                    <div class="team-card">
                        <div class="team-img" style="background-color: #8b5cf6;">
                            <i class="fas fa-user text-white"></i>
                        </div>
                        <div class="p-4 text-center">
                            <h5 class="fw-bold mb-1">Sulthan Nabil Al Hakim</h5>
                            <p class="text-muted small mb-2">NIM: 0110224234</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="text-center">
        <div class="container">
            <p class="mb-0 opacity-75">&copy; 2025 UniManage - Tugas PBO Semester 3</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>AOS.init({ duration: 800, once: true });</script>
</body>
</html>
