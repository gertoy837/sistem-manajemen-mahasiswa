<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - UniManage</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .card-hover:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 40px -12px rgba(0, 0, 0, 0.15);
        }
        .stat-icon {
            animation: float 3s ease-in-out infinite;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-6px); }
        }
        .pulse-dot {
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.7; transform: scale(1.1); }
        }
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
                
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-item active flex items-center space-x-3 px-3 py-2.5 rounded-lg text-white">
                    <i class="fas fa-th-large w-5 text-indigo-400"></i>
                    <span class="font-medium text-sm">Dashboard</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/mahasiswa" class="nav-item flex items-center space-x-3 px-3 py-2.5 rounded-lg text-slate-300">
                    <i class="fas fa-user-graduate w-5"></i>
                    <span class="font-medium text-sm">Mahasiswa</span>
                    <span class="ml-auto bg-indigo-500 text-white text-[10px] font-bold px-1.5 py-0.5 rounded">${totalMahasiswa}</span>
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
                        <h2 class="text-xl font-bold text-slate-800">Dashboard</h2>
                        <p class="text-slate-500 text-sm">Selamat datang kembali, ${sessionScope.namaLengkap != null ? sessionScope.namaLengkap : sessionScope.username}! 👋</p>
                    </div>
                    <div class="flex items-center space-x-3">
                        <div class="text-right mr-4">
                            <p class="text-xs text-slate-400">Hari ini</p>
                            <p class="text-sm font-semibold text-slate-700">
                                <script>document.write(new Date().toLocaleDateString('id-ID', {weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'}))</script>
                            </p>
                        </div>
                        <button class="p-2.5 rounded-xl bg-slate-100 hover:bg-slate-200 transition-colors relative">
                            <i class="fas fa-bell text-slate-600"></i>
                            <span class="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full pulse-dot"></span>
                        </button>
                    </div>
                </div>
            </header>
            
            <div class="p-8">
                <!-- Welcome Banner -->
                <div class="bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500 rounded-2xl p-8 mb-8 text-white relative overflow-hidden">
                    <div class="absolute right-0 top-0 w-64 h-64 bg-white/10 rounded-full -translate-y-1/2 translate-x-1/2"></div>
                    <div class="absolute right-20 bottom-0 w-32 h-32 bg-white/10 rounded-full translate-y-1/2"></div>
                    <div class="relative z-10">
                        <h1 class="text-3xl font-bold mb-2">Selamat Datang di UniManage! 🎓</h1>
                        <p class="text-indigo-100 text-lg mb-4">Sistem Manajemen Mahasiswa Universitas</p>
                        <div class="flex items-center space-x-6 text-sm">
                            <div class="flex items-center">
                                <i class="fas fa-users mr-2"></i>
                                <span>${totalMahasiswa} Total Mahasiswa</span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-check-circle mr-2"></i>
                                <span>${mahasiswaAktif} Aktif</span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-graduation-cap mr-2"></i>
                                <span>${totalJurusan} Jurusan</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Stats Cards -->
                <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">
                    <!-- Total Mahasiswa -->
                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover border border-slate-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-slate-500 text-sm font-medium">Total Mahasiswa</p>
                                <h3 class="text-3xl font-bold text-slate-800 mt-1">${totalMahasiswa}</h3>
                                <div class="flex items-center mt-2 text-sm">
                                    <span class="text-emerald-500 flex items-center">
                                        <i class="fas fa-arrow-up mr-1 text-xs"></i>Terdaftar
                                    </span>
                                </div>
                            </div>
                            <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-blue-500 to-blue-600 flex items-center justify-center shadow-lg shadow-blue-500/25 stat-icon">
                                <i class="fas fa-user-graduate text-white text-xl"></i>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Mahasiswa Aktif -->
                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover border border-slate-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-slate-500 text-sm font-medium">Mahasiswa Aktif</p>
                                <h3 class="text-3xl font-bold text-slate-800 mt-1">${mahasiswaAktif}</h3>
                                <div class="flex items-center mt-2 text-sm">
                                    <span class="text-emerald-500 flex items-center">
                                        <i class="fas fa-check-circle mr-1 text-xs"></i>Online
                                    </span>
                                </div>
                            </div>
                            <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-emerald-500 to-emerald-600 flex items-center justify-center shadow-lg shadow-emerald-500/25 stat-icon" style="animation-delay: 0.3s;">
                                <i class="fas fa-user-check text-white text-xl"></i>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Rata-rata IPK -->
                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover border border-slate-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-slate-500 text-sm font-medium">Rata-rata IPK</p>
                                <h3 class="text-3xl font-bold text-slate-800 mt-1">${avgIpk}</h3>
                                <div class="flex items-center mt-2 text-sm">
                                    <span class="text-amber-500 flex items-center">
                                        <i class="fas fa-chart-line mr-1 text-xs"></i>Prestasi
                                    </span>
                                </div>
                            </div>
                            <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-amber-500 to-orange-500 flex items-center justify-center shadow-lg shadow-amber-500/25 stat-icon" style="animation-delay: 0.6s;">
                                <i class="fas fa-star text-white text-xl"></i>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Total Jurusan -->
                    <div class="bg-white rounded-2xl p-6 shadow-sm card-hover border border-slate-100">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-slate-500 text-sm font-medium">Total Jurusan</p>
                                <h3 class="text-3xl font-bold text-slate-800 mt-1">${totalJurusan}</h3>
                                <div class="flex items-center mt-2 text-sm">
                                    <span class="text-purple-500 flex items-center">
                                        <i class="fas fa-building mr-1 text-xs"></i>Program Studi
                                    </span>
                                </div>
                            </div>
                            <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-purple-500 to-pink-500 flex items-center justify-center shadow-lg shadow-purple-500/25 stat-icon" style="animation-delay: 0.9s;">
                                <i class="fas fa-layer-group text-white text-xl"></i>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Charts Row -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
                    <!-- Distribusi Jurusan -->
                    <div class="bg-white rounded-2xl p-6 shadow-sm border border-slate-100">
                        <h3 class="text-lg font-bold text-slate-800 mb-4">Distribusi Mahasiswa per Jurusan</h3>
                        <div class="relative h-64">
                            <canvas id="jurusanChart"></canvas>
                        </div>
                    </div>
                    
                    <!-- Status Mahasiswa -->
                    <div class="bg-white rounded-2xl p-6 shadow-sm border border-slate-100">
                        <h3 class="text-lg font-bold text-slate-800 mb-4">Status Mahasiswa</h3>
                        <div class="relative h-64">
                            <canvas id="statusChart"></canvas>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions & Recent -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    <!-- Quick Actions -->
                    <div class="bg-white rounded-2xl p-6 shadow-sm border border-slate-100">
                        <h3 class="text-lg font-bold text-slate-800 mb-4">Aksi Cepat</h3>
                        <div class="space-y-3">
                            <a href="${pageContext.request.contextPath}/mahasiswa?action=add" 
                               class="flex items-center p-4 rounded-xl bg-gradient-to-r from-indigo-50 to-purple-50 hover:from-indigo-100 hover:to-purple-100 transition-all group">
                                <div class="w-10 h-10 rounded-lg bg-indigo-500 flex items-center justify-center mr-4 group-hover:scale-110 transition-transform">
                                    <i class="fas fa-user-plus text-white"></i>
                                </div>
                                <div>
                                    <p class="font-semibold text-slate-800">Tambah Mahasiswa</p>
                                    <p class="text-xs text-slate-500">Daftarkan mahasiswa baru</p>
                                </div>
                                <i class="fas fa-chevron-right ml-auto text-slate-400"></i>
                            </a>
                            
                            <a href="${pageContext.request.contextPath}/mahasiswa" 
                               class="flex items-center p-4 rounded-xl bg-gradient-to-r from-emerald-50 to-teal-50 hover:from-emerald-100 hover:to-teal-100 transition-all group">
                                <div class="w-10 h-10 rounded-lg bg-emerald-500 flex items-center justify-center mr-4 group-hover:scale-110 transition-transform">
                                    <i class="fas fa-list text-white"></i>
                                </div>
                                <div>
                                    <p class="font-semibold text-slate-800">Lihat Semua Data</p>
                                    <p class="text-xs text-slate-500">Kelola data mahasiswa</p>
                                </div>
                                <i class="fas fa-chevron-right ml-auto text-slate-400"></i>
                            </a>
                            
                            <div class="flex items-center p-4 rounded-xl bg-gradient-to-r from-amber-50 to-orange-50 hover:from-amber-100 hover:to-orange-100 transition-all group cursor-pointer">
                                <div class="w-10 h-10 rounded-lg bg-amber-500 flex items-center justify-center mr-4 group-hover:scale-110 transition-transform">
                                    <i class="fas fa-file-export text-white"></i>
                                </div>
                                <div>
                                    <p class="font-semibold text-slate-800">Export Data</p>
                                    <p class="text-xs text-slate-500">Download laporan</p>
                                </div>
                                <i class="fas fa-chevron-right ml-auto text-slate-400"></i>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent Students -->
                    <div class="lg:col-span-2 bg-white rounded-2xl p-6 shadow-sm border border-slate-100">
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-lg font-bold text-slate-800">Mahasiswa Terbaru</h3>
                            <a href="${pageContext.request.contextPath}/mahasiswa" class="text-sm text-indigo-500 hover:text-indigo-600 font-medium">
                                Lihat Semua <i class="fas fa-arrow-right ml-1"></i>
                            </a>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="w-full">
                                <thead>
                                    <tr class="border-b border-slate-100">
                                        <th class="text-left py-3 px-4 text-xs font-semibold text-slate-500 uppercase">Mahasiswa</th>
                                        <th class="text-left py-3 px-4 text-xs font-semibold text-slate-500 uppercase">Jurusan</th>
                                        <th class="text-left py-3 px-4 text-xs font-semibold text-slate-500 uppercase">IPK</th>
                                        <th class="text-left py-3 px-4 text-xs font-semibold text-slate-500 uppercase">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="mahasiswa" items="${listMahasiswa}" begin="0" end="4">
                                        <tr class="border-b border-slate-50 hover:bg-slate-50/50">
                                            <td class="py-3 px-4">
                                                <div class="flex items-center space-x-3">
                                                    <div class="w-8 h-8 rounded-full bg-gradient-to-br from-indigo-400 to-purple-500 flex items-center justify-center text-white font-semibold text-xs">
                                                        ${fn:toUpperCase(fn:substring(mahasiswa.namaMahasiswa, 0, 1))}
                                                    </div>
                                                    <div>
                                                        <p class="font-medium text-slate-800 text-sm">${mahasiswa.namaMahasiswa}</p>
                                                        <p class="text-xs text-slate-400">${mahasiswa.nim}</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="py-3 px-4">
                                                <span class="text-sm text-slate-600">${mahasiswa.namaJurusan}</span>
                                            </td>
                                            <td class="py-3 px-4">
                                                <span class="font-semibold text-sm text-slate-700">${mahasiswa.ipk}</span>
                                            </td>
                                            <td class="py-3 px-4">
                                                <c:choose>
                                                    <c:when test="${mahasiswa.status == 'Aktif'}">
                                                        <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-emerald-50 text-emerald-600">
                                                            <span class="w-1 h-1 rounded-full bg-emerald-500 mr-1"></span>
                                                            Aktif
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${mahasiswa.status == 'Cuti'}">
                                                        <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-amber-50 text-amber-600">
                                                            Cuti
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center px-2 py-0.5 rounded-full text-xs font-medium bg-blue-50 text-blue-600">
                                                            ${mahasiswa.status}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
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
        // Distribusi Jurusan Chart
        const jurusanCtx = document.getElementById('jurusanChart').getContext('2d');
        new Chart(jurusanCtx, {
            type: 'doughnut',
            data: {
                labels: ['Teknik Informatika', 'Sistem Informasi', 'Bisnis Digital'],
                datasets: [{
                    data: [${countTI}, ${countSI}, ${countBD}],
                    backgroundColor: [
                        'rgba(99, 102, 241, 0.8)',
                        'rgba(16, 185, 129, 0.8)',
                        'rgba(245, 158, 11, 0.8)'
                    ],
                    borderColor: [
                        'rgba(99, 102, 241, 1)',
                        'rgba(16, 185, 129, 1)',
                        'rgba(245, 158, 11, 1)'
                    ],
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true
                        }
                    }
                }
            }
        });
        
        // Status Mahasiswa Chart
        const statusCtx = document.getElementById('statusChart').getContext('2d');
        new Chart(statusCtx, {
            type: 'bar',
            data: {
                labels: ['Aktif', 'Cuti', 'Lulus'],
                datasets: [{
                    label: 'Jumlah Mahasiswa',
                    data: [${mahasiswaAktif}, ${mahasiswaCuti}, ${mahasiswaLulus}],
                    backgroundColor: [
                        'rgba(16, 185, 129, 0.8)',
                        'rgba(245, 158, 11, 0.8)',
                        'rgba(59, 130, 246, 0.8)'
                    ],
                    borderColor: [
                        'rgba(16, 185, 129, 1)',
                        'rgba(245, 158, 11, 1)',
                        'rgba(59, 130, 246, 1)'
                    ],
                    borderWidth: 2,
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
