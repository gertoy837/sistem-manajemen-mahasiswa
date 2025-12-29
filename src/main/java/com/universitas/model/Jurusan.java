package com.universitas.model;

import java.time.LocalDateTime;

/**
 * Model untuk tabel Jurusan
 */
public class Jurusan {
    private int idJurusan;
    private int idFakultas;
    private String namaJurusan;
    private String ketuaJurusan;
    private char akreditasi;
    private LocalDateTime createdAt;
    
    // Relational field
    private String namaFakultas;
    
    // Default constructor
    public Jurusan() {}
    
    // Constructor dengan parameter utama
    public Jurusan(String namaJurusan, int idFakultas, String ketuaJurusan, char akreditasi) {
        this.namaJurusan = namaJurusan;
        this.idFakultas = idFakultas;
        this.ketuaJurusan = ketuaJurusan;
        this.akreditasi = akreditasi;
    }
    
    // Getters and Setters
    public int getIdJurusan() { return idJurusan; }
    public void setIdJurusan(int idJurusan) { this.idJurusan = idJurusan; }
    
    public int getIdFakultas() { return idFakultas; }
    public void setIdFakultas(int idFakultas) { this.idFakultas = idFakultas; }
    
    public String getNamaJurusan() { return namaJurusan; }
    public void setNamaJurusan(String namaJurusan) { this.namaJurusan = namaJurusan; }
    
    public String getKetuaJurusan() { return ketuaJurusan; }
    public void setKetuaJurusan(String ketuaJurusan) { this.ketuaJurusan = ketuaJurusan; }
    
    public char getAkreditasi() { return akreditasi; }
    public void setAkreditasi(char akreditasi) { this.akreditasi = akreditasi; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public String getNamaFakultas() { return namaFakultas; }
    public void setNamaFakultas(String namaFakultas) { this.namaFakultas = namaFakultas; }
    
    @Override
    public String toString() {
        return "Jurusan{" +
                "id=" + idJurusan +
                ", nama='" + namaJurusan + '\'' +
                ", ketua='" + ketuaJurusan + '\'' +
                ", akreditasi=" + akreditasi +
                ", fakultas='" + namaFakultas + '\'' +
                '}';
    }
}