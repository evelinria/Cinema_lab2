package org.example.dao;

import org.example.model.Cinema;
import org.example.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CinemaDao
{
    public List<Cinema> findAll() throws SQLException
    {
        List<Cinema> list = new ArrayList<>();
        String sql = "SELECT id, name, address, halls FROM cinemas ORDER BY name";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery())
        {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }
    public Optional<Cinema> findById(int id) throws SQLException
    {
        String sql = "SELECT id, name, address, halls FROM cinemas WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql))
        {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery())
            {
                if (rs.next()) return Optional.of(map(rs));
            }
        }
        return Optional.empty();
    }
    private Cinema map(ResultSet rs) throws SQLException
    {
        return new Cinema(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("address"),
                rs.getInt("halls")
        );
    }
}
