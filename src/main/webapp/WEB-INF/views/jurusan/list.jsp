<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Jurusan - Sistem Manajemen Mahasiswa</title>
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
                        <h2 class="text-2xl font-bold text-gray-800">Daftar Jurusan</h2>
                        <p class="text-gray-500 text-sm">Kelola data jurusan/program studi</p>
                    </div>
                    <div class="flex items-center space-x-4">
                        <div class="flex items-center space-x-2 text-gray-600">
                            <i class="fas fa-user-circle text-2xl"></i>
                            <span class="font-medium">${sessionScope.user.namaLengkap}</span>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <main class="flex-1 overflow-y-auto p-8">
                <!-- Action Bar -->
                <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-6">
                    <a href="${pageContext.request.contextPath}/jurusan/new" 
                       class="inline-flex items-center px-5 py-2.5 bg-gradient-to-r from-blue-600 to-blue-700 text-white font-medium rounded-lg shadow hover:from-blue-700 hover:to-blue-800 transition">
                        <i class="fas fa-plus mr-2"></i>
                        Tambah Jurusan
                    </a>
                    
                    <form action="${pageContext.request.contextPath}/jurusan/search" method="get" class="flex gap-2">
                        <div class="relative">
                            <input type="text" name="keyword" value="${keyword}" placeholder="Cari kode atau nama jurusan..."
                                   class="pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg w-72 focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                            <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                        </div>
                        <button type="submit" class="px-5 py-2.5 bg-gray-600 text-white rounded-lg hover:bg-gray-700 transition">
                            Cari
                        </button>
                    </form>
                </div>

                <!-- Table -->
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gray-50 border-b border-gray-200">
                                <tr>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">No</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Kode</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Nama Jurusan</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Fakultas</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Jenjang</th>
                                    <th class="px-6 py-4 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider">Akreditasi</th>
                                    <th class="px-6 py-4 text-center text-xs font-semibold text-gray-600 uppercase tracking-wider">Aksi</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200">
                                <c:forEach var="jurusan" items="${listJurusan}" varStatus="loop">
                                    <tr class="hover:bg-gray-50 transition">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${loop.index + 1}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="text-sm font-mono bg-blue-100 text-blue-700 px-2 py-1 rounded">${jurusan.kodeJurusan}</span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="h-10 w-10 flex-shrink-0 bg-gradient-to-br from-teal-400 to-teal-600 rounded-full flex items-center justify-center text-white font-semibold">
                                                    <i class="fas fa-building text-sm"></i>
                                                </div>
                                                <div class="ml-3">
                                                    <p class="text-sm font-medium text-gray-900">${jurusan.namaJurusan}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${jurusan.namaFakultas}</td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-2.5 py-1 text-xs font-medium bg-indigo-100 text-indigo-700 rounded-full">${jurusan.jenjang}</span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <c:choose>
                                                <c:when test="${jurusan.akreditasi == 'A' || jurusan.akreditasi == 'Unggul'}">
                                                    <span class="px-2.5 py-1 text-xs font-medium bg-green-100 text-green-700 rounded-full">${jurusan.akreditasi}</span>
                                                </c:when>
                                                <c:when test="${jurusan.akreditasi == 'B' || jurusan.akreditasi == 'Baik Sekali'}">
                                                    <span class="px-2.5 py-1 text-xs font-medium bg-blue-100 text-blue-700 rounded-full">${jurusan.akreditasi}</span>
                                                </c:when>
                                                <c:when test="${jurusan.akreditasi == 'C' || jurusan.akreditasi == 'Baik'}">
                                                    <span class="px-2.5 py-1 text-xs font-medium bg-yellow-100 text-yellow-700 rounded-full">${jurusan.akreditasi}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2.5 py-1 text-xs font-medium bg-gray-100 text-gray-700 rounded-full">${jurusan.akreditasi}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-center">
                                            <div class="flex items-center justify-center space-x-2">
                                                <a href="${pageContext.request.contextPath}/jurusan/edit?id=${jurusan.idJurusan}" 
                                                   class="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition" title="Edit">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/jurusan/delete?id=${jurusan.idJurusan}" 
                                                   onclick="return confirm('Apakah Anda yakin ingin menghapus jurusan ini?')"
                                                   class="p-2 text-red-600 hover:bg-red-50 rounded-lg transition" title="Hapus">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listJurusan}">
                                    <tr>
                                        <td colspan="7" class="px-6 py-12 text-center">
                                            <div class="flex flex-col items-center">
                                                <i class="fas fa-building text-4xl text-gray-300 mb-3"></i>
                                                <p class="text-gray-500">Belum ada data jurusan</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
