<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Jurusan - UniManage</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: linear-gradient(135deg, #f5f3ff 0%, #fdf2f8 50%, #f0f9ff 100%); }
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
                    <i class="fas fa-th-large w-5"></i><span class="font-medium">Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/mahasiswa" class="sidebar-item flex items-center space-x-3 px-3 py-2.5 rounded-xl text-slate-600 mb-1">
                    <i class="fas fa-user-graduate w-5"></i><span class="font-medium">Mahasiswa</span>
                </a>
                <a href="${pageContext.request.contextPath}/matakuliah" class="sidebar-item flex items-center space-x-3 px-3 py-2.5 rounded-xl text-slate-600 mb-1">
                    <i class="fas fa-book w-5"></i><span class="font-medium">Mata Kuliah</span>
                </a>
                <a href="${pageContext.request.contextPath}/jurusan" class="sidebar-item active flex items-center space-x-3 px-3 py-2.5 rounded-xl mb-1">
                    <i class="fas fa-building w-5"></i><span class="font-medium">Jurusan</span>
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
                        <h2 class="text-xl font-bold text-slate-800">Tambah Jurusan Baru</h2>
                        <p class="text-slate-500 text-sm">Isi form untuk menambahkan jurusan baru</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/jurusan" class="px-4 py-2 text-slate-600 hover:text-slate-800 font-medium text-sm transition-colors">
                        <i class="fas fa-arrow-left mr-2"></i>Kembali
                    </a>
                </div>
            </header>

            <div class="p-8">
                <div class="max-w-2xl mx-auto">
                    <div class="bg-white rounded-2xl card-shadow overflow-hidden">
                        <div class="p-6 border-b border-slate-100">
                            <div class="flex items-center space-x-3">
                                <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-teal-400 to-cyan-500 flex items-center justify-center text-white">
                                    <i class="fas fa-building text-lg"></i>
                                </div>
                                <div>
                                    <h3 class="font-semibold text-slate-800">Informasi Jurusan</h3>
                                    <p class="text-sm text-slate-500">Masukkan data jurusan dengan lengkap</p>
                                </div>
                            </div>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/jurusan/insert" method="post" class="p-6 space-y-5">
                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Nama Jurusan <span class="text-red-500">*</span></label>
                                <input type="text" name="namaJurusan" required maxlength="100"
                                       class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm"
                                       placeholder="Contoh: Teknik Informatika">
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Fakultas</label>
                                <select name="idFakultas" class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                    <option value="">-- Pilih Fakultas --</option>
                                    <c:forEach var="fakultas" items="${listFakultas}">
                                        <option value="${fakultas.idFakultas}">${fakultas.namaFakultas}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Ketua Jurusan</label>
                                <input type="text" name="ketuaJurusan" maxlength="100"
                                       class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm"
                                       placeholder="Nama ketua jurusan">
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-slate-700 mb-2">Akreditasi</label>
                                <select name="akreditasi" class="w-full px-4 py-2.5 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                                    <option value="">-- Pilih Akreditasi --</option>
                                    <option value="A">A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                    <option value="Unggul">Unggul</option>
                                    <option value="Baik Sekali">Baik Sekali</option>
                                    <option value="Baik">Baik</option>
                                </select>
                            </div>

                            <div class="flex items-center justify-end space-x-3 pt-4 border-t border-slate-100">
                                <a href="${pageContext.request.contextPath}/jurusan" 
                                   class="px-5 py-2.5 text-slate-600 hover:text-slate-800 font-medium text-sm transition-colors">
                                    Batal
                                </a>
                                <button type="submit" 
                                        class="px-6 py-2.5 bg-violet-600 hover:bg-violet-700 text-white rounded-xl font-medium text-sm transition-colors">
                                    <i class="fas fa-save mr-2"></i>Simpan
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
