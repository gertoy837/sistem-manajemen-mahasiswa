package com.universitas.servlet;

import java.io.IOException;
import java.util.List;

import com.universitas.dao.DosenDAO;
import com.universitas.dao.JurusanDAO;
import com.universitas.model.Dosen;
import com.universitas.model.Jurusan;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet untuk mengelola CRUD Dosen
 */
@WebServlet("/dosen/*")
public class DosenServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DosenDAO dosenDAO;
    private JurusanDAO jurusanDAO;
    
    @Override
    public void init() throws ServletException {
        dosenDAO = new DosenDAO();
        jurusanDAO = new JurusanDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        
        if (action == null) {
            action = "/list";
        }
        
        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/delete":
                    deleteDosen(request, response);
                    break;
                case "/search":
                    searchDosen(request, response);
                    break;
                default:
                    listDosen(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getPathInfo();
        
        if (action == null) {
            action = "/list";
        }
        
        try {
            switch (action) {
                case "/insert":
                    insertDosen(request, response);
                    break;
                case "/update":
                    updateDosen(request, response);
                    break;
                default:
                    listDosen(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    /**
     * Menampilkan daftar dosen
     */
    private void listDosen(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Dosen> listDosen = dosenDAO.getAllDosen();
        request.setAttribute("listDosen", listDosen);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dosen/list.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Menampilkan form tambah dosen baru
     */
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Jurusan> listJurusan = jurusanDAO.getAllJurusan();
        request.setAttribute("listJurusan", listJurusan);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dosen/add.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Menampilkan form edit dosen
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Dosen existingDosen = dosenDAO.getDosenById(id);
        List<Jurusan> listJurusan = jurusanDAO.getAllJurusan();
        
        // Untuk handling jenis kelamin di JSP
        String jenisKelaminStr = String.valueOf(existingDosen.getJenisKelamin());
        request.setAttribute("jenisKelaminStr", jenisKelaminStr);
        
        request.setAttribute("dosen", existingDosen);
        request.setAttribute("listJurusan", listJurusan);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dosen/edit.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Menambahkan dosen baru
     */
    private void insertDosen(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Dosen dosen = extractDosenFromRequest(request);
        dosenDAO.insertDosen(dosen);
        response.sendRedirect(request.getContextPath() + "/dosen");
    }
    
    /**
     * Mengupdate data dosen
     */
    private void updateDosen(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idDosen"));
        Dosen dosen = extractDosenFromRequest(request);
        dosen.setIdDosen(id);
        dosenDAO.updateDosen(dosen);
        response.sendRedirect(request.getContextPath() + "/dosen");
    }
    
    /**
     * Menghapus dosen
     */
    private void deleteDosen(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        dosenDAO.deleteDosen(id);
        response.sendRedirect(request.getContextPath() + "/dosen");
    }
    
    /**
     * Mencari dosen
     */
    private void searchDosen(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Dosen> listDosen;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            listDosen = dosenDAO.searchDosen(keyword);
        } else {
            listDosen = dosenDAO.getAllDosen();
        }
        
        request.setAttribute("listDosen", listDosen);
        request.setAttribute("keyword", keyword);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/dosen/list.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Extract data dosen dari request
     */
    private Dosen extractDosenFromRequest(HttpServletRequest request) {
        Dosen dosen = new Dosen();
        
        String idJurusanStr = request.getParameter("idJurusan");
        if (idJurusanStr != null && !idJurusanStr.isEmpty()) {
            dosen.setIdJurusan(Integer.parseInt(idJurusanStr));
        }
        
        dosen.setNip(request.getParameter("nip"));
        dosen.setNamaDosen(request.getParameter("namaDosen"));
        dosen.setEmail(request.getParameter("email"));
        dosen.setTelepon(request.getParameter("telepon"));
        dosen.setAlamat(request.getParameter("alamat"));
        
        String jenisKelamin = request.getParameter("jenisKelamin");
        if (jenisKelamin != null && !jenisKelamin.isEmpty()) {
            dosen.setJenisKelamin(jenisKelamin.charAt(0));
        }
        
        dosen.setTanggalLahir(request.getParameter("tanggalLahir"));
        dosen.setPendidikanTerakhir(request.getParameter("pendidikanTerakhir"));
        dosen.setStatus(request.getParameter("status"));
        
        return dosen;
    }
}
