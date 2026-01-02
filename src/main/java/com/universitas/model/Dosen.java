package com.universitas.model;

/**
 * Model class untuk entitas Dosen
 */
public class Dosen {
    
    private int idDosen;
    private int idJurusan;
    private String nip;
    private String namaDosen;
    private String email;
    private String telepon;
    private String alamat;
    private char jenisKelamin;
    private String tanggalLahir;
    private String pendidikanTerakhir;
    private String status;
    private String createdAt;
    
    // Untuk join dengan jurusan
    private String namaJurusan;
    
    // Constructors
    public Dosen() {}
    
    public Dosen(int idDosen, String nip, String namaDosen, String email, String status) {
        this.idDosen = idDosen;
        this.nip = nip;
        this.namaDosen = namaDosen;
        this.email = email;
        this.status = status;
    }
    
    // Getters and Setters
    public int getIdDosen() {
        return idDosen;
    }
    
    public void setIdDosen(int idDosen) {
        this.idDosen = idDosen;
    }
    
    public int getIdJurusan() {
        return idJurusan;
    }
    
    public void setIdJurusan(int idJurusan) {
        this.idJurusan = idJurusan;
    }
    
    public String getNip() {
        return nip;
    }
    
    public void setNip(String nip) {
        this.nip = nip;
    }
    
    public String getNamaDosen() {
        return namaDosen;
    }
    
    public void setNamaDosen(String namaDosen) {
        this.namaDosen = namaDosen;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getTelepon() {
        return telepon;
    }
    
    public void setTelepon(String telepon) {
        this.telepon = telepon;
    }
    
    public String getAlamat() {
        return alamat;
    }
    
    public void setAlamat(String alamat) {
        this.alamat = alamat;
    }
    
    public char getJenisKelamin() {
        return jenisKelamin;
    }
    
    public void setJenisKelamin(char jenisKelamin) {
        this.jenisKelamin = jenisKelamin;
    }
    
    public String getTanggalLahir() {
        return tanggalLahir;
    }
    
    public void setTanggalLahir(String tanggalLahir) {
        this.tanggalLahir = tanggalLahir;
    }
    
    public String getPendidikanTerakhir() {
        return pendidikanTerakhir;
    }
    
    public void setPendidikanTerakhir(String pendidikanTerakhir) {
        this.pendidikanTerakhir = pendidikanTerakhir;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getNamaJurusan() {
        return namaJurusan;
    }
    
    public void setNamaJurusan(String namaJurusan) {
        this.namaJurusan = namaJurusan;
    }
}
