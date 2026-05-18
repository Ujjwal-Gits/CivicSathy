package com.civicsathy.controller;

import com.civicsathy.dao.AnnouncementDAO;
import com.civicsathy.model.Announcement;
import com.civicsathy.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Servlet controller handling HTTP requests and responses for BroadcastServlet operations.
 * 
 * @author Prashant
 * @version 1.0
 */
@WebServlet("/admin/broadcast")
public class BroadcastServlet extends HttpServlet {
    private AnnouncementDAO announcementDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        announcementDAO = new AnnouncementDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User admin = (User) request.getSession().getAttribute("loggedInUser");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/citizen/login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String message = request.getParameter("message");
        String audience = request.getParameter("audience");

        if (title != null && !title.trim().isEmpty() && message != null && !message.trim().isEmpty()) {
            Announcement a = new Announcement();
            a.setAdminId(admin.getId());
            a.setTitle(title.trim());
            a.setMessage(message.trim());
            a.setIcon("megaphone"); // default icon
            
            announcementDAO.addAnnouncement(a);
        }

        response.sendRedirect(request.getContextPath() + "/admin/announcements.jsp?success=true");
    }
}
