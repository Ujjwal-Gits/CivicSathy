package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.dao.StatusHistoryDAO;
import com.civicsathy.dao.TaskDAO;
import com.civicsathy.model.StatusHistory;
import com.civicsathy.model.Task;
import com.civicsathy.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

/**
 * Servlet controller handling HTTP requests and responses for AdminAssignTaskServlet operations.
 * 
 * @author Saurab
 * @version 1.0
 */
@WebServlet("/admin/assign-task")
public class AdminAssignTaskServlet extends HttpServlet {
    private TaskDAO taskDAO;
    private ComplaintDAO complaintDAO;
    private StatusHistoryDAO statusHistoryDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        taskDAO = new TaskDAO();
        complaintDAO = new ComplaintDAO();
        statusHistoryDAO = new StatusHistoryDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ticketIdStr = request.getParameter("ticketId");
        String assignedDateStr = request.getParameter("assignedDate");
        String assignedTimeStr = request.getParameter("assignedTime");
        String equipment = request.getParameter("equipment");
        String severity = request.getParameter("severity");
        
        // These will now be arrays from the dynamic form
        String[] vehicleIdsStr = request.getParameterValues("vehicleIds[]");
        String[] vehicleCountsStr = request.getParameterValues("vehicleCounts[]");
        String[] teamIdsStr = request.getParameterValues("teamIds[]");
        String[] teamCountsStr = request.getParameterValues("teamCounts[]");

        User admin = (User) request.getSession().getAttribute("loggedInUser");

        if (ticketIdStr != null && !ticketIdStr.isEmpty()) {
            try {
                int ticketId = Integer.parseInt(ticketIdStr);
                
                Task task = new Task();
                task.setComplaintId(ticketId);
                task.setAssignedDate(Date.valueOf(assignedDateStr));
                task.setEquipment(equipment);
                task.setSeverity(severity);
                
                if (assignedTimeStr != null && assignedTimeStr.length() == 5) {
                    assignedTimeStr += ":00";
                }
                task.setAssignedTime(Time.valueOf(assignedTimeStr));
                
                // Process Teams
                if (teamIdsStr != null && teamCountsStr != null) {
                    for (int i = 0; i < teamIdsStr.length; i++) {
                        if (!teamIdsStr[i].isEmpty() && !teamCountsStr[i].isEmpty()) {
                            task.getTeamIds().add(Integer.parseInt(teamIdsStr[i]));
                            task.getTeamCounts().add(Integer.parseInt(teamCountsStr[i]));
                        }
                    }
                }
                
                // Process Vehicles
                if (vehicleIdsStr != null && vehicleCountsStr != null) {
                    for (int i = 0; i < vehicleIdsStr.length; i++) {
                        if (!vehicleIdsStr[i].isEmpty() && !vehicleCountsStr[i].isEmpty()) {
                            task.getVehicleIds().add(Integer.parseInt(vehicleIdsStr[i]));
                            task.getVehicleCounts().add(Integer.parseInt(vehicleCountsStr[i]));
                        }
                    }
                }
                
                // If editing, delete old assignment first
                taskDAO.deleteTaskByComplaintId(ticketId);

                boolean success = taskDAO.insertTask(task);
                if (success) {
                    com.civicsathy.model.Complaint c = complaintDAO.getById(ticketId);
                    if (c != null && !c.getStatus().equals("In Progress") && !c.getStatus().equals("Resolved")) {
                        complaintDAO.updateStatus(ticketId, "Assigned");
                        
                        StatusHistory sh = new StatusHistory();
                        sh.setComplaintId(ticketId);
                        sh.setOldStatus(c.getStatus());
                        sh.setNewStatus("Assigned");
                        sh.setChangedBy(admin != null ? admin.getId() : 0);
                        sh.setComment("Task manually assigned. Multiple teams and vehicles deployed.");
                        statusHistoryDAO.addEntry(sh);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/tasks");
    }
}
