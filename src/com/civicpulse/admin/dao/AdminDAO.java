package com.civicpulse.admin.dao;

import com.civicpulse.shared.exception.DatabaseException;
import com.civicpulse.shared.model.User;

/**
 * Admin user DAO — login lookup.
 */
public class AdminDAO {

    public User findByEmail(String email) throws DatabaseException {
        String sql = "SELECT * FROM users WHERE email = ? AND role = 'ADMIN'";
        // TODO: Implement
        return null;
    }
}
