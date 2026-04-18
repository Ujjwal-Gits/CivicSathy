package com.civicpulse.admin.service;

import com.civicpulse.admin.dao.AdminUserDAO;
import com.civicpulse.admin.dto.UserListDTO;
import com.civicpulse.shared.exception.ServiceException;

import java.util.List;

/**
 * Admin user management service.
 * List citizens, view history, ban/unban.
 */
public class AdminUserService {

    private final AdminUserDAO adminUserDAO = new AdminUserDAO();

    public List<UserListDTO> getAllUsers(int page, String search) {
        // TODO: Fetch paginated, searchable user list
        return null;
    }

    public void toggleUserActive(int userId, boolean active) throws ServiceException {
        // TODO: Activate or deactivate a citizen account
    }

    public int getTotalUserCount(String search) {
        // TODO: Count users with optional search filter
        return 0;
    }
}
