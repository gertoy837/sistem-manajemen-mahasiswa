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
        String sql = "SELECT j.*, f.nama_fakultas FROM jurusan j " +
                     "LEFT JOIN fakultas f ON j.id_fakultas = f.id_fakultas " +
                     "ORDER BY j.nama_jurusan";
        
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            System.out.println("DEBUG: Executing getAllJurusan query");
            
            while (rs.next()) {
                Jurusan jurusan = mapResultSetToJurusan(rs);
                listJurusan.add(jurusan);
                System.out.println("DEBUG: Found jurusan - " + jurusan.getNamaJurusan());
            }
            
            System.out.println("DEBUG: Total jurusan found = " + listJurusan.size());
            
        } catch (SQLException e) {
            System.err.println("Error getAllJurusan: " + e.getMessage());
            e.printStackTrace();
        }
        
        return listJurusan;
    }
    
    /**
     * Mengambil jurusan berdasarkan ID
     */
    public Jurusan getJurusanById(int id) {
        String sql = "SELECT j.*, f.nama_fakultas FROM jurusan j " +
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
            System.err.println("Error getJurusanById: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Menambahkan jurusan baru
     */
    public boolean insertJurusan(Jurusan jurusan) {
        String sql = "INSERT INTO jurusan (id_fakultas, nama_jurusan, ketua_jurusan, akreditasi) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setObject(1, jurusan.getIdFakultas() > 0 ? jurusan.getIdFakultas() : null);
            pstmt.setString(2, jurusan.getNamaJurusan());
            pstmt.setString(3, jurusan.getKetuaJurusan());
            pstmt.setString(4, jurusan.getAkreditasi());
            
            int result = pstmt.executeUpdate();
            System.out.println("DEBUG DAO: Insert jurusan result = " + result);
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error insertJurusan: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Mengupdate data jurusan
     */
    public boolean updateJurusan(Jurusan jurusan) {
        String sql = "UPDATE jurusan SET id_fakultas = ?, nama_jurusan = ?, ketua_jurusan = ?, akreditasi = ? WHERE id_jurusan = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setObject(1, jurusan.getIdFakultas() > 0 ? jurusan.getIdFakultas() : null);
            pstmt.setString(2, jurusan.getNamaJurusan());
            pstmt.setString(3, jurusan.getKetuaJurusan());
            pstmt.setString(4, jurusan.getAkreditasi());
            pstmt.setInt(5, jurusan.getIdJurusan());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updateJurusan: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Menghapus jurusan berdasarkan ID
     */
    public boolean deleteJurusan(int id) {
        String sql = "DELETE FROM jurusan WHERE id_jurusan = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleteJurusan: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Mencari jurusan berdasarkan keyword
     */
    public List<Jurusan> searchJurusan(String keyword) {
        List<Jurusan> listJurusan = new ArrayList<>();
        String sql = "SELECT j.*, f.nama_fakultas FROM jurusan j " +
                     "LEFT JOIN fakultas f ON j.id_fakultas = f.id_fakultas " +
                     "WHERE j.nama_jurusan ILIKE ? ORDER BY j.nama_jurusan";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Jurusan jurusan = mapResultSetToJurusan(rs);
                listJurusan.add(jurusan);
            }
            
        } catch (SQLException e) {
            System.err.println("Error searchJurusan: " + e.getMessage());
            e.printStackTrace();
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
        jurusan.setKetuaJurusan(rs.getString("ketua_jurusan"));
        jurusan.setAkreditasi(rs.getString("akreditasi"));
        
        // Get nama fakultas from join
        try {
            jurusan.setNamaFakultas(rs.getString("nama_fakultas"));
        } catch (SQLException e) {
            // Column might not exist in some queries
        }
        
        return jurusan;
    }
}