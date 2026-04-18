package com.civicpulse.admin.service;

import com.civicpulse.admin.dao.AdminDAO;
import com.civicpulse.shared.exception.ServiceException;
import com.civicpulse.shared.model.User;
import com.civicpulse.shared.util.PasswordUtil;
import com.civicpulse.shared.util.ValidationUtil;

/**
 * Admin authentication service.
 */
public class AdminAuthService {

    private final AdminDAO adminDAO = new AdminDAO();

    public User authenticate(String email, String password) throws ServiceException {
        if (ValidationUtil.isNullOrEmpty(email) || ValidationUtil.isNullOrEmpty(password)) {
            throw new ServiceException("Email and password are required");
        }
        // TODO: Call adminDAO.findByEmail(email)
        // TODO: Verify password, check role == ADMIN
        // TODO: Return user or throw exception
        return null;
    }
}
