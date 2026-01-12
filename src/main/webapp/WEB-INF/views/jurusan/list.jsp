<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jurusan - UniManage</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="brand d-flex align-items-center">
            <div class="brand-icon me-3">
                <i class="fas fa-graduation-cap text-white fa-lg"></i>
            </div>
            <span class="text-white fw-bold fs-5">UniManage</span>
        </div>
        <nav class="nav flex-column mt-3">
            <span class="text-white-50 small text-uppercase px-4 mb-2">Menu</span>
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/mahasiswa" class="nav-link">
                <i class="fas fa-user-graduate"></i> Mahasiswa
            </a>
            <a href="${pageContext.request.contextPath}/matakuliah" class="nav-link">
                <i class="fas fa-book"></i> Mata Kuliah
            </a>
            <a href="${pageContext.request.contextPath}/jurusan" class="nav-link active">
                <i class="fas fa-building"></i> Jurusan
            </a>
        </nav>
        <div class="sidebar-footer">
            <div class="d-flex align-items-center">
                <div class="avatar avatar-circle bg-light text-primary me-2">
                    ${fn:toUpperCase(fn:substring(sessionScope.username, 0, 1))}
                </div>
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
                <h4 class="mb-0 fw-bold">Daftar Jurusan</h4>
                <small class="text-muted">Kelola data jurusan/program studi</small>
            </div>
            <div class="d-flex align-items-center gap-3">
                <form action="${pageContext.request.contextPath}/jurusan/search" method="get" class="d-flex">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                        <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Cari jurusan..." style="width: 250px;">
                    </div>
                </form>
                <a href="${pageContext.request.contextPath}/jurusan/new" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Tambah Jurusan
                </a>
            </div>
        </header>

        <div class="p-4">
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="successMessage" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>

            <div class="card">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>No</th>
                                    <th>Nama Jurusan</th>
                                    <th>Fakultas</th>
                                    <th>Ketua Jurusan</th>
                                    <th>Akreditasi</th>
                                    <th class="text-center">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="jurusan" items="${listJurusan}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="avatar bg-info me-2">
                                                    <i class="fas fa-building text-white"></i>
                                                </div>
                                                <strong>${jurusan.namaJurusan}</strong>
                                            </div>
                                        </td>
                                        <td>${jurusan.namaFakultas != null ? jurusan.namaFakultas : '-'}</td>
                                        <td>${jurusan.ketuaJurusan != null ? jurusan.ketuaJurusan : '-'}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${jurusan.akreditasi == 'A' || jurusan.akreditasi == 'Unggul'}">
                                                    <span class="badge bg-success">${jurusan.akreditasi}</span>
                                                </c:when>
                                                <c:when test="${jurusan.akreditasi == 'B' || jurusan.akreditasi == 'Baik Sekali'}">
                                                    <span class="badge bg-primary">${jurusan.akreditasi}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${jurusan.akreditasi != null ? jurusan.akreditasi : '-'}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/jurusan/edit?id=${jurusan.idJurusan}" class="btn btn-sm btn-outline-primary btn-action me-1">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/jurusan/delete?id=${jurusan.idJurusan}" onclick="return confirm('Hapus jurusan ini?')" class="btn btn-sm btn-outline-danger btn-action">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listJurusan}">
                                    <tr>
                                        <td colspan="6" class="text-center py-5 text-muted">
                                            <i class="fas fa-building fa-3x mb-3"></i>
                                            <p>Belum ada data jurusan</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer bg-light">
                    <small class="text-muted">Total: <strong>${fn:length(listJurusan)}</strong> jurusan</small>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
