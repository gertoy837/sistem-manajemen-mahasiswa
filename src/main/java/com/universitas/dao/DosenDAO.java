package com.universitas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.universitas.config.DatabaseConfig;
import com.universitas.model.Dosen;

/**
 * Data Access Object untuk tabel Dosen
 */
public class DosenDAO {
    
    /**
     * Mendapatkan semua data dosen dengan join ke jurusan
     */
    public List<Dosen> getAllDosen() {
        List<Dosen> listDosen = new ArrayList<>();
        String sql = "SELECT d.*, j.nama_jurusan FROM dosen d " +
                     "LEFT JOIN jurusan j ON d.id_jurusan = j.id_jurusan " +
                     "ORDER BY d.nama_dosen";
        
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Dosen dosen = mapResultSetToDosen(rs);
                listDosen.add(dosen);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all dosen: " + e.getMessage());
        }
        
        return listDosen;
    }
    
    /**
     * Mendapatkan dosen berdasarkan ID
     */
    public Dosen getDosenById(int id) {
        String sql = "SELECT d.*, j.nama_jurusan FROM dosen d " +
                     "LEFT JOIN jurusan j ON d.id_jurusan = j.id_jurusan " +
                     "WHERE d.id_dosen = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToDosen(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting dosen by id: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Menambahkan dosen baru
     */
    public boolean insertDosen(Dosen dosen) {
        String sql = "INSERT INTO dosen (id_jurusan, nip, nama_dosen, email, telepon, alamat, " +
                     "jenis_kelamin, tanggal_lahir, pendidikan_terakhir, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?::date, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, dosen.getIdJurusan());
            pstmt.setString(2, dosen.getNip());
            pstmt.setString(3, dosen.getNamaDosen());
            pstmt.setString(4, dosen.getEmail());
            pstmt.setString(5, dosen.getTelepon());
            pstmt.setString(6, dosen.getAlamat());
            pstmt.setString(7, String.valueOf(dosen.getJenisKelamin()));
            pstmt.setString(8, dosen.getTanggalLahir());
            pstmt.setString(9, dosen.getPendidikanTerakhir());
            pstmt.setString(10, dosen.getStatus());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error inserting dosen: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Mengupdate data dosen
     */
    public boolean updateDosen(Dosen dosen) {
        String sql = "UPDATE dosen SET id_jurusan = ?, nip = ?, nama_dosen = ?, email = ?, " +
                     "telepon = ?, alamat = ?, jenis_kelamin = ?, tanggal_lahir = ?::date, " +
                     "pendidikan_terakhir = ?, status = ? WHERE id_dosen = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, dosen.getIdJurusan());
            pstmt.setString(2, dosen.getNip());
            pstmt.setString(3, dosen.getNamaDosen());
            pstmt.setString(4, dosen.getEmail());
            pstmt.setString(5, dosen.getTelepon());
            pstmt.setString(6, dosen.getAlamat());
            pstmt.setString(7, String.valueOf(dosen.getJenisKelamin()));
            pstmt.setString(8, dosen.getTanggalLahir());
            pstmt.setString(9, dosen.getPendidikanTerakhir());
            pstmt.setString(10, dosen.getStatus());
            pstmt.setInt(11, dosen.getIdDosen());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating dosen: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Menghapus dosen berdasarkan ID
     */
    public boolean deleteDosen(int id) {
        String sql = "DELETE FROM dosen WHERE id_dosen = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting dosen: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Mencari dosen berdasarkan keyword
     */
    public List<Dosen> searchDosen(String keyword) {
        List<Dosen> listDosen = new ArrayList<>();
        String sql = "SELECT d.*, j.nama_jurusan FROM dosen d " +
                     "LEFT JOIN jurusan j ON d.id_jurusan = j.id_jurusan " +
                     "WHERE LOWER(d.nip) LIKE LOWER(?) OR LOWER(d.nama_dosen) LIKE LOWER(?) " +
                     "ORDER BY d.nama_dosen";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Dosen dosen = mapResultSetToDosen(rs);
                listDosen.add(dosen);
            }
            
        } catch (SQLException e) {
            System.err.println("Error searching dosen: " + e.getMessage());
        }
        
        return listDosen;
    }
    
    /**
     * Mapping ResultSet ke object Dosen
     */
    private Dosen mapResultSetToDosen(ResultSet rs) throws SQLException {
        Dosen dosen = new Dosen();
        dosen.setIdDosen(rs.getInt("id_dosen"));
        dosen.setIdJurusan(rs.getInt("id_jurusan"));
        dosen.setNip(rs.getString("nip"));
        dosen.setNamaDosen(rs.getString("nama_dosen"));
        dosen.setEmail(rs.getString("email"));
        dosen.setTelepon(rs.getString("telepon"));
        dosen.setAlamat(rs.getString("alamat"));
        
        String jk = rs.getString("jenis_kelamin");
        if (jk != null && !jk.isEmpty()) {
            dosen.setJenisKelamin(jk.charAt(0));
        }
        
        if (rs.getDate("tanggal_lahir") != null) {
            dosen.setTanggalLahir(rs.getDate("tanggal_lahir").toString());
        }
        
        dosen.setPendidikanTerakhir(rs.getString("pendidikan_terakhir"));
        dosen.setStatus(rs.getString("status"));
        dosen.setNamaJurusan(rs.getString("nama_jurusan"));
        
        return dosen;
    }
}
