package com.civicpulse.admin.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Admin dashboard — overview stats and recent complaints.
 * GET /admin/dashboard
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Fetch DashboardStatsDTO via AdminComplaintService
        // TODO: Fetch recent complaints
        // TODO: Set attributes and forward to admin/index.jsp
        request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
    }
}
