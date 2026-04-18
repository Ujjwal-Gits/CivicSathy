package com.civicpulse.admin.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Admin complaint management — paginated table view.
 * GET /admin/complaints?page=1&status=PENDING&category=Road
 */
@WebServlet("/admin/complaints")
public class ManageComplaintsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Read page, status filter, category filter from params
        // TODO: Fetch paginated complaints via AdminComplaintService
        // TODO: Forward to admin/complaints.jsp
        request.getRequestDispatcher("/admin/complaints.jsp").forward(request, response);
    }
}
