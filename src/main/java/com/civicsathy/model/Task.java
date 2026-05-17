package com.civicsathy.model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

import java.util.ArrayList;
import java.util.List;

/**
 * Entity model representing Task data structure.
 * 
 * @author Saurab
 * @version 1.0
 */
public class Task {
    private int id;
    private int complaintId;
    private Date assignedDate;
    private Time assignedTime;
    private String status;
    private Timestamp createdAt;
    
    // Lists for multiple resources
    private List<Integer> vehicleIds = new ArrayList<>();
    private List<Integer> vehicleCounts = new ArrayList<>();
    private List<Integer> teamIds = new ArrayList<>();
    private List<Integer> teamCounts = new ArrayList<>();

    // For joined queries
    private String complaintTitle;
    private String categoryName;
    private int wardNo;
    private String trackingId;
    
    // Display strings for frontend
    private String displayVehicles;
    private String displayTeams;
    
    // Equipment and severity for task assignment
    private String equipment;
    private String severity;

    /**
     * Executes the Task operation.
     *
     */
    public Task() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getComplaintId() { return complaintId; }
    public void setComplaintId(int complaintId) { this.complaintId = complaintId; }

    public Date getAssignedDate() { return assignedDate; }
    public void setAssignedDate(Date assignedDate) { this.assignedDate = assignedDate; }

    public Time getAssignedTime() { return assignedTime; }
    public void setAssignedTime(Time assignedTime) { this.assignedTime = assignedTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public List<Integer> getVehicleIds() { return vehicleIds; }
    public void setVehicleIds(List<Integer> vehicleIds) { this.vehicleIds = vehicleIds; }

    public List<Integer> getVehicleCounts() { return vehicleCounts; }
    public void setVehicleCounts(List<Integer> vehicleCounts) { this.vehicleCounts = vehicleCounts; }

    public List<Integer> getTeamIds() { return teamIds; }
    public void setTeamIds(List<Integer> teamIds) { this.teamIds = teamIds; }

    public List<Integer> getTeamCounts() { return teamCounts; }
    public void setTeamCounts(List<Integer> teamCounts) { this.teamCounts = teamCounts; }

    public String getDisplayVehicles() { return displayVehicles; }
    public void setDisplayVehicles(String displayVehicles) { this.displayVehicles = displayVehicles; }

    public String getDisplayTeams() { return displayTeams; }
    public void setDisplayTeams(String displayTeams) { this.displayTeams = displayTeams; }

    public String getComplaintTitle() { return complaintTitle; }
    public void setComplaintTitle(String complaintTitle) { this.complaintTitle = complaintTitle; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public int getWardNo() { return wardNo; }
    public void setWardNo(int wardNo) { this.wardNo = wardNo; }

    public String getTrackingId() { return trackingId; }
    public void setTrackingId(String trackingId) { this.trackingId = trackingId; }

    public String getEquipment() { return equipment; }
    public void setEquipment(String equipment) { this.equipment = equipment; }

    public String getSeverity() { return severity; }
    public void setSeverity(String severity) { this.severity = severity; }
}
