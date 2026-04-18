package com.civicpulse.citizen.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Citizen registration handler.
 * GET  /citizen/register → show registration form
 * POST /citizen/register → create new citizen account
 */
@WebServlet("/citizen/register")
public class CitizenRegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/citizen/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Read CitizenRegisterDTO from request
        // TODO: Call CitizenAuthService.register(dto)
        // TODO: On success → redirect to login with success message
        // TODO: On failure → set errors → forward back to register.jsp
        response.sendRedirect(request.getContextPath() + "/citizen/login");
    }
}
