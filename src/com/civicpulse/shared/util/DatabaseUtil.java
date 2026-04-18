package com.civicpulse.shared.util;

import com.civicpulse.shared.config.DatabaseConfig;
import java.sql.*;

/** Database utility — JDBC connections and resource cleanup. */
public class DatabaseUtil {
    static {
        try { Class.forName(DatabaseConfig.DRIVER_CLASS); }
        catch (ClassNotFoundException e) { throw new RuntimeException("Failed to load MySQL JDBC driver", e); }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DatabaseConfig.DB_URL, DatabaseConfig.DB_USER, DatabaseConfig.DB_PASSWORD);
    }

    public static void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }

    public static void closeResources(Connection conn, PreparedStatement ps) {
        closeResources(conn, ps, null);
    }
}
