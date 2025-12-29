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
            System.out.println("DEBUG: Entering listMahasiswa method");
            List<Mahasiswa> listMahasiswa = mahasiswaDAO.getAllMahasiswa();
            System.out.println("DEBUG: Retrieved " + listMahasiswa.size() + " records from DAO");
            
            request.setAttribute("listMahasiswa", listMahasiswa);
            
            // Handle messages from session (after redirect)
            String message = null;
            String messageType = null;
            
            if (request.getSession(false) != null) {
                message = (String) request.getSession().getAttribute("message");
                messageType = (String) request.getSession().getAttribute("messageType");
                System.out.println("DEBUG: Session message = " + message);
                
                if (message != null) {
                    request.setAttribute("message", message);
                    request.setAttribute("messageType", messageType);
                    // Clear from session
                    request.getSession().removeAttribute("message");
                    request.getSession().removeAttribute("messageType");
                    System.out.println("DEBUG: Message set in request attributes");
                }
            }
            
            System.out.println("DEBUG: Forwarding to JSP");
            request.getRequestDispatcher("/views/mahasiswa/list.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("ERROR in listMahasiswa: " + e.getMessage());
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
            System.out.println("DEBUG: Getting mahasiswa with ID: " + id);
            
            Mahasiswa mahasiswa = mahasiswaDAO.getMahasiswaById(id);
            if (mahasiswa == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Mahasiswa not found");
                return;
            }
            
            List<Jurusan> listJurusan = jurusanDAO.getAllJurusan();
            
            request.setAttribute("mahasiswa", mahasiswa);
            request.setAttribute("listJurusan", listJurusan);
            // Convert char to String untuk JSP compatibility
            request.setAttribute("jenisKelaminStr", String.valueOf(mahasiswa.getJenisKelamin()));
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
            
            String idDosenStr = request.getParameter("idDosen");
            if (idDosenStr != null && !idDosenStr.isEmpty()) {
                mahasiswa.setIdDosen(Integer.parseInt(idDosenStr));
            }
            
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
            System.out.println("DEBUG: ===== Starting updateMahasiswa =====");
            
            Mahasiswa mahasiswa = new Mahasiswa();
            
            // 1. ID Mahasiswa (required)
            String idParam = request.getParameter("idMahasiswa");
            System.out.println("DEBUG: idMahasiswa = [" + idParam + "]");
            if (idParam == null || idParam.trim().isEmpty()) {
                throw new IllegalArgumentException("ID is missing");
            }
            mahasiswa.setIdMahasiswa(safeParseInt(idParam, "ID"));
            
            // 2. ID Jurusan (required)
            String idJurusanStr = request.getParameter("idJurusan");
            System.out.println("DEBUG: idJurusan = [" + idJurusanStr + "]");
            if (idJurusanStr == null || idJurusanStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Jurusan is required");
            }
            mahasiswa.setIdJurusan(safeParseInt(idJurusanStr, "ID Jurusan"));
            
            // 3. ID Dosen (optional)
            String idDosenStr = request.getParameter("idDosen");
            System.out.println("DEBUG: idDosen = [" + idDosenStr + "]");
            if (idDosenStr != null && !idDosenStr.trim().isEmpty()) {
                mahasiswa.setIdDosen(safeParseInt(idDosenStr, "ID Dosen"));
            }
            
            // 4. NIM (required)
            String nim = request.getParameter("nim");
            System.out.println("DEBUG: nim = [" + nim + "]");
            if (nim == null || nim.trim().isEmpty()) {
                throw new IllegalArgumentException("NIM is required");
            }
            mahasiswa.setNim(nim.trim());
            
            // 5. Nama (required)
            String namaMahasiswa = request.getParameter("namaMahasiswa");
            System.out.println("DEBUG: namaMahasiswa = [" + namaMahasiswa + "]");
            if (namaMahasiswa == null || namaMahasiswa.trim().isEmpty()) {
                throw new IllegalArgumentException("Nama Mahasiswa is required");
            }
            mahasiswa.setNamaMahasiswa(namaMahasiswa.trim());
            
            // 6. Email (required)
            String email = request.getParameter("email");
            System.out.println("DEBUG: email = [" + email + "]");
            if (email == null || email.trim().isEmpty()) {
                throw new IllegalArgumentException("Email is required");
            }
            mahasiswa.setEmail(email.trim());
            
            // 7. Telepon (optional)
            String telepon = request.getParameter("telepon");
            mahasiswa.setTelepon(telepon != null ? telepon.trim() : "");
            
            // 8. Alamat (optional)
            String alamat = request.getParameter("alamat");
            mahasiswa.setAlamat(alamat != null ? alamat.trim() : "");
            
            // 9. Jenis Kelamin (required)
            String jenisKelamin = request.getParameter("jenisKelamin");
            System.out.println("DEBUG: jenisKelamin = [" + jenisKelamin + "]");
            if (jenisKelamin != null && !jenisKelamin.trim().isEmpty()) {
                mahasiswa.setJenisKelamin(jenisKelamin.charAt(0));
            } else {
                mahasiswa.setJenisKelamin('L'); // Default
            }
            
            // 10. Tanggal Lahir (optional)
            String tanggalLahir = request.getParameter("tanggalLahir");
            mahasiswa.setTanggalLahir(tanggalLahir != null ? tanggalLahir.trim() : "");
            
            // 11. Tahun Masuk (required)
            String tahunMasukStr = request.getParameter("tahunMasuk");
            System.out.println("DEBUG: tahunMasuk = [" + tahunMasukStr + "]");
            if (tahunMasukStr != null && !tahunMasukStr.trim().isEmpty()) {
                mahasiswa.setTahunMasuk(safeParseInt(tahunMasukStr, "Tahun Masuk"));
            } else {
                mahasiswa.setTahunMasuk(2023);
            }
            
            // 12. Semester Aktif
            String semesterAktifStr = request.getParameter("semesterAktif");
            System.out.println("DEBUG: semesterAktif = [" + semesterAktifStr + "]");
            if (semesterAktifStr != null && !semesterAktifStr.trim().isEmpty()) {
                mahasiswa.setSemesterAktif(safeParseInt(semesterAktifStr, "Semester Aktif"));
            } else {
                mahasiswa.setSemesterAktif(1);
            }
            
            // 13. IPK (optional)
            String ipkStr = request.getParameter("ipk");
            System.out.println("DEBUG: ipk = [" + ipkStr + "]");
            if (ipkStr != null && !ipkStr.trim().isEmpty()) {
                mahasiswa.setIpk(safeParseDouble(ipkStr, "IPK"));
            } else {
                mahasiswa.setIpk(0.0);
            }
            
            // 14. Status
            String status = request.getParameter("status");
            System.out.println("DEBUG: status = [" + status + "]");
            if (status != null && !status.trim().isEmpty()) {
                mahasiswa.setStatus(status.trim());
            } else {
                mahasiswa.setStatus("Aktif");
            }
            
            System.out.println("DEBUG: All fields parsed successfully, calling DAO...");
            
            boolean success = mahasiswaDAO.updateMahasiswa(mahasiswa);
            
            if (success) {
                System.out.println("DEBUG: Update successful!");
                request.getSession().setAttribute("message", "Mahasiswa berhasil diupdate!");
                request.getSession().setAttribute("messageType", "success");
            } else {
                System.out.println("DEBUG: Update failed in DAO");
                request.getSession().setAttribute("message", "Gagal mengupdate mahasiswa!");
                request.getSession().setAttribute("messageType", "error");
            }
            
        } catch (Exception e) {
            System.err.println("ERROR in updateMahasiswa: " + e.getClass().getName() + ": " + e.getMessage());
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/mahasiswa");
    }
    
    // Helper method untuk safe integer parsing
    private int safeParseInt(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " cannot be empty");
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(fieldName + " must be a valid number: " + value);
        }
    }
    
    // Helper method untuk safe double parsing (handle comma as decimal separator)
    private double safeParseDouble(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            return 0.0;
        }
        try {
            // Replace comma with dot for locales that use comma as decimal separator
            String normalized = value.trim().replace(",", ".");
            return Double.parseDouble(normalized);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(fieldName + " must be a valid number: " + value);
        }
    }
    
    private void deleteMahasiswa(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = mahasiswaDAO.deleteMahasiswa(id);
            
            if (success) {
                request.setAttribute("message", "Mahasiswa berhasil dihapus!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Gagal menghapus mahasiswa!");
                request.setAttribute("messageType", "error");
            }
            
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("messageType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/mahasiswa?action=list");
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