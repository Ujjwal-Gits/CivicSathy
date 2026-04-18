package com.civicpulse.shared.config;

/** Database connection config for XAMPP MySQL. */
public final class DatabaseConfig {
    private DatabaseConfig() {}

    public static final String DRIVER_CLASS = "com.mysql.cj.jdbc.Driver";
    public static final String DB_URL = "jdbc:mysql://localhost:3306/civicpulse";
    public static final String DB_USER = "root";
    public static final String DB_PASSWORD = "";
}
