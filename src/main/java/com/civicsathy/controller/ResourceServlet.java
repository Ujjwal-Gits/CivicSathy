package com.civicsathy.controller;

import com.civicsathy.dao.InventoryDAO;
import com.civicsathy.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet controller handling HTTP requests and responses for ResourceServlet operations.
 * 
 * @author Riwaz
 * @version 1.0
 */
@WebServlet("/admin/resource")
public class ResourceServlet extends HttpServlet {
    private InventoryDAO inventoryDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        inventoryDAO = new InventoryDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User admin = (User) request.getSession().getAttribute("loggedInUser");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/citizen/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("addVehicle".equals(action)) {
                String name = request.getParameter("name");
                int count = Integer.parseInt(request.getParameter("count"));
                inventoryDAO.addVehicle(name, count);
            } else if ("updateVehicle".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                int count = Integer.parseInt(request.getParameter("count"));
                inventoryDAO.updateVehicle(id, count);
            } else if ("addTeam".equals(action)) {
                String name = request.getParameter("name");
                String type = request.getParameter("type"); // e.g. Roads, Sanitation
                if (type == null || type.isEmpty()) type = "General";
                int count = Integer.parseInt(request.getParameter("count"));
                inventoryDAO.addTeam(name, type, count);
            } else if ("updateTeam".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                int count = Integer.parseInt(request.getParameter("count"));
                inventoryDAO.updateTeam(id, count);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/teams.jsp");
    }
}
