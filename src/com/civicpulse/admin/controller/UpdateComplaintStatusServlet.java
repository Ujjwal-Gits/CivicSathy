package com.civicpulse.admin.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Update complaint status via AJAX.
 * POST /admin/complaint/status
 * Expects: complaintId, newStatus, remarks
 * Returns: JSON response
 */
@WebServlet("/admin/complaint/status")
public class UpdateComplaintStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Read StatusUpdateDTO from request
        // TODO: Call AdminComplaintService.updateStatus(dto, adminUserId)
        // TODO: Return JSON success/error
        response.setContentType("application/json");
        response.getWriter().write("{\"success\": true}");
    }
}
