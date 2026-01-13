<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery - UniManage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.4/css/lightbox.min.css" rel="stylesheet">
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
        .gallery-item {
            position: relative;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            transition: all 0.3s;
            margin-bottom: 24px;
            border: 1px solid #eee;
        }
        .gallery-item:hover { transform: translateY(-5px); box-shadow: 0 10px 30px rgba(0,0,0,0.15); }
        .gallery-item img { width: 100%; height: 220px; object-fit: cover; }
        .gallery-overlay {
            position: absolute;
            bottom: 0; left: 0; right: 0;
            background: linear-gradient(transparent, rgba(0,0,0,0.7));
            padding: 20px;
            color: #fff;
        }
        .gallery-category {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.7rem;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .filter-btn { border-radius: 20px; padding: 8px 20px; margin: 4px; font-size: 0.875rem; }
        .filter-btn.active { background-color: var(--primary); border-color: var(--primary); color: #fff; }
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
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about">About</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                    <li class="nav-item ms-lg-3"><a class="btn btn-primary px-4" href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt me-2"></i>Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header text-center">
        <div class="container" data-aos="fade-up">
            <h1 class="display-5 fw-bold">Gallery</h1>
            <p class="lead opacity-75">Screenshot tampilan aplikasi dan database</p>
        </div>
    </section>

    <!-- Filter Buttons -->
    <section class="py-4 bg-light">
        <div class="container text-center">
            <button class="btn btn-outline-primary filter-btn active" data-filter="all">Semua</button>
            <button class="btn btn-outline-primary filter-btn" data-filter="dashboard">Dashboard</button>
            <button class="btn btn-outline-primary filter-btn" data-filter="mahasiswa">Mahasiswa</button>
            <button class="btn btn-outline-primary filter-btn" data-filter="matakuliah">Mata Kuliah</button>
            <button class="btn btn-outline-primary filter-btn" data-filter="jurusan">Jurusan</button>
            <button class="btn btn-outline-primary filter-btn" data-filter="database">Database</button>
        </div>
    </section>

    <!-- Gallery Content -->
    <section class="py-5">
        <div class="container py-3">
            <div class="row" id="galleryContainer">
                <!-- Dashboard Screenshots -->
                <div class="col-md-4 gallery-card" data-category="dashboard" data-aos="fade-up">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/dashboard-1.png" data-lightbox="gallery" data-title="Dashboard - Halaman Utama">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/dashboard-1.png" alt="Dashboard" onerror="this.src='https://via.placeholder.com/400x220/4a6cf7/ffffff?text=Dashboard'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #4a6cf7;">Dashboard</span>
                                <h6 class="mb-0">Halaman Dashboard</h6>
                            </div>
                        </a>
                    </div>
                </div>

                <!-- Mahasiswa Screenshots -->
                <div class="col-md-4 gallery-card" data-category="mahasiswa" data-aos="fade-up" data-aos-delay="200">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/mahasiswa-list.png" data-lightbox="gallery" data-title="Daftar Mahasiswa">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/mahasiswa-list.png" alt="Mahasiswa List" onerror="this.src='https://via.placeholder.com/400x220/10b981/ffffff?text=List+Mahasiswa'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #10b981;">Mahasiswa</span>
                                <h6 class="mb-0">Daftar Mahasiswa</h6>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-4 gallery-card" data-category="mahasiswa" data-aos="fade-up">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/mahasiswa-add.png" data-lightbox="gallery" data-title="Tambah Mahasiswa">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/mahasiswa-add.png" alt="Tambah Mahasiswa" onerror="this.src='https://via.placeholder.com/400x220/059669/ffffff?text=Tambah+Mahasiswa'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #10b981;">Mahasiswa</span>
                                <h6 class="mb-0">Form Tambah</h6>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-4 gallery-card" data-category="mahasiswa" data-aos="fade-up" data-aos-delay="100">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/mahasiswa-edit.png" data-lightbox="gallery" data-title="Edit Mahasiswa">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/mahasiswa-edit.png" alt="Edit Mahasiswa" onerror="this.src='https://via.placeholder.com/400x220/047857/ffffff?text=Edit+Mahasiswa'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #10b981;">Mahasiswa</span>
                                <h6 class="mb-0">Form Edit</h6>
                            </div>
                        </a>
                    </div>
                </div>

                <!-- Mata Kuliah Screenshots -->
                <div class="col-md-4 gallery-card" data-category="matakuliah" data-aos="fade-up" data-aos-delay="200">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/matakuliah-list.png" data-lightbox="gallery" data-title="Daftar Mata Kuliah">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/matakuliah-list.png" alt="Mata Kuliah List" onerror="this.src='https://via.placeholder.com/400x220/f59e0b/ffffff?text=List+Mata+Kuliah'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #f59e0b;">Mata Kuliah</span>
                                <h6 class="mb-0">Daftar Mata Kuliah</h6>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-4 gallery-card" data-category="matakuliah" data-aos="fade-up">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/matakuliah-add.png" data-lightbox="gallery" data-title="Tambah Mata Kuliah">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/matakuliah-add.png" alt="Tambah Matakuliah" onerror="this.src='https://via.placeholder.com/400x220/d97706/ffffff?text=Tambah+MK'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #f59e0b;">Mata Kuliah</span>
                                <h6 class="mb-0">Form Tambah</h6>
                            </div>
                        </a>
                    </div>
                </div>

                <!-- Jurusan Screenshots -->
                <div class="col-md-4 gallery-card" data-category="jurusan" data-aos="fade-up" data-aos-delay="100">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/jurusan-list.png" data-lightbox="gallery" data-title="Daftar Jurusan">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/jurusan-list.png" alt="Jurusan List" onerror="this.src='https://via.placeholder.com/400x220/8b5cf6/ffffff?text=List+Jurusan'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #8b5cf6;">Jurusan</span>
                                <h6 class="mb-0">Daftar Jurusan</h6>
                            </div>
                        </a>
                    </div>
                </div>

                <!-- Database Screenshots -->
                <div class="col-md-4 gallery-card" data-category="database" data-aos="fade-up" data-aos-delay="200">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/seluruh-tabel.png" data-lightbox="gallery" data-title="Tabel Mahasiswa">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/seluruh-tabel.png" alt="DB Mahasiswa" onerror="this.src='https://via.placeholder.com/400x220/336791/ffffff?text=Tabel+Mahasiswa'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #336791;">Database</span>
                                <h6 class="mb-0">Seluruh Tabel</h6>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-4 gallery-card" data-category="database" data-aos="fade-up">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/tbl-mahasiswa.png" data-lightbox="gallery" data-title="Tabel Mata Kuliah">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/tbl-mahasiswa.png" alt="DB Matakuliah" onerror="this.src='https://via.placeholder.com/400x220/2d5f8a/ffffff?text=Tabel+Matakuliah'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #336791;">Database</span>
                                <h6 class="mb-0">Tabel Mahasiswa</h6>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-4 gallery-card" data-category="database" data-aos="fade-up">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/tbl-matakuliah.png" data-lightbox="gallery" data-title="Tabel Mata Kuliah">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/tbl-matakuliah.png" alt="DB Matakuliah" onerror="this.src='https://via.placeholder.com/400x220/2d5f8a/ffffff?text=Tabel+Matakuliah'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #336791;">Database</span>
                                <h6 class="mb-0">Tabel Mata Kuliah</h6>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-4 gallery-card" data-category="database" data-aos="fade-up" data-aos-delay="100">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/tbl-jurusan.png" data-lightbox="gallery" data-title="Tabel Jurusan">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/tbl-jurusan.png" alt="DB Jurusan" onerror="this.src='https://via.placeholder.com/400x220/254e7a/ffffff?text=Tabel+Jurusan'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #336791;">Database</span>
                                <h6 class="mb-0">Tabel Jurusan</h6>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-md-4 gallery-card" data-category="database" data-aos="fade-up" data-aos-delay="200">
                    <div class="gallery-item">
                        <a href="${pageContext.request.contextPath}/assets/images/gallery/tbl-erd.png" data-lightbox="gallery" data-title="ERD Database">
                            <img src="${pageContext.request.contextPath}/assets/images/gallery/tbl-erd.png" alt="ERD" onerror="this.src='https://via.placeholder.com/400x220/1e293b/ffffff?text=ERD+Database'">
                            <div class="gallery-overlay">
                                <span class="gallery-category" style="background-color: #336791;">Database</span>
                                <h6 class="mb-0">ERD Database</h6>
                            </div>
                        </a>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.4/js/lightbox.min.js"></script>
    <script>
        AOS.init({ duration: 800, once: true });
        
        // Filter functionality
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                
                const filter = this.dataset.filter;
                document.querySelectorAll('.gallery-card').forEach(card => {
                    if (filter === 'all' || card.dataset.category === filter) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });
        });
        
        lightbox.option({ 'resizeDuration': 200, 'wrapAround': true });
    </script>
</body>
</html>
