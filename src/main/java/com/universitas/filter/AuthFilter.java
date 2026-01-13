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
        
        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = uri.substring(contextPath.length());
        
        // Halaman publik yang tidak perlu login
        boolean isPublicPage = path.equals("") || 
                               path.equals("/") || 
                               path.equals("/index.jsp") ||
                               path.equals("/login") || 
                               path.equals("/about") || 
                               path.equals("/gallery") ||
                               path.startsWith("/assets/") ||
                               path.startsWith("/views/login") ||
                               path.startsWith("/views/about") ||
                               path.startsWith("/views/gallery") ||
                               path.endsWith(".css") || 
                               path.endsWith(".js") || 
                               path.endsWith(".png") || 
                               path.endsWith(".jpg") || 
                               path.endsWith(".jpeg") || 
                               path.endsWith(".gif") ||
                               path.endsWith(".ico");
        
        if (isPublicPage) {
            chain.doFilter(request, response);
            return;
        }
        
        // Cek session untuk halaman yang memerlukan login
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        if (isLoggedIn) {
            // User sudah login, lanjutkan request
            chain.doFilter(request, response);
        } else {
            // User belum login, redirect ke halaman login
            httpResponse.sendRedirect(contextPath + "/login");
        }
    }
    
    @Override
    public void destroy() {
        // Cleanup
    }
}
