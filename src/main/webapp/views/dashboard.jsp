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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { 
            font-family: 'Plus Jakarta Sans', sans-serif; 
            background: linear-gradient(135deg, #f5f3ff 0%, #fdf2f8 50%, #f0f9ff 100%);
        }
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #f1f5f9; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 3px; }
        .sidebar-item { transition: all 0.2s ease; }
        .sidebar-item:hover { background: rgba(139, 92, 246, 0.08); }
        .sidebar-item.active { background: rgba(139, 92, 246, 0.12); color: #7c3aed; }
        .gradient-banner { background: linear-gradient(135deg, #a855f7 0%, #ec4899 50%, #f97316 100%); }
        .card-shadow { box-shadow: 0 1px 3px rgba(0,0,0,0.05), 0 1px 2px rgba(0,0,0,0.03); }
    </style>
</head>
<body class="min-h-screen text-slate-700">
    <div class="flex min-h-screen">
        <!-- Sidebar -->
        <aside class="w-64 bg-white/80 backdrop-blur-sm fixed h-full z-50 border-r border-slate-200/60">
            <!-- Logo -->
            <div class="p-6">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 rounded-xl bg-gradient-to-br from-violet-500 to-purple-600 flex items-center justify-center">
                        <i class="fas fa-graduation-cap text-white text-lg"></i>
                    </div>
                    <span class="font-bold text-xl text-slate-800">UniManage</span>
                </div>
            </div>
            <!-- Navigation -->
            <nav class="px-4 mt-2">
                <p class="text-xs font-semibold text-slate-400 uppercase tracking-wider px-3 mb-3">Menu</p>
                <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-item active flex items-center space-x-3 px-3 py-2.5 rounded-xl mb-1">
                    <i class="fas fa-th-large w-5"></i>
                    <span class="font-medium">Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/mahasiswa" class="sidebar-item flex items-center space-x-3 px-3 py-2.5 rounded-xl text-slate-600 mb-1">
                    <i class="fas fa-user-graduate w-5"></i>
                    <span class="font-medium">Mahasiswa</span>
                    <span class="ml-auto bg-violet-100 text-violet-600 text-xs font-semibold px-2 py-0.5 rounded-full">${totalMahasiswa}</span>
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
            <!-- User Profile -->
            <div class="absolute bottom-0 left-0 right-0 p-4 border-t border-slate-200/60">
                <div class="flex items-center space-x-3 p-2">
                    <div class="w-10 h-10 rounded-full bg-gradient-to-br from-violet-400 to-purple-500 flex items-center justify-center text-white font-semibold">
                        ${fn:toUpperCase(fn:substring(sessionScope.username, 0, 1))}
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="font-semibold text-slate-800 text-sm truncate">${sessionScope.namaLengkap != null ? sessionScope.namaLengkap : sessionScope.username}</p>
                        <p class="text-xs text-slate-500">${sessionScope.role}</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="p-2 text-slate-400 hover:text-red-500 transition-colors">
                        <i class="fas fa-sign-out-alt"></i>
                    </a>
                </div>
            </div>
        </aside>
        <!-- Main Content -->
        <main class="flex-1 ml-64">
            <!-- Header -->
            <header class="bg-white/60 backdrop-blur-sm border-b border-slate-200/60 sticky top-0 z-40">
                <div class="flex items-center justify-between px-8 py-4">
                    <div class="flex items-center space-x-4">
                        <div class="relative">
                            <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-slate-400"></i>
                            <input type="text" placeholder="Search..." class="pl-11 pr-4 py-2.5 w-80 bg-white rounded-xl border border-slate-200 focus:border-violet-400 focus:ring-2 focus:ring-violet-100 outline-none transition-all">
                        </div>
                    </div>
                    <div class="flex items-center space-x-4">
                        <button class="p-2.5 rounded-xl bg-white border border-slate-200 text-slate-600 hover:border-violet-300 transition-colors relative">
                            <i class="fas fa-bell"></i>
                            <span class="absolute -top-1 -right-1 w-4 h-4 bg-red-500 rounded-full text-[10px] text-white flex items-center justify-center">3</span>
                        </button>
                        <button class="p-2.5 rounded-xl bg-white border border-slate-200 text-slate-600 hover:border-violet-300 transition-colors">
                            <i class="fas fa-user"></i>
                        </button>
                        <div class="flex items-center space-x-2 px-4 py-2 bg-white rounded-xl border border-slate-200">
                            <i class="fas fa-calendar text-slate-400"></i>
                            <span class="text-sm font-medium text-slate-700">
                                <script>document.write(new Date().toLocaleDateString('id-ID', {day: 'numeric', month: 'long', year: 'numeric'}))</script>
                            </span>
                        </div>
                        <a href="${pageContext.request.contextPath}/mahasiswa?action=add" class="px-5 py-2.5 bg-violet-600 hover:bg-violet-700 text-white font-semibold rounded-xl transition-colors flex items-center space-x-2">
                            <span>Create</span>
                        </a>
                    </div>
                </div>
            </header>
            <div class="p-8">
                <h1 class="text-2xl font-bold text-slate-800 mb-6">Dashboard</h1>
                <!-- Two Column Layout -->
                <div class="grid grid-cols-3 gap-6">
                    <!-- Left Column - List -->
                    <!-- <div class="col-span-1">
                        <div class="bg-white rounded-2xl card-shadow p-4">
                            <div class="flex items-center justify-between mb-4">
                                <div class="relative flex-1 mr-3">
                                    <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-sm"></i>
                                    <input type="text" placeholder="Search mahasiswa..." class="pl-9 pr-3 py-2 w-full bg-slate-50 rounded-lg text-sm border-0 focus:ring-2 focus:ring-violet-100 outline-none">
                                </div>
                                <button class="p-2 rounded-lg bg-slate-50 text-slate-600"><i class="fas fa-filter text-sm"></i></button>
                                <a href="${pageContext.request.contextPath}/mahasiswa?action=add" class="p-2 rounded-lg bg-violet-600 text-white ml-2"><i class="fas fa-plus text-sm"></i></a>
                            </div>
                            <div class="space-y-2 max-h-96 overflow-y-auto">
                                <c:forEach var="mahasiswa" items="${listMahasiswa}" begin="0" end="5">
                                    <div class="flex items-center p-3 rounded-xl hover:bg-slate-50 transition-colors cursor-pointer group">
                                        <div class="w-10 h-10 rounded-full bg-gradient-to-br from-violet-400 to-purple-500 flex items-center justify-center text-white font-semibold text-sm mr-3">
                                            ${fn:toUpperCase(fn:substring(mahasiswa.namaMahasiswa, 0, 1))}
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <p class="font-semibold text-slate-800 text-sm truncate">${mahasiswa.namaMahasiswa}</p>
                                            <div class="flex items-center space-x-1">
                                                <span class="w-1.5 h-1.5 rounded-full ${mahasiswa.status == 'Aktif' ? 'bg-green-500' : mahasiswa.status == 'Cuti' ? 'bg-yellow-500' : 'bg-blue-500'}"></span>
                                                <span class="text-xs text-slate-500">${mahasiswa.status}</span>
                                            </div>
                                        </div>
                                        <span class="text-xs font-medium px-2 py-1 rounded-lg ${mahasiswa.status == 'Aktif' ? 'bg-green-50 text-green-600' : mahasiswa.status == 'Cuti' ? 'bg-yellow-50 text-yellow-600' : 'bg-blue-50 text-blue-600'}">${mahasiswa.namaJurusan}</span>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div> -->
                    <!-- Right Column - Detail -->
                    <div class="col-span-4">
                        <div class="bg-white rounded-2xl card-shadow p-6">
                            <!-- Stats Cards -->
                            <div class="grid grid-cols-3 gap-4 mb-6">
                                <div class="bg-gradient-to-br from-violet-50 to-purple-50 rounded-xl p-4 border border-violet-100">
                                    <div class="flex items-center justify-between mb-2">
                                        <span class="text-xs font-semibold text-violet-600">Total Mahasiswa</span>
                                        <i class="fas fa-thumbs-up text-violet-400"></i>
                                    </div>
                                    <p class="text-2xl font-bold text-slate-800">${totalMahasiswa}</p>
                                    <div class="flex items-center mt-2">
                                        <div class="flex-1 bg-violet-200 rounded-full h-1.5">
                                            <div class="bg-violet-500 h-1.5 rounded-full" style="width: 100%"></div>
                                        </div>
                                        <span class="text-xs text-violet-600 ml-2">Registered</span>
                                    </div>
                                </div>
                                <div class="bg-gradient-to-br from-emerald-50 to-teal-50 rounded-xl p-4 border border-emerald-100">
                                    <div class="flex items-center justify-between mb-2">
                                        <span class="text-xs font-semibold text-emerald-600">Mahasiswa Aktif</span>
                                        <i class="fas fa-check-circle text-emerald-400"></i>
                                    </div>
                                    <p class="text-2xl font-bold text-slate-800">${mahasiswaAktif}</p>
                                    <div class="flex items-center mt-2">
                                        <div class="flex-1 bg-emerald-200 rounded-full h-1.5">
                                            <div class="bg-emerald-500 h-1.5 rounded-full" style="width: 75%"></div>
                                        </div>
                                        <span class="text-xs text-emerald-600 ml-2">Active</span>
                                    </div>
                                </div>
                                <div class="bg-gradient-to-br from-amber-50 to-orange-50 rounded-xl p-4 border border-amber-100">
                                    <div class="flex items-center justify-between mb-2">
                                        <span class="text-xs font-semibold text-amber-600">Rata-rata IPK</span>
                                        <i class="fas fa-star text-amber-400"></i>
                                    </div>
                                    <p class="text-2xl font-bold text-slate-800">${avgIpk}</p>
                                    <div class="flex items-center mt-2">
                                        <div class="flex-1 bg-amber-200 rounded-full h-1.5">
                                            <div class="bg-amber-500 h-1.5 rounded-full" style="width: 85%"></div>
                                        </div>
                                        <span class="text-xs text-amber-600 ml-2">GPA</span>
                                    </div>
                                </div>
                            </div>
                            <!-- Progress Steps -->
                            <div class="mb-6">
                                <p class="text-sm font-semibold text-slate-800 mb-4">Status Overview</p>
                                <div class="flex items-center">
                                    <div class="flex-1 text-center">
                                        <div class="w-12 h-12 mx-auto rounded-xl bg-green-100 flex items-center justify-center text-green-600 mb-2">
                                            <i class="fas fa-user-check"></i>
                                        </div>
                                        <p class="text-lg font-bold text-slate-800">${mahasiswaAktif}</p>
                                        <p class="text-xs text-slate-500">Aktif</p>
                                    </div>
                                    <div class="w-16 h-0.5 bg-slate-200"></div>
                                    <div class="flex-1 text-center">
                                        <div class="w-12 h-12 mx-auto rounded-xl bg-yellow-100 flex items-center justify-center text-yellow-600 mb-2">
                                            <i class="fas fa-pause-circle"></i>
                                        </div>
                                        <p class="text-lg font-bold text-slate-800">${mahasiswaCuti}</p>
                                        <p class="text-xs text-slate-500">Cuti</p>
                                    </div>
                                    <div class="w-16 h-0.5 bg-slate-200"></div>
                                    <div class="flex-1 text-center">
                                        <div class="w-12 h-12 mx-auto rounded-xl bg-blue-100 flex items-center justify-center text-blue-600 mb-2">
                                            <i class="fas fa-graduation-cap"></i>
                                        </div>
                                        <p class="text-lg font-bold text-slate-800">${mahasiswaLulus}</p>
                                        <p class="text-xs text-slate-500">Lulus</p>
                                    </div>
                                </div>
                            </div>
                            <!-- Activity -->
                            <div>
                                <p class="text-sm font-semibold text-slate-800 mb-4">Recent Activity</p>
                                <div class="space-y-3">
                                    <c:forEach var="mahasiswa" items="${listMahasiswa}" begin="0" end="2">
                                        <div class="flex items-start space-x-3 p-3 rounded-xl bg-slate-50">
                                            <div class="w-8 h-8 rounded-full bg-gradient-to-br from-violet-400 to-purple-500 flex items-center justify-center text-white text-xs font-semibold">
                                                ${fn:toUpperCase(fn:substring(mahasiswa.namaMahasiswa, 0, 1))}
                                            </div>
                                            <div class="flex-1">
                                                <p class="text-sm"><span class="font-semibold text-slate-800">${mahasiswa.namaMahasiswa}</span> <span class="text-slate-500">registered as student</span></p>
                                                <p class="text-xs text-slate-400 mt-1">NIM: ${mahasiswa.nim}  ${mahasiswa.namaJurusan}</p>
                                            </div>
                                            <div class="flex space-x-1">
                                                <button class="p-1.5 rounded-lg hover:bg-slate-200 text-slate-400"><i class="fas fa-edit text-xs"></i></button>
                                                <button class="p-1.5 rounded-lg hover:bg-slate-200 text-slate-400"><i class="fas fa-copy text-xs"></i></button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Charts Section -->
                <div class="grid grid-cols-2 gap-6 mt-6">
                    <div class="bg-white rounded-2xl card-shadow p-6">
                        <p class="text-sm font-semibold text-slate-800 mb-4">Distribusi per Jurusan</p>
                        <div class="h-48">
                            <canvas id="jurusanChart"></canvas>
                        </div>
                    </div>
                    <div class="bg-white rounded-2xl card-shadow p-6">
                        <p class="text-sm font-semibold text-slate-800 mb-4">Status Mahasiswa</p>
                        <div class="h-48">
                            <canvas id="statusChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <script>
        const jurusanCtx = document.getElementById('jurusanChart').getContext('2d');
        new Chart(jurusanCtx, {
            type: 'doughnut',
            data: {
                labels: ['Teknik Informatika', 'Sistem Informasi', 'Bisnis Digital'],
                datasets: [{
                    data: [${countTI}, ${countSI}, ${countBD}],
                    backgroundColor: ['#8b5cf6', '#ec4899', '#f97316'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: { legend: { position: 'bottom', labels: { padding: 15, usePointStyle: true } } }
            }
        });
        const statusCtx = document.getElementById('statusChart').getContext('2d');
        new Chart(statusCtx, {
            type: 'bar',
            data: {
                labels: ['Aktif', 'Cuti', 'Lulus'],
                datasets: [{
                    data: [${mahasiswaAktif}, ${mahasiswaCuti}, ${mahasiswaLulus}],
                    backgroundColor: ['#22c55e', '#f59e0b', '#3b82f6'],
                    borderRadius: 8,
                    barThickness: 40
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } }, x: { grid: { display: false } } }
            }
        });
    </script>
</body>
</html>
