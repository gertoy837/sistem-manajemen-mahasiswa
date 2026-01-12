package com.universitas.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.universitas.config.DatabaseConfig;
import com.universitas.model.Fakultas;

public class FakultasDAO {
    
    public List<Fakultas> getAllFakultas() {
        List<Fakultas> listFakultas = new ArrayList<>();
        String sql = "SELECT * FROM fakultas ORDER BY nama_fakultas";
        
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Fakultas fakultas = new Fakultas();
                fakultas.setIdFakultas(rs.getInt("id_fakultas"));
                fakultas.setNamaFakultas(rs.getString("nama_fakultas"));
                fakultas.setDekan(rs.getString("dekan"));
                listFakultas.add(fakultas);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getAllFakultas: " + e.getMessage());
            e.printStackTrace();
        }
        
        return listFakultas;
    }
}
