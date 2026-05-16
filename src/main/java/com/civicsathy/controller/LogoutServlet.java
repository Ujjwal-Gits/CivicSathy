package com.civicsathy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * LogoutServlet handles user logout functionality.
 *
 * <p>This servlet:
 * <ul>
 *     <li>Invalidates the current user session</li>
 *     <li>Removes session data</li>
 *     <li>Redirects the user to the login page</li>
 * </ul>
 *
 * URL Pattern: /logout
 *
 * @author Aastha
 * @version 1.0
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    /**
     * Handles HTTP GET requests for user logout.
     *
     * <p>This method invalidates the existing session
     * and redirects the user to the login page.
     *
     * @param request HttpServletRequest object containing client request
     * @param response HttpServletResponse object used to send response
     * @throws ServletException if servlet-related error occurs
     * @throws IOException if input/output error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/citizen/login.jsp");
    }
}
