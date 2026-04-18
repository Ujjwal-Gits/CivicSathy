package com.civicpulse.admin.controller;

import com.civicpulse.shared.util.SessionUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Admin logout — invalidates session and redirects to admin login.
 * GET /admin/logout
 */
@WebServlet("/admin/logout")
public class AdminLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SessionUtil.logout(request);
        response.sendRedirect(request.getContextPath() + "/admin/login");
    }
}
