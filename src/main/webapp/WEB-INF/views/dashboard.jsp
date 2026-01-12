<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - UniManage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="brand d-flex align-items-center">
            <div class="brand-icon me-3"><i class="fas fa-graduation-cap text-white fa-lg"></i></div>
            <span class="text-white fw-bold fs-5">UniManage</span>
        </div>
        <nav class="nav flex-column mt-3">
            <span class="text-white-50 small text-uppercase px-4 mb-2">Menu</span>
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link active"><i class="fas fa-th-large"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/mahasiswa" class="nav-link"><i class="fas fa-user-graduate"></i> Mahasiswa</a>
            <a href="${pageContext.request.contextPath}/matakuliah" class="nav-link"><i class="fas fa-book"></i> Mata Kuliah</a>
            <a href="${pageContext.request.contextPath}/jurusan" class="nav-link"><i class="fas fa-building"></i> Jurusan</a>
        </nav>
        <div class="sidebar-footer">
            <div class="d-flex align-items-center">
                <div class="avatar avatar-circle bg-light text-primary me-2">${fn:toUpperCase(fn:substring(sessionScope.username, 0, 1))}</div>
                <div class="flex-grow-1">
                    <div class="text-white small fw-semibold">${sessionScope.username}</div>
                    <div class="text-white-50 small">${sessionScope.role}</div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="text-white-50"><i class="fas fa-sign-out-alt"></i></a>
            </div>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <header class="main-header d-flex justify-content-between align-items-center">
            <div>
                <h4 class="mb-0 fw-bold">Dashboard</h4>
                <small class="text-muted">Selamat datang, ${sessionScope.username}!</small>
            </div>
            <div class="d-flex align-items-center gap-2">
                <span class="badge bg-light text-dark"><i class="fas fa-calendar me-1"></i> <script>document.write(new Date().toLocaleDateString('id-ID', {day: 'numeric', month: 'long', year: 'numeric'}))</script></span>
            </div>
        </header>

        <div class="p-4">
            <!-- Stats Cards -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card border-0 bg-primary text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white-50 mb-1">Total Mahasiswa</h6>
                                    <h2 class="mb-0 fw-bold">${totalMahasiswa != null ? totalMahasiswa : 0}</h2>
                                </div>
                                <div class="avatar bg-white bg-opacity-25">
                                    <i class="fas fa-user-graduate fa-lg"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-0 bg-success text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white-50 mb-1">Total Mata Kuliah</h6>
                                    <h2 class="mb-0 fw-bold">${totalMataKuliah != null ? totalMataKuliah : 0}</h2>
                                </div>
                                <div class="avatar bg-white bg-opacity-25">
                                    <i class="fas fa-book fa-lg"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-0 bg-info text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white-50 mb-1">Total Jurusan</h6>
                                    <h2 class="mb-0 fw-bold">${totalJurusan != null ? totalJurusan : 0}</h2>
                                </div>
                                <div class="avatar bg-white bg-opacity-25">
                                    <i class="fas fa-building fa-lg"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card h-100">
                        <div class="card-header">
                            <h6 class="mb-0 fw-bold"><i class="fas fa-bolt text-warning me-2"></i>Aksi Cepat</h6>
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/mahasiswa?action=add" class="btn btn-outline-primary">
                                    <i class="fas fa-user-plus me-2"></i>Tambah Mahasiswa Baru
                                </a>
                                <a href="${pageContext.request.contextPath}/matakuliah/new" class="btn btn-outline-success">
                                    <i class="fas fa-book-medical me-2"></i>Tambah Mata Kuliah Baru
                                </a>
                                <a href="${pageContext.request.contextPath}/jurusan/new" class="btn btn-outline-info">
                                    <i class="fas fa-plus me-2"></i>Tambah Jurusan Baru
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card h-100">
                        <div class="card-header">
                            <h6 class="mb-0 fw-bold"><i class="fas fa-info-circle text-info me-2"></i>Informasi Sistem</h6>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Versi Aplikasi</span>
                                    <strong>1.0.0</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Server</span>
                                    <strong>Apache Tomcat</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Database</span>
                                    <strong>PostgreSQL</strong>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
