package com.civicpulse.citizen.dao;

import com.civicpulse.shared.exception.DatabaseException;
import com.civicpulse.shared.model.User;

/**
 * Data Access Object for citizen user operations.
 * Registration, login lookup, profile updates.
 */
public class CitizenDAO {

    public int insert(User user) throws DatabaseException {
        String sql = "INSERT INTO users (full_name, email, phone, password_hash, ward, role) VALUES (?, ?, ?, ?, ?, 'CITIZEN')";
        // TODO: Implement
        return 0;
    }

    public User findByEmail(String email) throws DatabaseException {
        String sql = "SELECT * FROM users WHERE email = ? AND role = 'CITIZEN'";
        // TODO: Implement
        return null;
    }

    public User findById(int id) throws DatabaseException {
        String sql = "SELECT * FROM users WHERE id = ?";
        // TODO: Implement
        return null;
    }

    public void update(User user) throws DatabaseException {
        String sql = "UPDATE users SET full_name = ?, phone = ?, ward = ?, avatar_url = ? WHERE id = ?";
        // TODO: Implement
    }

    public boolean emailExists(String email) throws DatabaseException {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        // TODO: Implement
        return false;
    }
}
