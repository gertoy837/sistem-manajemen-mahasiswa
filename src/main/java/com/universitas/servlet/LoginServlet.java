package com.universitas.servlet;

import java.io.IOException;

import com.universitas.dao.UserDAO;
import com.universitas.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet untuk menangani login dan logout
 */
@WebServlet(urlPatterns = {"/login", "/logout"})
public class LoginServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        if ("/logout".equals(path)) {
            // Handle logout
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Cek jika sudah login
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                response.sendRedirect(request.getContextPath() + "/mahasiswa");
                return;
            }
            
            // Tampilkan halaman login
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validasi input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username dan password harus diisi!");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        // Autentikasi
        User user = userDAO.authenticate(username.trim(), password);
        
        if (user != null) {
            // Login berhasil
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("namaLengkap", user.getNamaLengkap());
            session.setAttribute("role", user.getRole());
            session.setMaxInactiveInterval(30 * 60); // 30 menit
            
            response.sendRedirect(request.getContextPath() + "/mahasiswa");
        } else {
            // Login gagal
            request.setAttribute("error", "Username atau password salah!");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
