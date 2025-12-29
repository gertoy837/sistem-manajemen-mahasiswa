<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Mahasiswa - UniManage</title>
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
        .input-focus:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
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
                
                <a href="${pageContext.request.contextPath}/dashboard" class="nav-item flex items-center space-x-3 px-3 py-2.5 rounded-lg text-slate-300">
                    <i class="fas fa-th-large w-5"></i>
                    <span class="font-medium text-sm">Dashboard</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/mahasiswa" class="nav-item active flex items-center space-x-3 px-3 py-2.5 rounded-lg text-white">
                    <i class="fas fa-user-graduate w-5 text-indigo-400"></i>
                    <span class="font-medium text-sm">Mahasiswa</span>
                </a>
                
                <a href="#" class="nav-item flex items-center space-x-3 px-3 py-2.5 rounded-lg text-slate-300">
                    <i class="fas fa-chalkboard-teacher w-5"></i>
                    <span class="font-medium text-sm">Dosen</span>
                </a>
                
                <a href="#" class="nav-item flex items-center space-x-3 px-3 py-2.5 rounded-lg text-slate-300">
                    <i class="fas fa-book w-5"></i>
                    <span class="font-medium text-sm">Mata Kuliah</span>
                </a>
                
                <p class="text-[10px] font-semibold text-slate-500 uppercase tracking-wider px-3 mt-6 mb-3">Pengaturan</p>
                
                <a href="${pageContext.request.contextPath}/logout" class="nav-item flex items-center space-x-3 px-3 py-2.5 rounded-lg text-red-400 hover:bg-red-500/10">
                    <i class="fas fa-sign-out-alt w-5"></i>
                    <span class="font-medium text-sm">Logout</span>
                </a>
            </nav>
        </aside>
        
        <!-- Main Content -->
        <main class="flex-1 ml-64">
            <!-- Top Header -->
            <header class="bg-white/80 backdrop-blur-lg border-b border-slate-200 sticky top-0 z-40">
                <div class="flex items-center justify-between px-8 py-4">
                    <div class="flex items-center space-x-4">
                        <a href="${pageContext.request.contextPath}/mahasiswa" class="p-2 rounded-lg hover:bg-slate-100 transition-colors">
                            <i class="fas fa-arrow-left text-slate-600"></i>
                        </a>
                        <div>
                            <h2 class="text-xl font-bold text-slate-800">Tambah Mahasiswa</h2>
                            <p class="text-slate-500 text-sm">Tambahkan data mahasiswa baru</p>
                        </div>
                    </div>
                </div>
            </header>
            
            <div class="p-8">
                <!-- Form Card -->
                <div class="max-w-4xl mx-auto">
                    <div class="bg-white rounded-2xl shadow-sm border border-slate-100 overflow-hidden">
                        <!-- Form Header -->
                        <div class="px-8 py-6 border-b border-slate-100 bg-gradient-to-r from-indigo-500 to-purple-500">
                            <div class="flex items-center space-x-4">
                                <div class="w-14 h-14 rounded-xl bg-white/20 backdrop-blur flex items-center justify-center">
                                    <i class="fas fa-user-plus text-white text-xl"></i>
                                </div>
                                <div>
                                    <h3 class="text-xl font-bold text-white">Informasi Mahasiswa</h3>
                                    <p class="text-indigo-100 text-sm">Lengkapi semua field yang diperlukan</p>
                                </div>
                            </div>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/mahasiswa" method="POST" class="p-8">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- NIM -->
                                <div>
                                    <label for="nim" class="block text-sm font-semibold text-slate-700 mb-2">
                                        <i class="fas fa-id-card mr-2 text-indigo-500"></i>NIM <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="nim" name="nim" required 
                                           class="w-full px-4 py-3 rounded-xl border border-slate-200 input-focus transition-all text-sm"
                                           placeholder="Contoh: 2021001">
                                </div>
                                
                                <!-- Nama Mahasiswa -->
                                <div>
                                    <label for="namaMahasiswa" class="block text-sm font-semibold text-slate-700 mb-2">
                                        <i class="fas fa-user mr-2 text-indigo-500"></i>Nama Lengkap <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="namaMahasiswa" name="namaMahasiswa" required 
                                           class="w-full px-4 py-3 rounded-xl border border-slate-200 input-focus transition-all text-sm"
                                           placeholder="Nama lengkap mahasiswa">
                                </div>
                                
                                <!-- Email -->
                                <div>
                                    <label for="email" class="block text-sm font-semibold text-slate-700 mb-2">
                                        <i class="fas fa-envelope mr-2 text-indigo-500"></i>Email <span class="text-red-500">*</span>
                                    </label>
                                    <input type="email" id="email" name="email" required 
                                           class="w-full px-4 py-3 rounded-xl border border-slate-200 input-focus transition-all text-sm"
                                           placeholder="email@student.univ.ac.id">
                                </div>
                                
                                <!-- Telepon -->
                                <div>
                                    <label for="telepon" class="block text-sm font-semibold text-slate-700 mb-2">
                                        <i class="fas fa-phone mr-2 text-indigo-500"></i>Telepon <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="telepon" name="telepon" required 
                                           class="w-full px-4 py-3 rounded-xl border border-slate-200 input-focus transition-all text-sm"
                                           placeholder="08xxxxxxxxxx">
                                </div>
                                
                                <!-- Jurusan -->
                                <div>
                                    <label for="idJurusan" class="block text-sm font-semibold text-slate-700 mb-2">
                                        <i class="fas fa-graduation-cap mr-2 text-indigo-500"></i>Jurusan <span class="text-red-500">*</span>
                                    </label>
                                    <select id="idJurusan" name="idJurusan" required 
                                            class="w-full px-4 py-3 rounded-xl border border-slate-200 input-focus transition-all text-sm appearance-none bg-white">
                                        <option value="">-- Pilih Jurusan --</option>
                                        <c:forEach var="jurusan" items="${listJurusan}">
                                            <option value="${jurusan.idJurusan}">${jurusan.namaJurusan}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <!-- Tanggal Lahir -->
                                <div>
                                    <label for="tanggalLahir" class="block text-sm font-semibold text-slate-700 mb-2">
                                        <i class="fas fa-calendar mr-2 text-indigo-500"></i>Tanggal Lahir <span class="text-red-500">*</span>
                                    </label>
                                    <input type="date" id="tanggalLahir" name="tanggalLahir" required 
                                           class="w-full px-4 py-3 rounded-xl border border-slate-200 input-focus transition-all text-sm">
                                </div>
                                
                                <!-- Jenis Kelamin -->
                                <div>
                                    <label for="jenisKelamin" class="block text-sm font-semibold text-slate-700 mb-2">
                                        <i class="fas fa-venus-mars mr-2 text-indigo-500"></i>Jenis Kelamin <span class="text-red-500">*</span>
                                    </label>
                                    <select id="jenisKelamin" name="jenisKelamin" required 
                                            class="w-full px-4 py-3 rounded-xl border border-slate-200 input-focus transition-all text-sm appearance-none bg-white">
                                        <option value="">-- Pilih --</option>
                                        <option value="L">Laki-laki</option>
                                        <option value="P">Perempuan</option>
                                    </select>
                                </div>
                                
                                <!-- Semester -->
                                <div>
                                    <label for="semesterAktif" class="block text-sm font-semibold text-slate-700 mb-2">
                                        <i class="fas fa-layer-group mr-2 text-indigo-500"></i>Semester Aktif <span class="text-red-500">*</span>
                                    </label>
                                    <select id="semesterAktif" name="semesterAktif" required 
                                            class="w-full px-4 py-3 rounded-xl border border-slate-200 input-focus transition-all text-sm appearance-none bg-white">
                                        <option value="">-- Pilih --</option>
                                        <c:forEach begin="1" end="14" var="i">
                                            <option value="${i}">Semester ${i}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <!-- IPK -->
                                <div>
                                    <label for="ipk" class="block text-sm font-semibold text-slate-700 mb-2">
                                        <i class="fas fa-chart-line mr-2 text-indigo-500"></i>IPK
                                    </label>
                                    <input type="number" id="ipk" name="ipk" step="0.01" min="0" max="4" 
                                           class="w-full px-4 py-3 rounded-xl border border-slate-200 input-focus transition-all text-sm"
                                           placeholder="0.00 - 4.00" value="0.00">
                                </div>
                                
                                <!-- Status -->
                                <div>
                                    <label for="status" class="block text-sm font-semibold text-slate-700 mb-2">
                                        <i class="fas fa-toggle-on mr-2 text-indigo-500"></i>Status <span class="text-red-500">*</span>
                                    </label>
                                    <select id="status" name="status" required 
                                            class="w-full px-4 py-3 rounded-xl border border-slate-200 input-focus transition-all text-sm appearance-none bg-white">
                                        <option value="Aktif" selected>Aktif</option>
                                        <option value="Cuti">Cuti</option>
                                        <option value="Lulus">Lulus</option>
                                        <option value="Drop Out">Drop Out</option>
                                    </select>
                                </div>
                                
                                <!-- Alamat -->
                                <div class="md:col-span-2">
                                    <label for="alamat" class="block text-sm font-semibold text-slate-700 mb-2">
                                        <i class="fas fa-map-marker-alt mr-2 text-indigo-500"></i>Alamat <span class="text-red-500">*</span>
                                    </label>
                                    <textarea id="alamat" name="alamat" rows="3" required 
                                              class="w-full px-4 py-3 rounded-xl border border-slate-200 input-focus transition-all text-sm resize-none"
                                              placeholder="Alamat lengkap mahasiswa"></textarea>
                                </div>
                            </div>
                            
                            <!-- Form Actions -->
                            <div class="flex items-center justify-end space-x-4 mt-8 pt-6 border-t border-slate-100">
                                <a href="${pageContext.request.contextPath}/mahasiswa" 
                                   class="px-6 py-3 rounded-xl border border-slate-200 text-slate-600 font-medium text-sm hover:bg-slate-50 transition-colors">
                                    <i class="fas fa-times mr-2"></i>Batal
                                </a>
                                <button type="submit" 
                                        class="px-6 py-3 rounded-xl bg-gradient-to-r from-indigo-500 to-purple-500 text-white font-medium text-sm shadow-lg shadow-indigo-500/25 hover:shadow-xl hover:shadow-indigo-500/30 transition-all hover:-translate-y-0.5">
                                    <i class="fas fa-save mr-2"></i>Simpan Data
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
