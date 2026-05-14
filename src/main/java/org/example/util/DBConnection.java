package org.example.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection
{
    private static final String URL = "jdbc:postgresql://localhost:5432/cinema_db";
    private static final String USER = "postgres";
    private static final String PASSWORD = "postgres";
    static
    {
        try
        {
            Class.forName("org.postgresql.Driver");
        }
        catch (ClassNotFoundException e)
        {
            throw new ExceptionInInitializerError("PostgreSQL driver not found: " + e.getMessage());
        }
    }
    private DBconnection() {}
    public static Connection getConnection() throws SQLException
    {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
