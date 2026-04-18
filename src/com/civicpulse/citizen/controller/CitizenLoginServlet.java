package com.civicpulse.citizen.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Citizen login handler.
 * GET  /citizen/login → show login form
 * POST /citizen/login → authenticate citizen
 */
@WebServlet("/citizen/login")
public class CitizenLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/citizen/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Read CitizenLoginDTO from request
        // TODO: Call CitizenAuthService.authenticate(email, password)
        // TODO: On success → SessionUtil.setLoggedInUser() → redirect to dashboard
        // TODO: On failure → set error message → forward back to login.jsp
        response.sendRedirect(request.getContextPath() + "/citizen/dashboard");
    }
}
