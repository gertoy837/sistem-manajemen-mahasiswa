package com.universitas.model;

/**
 * Model class untuk entitas Mata Kuliah
 */
public class MataKuliah {
    
    private int idMatakuliah;
    private int idJurusan;
    private int idDosen;
    private String kodeMatakuliah;
    private String namaMatakuliah;
    private int sks;
    private int semester;
    private String jenis;
    private String deskripsi;
    private String createdAt;
    
    // Untuk join dengan tabel lain
    private String namaJurusan;
    private String namaDosen;
    
    // Constructors
    public MataKuliah() {}
    
    public MataKuliah(int idMatakuliah, String kodeMatakuliah, String namaMatakuliah, int sks, int semester) {
        this.idMatakuliah = idMatakuliah;
        this.kodeMatakuliah = kodeMatakuliah;
        this.namaMatakuliah = namaMatakuliah;
        this.sks = sks;
        this.semester = semester;
    }
    
    // Getters and Setters
    public int getIdMatakuliah() {
        return idMatakuliah;
    }
    
    public void setIdMatakuliah(int idMatakuliah) {
        this.idMatakuliah = idMatakuliah;
    }
    
    public int getIdJurusan() {
        return idJurusan;
    }
    
    public void setIdJurusan(int idJurusan) {
        this.idJurusan = idJurusan;
    }
    
    public int getIdDosen() {
        return idDosen;
    }
    
    public void setIdDosen(int idDosen) {
        this.idDosen = idDosen;
    }
    
    public String getKodeMatakuliah() {
        return kodeMatakuliah;
    }
    
    public void setKodeMatakuliah(String kodeMatakuliah) {
        this.kodeMatakuliah = kodeMatakuliah;
    }
    
    public String getNamaMatakuliah() {
        return namaMatakuliah;
    }
    
    public void setNamaMatakuliah(String namaMatakuliah) {
        this.namaMatakuliah = namaMatakuliah;
    }
    
    public int getSks() {
        return sks;
    }
    
    public void setSks(int sks) {
        this.sks = sks;
    }
    
    public int getSemester() {
        return semester;
    }
    
    public void setSemester(int semester) {
        this.semester = semester;
    }
    
    public String getJenis() {
        return jenis;
    }
    
    public void setJenis(String jenis) {
        this.jenis = jenis;
    }
    
    public String getDeskripsi() {
        return deskripsi;
    }
    
    public void setDeskripsi(String deskripsi) {
        this.deskripsi = deskripsi;
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
    
    public String getNamaDosen() {
        return namaDosen;
    }
    
    public void setNamaDosen(String namaDosen) {
        this.namaDosen = namaDosen;
    }
}
