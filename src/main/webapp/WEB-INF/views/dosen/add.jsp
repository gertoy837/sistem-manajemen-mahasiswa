<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Dosen - Sistem Manajemen Mahasiswa</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-gray-50">
    <div class="flex h-screen">
        <!-- Sidebar -->
        <aside class="w-64 bg-gradient-to-b from-blue-800 to-blue-900 text-white flex flex-col">
            <div class="p-6 border-b border-blue-700">
                <div class="flex items-center space-x-3">
                    <div class="bg-white/20 p-2 rounded-lg">
                        <i class="fas fa-graduation-cap text-2xl"></i>
                    </div>
                    <div>
                        <h1 class="font-bold text-lg">SIAKAD</h1>
                        <p class="text-blue-200 text-xs">Universitas</p>
                    </div>
                </div>
            </div>
            
            <nav class="flex-1 p-4 space-y-1">
                <a href="${pageContext.request.contextPath}/dashboard" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-blue-100 hover:bg-white/10 transition">
                    <i class="fas fa-chart-pie w-5"></i>
                    <span>Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/mahasiswa" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-blue-100 hover:bg-white/10 transition">
                    <i class="fas fa-user-graduate w-5"></i>
                    <span>Mahasiswa</span>
                </a>
                <a href="${pageContext.request.contextPath}/dosen" class="flex items-center space-x-3 px-4 py-3 rounded-lg bg-white/20 text-white transition">
                    <i class="fas fa-chalkboard-teacher w-5"></i>
                    <span>Dosen</span>
                </a>
                <a href="${pageContext.request.contextPath}/matakuliah" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-blue-100 hover:bg-white/10 transition">
                    <i class="fas fa-book w-5"></i>
                    <span>Mata Kuliah</span>
                </a>
                <a href="${pageContext.request.contextPath}/jurusan" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-blue-100 hover:bg-white/10 transition">
                    <i class="fas fa-building w-5"></i>
                    <span>Jurusan</span>
                </a>
            </nav>
            
            <div class="p-4 border-t border-blue-700">
                <a href="${pageContext.request.contextPath}/logout" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-blue-100 hover:bg-red-500/20 transition">
                    <i class="fas fa-sign-out-alt w-5"></i>
                    <span>Logout</span>
                </a>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="flex-1 flex flex-col overflow-hidden">
            <!-- Top Bar -->
            <header class="bg-white shadow-sm border-b border-gray-200 px-8 py-4">
                <div class="flex items-center justify-between">
                    <div>
                        <h2 class="text-2xl font-bold text-gray-800">Tambah Dosen</h2>
                        <p class="text-gray-500 text-sm">Tambahkan data dosen baru</p>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <main class="flex-1 overflow-y-auto p-8">
                <div class="max-w-4xl mx-auto">
                    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                        <form action="${pageContext.request.contextPath}/dosen/insert" method="post">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- NIP -->
                                <div>
                                    <label for="nip" class="block text-sm font-medium text-gray-700 mb-2">
                                        NIP <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="nip" name="nip" required
                                           class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                           placeholder="Masukkan NIP">
                                </div>

                                <!-- Nama Dosen -->
                                <div>
                                    <label for="namaDosen" class="block text-sm font-medium text-gray-700 mb-2">
                                        Nama Dosen <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="namaDosen" name="namaDosen" required
                                           class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                           placeholder="Masukkan nama lengkap">
                                </div>

                                <!-- Jurusan -->
                                <div>
                                    <label for="idJurusan" class="block text-sm font-medium text-gray-700 mb-2">
                                        Jurusan <span class="text-red-500">*</span>
                                    </label>
                                    <select id="idJurusan" name="idJurusan" required
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <option value="">Pilih Jurusan</option>
                                        <c:forEach var="jurusan" items="${listJurusan}">
                                            <option value="${jurusan.idJurusan}">${jurusan.namaJurusan}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Email -->
                                <div>
                                    <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                                        Email
                                    </label>
                                    <input type="email" id="email" name="email"
                                           class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                           placeholder="Masukkan email">
                                </div>

                                <!-- Telepon -->
                                <div>
                                    <label for="telepon" class="block text-sm font-medium text-gray-700 mb-2">
                                        Telepon
                                    </label>
                                    <input type="text" id="telepon" name="telepon"
                                           class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                           placeholder="Masukkan nomor telepon">
                                </div>

                                <!-- Jenis Kelamin -->
                                <div>
                                    <label for="jenisKelamin" class="block text-sm font-medium text-gray-700 mb-2">
                                        Jenis Kelamin <span class="text-red-500">*</span>
                                    </label>
                                    <select id="jenisKelamin" name="jenisKelamin" required
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <option value="">Pilih Jenis Kelamin</option>
                                        <option value="L">Laki-laki</option>
                                        <option value="P">Perempuan</option>
                                    </select>
                                </div>

                                <!-- Tanggal Lahir -->
                                <div>
                                    <label for="tanggalLahir" class="block text-sm font-medium text-gray-700 mb-2">
                                        Tanggal Lahir
                                    </label>
                                    <input type="date" id="tanggalLahir" name="tanggalLahir"
                                           class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                </div>

                                <!-- Pendidikan Terakhir -->
                                <div>
                                    <label for="pendidikanTerakhir" class="block text-sm font-medium text-gray-700 mb-2">
                                        Pendidikan Terakhir <span class="text-red-500">*</span>
                                    </label>
                                    <select id="pendidikanTerakhir" name="pendidikanTerakhir" required
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <option value="">Pilih Pendidikan</option>
                                        <option value="S1">S1</option>
                                        <option value="S2">S2</option>
                                        <option value="S3">S3</option>
                                    </select>
                                </div>

                                <!-- Status -->
                                <div>
                                    <label for="status" class="block text-sm font-medium text-gray-700 mb-2">
                                        Status <span class="text-red-500">*</span>
                                    </label>
                                    <select id="status" name="status" required
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <option value="">Pilih Status</option>
                                        <option value="Aktif">Aktif</option>
                                        <option value="Tidak Aktif">Tidak Aktif</option>
                                        <option value="Cuti">Cuti</option>
                                    </select>
                                </div>

                                <!-- Alamat -->
                                <div class="md:col-span-2">
                                    <label for="alamat" class="block text-sm font-medium text-gray-700 mb-2">
                                        Alamat
                                    </label>
                                    <textarea id="alamat" name="alamat" rows="3"
                                              class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                              placeholder="Masukkan alamat lengkap"></textarea>
                                </div>
                            </div>

                            <!-- Buttons -->
                            <div class="flex items-center justify-end space-x-4 mt-8 pt-6 border-t border-gray-200">
                                <a href="${pageContext.request.contextPath}/dosen" 
                                   class="px-6 py-2.5 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition">
                                    Batal
                                </a>
                                <button type="submit" 
                                        class="px-6 py-2.5 bg-gradient-to-r from-blue-600 to-blue-700 text-white rounded-lg hover:from-blue-700 hover:to-blue-800 transition">
                                    <i class="fas fa-save mr-2"></i>
                                    Simpan
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
