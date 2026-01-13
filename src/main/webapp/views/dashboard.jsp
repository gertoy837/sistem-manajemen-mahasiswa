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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <!-- Sidebar -->
    <aside class="sidebar" style="background-color: #1e293b;">
        <div class="brand d-flex align-items-center">
            <div class="brand-icon me-3" style="background-color: #4a6cf7;"><i class="fas fa-graduation-cap text-white fa-lg"></i></div>
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
                <div class="avatar avatar-circle me-2" style="background-color: #4a6cf7;">${fn:toUpperCase(fn:substring(sessionScope.username, 0, 1))}</div>
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
                <div class="col-md-3">
                    <div class="card border-0 text-white h-100" style="background-color: #4a6cf7;">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white-50 mb-1">Total Mahasiswa</h6>
                                    <h2 class="mb-0 fw-bold">${totalMahasiswa}</h2>
                                </div>
                                <div class="avatar bg-white bg-opacity-25"><i class="fas fa-user-graduate fa-lg"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-0 text-white h-100" style="background-color: #10b981;">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white-50 mb-1">Mahasiswa Aktif</h6>
                                    <h2 class="mb-0 fw-bold">${mahasiswaAktif}</h2>
                                </div>
                                <div class="avatar bg-white bg-opacity-25"><i class="fas fa-user-check fa-lg"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-0 text-white h-100" style="background-color: #f59e0b;">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white-50 mb-1">Rata-rata IPK</h6>
                                    <h2 class="mb-0 fw-bold">${avgIpk}</h2>
                                </div>
                                <div class="avatar bg-white bg-opacity-25"><i class="fas fa-star fa-lg"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-0 text-white h-100" style="background-color: #06b6d4;">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white-50 mb-1">Total Jurusan</h6>
                                    <h2 class="mb-0 fw-bold">${totalJurusan != null ? totalJurusan : 0}</h2>
                                </div>
                                <div class="avatar bg-white bg-opacity-25"><i class="fas fa-building fa-lg"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Status Overview -->
            <div class="row g-4 mb-4">
                <div class="col-md-8">
                    <div class="card h-100">
                        <div class="card-header bg-white"><h6 class="mb-0 fw-bold"><i class="fas fa-chart-bar me-2" style="color: #4a6cf7;"></i>Status Mahasiswa</h6></div>
                        <div class="card-body">
                            <div class="row text-center">
                                <div class="col-md-4">
                                    <div class="p-3 rounded-3" style="background-color: rgba(16, 185, 129, 0.1);">
                                        <i class="fas fa-user-check fa-2x mb-2" style="color: #10b981;"></i>
                                        <h3 class="fw-bold mb-0">${mahasiswaAktif}</h3>
                                        <p class="text-muted mb-0">Aktif</p>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="p-3 rounded-3" style="background-color: rgba(245, 158, 11, 0.1);">
                                        <i class="fas fa-pause-circle fa-2x mb-2" style="color: #f59e0b;"></i>
                                        <h3 class="fw-bold mb-0">${mahasiswaCuti}</h3>
                                        <p class="text-muted mb-0">Cuti</p>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="p-3 rounded-3" style="background-color: rgba(6, 182, 212, 0.1);">
                                        <i class="fas fa-graduation-cap fa-2x mb-2" style="color: #06b6d4;"></i>
                                        <h3 class="fw-bold mb-0">${mahasiswaLulus}</h3>
                                        <p class="text-muted mb-0">Lulus</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-header bg-white"><h6 class="mb-0 fw-bold"><i class="fas fa-bolt me-2" style="color: #f59e0b;"></i>Aksi Cepat</h6></div>
                        <div class="card-body d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/mahasiswa?action=add" class="btn btn-outline-primary"><i class="fas fa-user-plus me-2"></i>Tambah Mahasiswa</a>
                            <a href="${pageContext.request.contextPath}/matakuliah/new" class="btn btn-outline-success"><i class="fas fa-book-medical me-2"></i>Tambah Mata Kuliah</a>
                            <a href="${pageContext.request.contextPath}/jurusan/new" class="btn btn-outline-info"><i class="fas fa-plus me-2"></i>Tambah Jurusan</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts -->
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-white"><h6 class="mb-0 fw-bold"><i class="fas fa-chart-pie me-2" style="color: #4a6cf7;"></i>Distribusi per Jurusan</h6></div>
                        <div class="card-body"><canvas id="jurusanChart" height="200"></canvas></div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header bg-white"><h6 class="mb-0 fw-bold"><i class="fas fa-chart-bar me-2" style="color: #10b981;"></i>Status Mahasiswa</h6></div>
                        <div class="card-body"><canvas id="statusChart" height="200"></canvas></div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        new Chart(document.getElementById('jurusanChart'), {
            type: 'doughnut',
            data: {
                labels: ['Teknik Informatika', 'Sistem Informasi', 'Bisnis Digital'],
                datasets: [{ data: [${countTI != null ? countTI : 0}, ${countSI != null ? countSI : 0}, ${countBD != null ? countBD : 0}], backgroundColor: ['#4a6cf7', '#10b981', '#f59e0b'], borderWidth: 0 }]
            },
            options: { responsive: true, maintainAspectRatio: false, cutout: '60%', plugins: { legend: { position: 'bottom' } } }
        });
        new Chart(document.getElementById('statusChart'), {
            type: 'bar',
            data: {
                labels: ['Aktif', 'Cuti', 'Lulus'],
                datasets: [{ data: [${mahasiswaAktif != null ? mahasiswaAktif : 0}, ${mahasiswaCuti != null ? mahasiswaCuti : 0}, ${mahasiswaLulus != null ? mahasiswaLulus : 0}], backgroundColor: ['#10b981', '#f59e0b', '#06b6d4'], borderRadius: 6 }]
            },
            options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true } } }
        });
    </script>
</body>
</html>
