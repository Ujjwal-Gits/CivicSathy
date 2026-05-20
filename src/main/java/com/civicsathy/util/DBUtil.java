package com.civicsathy.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class providing helper methods for DBUtil.
 * 
 * @author Ujjwal
 * @version 1.0
 */
public class DBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/civicsathy";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    /**
     * Retrieves the Connection.
     *
     * @return The resulting Connection.
     * @throws SQLException if an exception occurs.
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL Driver not found! Please add the mysql-connector jar to WEB-INF/lib", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
