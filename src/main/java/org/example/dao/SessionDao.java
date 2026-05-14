package org.example.dao;

import org.example.model.Session;
import org.example.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class SessionDao
{
    public List<Session> findAll() throws SQLException
    {
        List<Session> list = new ArrayList<>();
        String sql = """
                SELECT s.id, s.cinema_id, s.movie_name, s.session_date,
                       s.session_time, s.hall_number, c.name AS cinema_name
                FROM sessions s
                JOIN cinemas  c ON c.id = s.cinema_id
                ORDER BY s.session_date, s.session_time
                """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery())
        {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }
    public Optional<Session> findById(int id) throws SQLException
    {
        String sql = """
                SELECT s.id, s.cinema_id, s.movie_name, s.session_date,
                       s.session_time, s.hall_number, c.name AS cinema_name
                FROM sessions s
                JOIN cinemas  c ON c.id = s.cinema_id
                WHERE s.id = ?
                """;
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
    private Session map(ResultSet rs) throws SQLException
    {
        Session s = new Session(
                rs.getInt("id"),
                rs.getInt("cinema_id"),
                rs.getString("movie_name"),
                rs.getDate("session_date").toLocalDate(),
                rs.getTime("session_time").toLocalTime(),
                rs.getInt("hall_number")
        );
        s.setCinemaName(rs.getString("cinema_name"));
        return s;
    }
}