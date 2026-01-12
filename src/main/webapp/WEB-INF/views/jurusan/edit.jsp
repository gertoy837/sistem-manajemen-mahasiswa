<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Jurusan - UniManage</title>
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
            <a href="${pageContext.request.contextPath}/matakuliah" class="nav-link"><i class="fas fa-book"></i> Mata Kuliah</a>
            <a href="${pageContext.request.contextPath}/jurusan" class="nav-link active"><i class="fas fa-building"></i> Jurusan</a>
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

    <main class="main-content">
        <header class="main-header d-flex justify-content-between align-items-center">
            <div>
                <h4 class="mb-0 fw-bold">Edit Jurusan</h4>
                <small class="text-muted">Perbarui data jurusan</small>
            </div>
            <a href="${pageContext.request.contextPath}/jurusan" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Kembali
            </a>
        </header>

        <div class="p-4">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header d-flex align-items-center">
                            <div class="avatar bg-info me-3"><i class="fas fa-edit text-white"></i></div>
                            <div>
                                <h6 class="mb-0 fw-bold">${jurusan.namaJurusan}</h6>
                                <small class="text-muted">ID: ${jurusan.idJurusan}</small>
                            </div>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/jurusan/update" method="post">
                                <input type="hidden" name="idJurusan" value="${jurusan.idJurusan}">
                                
                                <div class="mb-3">
                                    <label class="form-label">Nama Jurusan <span class="text-danger">*</span></label>
                                    <input type="text" name="namaJurusan" class="form-control" required value="${jurusan.namaJurusan}">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Fakultas</label>
                                    <select name="idFakultas" class="form-select">
                                        <option value="">-- Pilih Fakultas --</option>
                                        <c:forEach var="fakultas" items="${listFakultas}">
                                            <option value="${fakultas.idFakultas}" ${jurusan.idFakultas == fakultas.idFakultas ? 'selected' : ''}>${fakultas.namaFakultas}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Ketua Jurusan</label>
                                    <input type="text" name="ketuaJurusan" class="form-control" value="${jurusan.ketuaJurusan}">
                                </div>
                                <div class="mb-4">
                                    <label class="form-label">Akreditasi</label>
                                    <select name="akreditasi" class="form-select">
                                        <option value="">-- Pilih Akreditasi --</option>
                                        <option value="A" ${jurusan.akreditasi == 'A' ? 'selected' : ''}>A</option>
                                        <option value="B" ${jurusan.akreditasi == 'B' ? 'selected' : ''}>B</option>
                                        <option value="C" ${jurusan.akreditasi == 'C' ? 'selected' : ''}>C</option>
                                        <option value="Unggul" ${jurusan.akreditasi == 'Unggul' ? 'selected' : ''}>Unggul</option>
                                        <option value="Baik Sekali" ${jurusan.akreditasi == 'Baik Sekali' ? 'selected' : ''}>Baik Sekali</option>
                                        <option value="Baik" ${jurusan.akreditasi == 'Baik' ? 'selected' : ''}>Baik</option>
                                    </select>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="${pageContext.request.contextPath}/jurusan" class="btn btn-light">Batal</a>
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i>Update</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
