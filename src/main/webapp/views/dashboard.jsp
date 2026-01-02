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
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        obsidian: {
                            900: '#0a0a0b',
                            800: '#121214',
                            700: '#1a1a1d',
                            600: '#232326',
                            500: '#2d2d31'
                        },
                        slate: {
                            700: '#3d3d42',
                            600: '#52525a',
                            500: '#6b6b75',
                            400: '#8b8b96',
                            300: '#a8a8b3'
                        },
                        cobalt: {
                            600: '#0052cc',
                            500: '#0066ff',
                            400: '#3385ff',
                            300: '#66a3ff'
                        }
                    },
                    fontFamily: {
                        mono: ['JetBrains Mono', 'monospace'],
                        sans: ['Inter', 'sans-serif']
                    },
                    borderRadius: {
                        DEFAULT: '4px'
                    }
                }
            }
        }
    </script>
    <style>
        body { 
            font-family: 'Inter', sans-serif; 
            background-color: #0a0a0b;
        }
        .font-mono { font-family: 'JetBrains Mono', monospace; }
        
        /* Custom scrollbar */
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-track { background: #121214; }
        ::-webkit-scrollbar-thumb { background: #3d3d42; border-radius: 3px; }
        ::-webkit-scrollbar-thumb:hover { background: #52525a; }
        
        /* Data indicator */
        .data-dot {
            width: 8px;
            height: 8px;
            background-color: #0066ff;
            border-radius: 2px;
        }
        
        .data-dot-pulse {
            animation: dataPulse 2s ease-in-out infinite;
        }
        
        @keyframes dataPulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }
        
        /* Status indicator */
        .status-online { background-color: #22c55e; }
        .status-offline { background-color: #6b6b75; }
    </style>
</head>
<body class="bg-obsidian-900 text-slate-300 min-h-screen">
    
    <div class="flex min-h-screen">
        <!-- Sidebar -->
        <aside class="w-60 bg-obsidian-800 border-r border-obsidian-600 fixed h-full z-50">
            <!-- Logo -->
            <div class="p-5 border-b border-obsidian-600">
                <div class="flex items-center space-x-3">
                    <div class="w-9 h-9 rounded bg-obsidian-600 flex items-center justify-center">
                        <i class="fas fa-cube text-cobalt-500"></i>
                    </div>
                    <div>
                        <h1 class="font-semibold text-white text-sm tracking-wide">UNIMANAGE</h1>
                        <p class="text-[10px] text-slate-500 font-mono">v2.1.0</p>
                    </div>
                </div>
            </div>
            
            <!-- User -->
            <div class="p-4 border-b border-obsidian-600">
                <div class="flex items-center space-x-3">
                    <div class="w-8 h-8 rounded bg-obsidian-600 flex items-center justify-center text-white text-xs font-mono">
                        ${fn:toUpperCase(fn:substring(sessionScope.username, 0, 2))}
                    </div>
                    <div class="flex-1 min-w-0">
                        <p class="text-sm text-white truncate">${sessionScope.namaLengkap != null ? sessionScope.namaLengkap : sessionScope.username}</p>
                        <p class="text-[10px] text-slate-500 font-mono uppercase">${sessionScope.role}</p>
                    </div>
                    <div class="w-2 h-2 rounded-sm status-online"></div>
                </div>
            </div>
            
            <!-- Navigation -->
            <nav class="p-3">
                <p class="text-[10px] font-semibold text-slate-500 uppercase tracking-wider px-3 mb-2 font-mono">Navigation</p>
                
                <a href="${pageContext.request.contextPath}/dashboard" class="flex items-center space-x-3 px-3 py-2 rounded bg-obsidian-600 text-white mb-1">
                    <i class="fas fa-grip w-4 text-cobalt-500 text-xs"></i>
                    <span class="text-sm">Dashboard</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/mahasiswa" class="flex items-center space-x-3 px-3 py-2 rounded hover:bg-obsidian-700 text-slate-400 hover:text-white transition-colors mb-1">
                    <i class="fas fa-user-graduate w-4 text-xs"></i>
                    <span class="text-sm">Mahasiswa</span>
                    <span class="ml-auto text-[10px] font-mono text-cobalt-500">${totalMahasiswa}</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/dosen" class="flex items-center space-x-3 px-3 py-2 rounded hover:bg-obsidian-700 text-slate-400 hover:text-white transition-colors mb-1">
                    <i class="fas fa-chalkboard-teacher w-4 text-xs"></i>
                    <span class="text-sm">Dosen</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/matakuliah" class="flex items-center space-x-3 px-3 py-2 rounded hover:bg-obsidian-700 text-slate-400 hover:text-white transition-colors mb-1">
                    <i class="fas fa-book w-4 text-xs"></i>
                    <span class="text-sm">Mata Kuliah</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/jurusan" class="flex items-center space-x-3 px-3 py-2 rounded hover:bg-obsidian-700 text-slate-400 hover:text-white transition-colors mb-1">
                    <i class="fas fa-building w-4 text-xs"></i>
                    <span class="text-sm">Jurusan</span>
                </a>
                
                <div class="border-t border-obsidian-600 my-3"></div>
                
                <a href="${pageContext.request.contextPath}/logout" class="flex items-center space-x-3 px-3 py-2 rounded hover:bg-red-900/20 text-slate-400 hover:text-red-400 transition-colors">
                    <i class="fas fa-arrow-right-from-bracket w-4 text-xs"></i>
                    <span class="text-sm">Logout</span>
                </a>
            </nav>
            
            <!-- System Status -->
            <div class="absolute bottom-0 left-0 right-0 p-4 border-t border-obsidian-600">
                <div class="flex items-center justify-between text-[10px] font-mono text-slate-500">
                    <span>SYS STATUS</span>
                    <div class="flex items-center space-x-1">
                        <div class="w-1.5 h-1.5 rounded-sm status-online"></div>
                        <span class="text-green-500">ONLINE</span>
                    </div>
                </div>
            </div>
        </aside>
        
        <!-- Main Content -->
        <main class="flex-1 ml-60">
            <!-- Top Header -->
            <header class="bg-obsidian-800 border-b border-obsidian-600 sticky top-0 z-40">
                <div class="flex items-center justify-between px-6 py-3">
                    <div class="flex items-center space-x-4">
                        <h2 class="text-white font-semibold">Dashboard</h2>
                        <div class="flex items-center space-x-2 text-[10px] font-mono text-slate-500">
                            <span>|</span>
                            <span>REAL-TIME MONITORING</span>
                            <div class="data-dot data-dot-pulse"></div>
                        </div>
                    </div>
                    <div class="flex items-center space-x-4">
                        <div class="text-right">
                            <p class="text-[10px] font-mono text-slate-500">LAST UPDATE</p>
                            <p class="text-xs font-mono text-slate-300">
                                <script>document.write(new Date().toLocaleTimeString('id-ID', {hour: '2-digit', minute: '2-digit', second: '2-digit'}))</script>
                            </p>
                        </div>
                        <div class="w-px h-6 bg-obsidian-600"></div>
                        <div class="text-right">
                            <p class="text-[10px] font-mono text-slate-500">DATE</p>
                            <p class="text-xs font-mono text-slate-300">
                                <script>document.write(new Date().toLocaleDateString('id-ID', {day: '2-digit', month: 'short', year: 'numeric'}).toUpperCase())</script>
                            </p>
                        </div>
                    </div>
                </div>
            </header>
            
            <div class="p-6">
                <!-- Stats Grid -->
                <div class="grid grid-cols-4 gap-4 mb-6">
                    <!-- Total Mahasiswa -->
                    <div class="bg-obsidian-800 border border-obsidian-600 rounded p-4">
                        <div class="flex items-start justify-between mb-3">
                            <p class="text-[10px] font-mono text-slate-500 uppercase">Total Mahasiswa</p>
                            <div class="data-dot"></div>
                        </div>
                        <p class="text-2xl font-semibold text-white font-mono">${totalMahasiswa}</p>
                        <p class="text-[10px] font-mono text-slate-500 mt-1">REGISTERED USERS</p>
                    </div>
                    
                    <!-- Mahasiswa Aktif -->
                    <div class="bg-obsidian-800 border border-obsidian-600 rounded p-4">
                        <div class="flex items-start justify-between mb-3">
                            <p class="text-[10px] font-mono text-slate-500 uppercase">Aktif</p>
                            <div class="w-2 h-2 rounded-sm status-online"></div>
                        </div>
                        <p class="text-2xl font-semibold text-white font-mono">${mahasiswaAktif}</p>
                        <p class="text-[10px] font-mono text-slate-500 mt-1">ACTIVE STATUS</p>
                    </div>
                    
                    <!-- IPK Rata-rata -->
                    <div class="bg-obsidian-800 border border-obsidian-600 rounded p-4">
                        <div class="flex items-start justify-between mb-3">
                            <p class="text-[10px] font-mono text-slate-500 uppercase">Rata-rata IPK</p>
                            <i class="fas fa-chart-line text-cobalt-500 text-xs"></i>
                        </div>
                        <p class="text-2xl font-semibold text-white font-mono">${avgIpk}</p>
                        <p class="text-[10px] font-mono text-slate-500 mt-1">GRADE POINT AVG</p>
                    </div>
                    
                    <!-- Total Jurusan -->
                    <div class="bg-obsidian-800 border border-obsidian-600 rounded p-4">
                        <div class="flex items-start justify-between mb-3">
                            <p class="text-[10px] font-mono text-slate-500 uppercase">Jurusan</p>
                            <i class="fas fa-layer-group text-slate-500 text-xs"></i>
                        </div>
                        <p class="text-2xl font-semibold text-white font-mono">${totalJurusan}</p>
                        <p class="text-[10px] font-mono text-slate-500 mt-1">DEPARTMENTS</p>
                    </div>
                </div>
                
                <!-- Charts Row -->
                <div class="grid grid-cols-2 gap-4 mb-6">
                    <!-- Distribution Chart -->
                    <div class="bg-obsidian-800 border border-obsidian-600 rounded p-4">
                        <div class="flex items-center justify-between mb-4">
                            <div>
                                <p class="text-sm font-semibold text-white">Distribusi per Jurusan</p>
                                <p class="text-[10px] font-mono text-slate-500">DEPARTMENT BREAKDOWN</p>
                            </div>
                            <div class="flex items-center space-x-1">
                                <div class="data-dot"></div>
                                <span class="text-[10px] font-mono text-cobalt-500">LIVE</span>
                            </div>
                        </div>
                        <div class="h-48">
                            <canvas id="jurusanChart"></canvas>
                        </div>
                        <!-- Legend -->
                        <div class="flex items-center justify-center space-x-6 mt-4 pt-4 border-t border-obsidian-600">
                            <div class="flex items-center space-x-2">
                                <div class="w-3 h-3 rounded-sm bg-cobalt-500"></div>
                                <span class="text-xs text-slate-400">Teknik Informatika</span>
                            </div>
                            <div class="flex items-center space-x-2">
                                <div class="w-3 h-3 rounded-sm" style="background-color: #3d3d42;"></div>
                                <span class="text-xs text-slate-400">Sistem Informasi</span>
                            </div>
                            <div class="flex items-center space-x-2">
                                <div class="w-3 h-3 rounded-sm" style="background-color: #6b6b75;"></div>
                                <span class="text-xs text-slate-400">Bisnis Digital</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Status Chart -->
                    <div class="bg-obsidian-800 border border-obsidian-600 rounded p-4">
                        <div class="flex items-center justify-between mb-4">
                            <div>
                                <p class="text-sm font-semibold text-white">Status Mahasiswa</p>
                                <p class="text-[10px] font-mono text-slate-500">ENROLLMENT STATUS</p>
                            </div>
                        </div>
                        <div class="h-48">
                            <canvas id="statusChart"></canvas>
                        </div>
                        <!-- Status Legend -->
                        <div class="grid grid-cols-3 gap-4 mt-4 pt-4 border-t border-obsidian-600">
                            <div class="text-center">
                                <p class="text-lg font-mono font-semibold text-white">${mahasiswaAktif}</p>
                                <p class="text-[10px] font-mono text-green-500">AKTIF</p>
                            </div>
                            <div class="text-center">
                                <p class="text-lg font-mono font-semibold text-white">${mahasiswaCuti}</p>
                                <p class="text-[10px] font-mono text-yellow-500">CUTI</p>
                            </div>
                            <div class="text-center">
                                <p class="text-lg font-mono font-semibold text-white">${mahasiswaLulus}</p>
                                <p class="text-[10px] font-mono text-cobalt-400">LULUS</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Data Table -->
                <div class="bg-obsidian-800 border border-obsidian-600 rounded">
                    <div class="flex items-center justify-between p-4 border-b border-obsidian-600">
                        <div>
                            <p class="text-sm font-semibold text-white">Data Mahasiswa Terbaru</p>
                            <p class="text-[10px] font-mono text-slate-500">RECENT RECORDS</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/mahasiswa" class="text-xs font-mono text-cobalt-500 hover:text-cobalt-400 transition-colors">
                            VIEW ALL →
                        </a>
                    </div>
                    
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="border-b border-obsidian-600">
                                    <th class="text-left py-3 px-4 text-[10px] font-mono font-semibold text-slate-500 uppercase">ID</th>
                                    <th class="text-left py-3 px-4 text-[10px] font-mono font-semibold text-slate-500 uppercase">NIM</th>
                                    <th class="text-left py-3 px-4 text-[10px] font-mono font-semibold text-slate-500 uppercase">Nama</th>
                                    <th class="text-left py-3 px-4 text-[10px] font-mono font-semibold text-slate-500 uppercase">Jurusan</th>
                                    <th class="text-left py-3 px-4 text-[10px] font-mono font-semibold text-slate-500 uppercase">IPK</th>
                                    <th class="text-left py-3 px-4 text-[10px] font-mono font-semibold text-slate-500 uppercase">Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="mahasiswa" items="${listMahasiswa}" begin="0" end="7" varStatus="loop">
                                    <tr class="border-b border-obsidian-700 hover:bg-obsidian-700/50 transition-colors">
                                        <td class="py-3 px-4">
                                            <span class="text-xs font-mono text-slate-500">#${loop.index + 1}</span>
                                        </td>
                                        <td class="py-3 px-4">
                                            <span class="text-xs font-mono text-cobalt-400">${mahasiswa.nim}</span>
                                        </td>
                                        <td class="py-3 px-4">
                                            <span class="text-sm text-white">${mahasiswa.namaMahasiswa}</span>
                                        </td>
                                        <td class="py-3 px-4">
                                            <span class="text-xs text-slate-400">${mahasiswa.namaJurusan}</span>
                                        </td>
                                        <td class="py-3 px-4">
                                            <span class="text-xs font-mono text-white">${mahasiswa.ipk}</span>
                                        </td>
                                        <td class="py-3 px-4">
                                            <c:choose>
                                                <c:when test="${mahasiswa.status == 'Aktif'}">
                                                    <span class="inline-flex items-center space-x-1 px-2 py-0.5 rounded text-[10px] font-mono bg-green-900/30 text-green-400 border border-green-800/50">
                                                        <span class="w-1 h-1 rounded-sm bg-green-400"></span>
                                                        <span>AKTIF</span>
                                                    </span>
                                                </c:when>
                                                <c:when test="${mahasiswa.status == 'Cuti'}">
                                                    <span class="inline-flex items-center px-2 py-0.5 rounded text-[10px] font-mono bg-yellow-900/30 text-yellow-400 border border-yellow-800/50">
                                                        CUTI
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center px-2 py-0.5 rounded text-[10px] font-mono bg-cobalt-900/30 text-cobalt-400 border border-cobalt-800/50">
                                                        ${fn:toUpperCase(mahasiswa.status)}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listMahasiswa}">
                                    <tr>
                                        <td colspan="6" class="py-8 text-center">
                                            <p class="text-slate-500 text-sm">No data available</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="grid grid-cols-3 gap-4 mt-6">
                    <a href="${pageContext.request.contextPath}/mahasiswa?action=add" 
                       class="bg-obsidian-800 border border-obsidian-600 rounded p-4 hover:border-cobalt-500 transition-colors group">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 rounded bg-obsidian-600 flex items-center justify-center group-hover:bg-cobalt-500/20 transition-colors">
                                <i class="fas fa-user-plus text-cobalt-500"></i>
                            </div>
                            <div>
                                <p class="text-sm text-white">Tambah Mahasiswa</p>
                                <p class="text-[10px] font-mono text-slate-500">CREATE NEW RECORD</p>
                            </div>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/dosen/new" 
                       class="bg-obsidian-800 border border-obsidian-600 rounded p-4 hover:border-cobalt-500 transition-colors group">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 rounded bg-obsidian-600 flex items-center justify-center group-hover:bg-cobalt-500/20 transition-colors">
                                <i class="fas fa-chalkboard-teacher text-slate-400 group-hover:text-cobalt-500 transition-colors"></i>
                            </div>
                            <div>
                                <p class="text-sm text-white">Tambah Dosen</p>
                                <p class="text-[10px] font-mono text-slate-500">ADD INSTRUCTOR</p>
                            </div>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/matakuliah/new" 
                       class="bg-obsidian-800 border border-obsidian-600 rounded p-4 hover:border-cobalt-500 transition-colors group">
                        <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 rounded bg-obsidian-600 flex items-center justify-center group-hover:bg-cobalt-500/20 transition-colors">
                                <i class="fas fa-book text-slate-400 group-hover:text-cobalt-500 transition-colors"></i>
                            </div>
                            <div>
                                <p class="text-sm text-white">Tambah Mata Kuliah</p>
                                <p class="text-[10px] font-mono text-slate-500">ADD COURSE</p>
                            </div>
                        </div>
                    </a>
                </div>
                
                <!-- Footer -->
                <div class="mt-8 pt-4 border-t border-obsidian-600 flex items-center justify-between">
                    <p class="text-[10px] font-mono text-slate-600">© 2024 UNIMANAGE SYSTEM</p>
                    <p class="text-[10px] font-mono text-slate-600">BUILD 2.1.0 | PRODUCTION</p>
                </div>
            </div>
        </main>
    </div>
    
    <script>
        // Chart.js global config for dark theme
        Chart.defaults.color = '#6b6b75';
        Chart.defaults.borderColor = '#232326';
        
        // Distribusi Jurusan Chart
        const jurusanCtx = document.getElementById('jurusanChart').getContext('2d');
        new Chart(jurusanCtx, {
            type: 'doughnut',
            data: {
                labels: ['Teknik Informatika', 'Sistem Informasi', 'Bisnis Digital'],
                datasets: [{
                    data: [${countTI}, ${countSI}, ${countBD}],
                    backgroundColor: [
                        '#0066ff',
                        '#3d3d42',
                        '#6b6b75'
                    ],
                    borderColor: '#121214',
                    borderWidth: 2,
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: {
                    legend: {
                        display: false
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
                    data: [${mahasiswaAktif}, ${mahasiswaCuti}, ${mahasiswaLulus}],
                    backgroundColor: [
                        '#22c55e',
                        '#eab308',
                        '#0066ff'
                    ],
                    borderColor: 'transparent',
                    borderWidth: 0,
                    borderRadius: 2,
                    barThickness: 32
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
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            font: {
                                family: 'JetBrains Mono',
                                size: 10
                            }
                        }
                    },
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: '#1a1a1d'
                        },
                        ticks: {
                            stepSize: 1,
                            font: {
                                family: 'JetBrains Mono',
                                size: 10
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
