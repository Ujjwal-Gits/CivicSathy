package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/dashboard-stats")
public class AdminDashboardServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;

    @Override
    public void init() {
        complaintDAO = new ComplaintDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Fetch stats from DAO
        Map<String, Integer> stats = complaintDAO.getStats();
        
        // Pass stats to the JSP page
        request.setAttribute("pendingCount", stats.getOrDefault("Pending", 0));
        request.setAttribute("inProgressCount", stats.getOrDefault("In Progress", 0));
        request.setAttribute("resolvedCount", stats.getOrDefault("Resolved", 0));
        request.setAttribute("escalatedCount", stats.getOrDefault("Escalated", 0));

        // Get Recent Tickets
        // List<Complaint> recentTickets = complaintDAO.getRecentComplaints(5);
        // request.setAttribute("recentTickets", recentTickets);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
