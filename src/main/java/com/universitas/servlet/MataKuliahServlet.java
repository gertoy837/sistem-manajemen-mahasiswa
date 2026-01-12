package com.universitas.servlet;

import java.io.IOException;
import java.util.List;

import com.universitas.dao.JurusanDAO;
import com.universitas.dao.MataKuliahDAO;
import com.universitas.model.Jurusan;
import com.universitas.model.MataKuliah;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet untuk mengelola CRUD Mata Kuliah
 */
@WebServlet("/matakuliah/*")
public class MataKuliahServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MataKuliahDAO mataKuliahDAO;
    private JurusanDAO jurusanDAO;
    
    @Override
    public void init() throws ServletException {
        mataKuliahDAO = new MataKuliahDAO();
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
                    deleteMataKuliah(request, response);
                    break;
                case "/search":
                    searchMataKuliah(request, response);
                    break;
                default:
                    listMataKuliah(request, response);
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
                    insertMataKuliah(request, response);
                    break;
                case "/update":
                    updateMataKuliah(request, response);
                    break;
                default:
                    listMataKuliah(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    /**
     * Menampilkan daftar mata kuliah
     */
    private void listMataKuliah(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<MataKuliah> listMataKuliah = mataKuliahDAO.getAllMataKuliah();
        request.setAttribute("listMataKuliah", listMataKuliah);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/matakuliah/list.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Menampilkan form tambah mata kuliah baru
     */
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Jurusan> listJurusan = jurusanDAO.getAllJurusan();
        request.setAttribute("listJurusan", listJurusan);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/matakuliah/add.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Menampilkan form edit mata kuliah
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        MataKuliah existingMataKuliah = mataKuliahDAO.getMataKuliahById(id);
        List<Jurusan> listJurusan = jurusanDAO.getAllJurusan();
        
        request.setAttribute("mataKuliah", existingMataKuliah);
        request.setAttribute("listJurusan", listJurusan);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/matakuliah/edit.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Menambahkan mata kuliah baru
     */
    private void insertMataKuliah(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        MataKuliah mataKuliah = extractMataKuliahFromRequest(request);
        mataKuliahDAO.insertMataKuliah(mataKuliah);
        response.sendRedirect(request.getContextPath() + "/matakuliah");
    }
    
    /**
     * Mengupdate data mata kuliah
     */
    private void updateMataKuliah(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idMatakuliah"));
        MataKuliah mataKuliah = extractMataKuliahFromRequest(request);
        mataKuliah.setIdMatakuliah(id);
        mataKuliahDAO.updateMataKuliah(mataKuliah);
        response.sendRedirect(request.getContextPath() + "/matakuliah");
    }
    
    /**
     * Menghapus mata kuliah
     */
    private void deleteMataKuliah(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        mataKuliahDAO.deleteMataKuliah(id);
        response.sendRedirect(request.getContextPath() + "/matakuliah");
    }
    
    /**
     * Mencari mata kuliah
     */
    private void searchMataKuliah(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<MataKuliah> listMataKuliah;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            listMataKuliah = mataKuliahDAO.searchMataKuliah(keyword);
        } else {
            listMataKuliah = mataKuliahDAO.getAllMataKuliah();
        }
        
        request.setAttribute("listMataKuliah", listMataKuliah);
        request.setAttribute("keyword", keyword);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/matakuliah/list.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Extract data mata kuliah dari request
     */
    private MataKuliah extractMataKuliahFromRequest(HttpServletRequest request) {
        MataKuliah mataKuliah = new MataKuliah();
        
        String idJurusanStr = request.getParameter("idJurusan");
        if (idJurusanStr != null && !idJurusanStr.isEmpty()) {
            mataKuliah.setIdJurusan(Integer.parseInt(idJurusanStr));
        }
        
        mataKuliah.setKodeMatakuliah(request.getParameter("kodeMatakuliah"));
        mataKuliah.setNamaMatakuliah(request.getParameter("namaMatakuliah"));
        
        String sksStr = request.getParameter("sks");
        if (sksStr != null && !sksStr.isEmpty()) {
            mataKuliah.setSks(Integer.parseInt(sksStr));
        }
        
        String semesterStr = request.getParameter("semester");
        if (semesterStr != null && !semesterStr.isEmpty()) {
            mataKuliah.setSemester(Integer.parseInt(semesterStr));
        }
        
        mataKuliah.setJenis(request.getParameter("jenis"));
        mataKuliah.setDeskripsi(request.getParameter("deskripsi"));
        
        return mataKuliah;
    }
}
