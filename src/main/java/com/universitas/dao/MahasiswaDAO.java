package com.universitas.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.universitas.config.DatabaseConfig;
import com.universitas.model.Mahasiswa;

/**
 * Data Access Object untuk tabel Mahasiswa
 */
public class MahasiswaDAO {
    
    /**
     * Menambah mahasiswa baru
     */
    public boolean tambahMahasiswa(Mahasiswa mahasiswa) {
        String sql = "INSERT INTO mahasiswa (id_jurusan, id_dosen, nim, nama_mahasiswa, " +
                    "email, telepon, alamat, jenis_kelamin, tanggal_lahir, tahun_masuk, " +
                    "semester_aktif, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, mahasiswa.getIdJurusan());
            pstmt.setObject(2, mahasiswa.getIdDosen() > 0 ? mahasiswa.getIdDosen() : null);
            pstmt.setString(3, mahasiswa.getNim());
            pstmt.setString(4, mahasiswa.getNamaMahasiswa());
            pstmt.setString(5, mahasiswa.getEmail());
            pstmt.setString(6, mahasiswa.getTelepon());
            pstmt.setString(7, mahasiswa.getAlamat());
            pstmt.setString(8, String.valueOf(mahasiswa.getJenisKelamin()));
            
            // Handle tanggal lahir dengan proper null/empty check
            String tanggalLahir = mahasiswa.getTanggalLahir();
            if (tanggalLahir != null && !tanggalLahir.trim().isEmpty()) {
                try {
                    pstmt.setDate(9, Date.valueOf(tanggalLahir.trim()));
                } catch (IllegalArgumentException e) {
                    System.err.println("Invalid date format for insert: " + tanggalLahir);
                    pstmt.setNull(9, Types.DATE);
                }
            } else {
                pstmt.setNull(9, Types.DATE);
            }
            
            pstmt.setInt(10, mahasiswa.getTahunMasuk());
            pstmt.setInt(11, mahasiswa.getSemesterAktif());
            pstmt.setString(12, mahasiswa.getStatus());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error menambah mahasiswa: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Mengambil semua data mahasiswa dengan informasi jurusan
     */
    public List<Mahasiswa> getAllMahasiswa() {
        List<Mahasiswa> listMahasiswa = new ArrayList<>();
        String sql = "SELECT m.*, j.nama_jurusan, d.nama_dosen " +
                    "FROM mahasiswa m " +
                    "LEFT JOIN jurusan j ON m.id_jurusan = j.id_jurusan " +
                    "LEFT JOIN dosen d ON m.id_dosen = d.id_dosen " +
                    "ORDER BY m.nim";
        
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Mahasiswa mahasiswa = new Mahasiswa();
                
                mahasiswa.setIdMahasiswa(rs.getInt("id_mahasiswa"));
                mahasiswa.setIdJurusan(rs.getInt("id_jurusan"));
                mahasiswa.setIdDosen(rs.getInt("id_dosen"));
                mahasiswa.setNim(rs.getString("nim"));
                mahasiswa.setNamaMahasiswa(rs.getString("nama_mahasiswa"));
                mahasiswa.setEmail(rs.getString("email"));
                mahasiswa.setTelepon(rs.getString("telepon"));
                mahasiswa.setAlamat(rs.getString("alamat"));
                
                String jenisKelamin = rs.getString("jenis_kelamin");
                if (jenisKelamin != null && !jenisKelamin.isEmpty()) {
                    mahasiswa.setJenisKelamin(jenisKelamin.charAt(0));
                }
                
                Date tanggalLahir = rs.getDate("tanggal_lahir");
                if (tanggalLahir != null) {
                    mahasiswa.setTanggalLahir(tanggalLahir.toString());
                }
                
                mahasiswa.setTahunMasuk(rs.getInt("tahun_masuk"));
                mahasiswa.setSemesterAktif(rs.getInt("semester_aktif"));
                mahasiswa.setIpk(rs.getDouble("ipk"));
                mahasiswa.setStatus(rs.getString("status"));
                
                // Relational data
                mahasiswa.setNamaJurusan(rs.getString("nama_jurusan"));
                mahasiswa.setNamaDosen(rs.getString("nama_dosen"));
                
                listMahasiswa.add(mahasiswa);
            }
            
        } catch (SQLException e) {
            System.err.println("Error mengambil data mahasiswa: " + e.getMessage());
        }
        
        return listMahasiswa;
    }
    
    /**
     * Mengambil mahasiswa berdasarkan ID
     */
    public Mahasiswa getMahasiswaById(int id) {
        String sql = "SELECT m.*, j.nama_jurusan, d.nama_dosen " +
                    "FROM mahasiswa m " +
                    "LEFT JOIN jurusan j ON m.id_jurusan = j.id_jurusan " +
                    "LEFT JOIN dosen d ON m.id_dosen = d.id_dosen " +
                    "WHERE m.id_mahasiswa = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Mahasiswa mahasiswa = new Mahasiswa();
                
                mahasiswa.setIdMahasiswa(rs.getInt("id_mahasiswa"));
                mahasiswa.setIdJurusan(rs.getInt("id_jurusan"));
                mahasiswa.setIdDosen(rs.getInt("id_dosen"));
                mahasiswa.setNim(rs.getString("nim"));
                mahasiswa.setNamaMahasiswa(rs.getString("nama_mahasiswa"));
                mahasiswa.setEmail(rs.getString("email"));
                mahasiswa.setTelepon(rs.getString("telepon"));
                mahasiswa.setAlamat(rs.getString("alamat"));
                
                String jenisKelamin = rs.getString("jenis_kelamin");
                if (jenisKelamin != null && !jenisKelamin.isEmpty()) {
                    mahasiswa.setJenisKelamin(jenisKelamin.charAt(0));
                }
                
                Date tanggalLahir = rs.getDate("tanggal_lahir");
                if (tanggalLahir != null) {
                    mahasiswa.setTanggalLahir(tanggalLahir.toString());
                }
                
                mahasiswa.setTahunMasuk(rs.getInt("tahun_masuk"));
                mahasiswa.setSemesterAktif(rs.getInt("semester_aktif"));
                mahasiswa.setIpk(rs.getDouble("ipk"));
                mahasiswa.setStatus(rs.getString("status"));
                
                // Relational data
                mahasiswa.setNamaJurusan(rs.getString("nama_jurusan"));
                mahasiswa.setNamaDosen(rs.getString("nama_dosen"));
                
                return mahasiswa;
            }
            
        } catch (SQLException e) {
            System.err.println("Error mengambil mahasiswa by ID: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Update data mahasiswa
     */
    public boolean updateMahasiswa(Mahasiswa mahasiswa) {
        String sql = "UPDATE mahasiswa SET id_jurusan=?, id_dosen=?, nim=?, nama_mahasiswa=?, " +
                    "email=?, telepon=?, alamat=?, jenis_kelamin=?, tanggal_lahir=?, " +
                    "tahun_masuk=?, semester_aktif=?, ipk=?, status=? WHERE id_mahasiswa=?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            System.out.println("DEBUG DAO: Starting updateMahasiswa for ID " + mahasiswa.getIdMahasiswa());
            
            pstmt.setInt(1, mahasiswa.getIdJurusan());
            pstmt.setObject(2, mahasiswa.getIdDosen() > 0 ? mahasiswa.getIdDosen() : null);
            pstmt.setString(3, mahasiswa.getNim());
            pstmt.setString(4, mahasiswa.getNamaMahasiswa());
            pstmt.setString(5, mahasiswa.getEmail());
            pstmt.setString(6, mahasiswa.getTelepon() != null ? mahasiswa.getTelepon() : "");
            pstmt.setString(7, mahasiswa.getAlamat() != null ? mahasiswa.getAlamat() : "");
            
            // Handle jenis kelamin - ensure it's not null char
            char jk = mahasiswa.getJenisKelamin();
            if (jk == '\0' || (jk != 'L' && jk != 'P')) {
                jk = 'L'; // Default to 'L' if invalid
            }
            pstmt.setString(8, String.valueOf(jk));
            
            // Handle tanggal lahir dengan proper null/empty check
            String tanggalLahir = mahasiswa.getTanggalLahir();
            if (tanggalLahir != null && !tanggalLahir.trim().isEmpty()) {
                try {
                    pstmt.setDate(9, Date.valueOf(tanggalLahir.trim()));
                } catch (IllegalArgumentException e) {
                    System.err.println("Invalid date format: " + tanggalLahir);
                    pstmt.setNull(9, Types.DATE);
                }
            } else {
                pstmt.setNull(9, Types.DATE);
            }
            
            pstmt.setInt(10, mahasiswa.getTahunMasuk());
            pstmt.setInt(11, mahasiswa.getSemesterAktif());
            pstmt.setDouble(12, mahasiswa.getIpk());
            pstmt.setString(13, mahasiswa.getStatus() != null ? mahasiswa.getStatus() : "Aktif");
            pstmt.setInt(14, mahasiswa.getIdMahasiswa());
            
            System.out.println("DEBUG DAO: Executing update query...");
            int result = pstmt.executeUpdate();
            System.out.println("DEBUG DAO: Update result = " + result);
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error update mahasiswa: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Hapus mahasiswa berdasarkan ID
     */
    public boolean deleteMahasiswa(int id) {
        String sql = "DELETE FROM mahasiswa WHERE id_mahasiswa = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error hapus mahasiswa: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Cari mahasiswa berdasarkan NIM atau Nama
     */
    public List<Mahasiswa> cariMahasiswa(String keyword) {
        List<Mahasiswa> listMahasiswa = new ArrayList<>();
        String sql = "SELECT m.*, j.nama_jurusan, d.nama_dosen " +
                    "FROM mahasiswa m " +
                    "LEFT JOIN jurusan j ON m.id_jurusan = j.id_jurusan " +
                    "LEFT JOIN dosen d ON m.id_dosen = d.id_dosen " +
                    "WHERE m.nim ILIKE ? OR m.nama_mahasiswa ILIKE ? " +
                    "ORDER BY m.nim";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Mahasiswa mahasiswa = new Mahasiswa();
                
                mahasiswa.setIdMahasiswa(rs.getInt("id_mahasiswa"));
                mahasiswa.setIdJurusan(rs.getInt("id_jurusan"));
                mahasiswa.setIdDosen(rs.getInt("id_dosen"));
                mahasiswa.setNim(rs.getString("nim"));
                mahasiswa.setNamaMahasiswa(rs.getString("nama_mahasiswa"));
                mahasiswa.setEmail(rs.getString("email"));
                mahasiswa.setTelepon(rs.getString("telepon"));
                mahasiswa.setAlamat(rs.getString("alamat"));
                
                String jenisKelamin = rs.getString("jenis_kelamin");
                if (jenisKelamin != null && !jenisKelamin.isEmpty()) {
                    mahasiswa.setJenisKelamin(jenisKelamin.charAt(0));
                }
                
                Date tanggalLahir = rs.getDate("tanggal_lahir");
                if (tanggalLahir != null) {
                    mahasiswa.setTanggalLahir(tanggalLahir.toString());
                }
                
                mahasiswa.setTahunMasuk(rs.getInt("tahun_masuk"));
                mahasiswa.setSemesterAktif(rs.getInt("semester_aktif"));
                mahasiswa.setIpk(rs.getDouble("ipk"));
                mahasiswa.setStatus(rs.getString("status"));
                
                // Relational data
                mahasiswa.setNamaJurusan(rs.getString("nama_jurusan"));
                mahasiswa.setNamaDosen(rs.getString("nama_dosen"));
                
                listMahasiswa.add(mahasiswa);
            }
            
        } catch (SQLException e) {
            System.err.println("Error cari mahasiswa: " + e.getMessage());
        }
        
        return listMahasiswa;
    }
}