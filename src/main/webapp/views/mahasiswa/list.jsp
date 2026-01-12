<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mahasiswa - UniManage</title>
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
            <a href="${pageContext.request.contextPath}/mahasiswa" class="nav-link active">
                <i class="fas fa-user-graduate"></i> Mahasiswa
            </a>
            <a href="${pageContext.request.contextPath}/matakuliah" class="nav-link">
                <i class="fas fa-book"></i> Mata Kuliah
            </a>
            <a href="${pageContext.request.contextPath}/jurusan" class="nav-link">
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
                <h4 class="mb-0 fw-bold">Daftar Mahasiswa</h4>
                <small class="text-muted">Kelola data mahasiswa</small>
            </div>
            <div class="d-flex align-items-center gap-3">
                <form action="${pageContext.request.contextPath}/mahasiswa" method="get" class="d-flex">
                    <input type="hidden" name="action" value="search">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="fas fa-search text-muted"></i></span>
                        <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Cari mahasiswa..." style="width: 250px;">
                    </div>
                </form>
                <a href="${pageContext.request.contextPath}/mahasiswa?action=add" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Tambah Mahasiswa
                </a>
            </div>
        </header>

        <div class="p-4">
            <c:if test="${not empty message}">
                <div class="alert ${messageType == 'success' ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                    <i class="fas ${messageType == 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'} me-2"></i>
                    ${message}
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
                                    <th>NIM</th>
                                    <th>Mahasiswa</th>
                                    <th>Jurusan</th>
                                    <th>Semester</th>
                                    <th>IPK</th>
                                    <th>Status</th>
                                    <th class="text-center">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="mhs" items="${listMahasiswa}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td><span class="badge bg-primary-subtle text-primary">${mhs.nim}</span></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="avatar bg-primary me-2">
                                                    ${fn:toUpperCase(fn:substring(mhs.namaMahasiswa, 0, 1))}
                                                </div>
                                                <div>
                                                    <div class="fw-semibold">${mhs.namaMahasiswa}</div>
                                                    <small class="text-muted">${mhs.email}</small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>${mhs.namaJurusan}</td>
                                        <td><span class="badge bg-info">Sem ${mhs.semesterAktif}</span></td>
                                        <td><strong>${mhs.ipk}</strong></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${mhs.status == 'Aktif'}">
                                                    <span class="badge bg-success">${mhs.status}</span>
                                                </c:when>
                                                <c:when test="${mhs.status == 'Cuti'}">
                                                    <span class="badge bg-warning">${mhs.status}</span>
                                                </c:when>
                                                <c:when test="${mhs.status == 'Lulus'}">
                                                    <span class="badge bg-info">${mhs.status}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">${mhs.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/mahasiswa?action=edit&id=${mhs.idMahasiswa}" class="btn btn-sm btn-outline-primary btn-action me-1">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/mahasiswa?action=delete&id=${mhs.idMahasiswa}" onclick="return confirm('Hapus mahasiswa ${mhs.namaMahasiswa}?')" class="btn btn-sm btn-outline-danger btn-action">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listMahasiswa}">
                                    <tr>
                                        <td colspan="8" class="text-center py-5 text-muted">
                                            <i class="fas fa-user-graduate fa-3x mb-3"></i>
                                            <p>Belum ada data mahasiswa</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="card-footer bg-light">
                    <small class="text-muted">Total: <strong>${fn:length(listMahasiswa)}</strong> mahasiswa</small>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>setTimeout(() => { document.querySelectorAll('.alert').forEach(a => a.remove()); }, 4000);</script>
</body>
</html>
