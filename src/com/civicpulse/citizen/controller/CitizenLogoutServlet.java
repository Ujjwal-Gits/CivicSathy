package com.civicpulse.citizen.controller;

import com.civicpulse.shared.util.SessionUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Citizen logout — invalidates session and redirects to login.
 * GET /citizen/logout
 */
@WebServlet("/citizen/logout")
public class CitizenLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SessionUtil.logout(request);
        response.sendRedirect(request.getContextPath() + "/citizen/login");
    }
}
