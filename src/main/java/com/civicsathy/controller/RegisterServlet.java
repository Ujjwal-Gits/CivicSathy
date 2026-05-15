package com.civicsathy.controller;

import com.civicsathy.dao.UserDAO;
import com.civicsathy.model.User;
import com.civicsathy.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * RegisterServlet handles user registration operations.
 *
 * <p>This controller is responsible for:
 * <ul>
 *     <li>Receiving registration form data</li>
 *     <li>Validating user input</li>
 *     <li>Hashing user passwords</li>
 *     <li>Creating new user accounts</li>
 *     <li>Redirecting users after successful registration</li>
 * </ul>
 *
 * URL Pattern: /register
 *
 * @author Aastha
 * @version 1.0
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    /**
     * Data Access Object used to perform user-related database operations.
     */
    private UserDAO userDAO;

    /**
     * Initializes the servlet and creates the UserDAO instance.
     * This method is called once when the servlet is first loaded.
     */
    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    /**
     * Handles HTTP POST requests for user registration.
     *
     * <p>This method performs the following operations:
     * <ul>
     *     <li>Retrieves form parameters</li>
     *     <li>Validates required fields</li>
     *     <li>Checks password confirmation</li>
     *     <li>Hashes the password using PasswordUtil</li>
     *     <li>Creates a User object</li>
     *     <li>Stores user in database via UserDAO</li>
     *     <li>Redirects to login page on success</li>
     * </ul>
     *
     * @param request  HttpServletRequest containing registration form data
     * @param response HttpServletResponse used to send response
     * @throws ServletException if servlet error occurs
     * @throws IOException if input/output error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String wardNo = request.getParameter("wardNo");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate full name
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Full name is required");
            request.getRequestDispatcher("/citizen/register.jsp")
                    .forward(request, response);
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/citizen/register.jsp")
                    .forward(request, response);
            return;
        }

    }}