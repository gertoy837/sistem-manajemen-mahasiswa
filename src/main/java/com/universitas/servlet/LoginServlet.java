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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Cek jika sudah login, redirect ke dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username dan password harus diisi!");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        User user = userDAO.validateLogin(username.trim(), password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getIdUser());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("namaLengkap", user.getNamaLengkap());
            session.setAttribute("role", user.getRole());
            session.setMaxInactiveInterval(30 * 60);
            
            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            request.setAttribute("error", "Username atau password salah!");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
