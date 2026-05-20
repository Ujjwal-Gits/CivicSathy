package com.civicsathy.controller;

import com.civicsathy.dao.AnnouncementDAO;
import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.dao.NotificationDAO;
import com.civicsathy.model.Announcement;
import com.civicsathy.model.Complaint;
import com.civicsathy.model.Notification;
import com.civicsathy.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.civicsathy.dao.*;
import com.civicsathy.model.*;

import java.io.IOException;
import java.util.List;

// loads the citizen's personal dashboard with their own complaints
/**
 * Servlet controller handling HTTP requests and responses for CitizenDashboardServlet operations.
 * 
 * @author Aastha
 * @version 1.0
 */
@WebServlet("/my-dashboard")
public class CitizenDashboardServlet extends HttpServlet {
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

        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/citizen/login.jsp");
            return;
        }

        // get only this users complaints
        List<Complaint> myComplaints = complaintDAO.getComplaintsByUserId(user.getId());
        request.setAttribute("myComplaints", myComplaints);

        // count by status for the stat boxes
        int pending = 0, inProgress = 0, resolved = 0;
        for (Complaint c : myComplaints) {
            String s = c.getStatus() != null ? c.getStatus().toUpperCase() : "";
            if ("PENDING".equals(s)) pending++;
            else if ("IN_PROGRESS".equals(s) || "ASSIGNED".equals(s)) inProgress++;
            else if ("RESOLVED".equals(s) || "CLOSED".equals(s) || "ESCALATED".equals(s)) resolved++;
        }
        request.setAttribute("totalCount", myComplaints.size());
        request.setAttribute("pendingCount", pending);
        request.setAttribute("inProgressCount", inProgress);
        request.setAttribute("resolvedCount", resolved);

        // get active announcements
        List<Announcement> announcements = announcementDAO.getActiveAnnouncements();
        request.setAttribute("announcements", announcements);

        // get notifications for logged in user
        List<Notification> notifications = notificationDAO.getByUserId(user.getId());
        request.setAttribute("notifications", notifications);
        request.setAttribute("unreadCount", notificationDAO.getUnreadCount(user.getId()));

        request.getRequestDispatcher("/citizen/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/citizen/login.jsp");
            return;
        }

        String complaintIdStr = request.getParameter("complaintId");
        String action = request.getParameter("action");

        if (complaintIdStr != null && action != null) {
            try {
                int complaintId = Integer.parseInt(complaintIdStr);
                Complaint complaint = complaintDAO.getById(complaintId);
                
                // security check: user can only update their own complaints
                if (complaint != null && complaint.getUserId() == user.getId()) {
                    String newStatus = "";
                    String comment = "";
                    
                    if ("confirm".equals(action)) {
                        newStatus = "CLOSED";
                        comment = "Citizen confirmed resolution.";
                    } else if ("reopen".equals(action)) {
                        newStatus = "ESCALATED";
                        comment = "Citizen rejected resolution. Reported again.";
                    }

                    if (!newStatus.isEmpty()) {
                        complaintDAO.updateStatus(complaintId, newStatus);
                        
                        // If it's a reopen/escalation, update the task status as well
                        if ("ESCALATED".equals(newStatus)) {
                            new TaskDAO().updateTaskStatusByComplaintId(complaintId, "ESCALATED");
                        }
                        
                        // Log history
                        StatusHistory sh = new StatusHistory();
                        sh.setComplaintId(complaintId);
                        sh.setOldStatus(complaint.getStatus());
                        sh.setNewStatus(newStatus);
                        sh.setChangedBy(user.getId());
                        sh.setComment(comment);
                        new StatusHistoryDAO().addEntry(sh);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/my-dashboard");
    }
}
