package com.universitas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.universitas.config.DatabaseConfig;
import com.universitas.model.User;

/**
 * Data Access Object untuk tabel Users
 */
public class UserDAO {
    
    /**
     * Autentikasi user berdasarkan username dan password
     */
    public User authenticate(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        Connection conn = null;
        
        try {
            conn = DatabaseConfig.getConnection();
            if (conn == null) {
                System.err.println("ERROR: Database connection is null!");
                return null;
            }
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setIdUser(rs.getInt("id_user"));
                user.setUsername(rs.getString("username"));
                user.setNamaLengkap(rs.getString("nama_lengkap"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                rs.close();
                pstmt.close();
                DatabaseConfig.closeConnection(conn);
                return user;
            }
            rs.close();
            pstmt.close();
            DatabaseConfig.closeConnection(conn);
            
        } catch (SQLException e) {
            System.err.println("Error autentikasi user: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Mendapatkan user berdasarkan username
     */
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setIdUser(rs.getInt("id_user"));
                user.setUsername(rs.getString("username"));
                user.setNamaLengkap(rs.getString("nama_lengkap"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                return user;
            }
            
        } catch (SQLException e) {
            System.err.println("Error mengambil user: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Menambah user baru
     */
    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, password, nama_lengkap, email, role) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getNamaLengkap());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getRole() != null ? user.getRole() : "user");
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error menambah user: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Update password user
     */
    public boolean updatePassword(int idUser, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE id_user = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, idUser);
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error update password: " + e.getMessage());
            return false;
        }
    }
}
