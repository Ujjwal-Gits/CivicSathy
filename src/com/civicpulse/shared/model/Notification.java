package com.civicpulse.shared.model;

import java.sql.Timestamp;

/** Notification entity — maps to `notifications` table. */
public class Notification {
    private int id;
    private int userId;
    private String title;
    private String message;
    private String type;
    private int relatedComplaintId;
    private boolean isRead;
    private Timestamp createdAt;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public int getRelatedComplaintId() { return relatedComplaintId; }
    public void setRelatedComplaintId(int id) { this.relatedComplaintId = id; }
    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { isRead = read; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
