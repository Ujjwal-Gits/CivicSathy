package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.dao.StatusHistoryDAO;
import com.civicsathy.dao.NotificationDAO;
import com.civicsathy.model.Complaint;
import com.civicsathy.model.StatusHistory;
import com.civicsathy.model.Notification;
import com.civicsathy.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

// handles complaint tracking by ticket id (no login needed)
/**
 * Servlet controller handling HTTP requests and responses for TrackServlet operations.
 * 
 * @author Prashant
 * @version 1.0
 */
@WebServlet("/track")
public class TrackServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;
    private StatusHistoryDAO statusHistoryDAO;
    private NotificationDAO notificationDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        complaintDAO = new ComplaintDAO();
        statusHistoryDAO = new StatusHistoryDAO();
        notificationDAO = new NotificationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String trackingId = request.getParameter("id");

        if (trackingId != null && !trackingId.trim().isEmpty()) {
            // find the complaint by tracking id
            Complaint complaint = complaintDAO.getByTrackingId(trackingId.trim());

            if (complaint != null) {
                request.setAttribute("complaint", complaint);

                // get the full timeline for this complaint
                List<StatusHistory> timeline = statusHistoryDAO.getByComplaintId(complaint.getId());
                request.setAttribute("timeline", timeline);
            } else {
                request.setAttribute("error", "No complaint found with ID: " + trackingId);
            }
        }

        // load notifications for logged-in user navbar
        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user != null) {
            List<Notification> notifications = notificationDAO.getByUserId(user.getId());
            request.setAttribute("notifications", notifications);
            request.setAttribute("unreadCount", notificationDAO.getUnreadCount(user.getId()));
        }

        request.getRequestDispatcher("/citizen/track.jsp").forward(request, response);
    }
}
