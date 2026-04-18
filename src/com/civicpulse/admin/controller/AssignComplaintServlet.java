package com.civicpulse.admin.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Assign a complaint to an admin/officer.
 * POST /admin/complaint/assign
 */
@WebServlet("/admin/complaint/assign")
public class AssignComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Read complaintId and assignToUserId
        // TODO: Call AdminComplaintService.assignComplaint()
        response.setContentType("application/json");
        response.getWriter().write("{\"success\": true}");
    }
}
