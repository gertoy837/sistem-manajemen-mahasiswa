package com.universitas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.universitas.config.DatabaseConfig;
import com.universitas.model.Jurusan;

/**
 * Data Access Object untuk tabel Jurusan
 */
public class JurusanDAO {
    
    /**
     * Mengambil semua data jurusan dengan informasi fakultas
     */
    public List<Jurusan> getAllJurusan() {
        List<Jurusan> listJurusan = new ArrayList<>();
        String sql = "SELECT j.*, f.nama_fakultas " +
                    "FROM jurusan j " +
                    "LEFT JOIN fakultas f ON j.id_fakultas = f.id_fakultas " +
                    "ORDER BY j.nama_jurusan";
        
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Jurusan jurusan = mapResultSetToJurusan(rs);
                listJurusan.add(jurusan);
            }
            
        } catch (SQLException e) {
            System.err.println("Error mengambil data jurusan: " + e.getMessage());
        }
        
        return listJurusan;
    }
    
    /**
     * Mengambil jurusan berdasarkan ID
     */
    public Jurusan getJurusanById(int id) {
        String sql = "SELECT j.*, f.nama_fakultas " +
                    "FROM jurusan j " +
                    "LEFT JOIN fakultas f ON j.id_fakultas = f.id_fakultas " +
                    "WHERE j.id_jurusan = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToJurusan(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error mengambil jurusan by ID: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Menambahkan jurusan baru
     */
    public boolean insertJurusan(Jurusan jurusan) {
        String sql = "INSERT INTO jurusan (id_fakultas, kode_jurusan, nama_jurusan, jenjang, akreditasi) " +
                     "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, jurusan.getIdFakultas());
            pstmt.setString(2, jurusan.getKodeJurusan());
            pstmt.setString(3, jurusan.getNamaJurusan());
            pstmt.setString(4, jurusan.getJenjang());
            pstmt.setString(5, jurusan.getAkreditasi());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error inserting jurusan: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Mengupdate data jurusan
     */
    public boolean updateJurusan(Jurusan jurusan) {
        String sql = "UPDATE jurusan SET id_fakultas = ?, kode_jurusan = ?, nama_jurusan = ?, " +
                     "jenjang = ?, akreditasi = ? WHERE id_jurusan = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, jurusan.getIdFakultas());
            pstmt.setString(2, jurusan.getKodeJurusan());
            pstmt.setString(3, jurusan.getNamaJurusan());
            pstmt.setString(4, jurusan.getJenjang());
            pstmt.setString(5, jurusan.getAkreditasi());
            pstmt.setInt(6, jurusan.getIdJurusan());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating jurusan: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Menghapus jurusan berdasarkan ID
     */
    public boolean deleteJurusan(int id) {
        String sql = "DELETE FROM jurusan WHERE id_jurusan = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting jurusan: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Mencari jurusan berdasarkan keyword
     */
    public List<Jurusan> searchJurusan(String keyword) {
        List<Jurusan> listJurusan = new ArrayList<>();
        String sql = "SELECT j.*, f.nama_fakultas " +
                     "FROM jurusan j " +
                     "LEFT JOIN fakultas f ON j.id_fakultas = f.id_fakultas " +
                     "WHERE LOWER(j.kode_jurusan) LIKE LOWER(?) OR LOWER(j.nama_jurusan) LIKE LOWER(?) " +
                     "ORDER BY j.nama_jurusan";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Jurusan jurusan = mapResultSetToJurusan(rs);
                listJurusan.add(jurusan);
            }
            
        } catch (SQLException e) {
            System.err.println("Error searching jurusan: " + e.getMessage());
        }
        
        return listJurusan;
    }
    
    /**
     * Mapping ResultSet ke object Jurusan
     */
    private Jurusan mapResultSetToJurusan(ResultSet rs) throws SQLException {
        Jurusan jurusan = new Jurusan();
        
        jurusan.setIdJurusan(rs.getInt("id_jurusan"));
        jurusan.setIdFakultas(rs.getInt("id_fakultas"));
        jurusan.setNamaJurusan(rs.getString("nama_jurusan"));
        
        // Try to get kode_jurusan if exists
        try {
            jurusan.setKodeJurusan(rs.getString("kode_jurusan"));
        } catch (SQLException e) {
            // Column might not exist in some queries
        }
        
        // Try to get jenjang if exists
        try {
            jurusan.setJenjang(rs.getString("jenjang"));
        } catch (SQLException e) {
            // Column might not exist in some queries
        }
        
        jurusan.setAkreditasi(rs.getString("akreditasi"));
        
        // Relational data
        try {
            jurusan.setNamaFakultas(rs.getString("nama_fakultas"));
        } catch (SQLException e) {
            // Column might not exist in some queries
        }
        
        return jurusan;
    }
}