package com.universitas.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Konfigurasi koneksi database PostgreSQL
 */
public class DatabaseConfig {

    // Konfigurasi database
    private static final String URL = "jdbc:postgresql://localhost:5432/manajemen_mahasiswa";
    private static final String USERNAME = "postgres";
    private static final String PASSWORD = "bismillah";

    // Driver PostgreSQL
    private static final String DRIVER = "org.postgresql.Driver";

    // Static block untuk load driver saat class di-load
    static {
        try {
            Class.forName(DRIVER);
            System.out.println("PostgreSQL Driver loaded successfully!");
        } catch (ClassNotFoundException e) {
            System.err.println("FATAL: PostgreSQL Driver not found!");
            e.printStackTrace();
            throw new RuntimeException("PostgreSQL Driver not found", e);
        }
    }

    /**
     * Mendapatkan koneksi ke database
     *
     * @return Connection object atau null jika gagal
     */
    public static Connection getConnection() {
        Connection connection = null;

        try {
            // Membuat koneksi
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("Koneksi database berhasil!");

        } catch (SQLException e) {
            System.err.println("Gagal membuat koneksi database: " + e.getMessage());
            e.printStackTrace();
        }

        return connection;
    }

    /**
     * Menutup koneksi database
     *
     * @param connection Connection yang akan ditutup
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Koneksi database ditutup.");
            } catch (SQLException e) {
                System.err.println("Error saat menutup koneksi: " + e.getMessage());
            }
        }
    }

    /**
     * Test koneksi database
     *
     * @return true jika koneksi berhasil
     */
    public static boolean testConnection() {
        Connection connection = getConnection();
        if (connection != null) {
            closeConnection(connection);
            return true;
        }
        return false;
    }

    public static void main(String[] args) {
        System.out.println("Memulai pengetesan koneksi...");

        // Memanggil method testConnection yang sudah kamu buat
        boolean isConnected = testConnection();

        if (isConnected) {
            System.out.println("STATUS: Pengetesan Berhasil!");
        } else {
            System.out.println("STATUS: Pengetesan Gagal!");
        }
    }
}
