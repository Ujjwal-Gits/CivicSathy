package com.civicsathy.config;

/**
 * Utility class providing helper methods for DatabaseConfig.
 * 
 * @author Ujjwal
 * @version 1.0
 */
public class DatabaseConfig {
    public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    public static final String DB_NAME = "civicsathy";
    
    /**
     * Gets the standard JDBC connection URL.
     * @return The connection string.
     */
    public static String getConnectionUrl() {
        return "jdbc:mysql://localhost:3306/" + DB_NAME;
    }
}


