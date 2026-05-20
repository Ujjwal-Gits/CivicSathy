package com.civicsathy.controller;

import com.civicsathy.dao.*;
import com.civicsathy.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// handles admin actions on a ticket like status update and team assignment
/**
 * Servlet controller handling HTTP requests and responses for AdminTicketServlet operations.
 * 
 * @author Saurab
 * @version 1.0
 */
@WebServlet("/admin/update-ticket")
public class AdminTicketServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;
    private StatusHistoryDAO statusHistoryDAO;
    private NotificationDAO notificationDAO;
    private ResolutionReportDAO resolutionReportDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        complaintDAO = new ComplaintDAO();
        statusHistoryDAO = new StatusHistoryDAO();
        notificationDAO = new NotificationDAO();
        resolutionReportDAO = new ResolutionReportDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ticketIdStr = request.getParameter("ticketId");
        String newStatus = request.getParameter("status");
        String adminComment = request.getParameter("comment");
        User admin = (User) request.getSession().getAttribute("loggedInUser");

        if (ticketIdStr != null && newStatus != null) {
            try {
                int ticketId = Integer.parseInt(ticketIdStr);

                // get current complaint to know the old status
                Complaint complaint = complaintDAO.getById(ticketId);
                if (complaint == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/complaints.jsp?error=Ticket not found");
                    return;
                }

                String oldStatus = complaint.getStatus();

                // update the status
                boolean success = complaintDAO.updateStatus(ticketId, newStatus);

                if (success) {
                    // Update task status as well so inventory gets released if resolved
                    TaskDAO taskDAO = new TaskDAO();
                    taskDAO.updateTaskStatusByComplaintId(ticketId, newStatus);
                    
                    // If status is RESOLVED, save resolution report
                    if ("Resolved".equalsIgnoreCase(newStatus) || "RESOLVED".equalsIgnoreCase(newStatus)) {
                        String workDone = request.getParameter("workDone");
                        String hoursStr = request.getParameter("hoursTaken");
                        String costStr = request.getParameter("costEstimate");
                        String team = request.getParameter("teamDeployed");
                        
                        ResolutionReport report = new ResolutionReport();
                        report.setComplaintId(ticketId);
                        report.setWorkDone(workDone != null ? workDone : adminComment);
                        try {
                            if(hoursStr != null) report.setHoursTaken(Double.parseDouble(hoursStr));
                            if(costStr != null && !costStr.isEmpty()) report.setCostEstimate(Double.parseDouble(costStr));
                        } catch(Exception e){}
                        report.setTeamDeployed(team);
                        report.setClosedBy(admin != null ? admin.getId() : 0);
                        
                        resolutionReportDAO.addReport(report);
                    }
                    
                    // log the status change in history
                    StatusHistory sh = new StatusHistory();
                    sh.setComplaintId(ticketId);
                    sh.setOldStatus(oldStatus);
                    sh.setNewStatus(newStatus);
                    sh.setChangedBy(admin != null ? admin.getId() : 0);
                    sh.setComment(adminComment);
                    statusHistoryDAO.addEntry(sh);

                    // notify the citizen
                    String message = "Your complaint #" + complaint.getTrackingId() +
                                   " status changed to " + newStatus;
                    notificationDAO.addNotification(complaint.getUserId(), ticketId, message);

                    response.sendRedirect(request.getContextPath() +
                        "/admin/ticket.jsp?id=" + ticketId + "&success=Status updated to " + newStatus + "#statusSection");
                } else {
                    response.sendRedirect(request.getContextPath() +
                        "/admin/ticket.jsp?id=" + ticketId + "&error=Failed to update status#statusSection");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/complaints.jsp?error=Invalid ID");
            }
        }
    }
}
