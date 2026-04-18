package com.civicpulse.admin.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Admin user management — list and manage citizen accounts.
 * GET /admin/users
 */
@WebServlet("/admin/users")
public class ManageUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Fetch paginated user list via AdminUserService
        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }
}
