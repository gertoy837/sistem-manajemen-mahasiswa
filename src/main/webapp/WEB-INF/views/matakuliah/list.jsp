<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mata Kuliah - UniManage</title>
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
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-link"><i class="fas fa-th-large"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/mahasiswa" class="nav-link"><i class="fas fa-user-graduate"></i> Mahasiswa</a>
            <a href="${pageContext.request.contextPath}/matakuliah" class="nav-link active"><i class="fas fa-book"></i> Mata Kuliah</a>
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
                <h4 class="mb-0 fw-bold">Daftar Mata Kuliah</h4>
                <small class="text-muted">Kelola data mata kuliah</small>
            </div>
            <div class="d-flex align-items-center gap-3">
                <form action="${pageContext.request.contextPath}/matakuliah/search" method="get" class="d-flex">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                        <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Cari mata kuliah..." style="width: 250px;">
                    </div>
                </form>
                <a href="${pageContext.request.contextPath}/matakuliah/new" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Tambah Mata Kuliah
                </a>
            </div>
        </header>

        <div class="p-4">
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>No</th>
                                    <th>Kode</th>
                                    <th>Mata Kuliah</th>
                                    <th>SKS</th>
                                    <th>Semester</th>
                                    <th>Jurusan</th>
                                    <th>Jenis</th>
                                    <th class="text-center">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="mk" items="${listMataKuliah}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td><span class="badge bg-primary-subtle text-primary">${mk.kodeMatakuliah}</span></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="avatar bg-warning me-2">
                                                    <i class="fas fa-book-open text-white"></i>
                                                </div>
                                                <strong>${mk.namaMatakuliah}</strong>
                                            </div>
                                        </td>
                                        <td><span class="badge bg-info">${mk.sks} SKS</span></td>
                                        <td>Semester ${mk.semester}</td>
                                        <td>${mk.namaJurusan}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${mk.jenis == 'Wajib'}">
                                                    <span class="badge bg-danger">${mk.jenis}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success">${mk.jenis}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/matakuliah/edit?id=${mk.idMatakuliah}" class="btn btn-sm btn-outline-primary btn-action me-1">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/matakuliah/delete?id=${mk.idMatakuliah}" onclick="return confirm('Hapus mata kuliah ini?')" class="btn btn-sm btn-outline-danger btn-action">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listMataKuliah}">
                                    <tr>
                                        <td colspan="8" class="text-center py-5 text-muted">
                                            <i class="fas fa-book fa-3x mb-3"></i>
                                            <p>Belum ada data mata kuliah</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer bg-light">
                    <small class="text-muted">Total: <strong>${fn:length(listMataKuliah)}</strong> mata kuliah</small>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
