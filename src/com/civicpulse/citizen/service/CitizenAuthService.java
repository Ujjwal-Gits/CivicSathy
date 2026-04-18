package com.civicpulse.citizen.service;

import com.civicpulse.citizen.dao.CitizenDAO;
import com.civicpulse.citizen.dto.CitizenRegisterDTO;
import com.civicpulse.shared.exception.ServiceException;
import com.civicpulse.shared.exception.ValidationException;
import com.civicpulse.shared.model.User;
import com.civicpulse.shared.util.PasswordUtil;
import com.civicpulse.shared.util.ValidationUtil;

/**
 * Authentication service for citizen users.
 * Handles login verification and registration.
 */
public class CitizenAuthService {

    private final CitizenDAO citizenDAO = new CitizenDAO();

    /**
     * Authenticate a citizen by email and password.
     * Returns the User on success, throws ServiceException on failure.
     */
    public User authenticate(String email, String password) throws ServiceException {
        if (ValidationUtil.isNullOrEmpty(email) || ValidationUtil.isNullOrEmpty(password)) {
            throw new ServiceException("Email and password are required");
        }

        // TODO: Call citizenDAO.findByEmail(email)
        // TODO: Verify password with PasswordUtil.verifyPassword()
        // TODO: Return user or throw ServiceException
        return null;
    }

    /**
     * Register a new citizen account.
     */
    public User register(CitizenRegisterDTO dto) throws ServiceException, ValidationException {
        // TODO: Validate all fields
        // TODO: Check if email already exists → citizenDAO.findByEmail(dto.getEmail())
        // TODO: Hash password with PasswordUtil.hashPassword()
        // TODO: Call citizenDAO.insert(user)
        // TODO: Return created user
        return null;
    }
}
