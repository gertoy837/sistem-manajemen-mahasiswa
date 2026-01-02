package com.universitas.servlet;

import java.io.IOException;
import java.util.List;

import com.universitas.dao.FakultasDAO;
import com.universitas.dao.JurusanDAO;
import com.universitas.model.Fakultas;
import com.universitas.model.Jurusan;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet untuk mengelola CRUD Jurusan
 */
@WebServlet("/jurusan/*")
public class JurusanServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private JurusanDAO jurusanDAO;
    private FakultasDAO fakultasDAO;
    
    @Override
    public void init() throws ServletException {
        jurusanDAO = new JurusanDAO();
        fakultasDAO = new FakultasDAO();
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
                    deleteJurusan(request, response);
                    break;
                case "/search":
                    searchJurusan(request, response);
                    break;
                default:
                    listJurusan(request, response);
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
                    insertJurusan(request, response);
                    break;
                case "/update":
                    updateJurusan(request, response);
                    break;
                default:
                    listJurusan(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    /**
     * Menampilkan daftar jurusan
     */
    private void listJurusan(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Jurusan> listJurusan = jurusanDAO.getAllJurusan();
        request.setAttribute("listJurusan", listJurusan);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/jurusan/list.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Menampilkan form tambah jurusan baru
     */
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Fakultas> listFakultas = fakultasDAO.getAllFakultas();
        request.setAttribute("listFakultas", listFakultas);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/jurusan/add.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Menampilkan form edit jurusan
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Jurusan existingJurusan = jurusanDAO.getJurusanById(id);
        List<Fakultas> listFakultas = fakultasDAO.getAllFakultas();
        
        request.setAttribute("jurusan", existingJurusan);
        request.setAttribute("listFakultas", listFakultas);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/jurusan/edit.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Menambahkan jurusan baru
     */
    private void insertJurusan(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Jurusan jurusan = extractJurusanFromRequest(request);
        jurusanDAO.insertJurusan(jurusan);
        response.sendRedirect(request.getContextPath() + "/jurusan");
    }
    
    /**
     * Mengupdate data jurusan
     */
    private void updateJurusan(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idJurusan"));
        Jurusan jurusan = extractJurusanFromRequest(request);
        jurusan.setIdJurusan(id);
        jurusanDAO.updateJurusan(jurusan);
        response.sendRedirect(request.getContextPath() + "/jurusan");
    }
    
    /**
     * Menghapus jurusan
     */
    private void deleteJurusan(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        jurusanDAO.deleteJurusan(id);
        response.sendRedirect(request.getContextPath() + "/jurusan");
    }
    
    /**
     * Mencari jurusan
     */
    private void searchJurusan(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Jurusan> listJurusan;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            listJurusan = jurusanDAO.searchJurusan(keyword);
        } else {
            listJurusan = jurusanDAO.getAllJurusan();
        }
        
        request.setAttribute("listJurusan", listJurusan);
        request.setAttribute("keyword", keyword);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/jurusan/list.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Extract data jurusan dari request
     */
    private Jurusan extractJurusanFromRequest(HttpServletRequest request) {
        Jurusan jurusan = new Jurusan();
        
        String idFakultasStr = request.getParameter("idFakultas");
        if (idFakultasStr != null && !idFakultasStr.isEmpty()) {
            jurusan.setIdFakultas(Integer.parseInt(idFakultasStr));
        }
        
        jurusan.setKodeJurusan(request.getParameter("kodeJurusan"));
        jurusan.setNamaJurusan(request.getParameter("namaJurusan"));
        jurusan.setJenjang(request.getParameter("jenjang"));
        jurusan.setAkreditasi(request.getParameter("akreditasi"));
        
        return jurusan;
    }
}
