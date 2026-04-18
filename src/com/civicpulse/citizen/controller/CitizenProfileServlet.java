package com.civicpulse.citizen.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Citizen profile view and edit.
 * GET  /citizen/profile → display profile
 * POST /citizen/profile → update profile
 */
@WebServlet("/citizen/profile")
public class CitizenProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/citizen/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Update profile fields
        response.sendRedirect(request.getContextPath() + "/citizen/profile");
    }
}
