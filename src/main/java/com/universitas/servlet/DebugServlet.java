package com.universitas.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.universitas.dao.MahasiswaDAO;
import com.universitas.model.Mahasiswa;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Debug servlet untuk troubleshoot masalah
 */
public class DebugServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head><title>Debug Info</title>");
        out.println("<script src=\"https://cdn.tailwindcss.com\"></script></head>");
        out.println("<body class=\"bg-gray-100 p-8\">");
        out.println("<div class=\"max-w-4xl mx-auto bg-white rounded-lg shadow-lg p-6\">");
        out.println("<h1 class=\"text-2xl font-bold mb-4\">Debug Information</h1>");
        
        try {
            // Test DAO
            MahasiswaDAO dao = new MahasiswaDAO();
            List<Mahasiswa> data = dao.getAllMahasiswa();
            
            out.println("<div class=\"mb-4 p-4 bg-green-100 rounded\">");
            out.println("<h2 class=\"font-bold text-green-800\">Database Connection: OK</h2>");
            out.println("<p>Found " + data.size() + " mahasiswa records</p>");
            out.println("</div>");
            
            // Show first 3 records
            out.println("<div class=\"mb-4\">");
            out.println("<h3 class=\"font-bold mb-2\">Sample Data:</h3>");
            out.println("<div class=\"bg-gray-50 p-4 rounded\">");
            
            int count = 0;
            for (Mahasiswa m : data) {
                if (count >= 3) break;
                out.println("<p><strong>NIM:</strong> " + m.getNim() + 
                           " | <strong>Nama:</strong> " + m.getNamaMahasiswa() + 
                           " | <strong>Jurusan:</strong> " + m.getNamaJurusan() + "</p>");
                count++;
            }
            out.println("</div>");
            out.println("</div>");
            
            // Test JSP path
            String jspPath = "/views/mahasiswa/list.jsp";
            out.println("<div class=\"mb-4 p-4 bg-blue-100 rounded\">");
            out.println("<h2 class=\"font-bold text-blue-800\">JSP Path Test</h2>");
            out.println("<p>Target JSP: " + jspPath + "</p>");
            out.println("<p>Context Path: " + request.getContextPath() + "</p>");
            out.println("<p>Servlet Path: " + request.getServletPath() + "</p>");
            out.println("</div>");
            
        } catch (Exception e) {
            out.println("<div class=\"mb-4 p-4 bg-red-100 rounded\">");
            out.println("<h2 class=\"font-bold text-red-800\">ERROR</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("<pre class=\"bg-red-50 p-2 mt-2 text-xs\">");
            e.printStackTrace(out);
            out.println("</pre>");
            out.println("</div>");
        }
        
        out.println("<div class=\"mt-6\">");
        out.println("<a href=\"" + request.getContextPath() + "/mahasiswa\" class=\"bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600\">Test Mahasiswa Servlet</a>");
        out.println("</div>");
        
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }
}