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
                Jurusan jurusan = new Jurusan();
                
                jurusan.setIdJurusan(rs.getInt("id_jurusan"));
                jurusan.setIdFakultas(rs.getInt("id_fakultas"));
                jurusan.setNamaJurusan(rs.getString("nama_jurusan"));
                jurusan.setKetuaJurusan(rs.getString("ketua_jurusan"));
                
                String akreditasi = rs.getString("akreditasi");
                if (akreditasi != null && !akreditasi.isEmpty()) {
                    jurusan.setAkreditasi(akreditasi.charAt(0));
                }
                
                // Relational data
                jurusan.setNamaFakultas(rs.getString("nama_fakultas"));
                
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
                Jurusan jurusan = new Jurusan();
                
                jurusan.setIdJurusan(rs.getInt("id_jurusan"));
                jurusan.setIdFakultas(rs.getInt("id_fakultas"));
                jurusan.setNamaJurusan(rs.getString("nama_jurusan"));
                jurusan.setKetuaJurusan(rs.getString("ketua_jurusan"));
                
                String akreditasi = rs.getString("akreditasi");
                if (akreditasi != null && !akreditasi.isEmpty()) {
                    jurusan.setAkreditasi(akreditasi.charAt(0));
                }
                
                // Relational data
                jurusan.setNamaFakultas(rs.getString("nama_fakultas"));
                
                return jurusan;
            }
            
        } catch (SQLException e) {
            System.err.println("Error mengambil jurusan by ID: " + e.getMessage());
        }
        
        return null;
    }
}