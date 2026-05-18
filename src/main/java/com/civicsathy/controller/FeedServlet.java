package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.dao.AnnouncementDAO;
import com.civicsathy.dao.NotificationDAO;
import com.civicsathy.model.Complaint;
import com.civicsathy.model.Announcement;
import com.civicsathy.model.Notification;
import com.civicsathy.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

// loads complaints and announcements for the public feed page
/**
 * Servlet controller handling HTTP requests and responses for FeedServlet operations.
 * 
 * @author Riwaz
 * @version 1.0
 */
@WebServlet("/feed")
public class FeedServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;
    private AnnouncementDAO announcementDAO;
    private NotificationDAO notificationDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        complaintDAO = new ComplaintDAO();
        announcementDAO = new AnnouncementDAO();
        notificationDAO = new NotificationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // get all complaints for the feed
        List<Complaint> complaints = complaintDAO.getAllComplaints();
        request.setAttribute("complaints", complaints);

        // get stats for the sidebar
        Map<String, Integer> stats = complaintDAO.getStats();
        request.setAttribute("stats", stats);
        request.setAttribute("totalCount", complaintDAO.getTotalCount());
        request.setAttribute("resolvedTodayCount", complaintDAO.getResolvedTodayCount());

        // calculate pending and in-progress from the stats map
        int pendingCount = stats.getOrDefault("PENDING", 0);
        int inProgressCount = stats.getOrDefault("IN_PROGRESS", 0) + stats.getOrDefault("ASSIGNED", 0);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("inProgressCount", inProgressCount);

        // get active announcements
        List<Announcement> announcements = announcementDAO.getActiveAnnouncements();
        request.setAttribute("announcements", announcements);

        // get notifications for logged in user
        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user != null) {
            List<Notification> notifications = notificationDAO.getByUserId(user.getId());
            request.setAttribute("notifications", notifications);
            request.setAttribute("unreadCount", notificationDAO.getUnreadCount(user.getId()));
            
            // get list of complaint IDs this user is affected by
            List<Integer> affectedIds = complaintDAO.getUserAffectedComplaintIds(user.getId());
            request.setAttribute("affectedIds", affectedIds);
        }

        // fetch comments for each complaint
        com.civicsathy.dao.CommentDAO commentDAO = new com.civicsathy.dao.CommentDAO();
        java.util.Map<Integer, List<com.civicsathy.model.Comment>> commentsMap = new java.util.HashMap<>();
        for (Complaint c : complaints) {
            commentsMap.put(c.getId(), commentDAO.getCommentsForComplaint(c.getId()));
        }
        request.setAttribute("commentsMap", commentsMap);

        request.getRequestDispatcher("/citizen/feed.jsp").forward(request, response);
    }
}
