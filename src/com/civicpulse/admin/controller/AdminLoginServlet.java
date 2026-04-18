package com.civicpulse.admin.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Admin login handler.
 * GET  /admin/login → show login form
 * POST /admin/login → authenticate admin
 */
@WebServlet("/admin/login")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Authenticate via AdminAuthService
        // TODO: On success → redirect to /admin/dashboard
        // TODO: On failure → set error → forward to login.jsp
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
