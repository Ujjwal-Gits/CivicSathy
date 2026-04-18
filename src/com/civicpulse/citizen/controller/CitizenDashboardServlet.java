package com.civicpulse.citizen.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Citizen Dashboard — loads the public complaint feed.
 * GET /citizen/dashboard
 */
@WebServlet("/citizen/dashboard")
public class CitizenDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Fetch complaint list via ComplaintService
        // TODO: Set complaints as request attribute
        request.getRequestDispatcher("/citizen/dashboard.jsp").forward(request, response);
    }
}
