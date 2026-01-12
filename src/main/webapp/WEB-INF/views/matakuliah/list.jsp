<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mata Kuliah - UniManage</title>
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
                <a href="${pageContext.request.contextPath}/mahasiswa" class="sidebar-item flex items-center space-x-3 px-3 py-2.5 rounded-xl text-slate-600 mb-1">
                    <i class="fas fa-user-graduate w-5"></i>
                    <span class="font-medium">Mahasiswa</span>
                </a>
                <a href="${pageContext.request.contextPath}/matakuliah" class="sidebar-item active flex items-center space-x-3 px-3 py-2.5 rounded-xl mb-1">
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
                        <h2 class="text-xl font-bold text-slate-800">Daftar Mata Kuliah</h2>
                        <p class="text-slate-500 text-sm">Kelola data mata kuliah</p>
                    </div>
                    <div class="flex items-center space-x-4">
                        <form action="${pageContext.request.contextPath}/matakuliah/search" method="get" class="relative">
                            <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-slate-400"></i>
                            <input type="text" name="keyword" value="${keyword}" placeholder="Cari mata kuliah..." class="pl-11 pr-4 py-2.5 w-72 rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 transition-all text-sm">
                        </form>
                        <a href="${pageContext.request.contextPath}/matakuliah/new" class="px-5 py-2.5 bg-violet-600 hover:bg-violet-700 text-white rounded-xl font-medium text-sm transition-colors">
                            <i class="fas fa-plus mr-2"></i>Tambah Mata Kuliah
                        </a>
                    </div>
                </div>
            </header>
            <div class="p-8">
                <c:if test="${not empty successMessage}">
                    <div class="mb-6 p-4 bg-emerald-50 border border-emerald-200 text-emerald-700 rounded-xl flex items-center">
                        <i class="fas fa-check-circle mr-3"></i>${successMessage}
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="mb-6 p-4 bg-red-50 border border-red-200 text-red-700 rounded-xl flex items-center">
                        <i class="fas fa-exclamation-circle mr-3"></i>${errorMessage}
                    </div>
                </c:if>
                <div class="bg-white rounded-2xl card-shadow overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-slate-50/80">
                                <tr>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase">No</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase">Kode</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase">Mata Kuliah</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase">SKS</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase">Semester</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase">Jurusan</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase">Jenis</th>
                                    <th class="px-6 py-4 text-center text-xs font-semibold text-slate-500 uppercase">Aksi</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100">
                                <c:forEach var="mk" items="${listMataKuliah}" varStatus="loop">
                                    <tr class="hover:bg-slate-50/50 transition-colors">
                                        <td class="px-6 py-4 text-sm text-slate-600">${loop.index + 1}</td>
                                        <td class="px-6 py-4"><span class="px-2.5 py-1 text-xs font-mono bg-violet-100 text-violet-700 rounded-lg">${mk.kodeMatakuliah}</span></td>
                                        <td class="px-6 py-4">
                                            <div class="flex items-center space-x-3">
                                                <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-orange-400 to-pink-500 flex items-center justify-center text-white">
                                                    <i class="fas fa-book-open text-sm"></i>
                                                </div>
                                                <span class="font-medium text-slate-800">${mk.namaMatakuliah}</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4"><span class="px-2.5 py-1 text-xs font-bold bg-indigo-100 text-indigo-700 rounded-full">${mk.sks} SKS</span></td>
                                        <td class="px-6 py-4 text-sm text-slate-600">Semester ${mk.semester}</td>
                                        <td class="px-6 py-4 text-sm text-slate-600">${mk.namaJurusan}</td>
                                        <td class="px-6 py-4">
                                            <span class="px-2.5 py-1 text-xs font-medium rounded-full ${mk.jenis == 'Wajib' ? 'bg-red-100 text-red-700' : 'bg-emerald-100 text-emerald-700'}">${mk.jenis}</span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex items-center justify-center space-x-1">
                                                <a href="${pageContext.request.contextPath}/matakuliah/edit?id=${mk.idMatakuliah}" class="p-2 text-violet-600 hover:bg-violet-50 rounded-lg transition-colors"><i class="fas fa-edit"></i></a>
                                                <a href="${pageContext.request.contextPath}/matakuliah/delete?id=${mk.idMatakuliah}" onclick="return confirm('Hapus mata kuliah ini?')" class="p-2 text-red-500 hover:bg-red-50 rounded-lg transition-colors"><i class="fas fa-trash"></i></a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listMataKuliah}">
                                    <tr><td colspan="8" class="px-6 py-12 text-center text-slate-400"><i class="fas fa-book text-4xl mb-3"></i><p>Belum ada data mata kuliah</p></td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                    <div class="px-6 py-4 bg-slate-50/50 border-t border-slate-100">
                        <p class="text-sm text-slate-500">Total: <span class="font-semibold text-slate-700">${fn:length(listMataKuliah)}</span> mata kuliah</p>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
