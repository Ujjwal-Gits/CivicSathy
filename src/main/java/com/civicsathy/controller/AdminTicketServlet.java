package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/update-ticket")
public class AdminTicketServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;

    @Override
    public void init() {
        complaintDAO = new ComplaintDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ticketIdStr = request.getParameter("ticketId");
        String newStatus = request.getParameter("status");
        String adminComment = request.getParameter("comment");

        if (ticketIdStr != null && newStatus != null) {
            try {
                int ticketId = Integer.parseInt(ticketIdStr);
                
                // Update status in Database
                boolean success = complaintDAO.updateStatus(ticketId, newStatus);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin/ticket.jsp?id=" + ticketId + "&success=Status Updated");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/ticket.jsp?id=" + ticketId + "&error=Failed to update");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/complaints.jsp?error=Invalid Ticket ID");
            }
        }
    }
}
