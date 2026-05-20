package com.civicsathy.model;

import java.sql.Timestamp;

// notification sent to citizens about their complaint status
/**
 * Entity model representing Notification data structure.
 * 
 * @author Prashant
 * @version 1.0
 */
public class Notification {
    private int id;
    private int userId;
    private int complaintId;
    private String message;
    private boolean isRead;
    private Timestamp createdAt;

    /**
     * Executes the Notification operation.
     *
     */
    public Notification() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getComplaintId() { return complaintId; }
    public void setComplaintId(int complaintId) { this.complaintId = complaintId; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public boolean getIsRead() { return isRead; }
    public void setIsRead(boolean isRead) { this.isRead = isRead; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
