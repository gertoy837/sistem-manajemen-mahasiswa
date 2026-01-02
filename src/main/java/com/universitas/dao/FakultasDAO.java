package com.universitas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.universitas.config.DatabaseConfig;
import com.universitas.model.Fakultas;

/**
 * Data Access Object untuk tabel Fakultas
 */
public class FakultasDAO {
    
    /**
     * Mendapatkan semua data fakultas
     */
    public List<Fakultas> getAllFakultas() {
        List<Fakultas> listFakultas = new ArrayList<>();
        String sql = "SELECT * FROM fakultas ORDER BY nama_fakultas";
        
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Fakultas fakultas = mapResultSetToFakultas(rs);
                listFakultas.add(fakultas);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all fakultas: " + e.getMessage());
        }
        
        return listFakultas;
    }
    
    /**
     * Mendapatkan fakultas berdasarkan ID
     */
    public Fakultas getFakultasById(int id) {
        String sql = "SELECT * FROM fakultas WHERE id_fakultas = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToFakultas(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting fakultas by id: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Menambahkan fakultas baru
     */
    public boolean insertFakultas(Fakultas fakultas) {
        String sql = "INSERT INTO fakultas (kode_fakultas, nama_fakultas, dekan) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, fakultas.getKodeFakultas());
            pstmt.setString(2, fakultas.getNamaFakultas());
            pstmt.setString(3, fakultas.getDekan());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error inserting fakultas: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Mengupdate data fakultas
     */
    public boolean updateFakultas(Fakultas fakultas) {
        String sql = "UPDATE fakultas SET kode_fakultas = ?, nama_fakultas = ?, dekan = ? WHERE id_fakultas = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, fakultas.getKodeFakultas());
            pstmt.setString(2, fakultas.getNamaFakultas());
            pstmt.setString(3, fakultas.getDekan());
            pstmt.setInt(4, fakultas.getIdFakultas());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating fakultas: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Menghapus fakultas berdasarkan ID
     */
    public boolean deleteFakultas(int id) {
        String sql = "DELETE FROM fakultas WHERE id_fakultas = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting fakultas: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Mapping ResultSet ke object Fakultas
     */
    private Fakultas mapResultSetToFakultas(ResultSet rs) throws SQLException {
        Fakultas fakultas = new Fakultas();
        fakultas.setIdFakultas(rs.getInt("id_fakultas"));
        
        try {
            fakultas.setKodeFakultas(rs.getString("kode_fakultas"));
        } catch (SQLException e) {
            // Column might not exist
        }
        
        fakultas.setNamaFakultas(rs.getString("nama_fakultas"));
        
        try {
            fakultas.setDekan(rs.getString("dekan"));
        } catch (SQLException e) {
            // Column might not exist
        }
        
        return fakultas;
    }
}
