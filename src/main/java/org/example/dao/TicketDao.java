package org.example.dao;

import org.example.model.Ticket;
import org.example.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class TicketDao
{
    public List<Ticket> findAll() throws SQLException
    {
        List<Ticket> list = new ArrayList<>();
        String sql = """
                SELECT t.id, t.session_id, t.row_number, t.seat_number,
                       t.price, t.is_sold, t.owner_name,
                       s.movie_name, s.session_date::text, s.session_time::text,
                       c.name AS cinema_name
                FROM   tickets  t
                JOIN   sessions s ON s.id = t.session_id
                JOIN   cinemas  c ON c.id = s.cinema_id
                ORDER  BY t.id
                """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery())
        {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public List<Ticket> findBySession(int sessionId) throws SQLException
    {
        List<Ticket> list = new ArrayList<>();
        String sql = """
                SELECT t.id, t.session_id, t.row_number, t.seat_number,
                       t.price, t.is_sold, t.owner_name,
                       s.movie_name, s.session_date::text, s.session_time::text,
                       c.name AS cinema_name
                FROM   tickets  t
                JOIN   sessions s ON s.id = t.session_id
                JOIN   cinemas  c ON c.id = s.cinema_id
                WHERE  t.session_id = ?
                ORDER  BY t.row_number, t.seat_number
                """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql))
        {
            ps.setInt(1, sessionId);
            try (ResultSet rs = ps.executeQuery())
            {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    public Optional<Ticket> findById(int id) throws SQLException
    {
        String sql = """
                SELECT t.id, t.session_id, t.row_number, t.seat_number,
                       t.price, t.is_sold, t.owner_name,
                       s.movie_name, s.session_date::text, s.session_time::text,
                       c.name AS cinema_name
                FROM   tickets  t
                JOIN   sessions s ON s.id = t.session_id
                JOIN   cinemas  c ON c.id = s.cinema_id
                WHERE  t.id = ?
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

    public Ticket create(Ticket t) throws SQLException
    {
        String sql = """
                INSERT INTO tickets (session_id, row_number, seat_number, price, is_sold, owner_name)
                VALUES (?, ?, ?, ?, ?, ?)
                RETURNING id
                """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql))
        {
            ps.setInt(1, t.getSessionId());
            ps.setInt(2, t.getRowNumber());
            ps.setInt(3, t.getSeatNumber());
            ps.setDouble(4, t.getPrice());
            ps.setBoolean(5, t.isSold());
            ps.setString(6, t.getOwnerName());
            try (ResultSet rs = ps.executeQuery())
            {
                if (rs.next()) t.setId(rs.getInt(1));
            }
        }
        return t;
    }

    public boolean update(Ticket t) throws SQLException
    {
        String sql = """
                UPDATE tickets
                SET session_id  = ?,
                    row_number  = ?,
                    seat_number = ?,
                    price       = ?,
                    is_sold     = ?,
                    owner_name  = ?
                WHERE id = ?
                """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql))
        {
            ps.setInt(1, t.getSessionId());
            ps.setInt(2, t.getRowNumber());
            ps.setInt(3, t.getSeatNumber());
            ps.setDouble(4, t.getPrice());
            ps.setBoolean(5, t.isSold());
            ps.setString(6, t.getOwnerName());
            ps.setInt(7, t.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException
    {
        String sql = "DELETE FROM tickets WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql))
        {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Ticket map(ResultSet rs) throws SQLException
    {
        Ticket t = new Ticket();
        t.setId(rs.getInt("id"));
        t.setSessionId(rs.getInt("session_id"));
        t.setRowNumber(rs.getInt("row_number"));
        t.setSeatNumber(rs.getInt("seat_number"));
        t.setPrice(rs.getDouble("price"));
        t.setSold(rs.getBoolean("is_sold"));
        t.setOwnerName(rs.getString("owner_name"));
        t.setMovieName(rs.getString("movie_name"));
        t.setSessionDate(rs.getString("session_date"));
        t.setSessionTime(rs.getString("session_time"));
        t.setCinemaName(rs.getString("cinema_name"));
        return t;
    }
}