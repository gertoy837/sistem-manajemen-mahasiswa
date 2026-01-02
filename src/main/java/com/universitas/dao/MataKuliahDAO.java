package com.universitas.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.universitas.config.DatabaseConfig;
import com.universitas.model.MataKuliah;

/**
 * Data Access Object untuk tabel Mata Kuliah
 */
public class MataKuliahDAO {
    
    /**
     * Mendapatkan semua data mata kuliah dengan join ke jurusan dan dosen
     */
    public List<MataKuliah> getAllMataKuliah() {
        List<MataKuliah> listMataKuliah = new ArrayList<>();
        String sql = "SELECT mk.*, j.nama_jurusan, d.nama_dosen FROM mata_kuliah mk " +
                     "LEFT JOIN jurusan j ON mk.id_jurusan = j.id_jurusan " +
                     "LEFT JOIN dosen d ON mk.id_dosen = d.id_dosen " +
                     "ORDER BY mk.nama_matakuliah";
        
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                MataKuliah mataKuliah = mapResultSetToMataKuliah(rs);
                listMataKuliah.add(mataKuliah);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting all mata kuliah: " + e.getMessage());
        }
        
        return listMataKuliah;
    }
    
    /**
     * Mendapatkan mata kuliah berdasarkan ID
     */
    public MataKuliah getMataKuliahById(int id) {
        String sql = "SELECT mk.*, j.nama_jurusan, d.nama_dosen FROM mata_kuliah mk " +
                     "LEFT JOIN jurusan j ON mk.id_jurusan = j.id_jurusan " +
                     "LEFT JOIN dosen d ON mk.id_dosen = d.id_dosen " +
                     "WHERE mk.id_matakuliah = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToMataKuliah(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting mata kuliah by id: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Menambahkan mata kuliah baru
     */
    public boolean insertMataKuliah(MataKuliah mataKuliah) {
        String sql = "INSERT INTO mata_kuliah (id_jurusan, id_dosen, kode_matakuliah, nama_matakuliah, " +
                     "sks, semester, jenis, deskripsi) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, mataKuliah.getIdJurusan());
            if (mataKuliah.getIdDosen() > 0) {
                pstmt.setInt(2, mataKuliah.getIdDosen());
            } else {
                pstmt.setNull(2, java.sql.Types.INTEGER);
            }
            pstmt.setString(3, mataKuliah.getKodeMatakuliah());
            pstmt.setString(4, mataKuliah.getNamaMatakuliah());
            pstmt.setInt(5, mataKuliah.getSks());
            pstmt.setInt(6, mataKuliah.getSemester());
            pstmt.setString(7, mataKuliah.getJenis());
            pstmt.setString(8, mataKuliah.getDeskripsi());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error inserting mata kuliah: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Mengupdate data mata kuliah
     */
    public boolean updateMataKuliah(MataKuliah mataKuliah) {
        String sql = "UPDATE mata_kuliah SET id_jurusan = ?, id_dosen = ?, kode_matakuliah = ?, " +
                     "nama_matakuliah = ?, sks = ?, semester = ?, jenis = ?, deskripsi = ? " +
                     "WHERE id_matakuliah = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, mataKuliah.getIdJurusan());
            if (mataKuliah.getIdDosen() > 0) {
                pstmt.setInt(2, mataKuliah.getIdDosen());
            } else {
                pstmt.setNull(2, java.sql.Types.INTEGER);
            }
            pstmt.setString(3, mataKuliah.getKodeMatakuliah());
            pstmt.setString(4, mataKuliah.getNamaMatakuliah());
            pstmt.setInt(5, mataKuliah.getSks());
            pstmt.setInt(6, mataKuliah.getSemester());
            pstmt.setString(7, mataKuliah.getJenis());
            pstmt.setString(8, mataKuliah.getDeskripsi());
            pstmt.setInt(9, mataKuliah.getIdMatakuliah());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating mata kuliah: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Menghapus mata kuliah berdasarkan ID
     */
    public boolean deleteMataKuliah(int id) {
        String sql = "DELETE FROM mata_kuliah WHERE id_matakuliah = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting mata kuliah: " + e.getMessage());
        }
        
        return false;
    }
    
    /**
     * Mencari mata kuliah berdasarkan keyword
     */
    public List<MataKuliah> searchMataKuliah(String keyword) {
        List<MataKuliah> listMataKuliah = new ArrayList<>();
        String sql = "SELECT mk.*, j.nama_jurusan, d.nama_dosen FROM mata_kuliah mk " +
                     "LEFT JOIN jurusan j ON mk.id_jurusan = j.id_jurusan " +
                     "LEFT JOIN dosen d ON mk.id_dosen = d.id_dosen " +
                     "WHERE LOWER(mk.kode_matakuliah) LIKE LOWER(?) OR LOWER(mk.nama_matakuliah) LIKE LOWER(?) " +
                     "ORDER BY mk.nama_matakuliah";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                MataKuliah mataKuliah = mapResultSetToMataKuliah(rs);
                listMataKuliah.add(mataKuliah);
            }
            
        } catch (SQLException e) {
            System.err.println("Error searching mata kuliah: " + e.getMessage());
        }
        
        return listMataKuliah;
    }
    
    /**
     * Mapping ResultSet ke object MataKuliah
     */
    private MataKuliah mapResultSetToMataKuliah(ResultSet rs) throws SQLException {
        MataKuliah mataKuliah = new MataKuliah();
        mataKuliah.setIdMatakuliah(rs.getInt("id_matakuliah"));
        mataKuliah.setIdJurusan(rs.getInt("id_jurusan"));
        mataKuliah.setIdDosen(rs.getInt("id_dosen"));
        mataKuliah.setKodeMatakuliah(rs.getString("kode_matakuliah"));
        mataKuliah.setNamaMatakuliah(rs.getString("nama_matakuliah"));
        mataKuliah.setSks(rs.getInt("sks"));
        mataKuliah.setSemester(rs.getInt("semester"));
        mataKuliah.setJenis(rs.getString("jenis"));
        mataKuliah.setDeskripsi(rs.getString("deskripsi"));
        mataKuliah.setNamaJurusan(rs.getString("nama_jurusan"));
        mataKuliah.setNamaDosen(rs.getString("nama_dosen"));
        
        return mataKuliah;
    }
}
