<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Mahasiswa - UniManage</title>
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
                <h4 class="mb-0 fw-bold">Tambah Mahasiswa Baru</h4>
                <small class="text-muted">Isi form untuk menambahkan mahasiswa baru</small>
            </div>
            <a href="${pageContext.request.contextPath}/mahasiswa" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Kembali
            </a>
        </header>

        <div class="p-4">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-header d-flex align-items-center">
                            <div class="avatar bg-primary me-3">
                                <i class="fas fa-user-plus text-white"></i>
                            </div>
                            <div>
                                <h6 class="mb-0 fw-bold">Data Mahasiswa</h6>
                                <small class="text-muted">Masukkan data mahasiswa dengan lengkap</small>
                            </div>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/mahasiswa" method="post">
                                <input type="hidden" name="action" value="add">
                                
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">NIM <span class="text-danger">*</span></label>
                                        <input type="text" name="nim" class="form-control" required maxlength="20" placeholder="Contoh: 2024001">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Nama Lengkap <span class="text-danger">*</span></label>
                                        <input type="text" name="namaMahasiswa" class="form-control" required maxlength="100" placeholder="Nama lengkap mahasiswa">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Email <span class="text-danger">*</span></label>
                                        <input type="email" name="email" class="form-control" required placeholder="email@example.com">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Telepon</label>
                                        <input type="text" name="telepon" class="form-control" maxlength="15" placeholder="08xxxxxxxxxx">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Jurusan <span class="text-danger">*</span></label>
                                    <select name="idJurusan" class="form-select" required>
                                        <option value="">-- Pilih Jurusan --</option>
                                        <c:forEach var="jurusan" items="${listJurusan}">
                                            <option value="${jurusan.idJurusan}">${jurusan.namaJurusan}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Jenis Kelamin <span class="text-danger">*</span></label>
                                        <select name="jenisKelamin" class="form-select" required>
                                            <option value="">-- Pilih --</option>
                                            <option value="L">Laki-laki</option>
                                            <option value="P">Perempuan</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Tanggal Lahir</label>
                                        <input type="date" name="tanggalLahir" class="form-control">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Alamat</label>
                                    <textarea name="alamat" class="form-control" rows="3" placeholder="Alamat lengkap"></textarea>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <label class="form-label">Tahun Masuk <span class="text-danger">*</span></label>
                                        <input type="number" name="tahunMasuk" class="form-control" required min="2000" max="2030" value="2024">
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">Semester</label>
                                        <input type="number" name="semesterAktif" class="form-control" min="1" max="14" value="1">
                                    </div>
                                    <div class="col-md-4">
                                        <label class="form-label">IPK</label>
                                        <input type="number" name="ipk" class="form-control" step="0.01" min="0" max="4" value="0.00">
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">Status</label>
                                    <select name="status" class="form-select">
                                        <option value="Aktif" selected>Aktif</option>
                                        <option value="Cuti">Cuti</option>
                                        <option value="Lulus">Lulus</option>
                                        <option value="DO">DO</option>
                                    </select>
                                </div>

                                <hr>
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="${pageContext.request.contextPath}/mahasiswa" class="btn btn-light">Batal</a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Simpan
                                    </button>
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
