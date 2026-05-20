package com.civicsathy.model;

import java.sql.Timestamp;

// this represents a single complaint/report from a citizen
/**
 * Entity model representing Complaint data structure.
 * 
 * @author Ujjwal
 * @version 1.0
 */
public class Complaint {
    private int id;
    private String trackingId;
    private int userId;
    private int categoryId;
    private String title;
    private String description;
    private int wardNo;
    private String locationText;
    private double latitude;
    private double longitude;
    private String imagePath;
    private boolean isAnonymous;
    private String status;
    private String severity;
    private int affectedCount;
    private Integer assignedTeamId;
    private String aiSeverity;
    private String aiTeamSuggestion;
    private String aiEquipment;
    private double aiEstimatedHours;
    private int aiTeamSize;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // extra fields we join from other tables for display
    private String categoryName;
    private String userName;
    private String teamName;

    /**
     * Executes the Complaint operation.
     *
     */
    public Complaint() {}

    // getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTrackingId() { return trackingId; }
    public void setTrackingId(String trackingId) { this.trackingId = trackingId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getWardNo() { return wardNo; }
    public void setWardNo(int wardNo) { this.wardNo = wardNo; }

    public String getLocationText() { return locationText; }
    public void setLocationText(String locationText) { this.locationText = locationText; }

    public double getLatitude() { return latitude; }
    public void setLatitude(double latitude) { this.latitude = latitude; }

    public double getLongitude() { return longitude; }
    public void setLongitude(double longitude) { this.longitude = longitude; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public boolean getIsAnonymous() { return isAnonymous; }
    public void setIsAnonymous(boolean isAnonymous) { this.isAnonymous = isAnonymous; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getSeverity() { return severity; }
    public void setSeverity(String severity) { this.severity = severity; }

    public int getAffectedCount() { return affectedCount; }
    public void setAffectedCount(int affectedCount) { this.affectedCount = affectedCount; }

    public Integer getAssignedTeamId() { return assignedTeamId; }
    public void setAssignedTeamId(Integer assignedTeamId) { this.assignedTeamId = assignedTeamId; }

    public String getAiSeverity() { return aiSeverity; }
    public void setAiSeverity(String aiSeverity) { this.aiSeverity = aiSeverity; }

    public String getAiTeamSuggestion() { return aiTeamSuggestion; }
    public void setAiTeamSuggestion(String aiTeamSuggestion) { this.aiTeamSuggestion = aiTeamSuggestion; }

    public String getAiEquipment() { return aiEquipment; }
    public void setAiEquipment(String aiEquipment) { this.aiEquipment = aiEquipment; }

    public double getAiEstimatedHours() { return aiEstimatedHours; }
    public void setAiEstimatedHours(double aiEstimatedHours) { this.aiEstimatedHours = aiEstimatedHours; }

    public int getAiTeamSize() { return aiTeamSize; }
    public void setAiTeamSize(int aiTeamSize) { this.aiTeamSize = aiTeamSize; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getTeamName() { return teamName; }
    public void setTeamName(String teamName) { this.teamName = teamName; }
}
