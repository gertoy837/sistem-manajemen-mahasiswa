<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Jurusan - Sistem Manajemen Mahasiswa</title>
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
                <a href="${pageContext.request.contextPath}/matakuliah" class="flex items-center space-x-3 px-4 py-3 rounded-lg text-blue-100 hover:bg-white/10 transition">
                    <i class="fas fa-book w-5"></i>
                    <span>Mata Kuliah</span>
                </a>
                <a href="${pageContext.request.contextPath}/jurusan" class="flex items-center space-x-3 px-4 py-3 rounded-lg bg-white/20 text-white transition">
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
                        <h2 class="text-2xl font-bold text-gray-800">Edit Jurusan</h2>
                        <p class="text-gray-500 text-sm">Edit: ${jurusan.namaJurusan}</p>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <main class="flex-1 overflow-y-auto p-8">
                <div class="max-w-2xl mx-auto">
                    <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-8">
                        <form action="${pageContext.request.contextPath}/jurusan/update" method="post">
                            <input type="hidden" name="idJurusan" value="${jurusan.idJurusan}">
                            
                            <div class="space-y-6">
                                <!-- Kode Jurusan -->
                                <div>
                                    <label for="kodeJurusan" class="block text-sm font-medium text-gray-700 mb-2">
                                        Kode Jurusan <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="kodeJurusan" name="kodeJurusan" value="${jurusan.kodeJurusan}" required
                                           class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                           placeholder="Contoh: TI, SI, TK">
                                </div>

                                <!-- Nama Jurusan -->
                                <div>
                                    <label for="namaJurusan" class="block text-sm font-medium text-gray-700 mb-2">
                                        Nama Jurusan <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="namaJurusan" name="namaJurusan" value="${jurusan.namaJurusan}" required
                                           class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                           placeholder="Masukkan nama jurusan">
                                </div>

                                <!-- Fakultas -->
                                <div>
                                    <label for="idFakultas" class="block text-sm font-medium text-gray-700 mb-2">
                                        Fakultas <span class="text-red-500">*</span>
                                    </label>
                                    <select id="idFakultas" name="idFakultas" required
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <option value="">Pilih Fakultas</option>
                                        <c:forEach var="fakultas" items="${listFakultas}">
                                            <option value="${fakultas.idFakultas}" ${fakultas.idFakultas == jurusan.idFakultas ? 'selected' : ''}>${fakultas.namaFakultas}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Jenjang -->
                                <div>
                                    <label for="jenjang" class="block text-sm font-medium text-gray-700 mb-2">
                                        Jenjang <span class="text-red-500">*</span>
                                    </label>
                                    <select id="jenjang" name="jenjang" required
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <option value="">Pilih Jenjang</option>
                                        <option value="D3" ${jurusan.jenjang == 'D3' ? 'selected' : ''}>D3 (Diploma)</option>
                                        <option value="S1" ${jurusan.jenjang == 'S1' ? 'selected' : ''}>S1 (Sarjana)</option>
                                        <option value="S2" ${jurusan.jenjang == 'S2' ? 'selected' : ''}>S2 (Magister)</option>
                                        <option value="S3" ${jurusan.jenjang == 'S3' ? 'selected' : ''}>S3 (Doktor)</option>
                                    </select>
                                </div>

                                <!-- Akreditasi -->
                                <div>
                                    <label for="akreditasi" class="block text-sm font-medium text-gray-700 mb-2">
                                        Akreditasi <span class="text-red-500">*</span>
                                    </label>
                                    <select id="akreditasi" name="akreditasi" required
                                            class="w-full px-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                                        <option value="">Pilih Akreditasi</option>
                                        <option value="Unggul" ${jurusan.akreditasi == 'Unggul' ? 'selected' : ''}>Unggul</option>
                                        <option value="Baik Sekali" ${jurusan.akreditasi == 'Baik Sekali' ? 'selected' : ''}>Baik Sekali</option>
                                        <option value="Baik" ${jurusan.akreditasi == 'Baik' ? 'selected' : ''}>Baik</option>
                                        <option value="A" ${jurusan.akreditasi == 'A' ? 'selected' : ''}>A</option>
                                        <option value="B" ${jurusan.akreditasi == 'B' ? 'selected' : ''}>B</option>
                                        <option value="C" ${jurusan.akreditasi == 'C' ? 'selected' : ''}>C</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Buttons -->
                            <div class="flex items-center justify-end space-x-4 mt-8 pt-6 border-t border-gray-200">
                                <a href="${pageContext.request.contextPath}/jurusan" 
                                   class="px-6 py-2.5 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition">
                                    Batal
                                </a>
                                <button type="submit" 
                                        class="px-6 py-2.5 bg-gradient-to-r from-blue-600 to-blue-700 text-white rounded-lg hover:from-blue-700 hover:to-blue-800 transition">
                                    <i class="fas fa-save mr-2"></i>
                                    Update
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
