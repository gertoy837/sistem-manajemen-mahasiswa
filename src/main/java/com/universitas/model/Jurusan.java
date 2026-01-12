package com.universitas.model;

/**
 * Model untuk tabel Jurusan
 */
public class Jurusan {
    private int idJurusan;
    private int idFakultas;
    private String namaJurusan;
    private String ketuaJurusan;
    private String akreditasi;
    
    // Untuk join dengan fakultas
    private String namaFakultas;
    
    // Constructors
    public Jurusan() {}
    
    public Jurusan(int idJurusan, String namaJurusan) {
        this.idJurusan = idJurusan;
        this.namaJurusan = namaJurusan;
    }
    
    // Getters and Setters
    public int getIdJurusan() {
        return idJurusan;
    }
    
    public void setIdJurusan(int idJurusan) {
        this.idJurusan = idJurusan;
    }
    
    public int getIdFakultas() {
        return idFakultas;
    }
    
    public void setIdFakultas(int idFakultas) {
        this.idFakultas = idFakultas;
    }
    
    public String getNamaJurusan() {
        return namaJurusan;
    }
    
    public void setNamaJurusan(String namaJurusan) {
        this.namaJurusan = namaJurusan;
    }
    
    public String getKetuaJurusan() {
        return ketuaJurusan;
    }
    
    public void setKetuaJurusan(String ketuaJurusan) {
        this.ketuaJurusan = ketuaJurusan;
    }
    
    public String getAkreditasi() {
        return akreditasi;
    }
    
    public void setAkreditasi(String akreditasi) {
        this.akreditasi = akreditasi;
    }
    
    public String getNamaFakultas() {
        return namaFakultas;
    }
    
    public void setNamaFakultas(String namaFakultas) {
        this.namaFakultas = namaFakultas;
    }
    
    // Backward compatibility methods (jika ada kode lama yang menggunakan ini)
    public String getKodeJurusan() {
        return String.valueOf(idJurusan);
    }
    
    public void setKodeJurusan(String kodeJurusan) {
        // Do nothing - for backward compatibility
    }
    
    public String getJenjang() {
        return "S1"; // Default value
    }
    
    public void setJenjang(String jenjang) {
        // Do nothing - for backward compatibility
    }
    
    @Override
    public String toString() {
        return "Jurusan{" +
                "id=" + idJurusan +
                ", nama='" + namaJurusan + '\'' +
                ", ketua='" + ketuaJurusan + '\'' +
                ", akreditasi='" + akreditasi + '\'' +
                ", fakultas='" + namaFakultas + '\'' +
                '}';
    }
}