package com.universitas.model;

import java.time.LocalDateTime;

/**
 * Model untuk tabel Jurusan
 */
public class Jurusan {
    private int idJurusan;
    private int idFakultas;
    private String kodeJurusan;
    private String namaJurusan;
    private String jenjang;
    private String akreditasi;
    private String ketuaJurusan;
    private LocalDateTime createdAt;
    
    // Relational field
    private String namaFakultas;
    
    // Default constructor
    public Jurusan() {}
    
    // Constructor dengan parameter utama
    public Jurusan(String kodeJurusan, String namaJurusan, int idFakultas, String jenjang, String akreditasi) {
        this.kodeJurusan = kodeJurusan;
        this.namaJurusan = namaJurusan;
        this.idFakultas = idFakultas;
        this.jenjang = jenjang;
        this.akreditasi = akreditasi;
    }
    
    // Getters and Setters
    public int getIdJurusan() { return idJurusan; }
    public void setIdJurusan(int idJurusan) { this.idJurusan = idJurusan; }
    
    public int getIdFakultas() { return idFakultas; }
    public void setIdFakultas(int idFakultas) { this.idFakultas = idFakultas; }
    
    public String getKodeJurusan() { return kodeJurusan; }
    public void setKodeJurusan(String kodeJurusan) { this.kodeJurusan = kodeJurusan; }
    
    public String getNamaJurusan() { return namaJurusan; }
    public void setNamaJurusan(String namaJurusan) { this.namaJurusan = namaJurusan; }
    
    public String getJenjang() { return jenjang; }
    public void setJenjang(String jenjang) { this.jenjang = jenjang; }
    
    public String getAkreditasi() { return akreditasi; }
    public void setAkreditasi(String akreditasi) { this.akreditasi = akreditasi; }
    
    public String getKetuaJurusan() { return ketuaJurusan; }
    public void setKetuaJurusan(String ketuaJurusan) { this.ketuaJurusan = ketuaJurusan; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public String getNamaFakultas() { return namaFakultas; }
    public void setNamaFakultas(String namaFakultas) { this.namaFakultas = namaFakultas; }
    
    @Override
    public String toString() {
        return "Jurusan{" +
                "id=" + idJurusan +
                ", kode='" + kodeJurusan + '\'' +
                ", nama='" + namaJurusan + '\'' +
                ", jenjang='" + jenjang + '\'' +
                ", akreditasi='" + akreditasi + '\'' +
                ", fakultas='" + namaFakultas + '\'' +
                '}';
    }
}