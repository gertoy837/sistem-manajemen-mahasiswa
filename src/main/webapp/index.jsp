<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Redirect ke login jika belum login, atau ke dashboard jika sudah login
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    } else {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistem Manajemen Mahasiswa</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-to-br from-blue-50 to-indigo-100 min-h-screen">
    
    <!-- Navigation -->
    <nav class="bg-white shadow-lg">
        <div class="max-w-7xl mx-auto px-4">
            <div class="flex justify-between items-center py-4">
                <div class="flex items-center space-x-4">
                    <i class="fas fa-graduation-cap text-2xl text-blue-600"></i>
                    <h1 class="text-xl font-bold text-gray-800">Sistem Manajemen Mahasiswa</h1>
                </div>
                <div class="hidden md:flex space-x-6">
                    <a href="<%= request.getContextPath() %>/mahasiswa" 
                       class="text-gray-600 hover:text-blue-600 transition duration-300">
                        <i class="fas fa-users mr-2"></i>Data Mahasiswa
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="max-w-7xl mx-auto px-4 py-16">
        <div class="text-center">
            <div class="mb-8">
                <i class="fas fa-university text-6xl text-blue-600 mb-4"></i>
            </div>
            
            <h1 class="text-5xl font-bold text-gray-900 mb-6">
                Sistem Manajemen Mahasiswa
            </h1>
            
            <p class="text-xl text-gray-600 mb-12 max-w-2xl mx-auto">
                Platform terpadu untuk mengelola data mahasiswa, jurusan, dan akademik 
                dengan antarmuka yang modern dan responsif.
            </p>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
                <!-- Card 1 -->
                <div class="bg-white rounded-lg shadow-lg p-6 transform hover:scale-105 transition duration-300">
                    <div class="text-blue-600 mb-4">
                        <i class="fas fa-users text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-800 mb-2">Data Mahasiswa</h3>
                    <p class="text-gray-600 mb-4">Kelola informasi lengkap mahasiswa termasuk biodata, akademik, dan status aktif.</p>
                    <a href="<%= request.getContextPath() %>/mahasiswa" 
                       class="inline-block bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition duration-300">
                        Kelola Mahasiswa
                    </a>
                </div>
                
                <!-- Card 2 -->
                <div class="bg-white rounded-lg shadow-lg p-6 transform hover:scale-105 transition duration-300">
                    <div class="text-green-600 mb-4">
                        <i class="fas fa-building text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-800 mb-2">Data Jurusan</h3>
                    <p class="text-gray-600 mb-4">Informasi lengkap jurusan, fakultas, dan program studi yang tersedia.</p>
                    <button class="inline-block bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 transition duration-300">
                        Kelola Jurusan
                    </button>
                </div>
                
                <!-- Card 3 -->
                <div class="bg-white rounded-lg shadow-lg p-6 transform hover:scale-105 transition duration-300">
                    <div class="text-purple-600 mb-4">
                        <i class="fas fa-database text-4xl"></i>
                    </div>
                    <h3 class="text-xl font-bold text-gray-800 mb-2">Database</h3>
                    <p class="text-gray-600 mb-4">Sistem database PostgreSQL yang handal dengan 5 tabel terintegrasi.</p>
                    <a href="<%= request.getContextPath() %>/test-db" 
                       class="inline-block bg-purple-600 text-white px-4 py-2 rounded hover:bg-purple-700 transition duration-300">
                        Test Koneksi
                    </a>
                </div>
            </div>
            
            <!-- Features List -->
            <div class="bg-white rounded-lg shadow-lg p-8 max-w-4xl mx-auto">
                <h2 class="text-2xl font-bold text-gray-800 mb-6 text-center">Fitur Sistem</h2>
                
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="flex items-center space-x-3">
                        <i class="fas fa-check-circle text-green-500 text-xl"></i>
                        <span class="text-gray-700">CRUD Mahasiswa Lengkap</span>
                    </div>
                    
                    <div class="flex items-center space-x-3">
                        <i class="fas fa-check-circle text-green-500 text-xl"></i>
                        <span class="text-gray-700">Database PostgreSQL</span>
                    </div>
                    
                    <div class="flex items-center space-x-3">
                        <i class="fas fa-check-circle text-green-500 text-xl"></i>
                        <span class="text-gray-700">UI Responsif dengan TailwindCSS</span>
                    </div>
                    
                    <div class="flex items-center space-x-3">
                        <i class="fas fa-check-circle text-green-500 text-xl"></i>
                        <span class="text-gray-700">5 Tabel Database Terintegrasi</span>
                    </div>
                    
                    <div class="flex items-center space-x-3">
                        <i class="fas fa-check-circle text-green-500 text-xl"></i>
                        <span class="text-gray-700">Pencarian & Filter Data</span>
                    </div>
                    
                    <div class="flex items-center space-x-3">
                        <i class="fas fa-check-circle text-green-500 text-xl"></i>
                        <span class="text-gray-700">Validasi Form Otomatis</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-gray-800 text-white py-8 mt-16">
        <div class="max-w-7xl mx-auto px-4 text-center">
            <div class="flex justify-center items-center space-x-4 mb-4">
                <i class="fas fa-graduation-cap text-2xl"></i>
                <span class="text-lg font-semibold">Universitas XYZ</span>
            </div>
            <p class="text-gray-400">© 2024 Sistem Manajemen Mahasiswa. Dibuat dengan Java, PostgreSQL & TailwindCSS</p>
        </div>
    </footer>
</body>
</html>
