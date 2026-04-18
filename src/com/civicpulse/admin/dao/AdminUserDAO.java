package com.civicpulse.admin.dao;

import com.civicpulse.shared.exception.DatabaseException;
import com.civicpulse.shared.model.User;

import java.util.ArrayList;
import java.util.List;

/**
 * Admin user management DAO.
 * Fetches citizen users, search, activate/deactivate.
 */
public class AdminUserDAO {

    public List<User> findAllCitizens(int offset, int limit, String search) throws DatabaseException {
        // TODO: SELECT users WHERE role='CITIZEN' with optional name/email search
        return new ArrayList<>();
    }

    public int getCitizenCount(String search) throws DatabaseException {
        return 0;
    }

    public void setActive(int userId, boolean active) throws DatabaseException {
        String sql = "UPDATE users SET is_active = ? WHERE id = ?";
        // TODO: Implement
    }
}
