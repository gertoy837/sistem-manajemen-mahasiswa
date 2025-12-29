package com.universitas.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Filter untuk mengecek autentikasi user
 * Semua request kecuali /login akan dicek apakah sudah login
 */
@WebFilter(urlPatterns = {"/*"})
public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String path = httpRequest.getServletPath();
        
        // Allow access to login page, static resources, and root
        if (isPublicResource(path)) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check if user is logged in
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        if (isLoggedIn) {
            // User sudah login, lanjutkan request
            chain.doFilter(request, response);
        } else {
            // User belum login, redirect ke halaman login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
    
    /**
     * Cek apakah resource bisa diakses tanpa login
     */
    private boolean isPublicResource(String path) {
        return path.equals("/login") || 
               path.equals("/logout") ||
               path.startsWith("/css/") ||
               path.startsWith("/js/") ||
               path.startsWith("/images/") ||
               path.endsWith(".css") ||
               path.endsWith(".js") ||
               path.endsWith(".png") ||
               path.endsWith(".jpg") ||
               path.endsWith(".ico");
    }
    
    @Override
    public void destroy() {
        // Cleanup
    }
}
