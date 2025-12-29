package com.universitas.servlet;

import java.io.IOException;
import java.util.List;

import com.universitas.dao.JurusanDAO;
import com.universitas.dao.MahasiswaDAO;
import com.universitas.model.Jurusan;
import com.universitas.model.Mahasiswa;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    
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
        
        try {
            // Get all data for statistics
            List<Mahasiswa> listMahasiswa = mahasiswaDAO.getAllMahasiswa();
            List<Jurusan> listJurusan = jurusanDAO.getAllJurusan();
            
            // Count statistics
            int totalMahasiswa = listMahasiswa.size();
            int mahasiswaAktif = 0;
            int mahasiswaCuti = 0;
            int mahasiswaLulus = 0;
            double totalIpk = 0;
            
            // Count by jurusan
            int countTI = 0;
            int countSI = 0;
            int countBD = 0;
            
            for (Mahasiswa m : listMahasiswa) {
                // Count by status
                if ("Aktif".equals(m.getStatus())) mahasiswaAktif++;
                else if ("Cuti".equals(m.getStatus())) mahasiswaCuti++;
                else if ("Lulus".equals(m.getStatus())) mahasiswaLulus++;
                
                // Sum IPK
                totalIpk += m.getIpk();
                
                // Count by jurusan
                String jurusan = m.getNamaJurusan();
                if (jurusan != null) {
                    if (jurusan.contains("Teknik Informatika")) countTI++;
                    else if (jurusan.contains("Sistem Informasi")) countSI++;
                    else if (jurusan.contains("Bisnis Digital")) countBD++;
                }
            }
            
            double avgIpk = totalMahasiswa > 0 ? totalIpk / totalMahasiswa : 0;
            
            // Set attributes
            request.setAttribute("totalMahasiswa", totalMahasiswa);
            request.setAttribute("mahasiswaAktif", mahasiswaAktif);
            request.setAttribute("mahasiswaCuti", mahasiswaCuti);
            request.setAttribute("mahasiswaLulus", mahasiswaLulus);
            request.setAttribute("avgIpk", String.format("%.2f", avgIpk));
            request.setAttribute("totalJurusan", listJurusan.size());
            request.setAttribute("countTI", countTI);
            request.setAttribute("countSI", countSI);
            request.setAttribute("countBD", countBD);
            request.setAttribute("listMahasiswa", listMahasiswa);
            
            request.getRequestDispatcher("/views/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard: " + e.getMessage());
        }
    }
}
