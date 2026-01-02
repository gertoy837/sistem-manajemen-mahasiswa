<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Mata Kuliah - Sistem Manajemen Mahasiswa</title>
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
                <a href="${pageContext.request.contextPath}/dosen" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-blue-100 hover:bg-white/10 transition">
                    <i class="fas fa-chalkboard-teacher w-5"></i>
                    <span>Dosen</span>
                </a>
                <a href="${pageContext.request.contextPath}/matakuliah" class="flex items-center space-x-3 px-4 py-3 rounded-lg bg-white/20 text-white transition">
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
                        <h2 class="text-2xl font-bold text-gray-800">Tambah Mata Kuliah</h2>
                        <p class="text-gray-500 text-sm">Tambahkan mata kuliah baru</p>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <main class="flex-1 overflow-y-auto p-8">
                <div class="max-w-4xl mx-auto">
                    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                        <form action="${pageContext.request.contextPath}/matakuliah/insert" method="post">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- Kode Mata Kuliah -->
                                <div>
                                    <label for="kodeMatakuliah" class="block text-sm font-medium text-gray-700 mb-2">
                                        Kode Mata Kuliah <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="kodeMatakuliah" name="kodeMatakuliah" required
                                           class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                           placeholder="Contoh: MK001">
                                </div>

                                <!-- Nama Mata Kuliah -->
                                <div>
                                    <label for="namaMatakuliah" class="block text-sm font-medium text-gray-700 mb-2">
                                        Nama Mata Kuliah <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="namaMatakuliah" name="namaMatakuliah" required
                                           class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                           placeholder="Masukkan nama mata kuliah">
                                </div>

                                <!-- SKS -->
                                <div>
                                    <label for="sks" class="block text-sm font-medium text-gray-700 mb-2">
                                        SKS <span class="text-red-500">*</span>
                                    </label>
                                    <input type="number" id="sks" name="sks" min="1" max="6" required
                                           class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                           placeholder="Jumlah SKS">
                                </div>

                                <!-- Semester -->
                                <div>
                                    <label for="semester" class="block text-sm font-medium text-gray-700 mb-2">
                                        Semester <span class="text-red-500">*</span>
                                    </label>
                                    <select id="semester" name="semester" required
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <option value="">Pilih Semester</option>
                                        <c:forEach begin="1" end="8" var="sem">
                                            <option value="${sem}">Semester ${sem}</option>
                                        </c:forEach>
                                    </select>
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

                                <!-- Dosen Pengampu -->
                                <div>
                                    <label for="idDosen" class="block text-sm font-medium text-gray-700 mb-2">
                                        Dosen Pengampu
                                    </label>
                                    <select id="idDosen" name="idDosen"
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <option value="">Pilih Dosen (Opsional)</option>
                                        <c:forEach var="dosen" items="${listDosen}">
                                            <option value="${dosen.idDosen}">${dosen.namaDosen}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Jenis -->
                                <div>
                                    <label for="jenis" class="block text-sm font-medium text-gray-700 mb-2">
                                        Jenis <span class="text-red-500">*</span>
                                    </label>
                                    <select id="jenis" name="jenis" required
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <option value="">Pilih Jenis</option>
                                        <option value="Wajib">Wajib</option>
                                        <option value="Pilihan">Pilihan</option>
                                    </select>
                                </div>

                                <!-- Deskripsi -->
                                <div class="md:col-span-2">
                                    <label for="deskripsi" class="block text-sm font-medium text-gray-700 mb-2">
                                        Deskripsi
                                    </label>
                                    <textarea id="deskripsi" name="deskripsi" rows="3"
                                              class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                              placeholder="Deskripsi mata kuliah (opsional)"></textarea>
                                </div>
                            </div>

                            <!-- Buttons -->
                            <div class="flex items-center justify-end space-x-4 mt-8 pt-6 border-t border-gray-200">
                                <a href="${pageContext.request.contextPath}/matakuliah" 
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
