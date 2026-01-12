package com.universitas.servlet;

import java.io.IOException;
import java.util.List;

import com.universitas.dao.JurusanDAO;
import com.universitas.dao.MahasiswaDAO;
import com.universitas.model.Jurusan;
import com.universitas.model.Mahasiswa;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet Controller untuk operasi CRUD Mahasiswa
 */
public class MahasiswaServlet extends HttpServlet {
    
    private MahasiswaDAO mahasiswaDAO;
    private JurusanDAO jurusanDAO;
    
    @Override
    public void init() throws ServletException {
        mahasiswaDAO = new MahasiswaDAO();
        jurusanDAO = new JurusanDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        switch (action) {
            case "list":
                listMahasiswa(request, response);
                break;
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteMahasiswa(request, response);
                break;
            case "search":
                searchMahasiswa(request, response);
                break;
            default:
                listMahasiswa(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "add";
        
        switch (action) {
            case "add":
                addMahasiswa(request, response);
                break;
            case "update":
                updateMahasiswa(request, response);
                break;
            default:
                listMahasiswa(request, response);
                break;
        }
    }
    
    private void listMahasiswa(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Mahasiswa> listMahasiswa = mahasiswaDAO.getAllMahasiswa();
            request.setAttribute("listMahasiswa", listMahasiswa);
            
            // Handle messages from session (after redirect)
            if (request.getSession(false) != null) {
                String message = (String) request.getSession().getAttribute("message");
                String messageType = (String) request.getSession().getAttribute("messageType");
                
                if (message != null) {
                    request.setAttribute("message", message);
                    request.setAttribute("messageType", messageType);
                    request.getSession().removeAttribute("message");
                    request.getSession().removeAttribute("messageType");
                }
            }
            
            request.getRequestDispatcher("/views/mahasiswa/list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading data: " + e.getMessage());
        }
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Jurusan> listJurusan = jurusanDAO.getAllJurusan();
        request.setAttribute("listJurusan", listJurusan);
        request.getRequestDispatcher("/views/mahasiswa/add.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID parameter is missing");
                return;
            }
            
            int id = Integer.parseInt(idParam);
            Mahasiswa mahasiswa = mahasiswaDAO.getMahasiswaById(id);
            if (mahasiswa == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Mahasiswa not found with ID: " + id);
                return;
            }
            
            List<Jurusan> listJurusan = jurusanDAO.getAllJurusan();
            
            request.setAttribute("mahasiswa", mahasiswa);
            request.setAttribute("listJurusan", listJurusan);
            
            // Convert jenis kelamin char to String for JSP EL compatibility
            char jk = mahasiswa.getJenisKelamin();
            String jenisKelaminValue = (jk == 'L' || jk == 'P') ? String.valueOf(jk) : "L";
            request.setAttribute("selectedJenisKelamin", jenisKelaminValue);
            
            request.getRequestDispatcher("/views/mahasiswa/edit.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading edit form: " + e.getMessage());
        }
    }
    
    private void addMahasiswa(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Mahasiswa mahasiswa = new Mahasiswa();
            
            mahasiswa.setIdJurusan(Integer.parseInt(request.getParameter("idJurusan")));
            mahasiswa.setNim(request.getParameter("nim"));
            mahasiswa.setNamaMahasiswa(request.getParameter("namaMahasiswa"));
            mahasiswa.setEmail(request.getParameter("email"));
            mahasiswa.setTelepon(request.getParameter("telepon"));
            mahasiswa.setAlamat(request.getParameter("alamat"));
            
            String jenisKelamin = request.getParameter("jenisKelamin");
            if (jenisKelamin != null && !jenisKelamin.isEmpty()) {
                mahasiswa.setJenisKelamin(jenisKelamin.charAt(0));
            }
            
            mahasiswa.setTanggalLahir(request.getParameter("tanggalLahir"));
            
            String tahunMasukStr = request.getParameter("tahunMasuk");
            if (tahunMasukStr != null && !tahunMasukStr.isEmpty()) {
                mahasiswa.setTahunMasuk(Integer.parseInt(tahunMasukStr));
            }
            
            String semesterAktifStr = request.getParameter("semesterAktif");
            if (semesterAktifStr != null && !semesterAktifStr.isEmpty()) {
                mahasiswa.setSemesterAktif(Integer.parseInt(semesterAktifStr));
            } else {
                mahasiswa.setSemesterAktif(1);
            }
            
            // Parse IPK
            String ipkStr = request.getParameter("ipk");
            if (ipkStr != null && !ipkStr.trim().isEmpty()) {
                String normalized = ipkStr.trim().replace(",", ".");
                mahasiswa.setIpk(Double.parseDouble(normalized));
            } else {
                mahasiswa.setIpk(0.0);
            }
            
            mahasiswa.setStatus(request.getParameter("status"));
            
            boolean success = mahasiswaDAO.tambahMahasiswa(mahasiswa);
            
            if (success) {
                request.getSession().setAttribute("message", "Mahasiswa berhasil ditambahkan!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Gagal menambahkan mahasiswa!");
                request.getSession().setAttribute("messageType", "error");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/mahasiswa");
    }
    
    private void updateMahasiswa(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Mahasiswa mahasiswa = new Mahasiswa();
            
            // ID Mahasiswa (required)
            String idParam = request.getParameter("idMahasiswa");
            if (idParam == null || idParam.trim().isEmpty()) {
                throw new IllegalArgumentException("ID is missing");
            }
            mahasiswa.setIdMahasiswa(Integer.parseInt(idParam.trim()));
            
            // ID Jurusan (required)
            String idJurusanStr = request.getParameter("idJurusan");
            if (idJurusanStr == null || idJurusanStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Jurusan is required");
            }
            mahasiswa.setIdJurusan(Integer.parseInt(idJurusanStr.trim()));
            
            // NIM (required)
            String nim = request.getParameter("nim");
            if (nim == null || nim.trim().isEmpty()) {
                throw new IllegalArgumentException("NIM is required");
            }
            mahasiswa.setNim(nim.trim());
            
            // Nama (required)
            String namaMahasiswa = request.getParameter("namaMahasiswa");
            if (namaMahasiswa == null || namaMahasiswa.trim().isEmpty()) {
                throw new IllegalArgumentException("Nama Mahasiswa is required");
            }
            mahasiswa.setNamaMahasiswa(namaMahasiswa.trim());
            
            // Email (required)
            String email = request.getParameter("email");
            if (email == null || email.trim().isEmpty()) {
                throw new IllegalArgumentException("Email is required");
            }
            mahasiswa.setEmail(email.trim());
            
            // Telepon (optional)
            String telepon = request.getParameter("telepon");
            mahasiswa.setTelepon(telepon != null ? telepon.trim() : "");
            
            // Alamat (optional)
            String alamat = request.getParameter("alamat");
            mahasiswa.setAlamat(alamat != null ? alamat.trim() : "");
            
            // Jenis Kelamin
            String jenisKelamin = request.getParameter("jenisKelamin");
            if (jenisKelamin != null && !jenisKelamin.trim().isEmpty()) {
                mahasiswa.setJenisKelamin(jenisKelamin.charAt(0));
            } else {
                mahasiswa.setJenisKelamin('L');
            }
            
            // Tanggal Lahir (optional)
            String tanggalLahir = request.getParameter("tanggalLahir");
            mahasiswa.setTanggalLahir(tanggalLahir != null ? tanggalLahir.trim() : "");
            
            // Tahun Masuk
            String tahunMasukStr = request.getParameter("tahunMasuk");
            if (tahunMasukStr != null && !tahunMasukStr.trim().isEmpty()) {
                mahasiswa.setTahunMasuk(Integer.parseInt(tahunMasukStr.trim()));
            } else {
                mahasiswa.setTahunMasuk(2023);
            }
            
            // Semester Aktif
            String semesterAktifStr = request.getParameter("semesterAktif");
            if (semesterAktifStr != null && !semesterAktifStr.trim().isEmpty()) {
                mahasiswa.setSemesterAktif(Integer.parseInt(semesterAktifStr.trim()));
            } else {
                mahasiswa.setSemesterAktif(1);
            }
            
            // IPK (optional)
            String ipkStr = request.getParameter("ipk");
            if (ipkStr != null && !ipkStr.trim().isEmpty()) {
                String normalized = ipkStr.trim().replace(",", ".");
                mahasiswa.setIpk(Double.parseDouble(normalized));
            } else {
                mahasiswa.setIpk(0.0);
            }
            
            // Status
            String status = request.getParameter("status");
            if (status != null && !status.trim().isEmpty()) {
                mahasiswa.setStatus(status.trim());
            } else {
                mahasiswa.setStatus("Aktif");
            }
            
            boolean success = mahasiswaDAO.updateMahasiswa(mahasiswa);
            
            if (success) {
                request.getSession().setAttribute("message", "Mahasiswa berhasil diupdate!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Gagal mengupdate mahasiswa!");
                request.getSession().setAttribute("messageType", "error");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/mahasiswa");
    }
    
    private void deleteMahasiswa(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = mahasiswaDAO.deleteMahasiswa(id);
            
            if (success) {
                request.getSession().setAttribute("message", "Mahasiswa berhasil dihapus!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Gagal menghapus mahasiswa!");
                request.getSession().setAttribute("messageType", "error");
            }
            
        } catch (Exception e) {
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/mahasiswa");
    }
    
    private void searchMahasiswa(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        List<Mahasiswa> listMahasiswa;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            listMahasiswa = mahasiswaDAO.cariMahasiswa(keyword.trim());
        } else {
            listMahasiswa = mahasiswaDAO.getAllMahasiswa();
        }
        
        request.setAttribute("listMahasiswa", listMahasiswa);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/views/mahasiswa/list.jsp").forward(request, response);
    }
}