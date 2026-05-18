package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet controller handling HTTP requests and responses for AddAffectedServlet operations.
 * 
 * @author Riwaz
 * @version 1.0
 */
@WebServlet("/add-affected")
public class AddAffectedServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        complaintDAO = new ComplaintDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/citizen/login.jsp?error=You must be logged in to mark yourself as affected.");
            return;
        }

        String complaintIdStr = request.getParameter("complaintId");
        if (complaintIdStr != null && !complaintIdStr.isEmpty()) {
            try {
                int complaintId = Integer.parseInt(complaintIdStr);
                String result = complaintDAO.toggleAffectedVote(complaintId, user.getId());
                
                // If it's an AJAX request, return the action taken
                if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With")) || request.getParameter("ajax") != null) {
                    response.getWriter().write(result);
                    return;
                }
                
                response.sendRedirect(request.getContextPath() + "/feed#complaint-" + complaintId);
                return;
            } catch (NumberFormatException e) {
                // Ignore invalid IDs
            }
        }

        response.sendRedirect(request.getContextPath() + "/feed");
    }
}
