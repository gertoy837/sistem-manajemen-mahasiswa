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
     * Validasi login user - cek password plain text dulu, jika tidak cocok coba dengan hash
     */
    public User validateLogin(String username, String password) {
        // Query untuk mengambil user berdasarkan username
        String sql = "SELECT * FROM users WHERE username = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            System.out.println("DEBUG: Attempting login for username: " + username);
            
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                System.out.println("DEBUG: User found, checking password...");
                
                // Cek password - bisa plain text atau hashed
                boolean passwordMatch = false;
                
                // Cek plain text password dulu
                if (storedPassword != null && storedPassword.equals(password)) {
                    passwordMatch = true;
                    System.out.println("DEBUG: Plain text password match!");
                }
                
                // Jika tidak cocok, coba dengan MD5 hash
                if (!passwordMatch) {
                    String hashedInput = hashMD5(password);
                    if (storedPassword != null && storedPassword.equals(hashedInput)) {
                        passwordMatch = true;
                        System.out.println("DEBUG: MD5 hashed password match!");
                    }
                }
                
                // Jika tidak cocok, coba dengan SHA-256 hash
                if (!passwordMatch) {
                    String hashedInput = hashSHA256(password);
                    if (storedPassword != null && storedPassword.equals(hashedInput)) {
                        passwordMatch = true;
                        System.out.println("DEBUG: SHA-256 hashed password match!");
                    }
                }
                
                if (passwordMatch) {
                    User user = new User();
                    user.setIdUser(rs.getInt("id_user"));
                    user.setUsername(rs.getString("username"));
                    user.setNamaLengkap(rs.getString("nama_lengkap"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    System.out.println("DEBUG: Login successful for user: " + username);
                    return user;
                } else {
                    System.out.println("DEBUG: Password mismatch for user: " + username);
                    System.out.println("DEBUG: Stored password hash: " + storedPassword);
                }
            } else {
                System.out.println("DEBUG: User not found: " + username);
            }
            
        } catch (SQLException e) {
            System.err.println("Error validating login: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Hash password dengan MD5
     */
    private String hashMD5(String password) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : array) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            return null;
        }
    }
    
    /**
     * Hash password dengan SHA-256
     */
    private String hashSHA256(String password) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
            byte[] array = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : array) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            return null;
        }
    }
    
    /**
     * Get user by ID
     */
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id_user = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
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
            System.err.println("Error getting user by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
}
