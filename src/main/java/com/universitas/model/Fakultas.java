package com.universitas.model;

/**
 * Model untuk tabel Fakultas
 */
public class Fakultas {
    private int idFakultas;
    private String kodeFakultas;
    private String namaFakultas;
    private String dekan;
    
    // Default constructor
    public Fakultas() {}
    
    // Constructor dengan parameter
    public Fakultas(String kodeFakultas, String namaFakultas) {
        this.kodeFakultas = kodeFakultas;
        this.namaFakultas = namaFakultas;
    }
    
    // Getters and Setters
    public int getIdFakultas() { return idFakultas; }
    public void setIdFakultas(int idFakultas) { this.idFakultas = idFakultas; }
    
    public String getKodeFakultas() { return kodeFakultas; }
    public void setKodeFakultas(String kodeFakultas) { this.kodeFakultas = kodeFakultas; }
    
    public String getNamaFakultas() { return namaFakultas; }
    public void setNamaFakultas(String namaFakultas) { this.namaFakultas = namaFakultas; }
    
    public String getDekan() { return dekan; }
    public void setDekan(String dekan) { this.dekan = dekan; }
    
    @Override
    public String toString() {
        return "Fakultas{" +
                "id=" + idFakultas +
                ", kode='" + kodeFakultas + '\'' +
                ", nama='" + namaFakultas + '\'' +
                '}';
    }
}
