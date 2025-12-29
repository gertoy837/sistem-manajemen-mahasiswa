<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Mahasiswa - UniManage</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        .sidebar-gradient {
            background: linear-gradient(180deg, #1e293b 0%, #0f172a 100%);
        }
        .nav-item {
            transition: all 0.2s ease;
        }
        .nav-item:hover {
            background: rgba(255, 255, 255, 0.1);
        }
        .nav-item.active {
            background: linear-gradient(90deg, rgba(99, 102, 241, 0.2) 0%, transparent 100%);
            border-left: 3px solid #6366f1;
        }
        .table-row {
            transition: all 0.15s ease;
        }
        .table-row:hover {
            background: linear-gradient(90deg, rgba(99, 102, 241, 0.04) 0%, rgba(139, 92, 246, 0.04) 100%);
        }
        .pulse-dot {
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.7; transform: scale(1.1); }
        }
        .progress-bar {
            transition: width 1s ease-in-out;
        }
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-track { background: #f1f5f9; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 3px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }
    </style>
</head>
<body class="bg-slate-50 min-h-screen">
    
    <div class="flex min-h-screen">
        <!-- Sidebar -->
        <aside class="w-64 sidebar-gradient fixed h-full z-50 shadow-2xl">
            <!-- Logo -->
            <div class="p-6">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center shadow-lg shadow-indigo-500/30">
                        <i class="fas fa-graduation-cap text-white text-lg"></i>
                    </div>
                    <div>
                        <h1 class="font-bold text-white text-lg tracking-tight">UniManage</h1>
                        <p class="text-xs text-slate-400">Student Portal</p>
                    </div>
                </div>
            </div>
            
            <!-- User Card -->
            <div class="mx-4 p-4 rounded-xl bg-slate-800/50 mb-6">
                <div class="flex items-center space-x-3">
                    <div class="w-11 h-11 rounded-full bg-gradient-to-br from-indigo-400 to-purple-500 flex items-center justify-center text-white font-bold shadow-lg">
                        ${fn:toUpperCase(fn:substring(sessionScope.username, 0, 1))}
                    </div>
                    <div class="flex-1 min-w-0">
                        <h3 class="font-semibold text-white text-sm truncate">${sessionScope.namaLengkap != null ? sessionScope.namaLengkap : sessionScope.username}</h3>
                        <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-indigo-500/20 text-indigo-300">
                            <i class="fas fa-shield-alt mr-1 text-[10px]"></i>${sessionScope.role}
                        </span>
                    </div>
                </div>
            </div>
            
            <!-- Navigation -->
            <nav class="px-3 space-y-1">
                <p class="text-[10px] font-semibold text-slate-500 uppercase tracking-wider px-3 mb-3">Menu</p>
                
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-item flex items-center space-x-3 px-3 py-2.5 rounded-lg text-slate-300">
                    <i class="fas fa-th-large w-5"></i>
                    <span class="font-medium text-sm">Dashboard</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/mahasiswa" class="nav-item active flex items-center space-x-3 px-3 py-2.5 rounded-lg text-white">
                    <i class="fas fa-user-graduate w-5 text-indigo-400"></i>
                    <span class="font-medium text-sm">Mahasiswa</span>
                    <span class="ml-auto bg-indigo-500 text-white text-[10px] font-bold px-1.5 py-0.5 rounded">${fn:length(listMahasiswa)}</span>
                </a>
                
                <a href="#" class="nav-item flex items-center space-x-3 px-3 py-2.5 rounded-lg text-slate-300">
                    <i class="fas fa-chalkboard-teacher w-5"></i>
                    <span class="font-medium text-sm">Dosen</span>
                </a>
                
                <a href="#" class="nav-item flex items-center space-x-3 px-3 py-2.5 rounded-lg text-slate-300">
                    <i class="fas fa-book w-5"></i>
                    <span class="font-medium text-sm">Mata Kuliah</span>
                </a>
                
                <a href="#" class="nav-item flex items-center space-x-3 px-3 py-2.5 rounded-lg text-slate-300">
                    <i class="fas fa-building w-5"></i>
                    <span class="font-medium text-sm">Jurusan</span>
                </a>
                
                <p class="text-[10px] font-semibold text-slate-500 uppercase tracking-wider px-3 mt-6 mb-3">Pengaturan</p>
                
                <a href="#" class="nav-item flex items-center space-x-3 px-3 py-2.5 rounded-lg text-slate-300">
                    <i class="fas fa-cog w-5"></i>
                    <span class="font-medium text-sm">Settings</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/logout" class="nav-item flex items-center space-x-3 px-3 py-2.5 rounded-lg text-red-400 hover:bg-red-500/10">
                    <i class="fas fa-sign-out-alt w-5"></i>
                    <span class="font-medium text-sm">Logout</span>
                </a>
            </nav>
            
            <!-- Version -->
            <div class="absolute bottom-4 left-0 right-0 px-6">
                <p class="text-[10px] text-slate-600 text-center">Version 2.0.0</p>
            </div>
        </aside>
        
        <!-- Main Content -->
        <main class="flex-1 ml-64">
            <!-- Top Header -->
            <header class="bg-white/80 backdrop-blur-lg border-b border-slate-200 sticky top-0 z-40">
                <div class="flex items-center justify-between px-8 py-4">
                    <div>
                        <h2 class="text-xl font-bold text-slate-800">Data Mahasiswa</h2>
                        <p class="text-slate-500 text-sm">Kelola data mahasiswa terdaftar</p>
                    </div>
                    <div class="flex items-center space-x-3">
                        <button class="p-2.5 rounded-xl bg-slate-100 hover:bg-slate-200 transition-colors relative">
                            <i class="fas fa-bell text-slate-600"></i>
                            <span class="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full pulse-dot"></span>
                        </button>
                        <button class="p-2.5 rounded-xl bg-slate-100 hover:bg-slate-200 transition-colors">
                            <i class="fas fa-cog text-slate-600"></i>
                        </button>
                    </div>
                </div>
            </header>
            
            <div class="p-8">
                <!-- Alert Messages -->
                <c:if test="${not empty message}">
                    <div class="mb-6 p-4 rounded-xl flex items-center space-x-3 ${messageType == 'success' ? 'bg-emerald-50 border border-emerald-200' : 'bg-red-50 border border-red-200'}" id="alertBox">
                        <div class="flex-shrink-0">
                            <c:choose>
                                <c:when test="${messageType == 'success'}">
                                    <div class="w-10 h-10 rounded-full bg-emerald-100 flex items-center justify-center">
                                        <i class="fas fa-check text-emerald-600"></i>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="w-10 h-10 rounded-full bg-red-100 flex items-center justify-center">
                                        <i class="fas fa-exclamation text-red-600"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="flex-1">
                            <p class="${messageType == 'success' ? 'text-emerald-800' : 'text-red-800'} font-medium">${message}</p>
                        </div>
                        <button onclick="document.getElementById('alertBox').remove()" class="text-slate-400 hover:text-slate-600">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </c:if>
                
                <!-- Main Table Card -->
                <div class="bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden">
                    <!-- Table Header -->
                    <div class="p-6 border-b border-slate-100">
                        <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
                            <div class="flex items-center space-x-4">
                                <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-indigo-500 to-purple-500 flex items-center justify-center">
                                    <i class="fas fa-users text-white text-lg"></i>
                                </div>
                                <div>
                                    <h3 class="text-lg font-bold text-slate-800">Daftar Mahasiswa</h3>
                                    <p class="text-slate-500 text-sm">Total: ${fn:length(listMahasiswa)} mahasiswa terdaftar</p>
                                </div>
                            </div>
                            <div class="flex flex-wrap items-center gap-3">
                                <!-- Search -->
                                <form action="${pageContext.request.contextPath}/mahasiswa" method="GET" class="flex items-center gap-2">
                                    <input type="hidden" name="action" value="search">
                                    <div class="relative">
                                        <input type="text" name="keyword" value="${keyword}" placeholder="Cari NIM atau Nama..." 
                                               class="w-56 pl-9 pr-4 py-2 rounded-xl border border-slate-200 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-100 transition-all text-sm">
                                        <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-slate-400 text-sm"></i>
                                    </div>
                                    <button type="submit" class="p-2 bg-slate-100 hover:bg-slate-200 rounded-xl transition-colors">
                                        <i class="fas fa-search text-slate-600"></i>
                                    </button>
                                    <c:if test="${not empty keyword}">
                                        <a href="${pageContext.request.contextPath}/mahasiswa" class="p-2 bg-slate-100 hover:bg-slate-200 rounded-xl transition-colors" title="Reset">
                                            <i class="fas fa-times text-slate-600"></i>
                                        </a>
                                    </c:if>
                                </form>
                                
                                <!-- Add Button -->
                                <a href="${pageContext.request.contextPath}/mahasiswa?action=add" 
                                   class="inline-flex items-center px-4 py-2 rounded-xl bg-gradient-to-r from-indigo-500 to-purple-500 text-white font-medium text-sm shadow-lg shadow-indigo-500/25 hover:shadow-xl hover:shadow-indigo-500/30 transition-all hover:-translate-y-0.5">
                                    <i class="fas fa-plus mr-2"></i>
                                    Tambah Mahasiswa
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Table -->
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="bg-slate-50/80">
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">No</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Mahasiswa</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Jurusan</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Kontak</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Semester</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">IPK</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Status</th>
                                    <th class="px-6 py-4 text-center text-xs font-semibold text-slate-500 uppercase tracking-wider">Aksi</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100">
                                <c:forEach var="mahasiswa" items="${listMahasiswa}" varStatus="status">
                                    <tr class="table-row">
                                        <td class="px-6 py-4">
                                            <span class="text-slate-500 font-medium text-sm">${status.index + 1}</span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex items-center space-x-3">
                                                <div class="w-10 h-10 rounded-full bg-gradient-to-br from-indigo-400 to-purple-500 flex items-center justify-center text-white font-semibold text-sm shadow-sm">
                                                    ${fn:toUpperCase(fn:substring(mahasiswa.namaMahasiswa, 0, 1))}
                                                </div>
                                                <div>
                                                    <p class="font-semibold text-slate-800 text-sm">${mahasiswa.namaMahasiswa}</p>
                                                    <p class="text-xs text-slate-500">${mahasiswa.nim}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="inline-flex items-center px-2.5 py-1 rounded-lg bg-indigo-50 text-indigo-600 text-xs font-medium">
                                                <i class="fas fa-graduation-cap mr-1.5 text-[10px]"></i>
                                                ${mahasiswa.namaJurusan}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div>
                                                <p class="text-sm text-slate-700">${mahasiswa.email}</p>
                                                <p class="text-xs text-slate-400 flex items-center mt-0.5">
                                                    <i class="fas fa-phone mr-1"></i>${mahasiswa.telepon}
                                                </p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex items-center">
                                                <div class="w-8 h-8 rounded-lg bg-blue-50 flex items-center justify-center">
                                                    <span class="text-blue-600 font-bold text-sm">${mahasiswa.semesterAktif}</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex items-center space-x-2">
                                                <div class="w-16 bg-slate-200 rounded-full h-1.5">
                                                    <div class="bg-gradient-to-r from-indigo-500 to-purple-500 h-1.5 rounded-full progress-bar" style="width: ${mahasiswa.ipk / 4 * 100}%"></div>
                                                </div>
                                                <span class="text-sm font-semibold text-slate-700 w-10">${mahasiswa.ipk}</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${mahasiswa.status == 'Aktif'}">
                                                    <span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold bg-emerald-50 text-emerald-600">
                                                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-500 mr-1.5 pulse-dot"></span>
                                                        Aktif
                                                    </span>
                                                </c:when>
                                                <c:when test="${mahasiswa.status == 'Cuti'}">
                                                    <span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold bg-amber-50 text-amber-600">
                                                        <span class="w-1.5 h-1.5 rounded-full bg-amber-500 mr-1.5"></span>
                                                        Cuti
                                                    </span>
                                                </c:when>
                                                <c:when test="${mahasiswa.status == 'Lulus'}">
                                                    <span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold bg-blue-50 text-blue-600">
                                                        <span class="w-1.5 h-1.5 rounded-full bg-blue-500 mr-1.5"></span>
                                                        Lulus
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold bg-red-50 text-red-600">
                                                        <span class="w-1.5 h-1.5 rounded-full bg-red-500 mr-1.5"></span>
                                                        ${mahasiswa.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex items-center justify-center space-x-1">
                                                <a href="${pageContext.request.contextPath}/mahasiswa?action=edit&id=${mahasiswa.idMahasiswa}" 
                                                   class="p-2 rounded-lg text-blue-600 hover:bg-blue-50 transition-colors" title="Edit">
                                                    <i class="fas fa-pen text-sm"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/mahasiswa?action=delete&id=${mahasiswa.idMahasiswa}" 
                                                   onclick="return confirm('Apakah Anda yakin ingin menghapus mahasiswa ${mahasiswa.namaMahasiswa}?')"
                                                   class="p-2 rounded-lg text-red-600 hover:bg-red-50 transition-colors" title="Hapus">
                                                    <i class="fas fa-trash text-sm"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty listMahasiswa}">
                                    <tr>
                                        <td colspan="8" class="px-6 py-16 text-center">
                                            <div class="flex flex-col items-center">
                                                <div class="w-16 h-16 rounded-2xl bg-slate-100 flex items-center justify-center mb-4">
                                                    <i class="fas fa-inbox text-2xl text-slate-400"></i>
                                                </div>
                                                <p class="text-slate-600 font-medium">Tidak ada data mahasiswa</p>
                                                <p class="text-slate-400 text-sm mt-1">
                                                    <c:choose>
                                                        <c:when test="${not empty keyword}">
                                                            Tidak ditemukan hasil untuk "${keyword}"
                                                        </c:when>
                                                        <c:otherwise>
                                                            Mulai dengan menambahkan data baru
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <a href="${pageContext.request.contextPath}/mahasiswa?action=add" 
                                                   class="mt-4 inline-flex items-center px-4 py-2 rounded-lg bg-indigo-500 text-white text-sm font-medium hover:bg-indigo-600 transition-colors">
                                                    <i class="fas fa-plus mr-2"></i>Tambah Mahasiswa
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Table Footer -->
                    <div class="px-6 py-4 bg-slate-50/50 border-t border-slate-100">
                        <div class="flex flex-col sm:flex-row items-center justify-between gap-4">
                            <p class="text-sm text-slate-500">
                                Menampilkan <span class="font-semibold text-slate-700">${fn:length(listMahasiswa)}</span> data mahasiswa
                            </p>
                            <div class="flex items-center space-x-1">
                                <button class="px-3 py-1.5 rounded-lg bg-white border border-slate-200 text-slate-600 hover:bg-slate-50 transition-colors text-sm disabled:opacity-50" disabled>
                                    <i class="fas fa-chevron-left"></i>
                                </button>
                                <button class="px-3 py-1.5 rounded-lg bg-indigo-500 text-white text-sm font-medium">1</button>
                                <button class="px-3 py-1.5 rounded-lg bg-white border border-slate-200 text-slate-600 hover:bg-slate-50 transition-colors text-sm disabled:opacity-50" disabled>
                                    <i class="fas fa-chevron-right"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Footer -->
                <div class="mt-8 text-center">
                    <p class="text-sm text-slate-400">© 2024 UniManage - Sistem Manajemen Mahasiswa</p>
                </div>
            </div>
        </main>
    </div>
    
    <script>
        // Auto-hide alerts
        setTimeout(() => {
            const alertBox = document.getElementById('alertBox');
            if (alertBox) {
                alertBox.style.transition = 'opacity 0.5s ease';
                alertBox.style.opacity = '0';
                setTimeout(() => alertBox.remove(), 500);
            }
        }, 4000);
    </script>
</body>
</html>
