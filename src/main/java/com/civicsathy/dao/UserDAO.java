package com.civicsathy.dao;

import com.civicsathy.model.User;
import com.civicsathy.util.DBUtil;

import java.sql.*;

/**
 * UserDAO handles all database operations related to User entity.
 *
 * <p>This DAO provides functionality for:
 * <ul>
 *     <li>User registration</li>
 *     <li>User authentication (login)</li>
 *     <li>Fetching user details by ID</li>
 *     <li>Updating user profile information</li>
 *     <li>Updating user password</li>
 * </ul>
 *
 * It uses JDBC with DBUtil for database connection management.
 *
 * @author Aastha
 * @version 1.0
 */
public class UserDAO {

    /**
     * Registers a new citizen user into the database.
     *
     * @param user User object containing registration details
     * @return true if user is successfully registered, false otherwise
     */
    public boolean registerCitizen(User user) {
        String sql = "INSERT INTO users (full_name, email, password_hash, phone, ward, location, role) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getContactNo());
            stmt.setInt(5, Integer.parseInt(user.getWardNo()));
            stmt.setString(6, user.getLocation());
            stmt.setString(7, "CITIZEN");

            return stmt.executeUpdate() > 0;
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Authenticates a user using email and password.
     *
     * @param email user's email address
     * @param password hashed password
     * @return User object if authentication is successful, otherwise null
     */
    public User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password_hash = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Retrieves user details from database using user ID.
     *
     * @param id unique user ID
     * @return User object if found, otherwise null
     */
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Updates user profile information in the database.
     *
     * @param user User object containing updated profile data
     * @return true if update is successful, false otherwise
     */
    public boolean updateProfile(User user) {
        String sql = "UPDATE users SET full_name = ?, phone = ?, ward = ?, location = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getContactNo());
            stmt.setInt(3, Integer.parseInt(user.getWardNo()));
            stmt.setString(4, user.getLocation());
            stmt.setInt(5, user.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates password for a specific user.
     *
     * @param userId user ID
     * @param newPasswordHash hashed password
     * @return true if password update is successful, false otherwise
     */
    public boolean updatePassword(int userId, String newPasswordHash) {
        String sql = "UPDATE users SET password_hash = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPasswordHash);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * helper to map a result set row to a User object
     *
     * @param rs ResultSet containing user data
     * @return mapped User object
     * @throws SQLException if database access error occurs
     */
    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setContactNo(rs.getString("phone"));
        user.setWardNo(String.valueOf(rs.getInt("ward")));
        user.setLocation(rs.getString("location"));
        user.setRole(rs.getString("role"));
        return user;
    }
}
