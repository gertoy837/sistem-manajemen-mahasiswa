<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Mahasiswa - UniManage</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: linear-gradient(135deg, #f5f3ff 0%, #fdf2f8 50%, #f0f9ff 100%); }
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #f1f5f9; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 3px; }
        .sidebar-item { transition: all 0.2s ease; }
        .sidebar-item:hover { background: rgba(139, 92, 246, 0.08); }
        .sidebar-item.active { background: rgba(139, 92, 246, 0.12); color: #7c3aed; }
        .card-shadow { box-shadow: 0 1px 3px rgba(0,0,0,0.05), 0 1px 2px rgba(0,0,0,0.03); }
    </style>
</head>
<body class="min-h-screen text-slate-700">
    <div class="flex min-h-screen">
        <!-- Sidebar -->
        <aside class="w-64 bg-white/80 backdrop-blur-sm fixed h-full z-50 border-r border-slate-200/60">
            <div class="p-6">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-violet-500 to-purple-600 flex items-center justify-center">
                        <i class="fas fa-graduation-cap text-white text-lg"></i>
                    </div>
                    <span class="font-bold text-xl text-slate-800">UniManage</span>
                </div>
            </div>
            <nav class="px-4 mt-2">
                <p class="text-xs font-semibold text-slate-400 uppercase tracking-wider px-3 mb-3">Menu</p>
                <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-item flex items-center space-x-3 px-3 py-2.5 rounded-xl text-slate-600 mb-1">
                    <i class="fas fa-th-large w-5"></i>
                    <span class="font-medium">Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/mahasiswa" class="sidebar-item active flex items-center space-x-3 px-3 py-2.5 rounded-xl mb-1">
                    <i class="fas fa-user-graduate w-5"></i>
                    <span class="font-medium">Mahasiswa</span>
                </a>
                <a href="${pageContext.request.contextPath}/matakuliah" class="sidebar-item flex items-center space-x-3 px-3 py-2.5 rounded-xl text-slate-600 mb-1">
                    <i class="fas fa-book w-5"></i>
                    <span class="font-medium">Mata Kuliah</span>
                </a>
                <a href="${pageContext.request.contextPath}/jurusan" class="sidebar-item flex items-center space-x-3 px-3 py-2.5 rounded-xl text-slate-600 mb-1">
                    <i class="fas fa-building w-5"></i>
                    <span class="font-medium">Jurusan</span>
                </a>
            </nav>
            <div class="absolute bottom-0 left-0 right-0 p-4 border-t border-slate-200/60">
                <div class="flex items-center space-x-3 p-2">
                    <div class="w-10 h-10 rounded-full bg-gradient-to-br from-violet-400 to-purple-500 flex items-center justify-center text-white font-semibold">
                        ${fn:toUpperCase(fn:substring(sessionScope.username, 0, 1))}
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="font-semibold text-slate-800 text-sm truncate">${sessionScope.namaLengkap != null ? sessionScope.namaLengkap : sessionScope.username}</p>
                        <p class="text-xs text-slate-500">${sessionScope.role}</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="p-2 text-slate-400 hover:text-red-500 transition-colors"><i class="fas fa-sign-out-alt"></i></a>
                </div>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 ml-64">
            <header class="bg-white/60 backdrop-blur-sm border-b border-slate-200/60 sticky top-0 z-40">
                <div class="flex items-center justify-between px-8 py-4">
                    <div>
                        <h2 class="text-xl font-bold text-slate-800">Edit Mahasiswa</h2>
                        <p class="text-slate-500 text-sm">Perbarui data mahasiswa</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/mahasiswa" class="px-4 py-2 text-slate-600 hover:text-slate-800 font-medium text-sm transition-colors">
                        <i class="fas fa-arrow-left mr-2"></i>Kembali
                    </a>
                </div>
            </header>

            <div class="p-8">
                <div class="max-w-2xl mx-auto">
                    <div class="bg-white rounded-2xl card-shadow overflow-hidden">
                        <div class="p-6 border-b border-slate-100">
                            <div class="flex items-center space-x-3">
                                <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-violet-400 to-purple-500 flex items-center justify-center text-white font-bold text-lg">
                                    ${fn:toUpperCase(fn:substring(mahasiswa.namaMahasiswa, 0, 1))}
                                </div>
                                <div>
                                    <h3 class="font-semibold text-slate-800">${mahasiswa.namaMahasiswa}</h3>
                                    <p class="text-sm text-slate-500">NIM: ${mahasiswa.nim}</p>
                                </div>
                            </div>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/mahasiswa" method="post" class="p-6 space-y-5">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="idMahasiswa" value="${mahasiswa.idMahasiswa}">
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">NIM <span class="text-red-500">*</span></label>
                                    <input type="text" name="nim" required maxlength="20" value="${mahasiswa.nim}"
                                           class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">Nama Lengkap <span class="text-red-500">*</span></label>
                                    <input type="text" name="namaMahasiswa" required maxlength="100" value="${mahasiswa.namaMahasiswa}"
                                           class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                </div>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">Email <span class="text-red-500">*</span></label>
                                    <input type="email" name="email" required value="${mahasiswa.email}"
                                           class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">Telepon</label>
                                    <input type="text" name="telepon" maxlength="15" value="${mahasiswa.telepon}"
                                           class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Jurusan <span class="text-red-500">*</span></label>
                                <select name="idJurusan" required class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                    <option value="">-- Pilih Jurusan --</option>
                                    <c:forEach var="jurusan" items="${listJurusan}">
                                        <option value="${jurusan.idJurusan}" ${mahasiswa.idJurusan == jurusan.idJurusan ? 'selected' : ''}>${jurusan.namaJurusan}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">Jenis Kelamin <span class="text-red-500">*</span></label>
                                    <select name="jenisKelamin" required class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                        <option value="">-- Pilih --</option>
                                        <option value="L" ${selectedJenisKelamin == 'L' ? 'selected' : ''}>Laki-laki</option>
                                        <option value="P" ${selectedJenisKelamin == 'P' ? 'selected' : ''}>Perempuan</option>
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">Tanggal Lahir</label>
                                    <input type="date" name="tanggalLahir" value="${mahasiswa.tanggalLahir}"
                                           class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Alamat</label>
                                <textarea name="alamat" rows="3"
                                          class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm resize-none">${mahasiswa.alamat}</textarea>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-3 gap-5">
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">Tahun Masuk <span class="text-red-500">*</span></label>
                                    <input type="number" name="tahunMasuk" required min="2000" max="2030" value="${mahasiswa.tahunMasuk}"
                                           class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">Semester</label>
                                    <input type="number" name="semesterAktif" min="1" max="14" value="${mahasiswa.semesterAktif}"
                                           class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-slate-700 mb-2">IPK</label>
                                    <input type="number" name="ipk" step="0.01" min="0" max="4" value="${mahasiswa.ipk}"
                                           class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Status</label>
                                <select name="status" class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                    <option value="Aktif" ${mahasiswa.status == 'Aktif' ? 'selected' : ''}>Aktif</option>
                                    <option value="Cuti" ${mahasiswa.status == 'Cuti' ? 'selected' : ''}>Cuti</option>
                                    <option value="Lulus" ${mahasiswa.status == 'Lulus' ? 'selected' : ''}>Lulus</option>
                                    <option value="DO" ${mahasiswa.status == 'DO' ? 'selected' : ''}>DO</option>
                                </select>
                            </div>

                            <div class="flex items-center justify-end space-x-3 pt-4 border-t border-slate-100">
                                <a href="${pageContext.request.contextPath}/mahasiswa" 
                                   class="px-5 py-2.5 text-slate-600 hover:text-slate-800 font-medium text-sm transition-colors">
                                    Batal
                                </a>
                                <button type="submit" 
                                        class="px-6 py-2.5 bg-violet-600 hover:bg-violet-700 text-white rounded-xl font-medium text-sm transition-colors">
                                    <i class="fas fa-save mr-2"></i>Update
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
