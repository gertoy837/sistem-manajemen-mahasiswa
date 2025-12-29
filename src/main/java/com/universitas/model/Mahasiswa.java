package com.universitas.model;

import java.time.LocalDateTime;

/**
 * Model untuk tabel Mahasiswa
 */
public class Mahasiswa {
    private int idMahasiswa;
    private int idJurusan;
    private int idDosen; // Dosen Pembimbing Akademik
    private String nim;
    private String namaMahasiswa;
    private String email;
    private String telepon;
    private String alamat;
    private char jenisKelamin;
    private String tanggalLahir;
    private int tahunMasuk;
    private int semesterAktif;
    private double ipk;
    private String status;
    private LocalDateTime createdAt;
    
    // Relational fields
    private String namaJurusan;
    private String namaDosen;
    
    // Default constructor
    public Mahasiswa() {}
    
    // Constructor dengan parameter utama
    public Mahasiswa(String nim, String namaMahasiswa, String email, int idJurusan) {
        this.nim = nim;
        this.namaMahasiswa = namaMahasiswa;
        this.email = email;
        this.idJurusan = idJurusan;
        this.status = "Aktif";
        this.semesterAktif = 1;
        this.ipk = 0.0;
    }
    
    // Getters and Setters
    public int getIdMahasiswa() { return idMahasiswa; }
    public void setIdMahasiswa(int idMahasiswa) { this.idMahasiswa = idMahasiswa; }
    
    public int getIdJurusan() { return idJurusan; }
    public void setIdJurusan(int idJurusan) { this.idJurusan = idJurusan; }
    
    public int getIdDosen() { return idDosen; }
    public void setIdDosen(int idDosen) { this.idDosen = idDosen; }
    
    public String getNim() { return nim; }
    public void setNim(String nim) { this.nim = nim; }
    
    public String getNamaMahasiswa() { return namaMahasiswa; }
    public void setNamaMahasiswa(String namaMahasiswa) { this.namaMahasiswa = namaMahasiswa; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getTelepon() { return telepon; }
    public void setTelepon(String telepon) { this.telepon = telepon; }
    
    public String getAlamat() { return alamat; }
    public void setAlamat(String alamat) { this.alamat = alamat; }
    
    public char getJenisKelamin() { return jenisKelamin; }
    public void setJenisKelamin(char jenisKelamin) { this.jenisKelamin = jenisKelamin; }
    
    public String getTanggalLahir() { return tanggalLahir; }
    public void setTanggalLahir(String tanggalLahir) { this.tanggalLahir = tanggalLahir; }
    
    public int getTahunMasuk() { return tahunMasuk; }
    public void setTahunMasuk(int tahunMasuk) { this.tahunMasuk = tahunMasuk; }
    
    public int getSemesterAktif() { return semesterAktif; }
    public void setSemesterAktif(int semesterAktif) { this.semesterAktif = semesterAktif; }
    
    public double getIpk() { return ipk; }
    public void setIpk(double ipk) { this.ipk = ipk; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public String getNamaJurusan() { return namaJurusan; }
    public void setNamaJurusan(String namaJurusan) { this.namaJurusan = namaJurusan; }
    
    public String getNamaDosen() { return namaDosen; }
    public void setNamaDosen(String namaDosen) { this.namaDosen = namaDosen; }
    
    @Override
    public String toString() {
        return "Mahasiswa{" +
                "nim='" + nim + '\'' +
                ", nama='" + namaMahasiswa + '\'' +
                ", email='" + email + '\'' +
                ", jurusan='" + namaJurusan + '\'' +
                ", semester=" + semesterAktif +
                ", ipk=" + ipk +
                '}';
    }
}