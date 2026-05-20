package com.civicsathy.model;

import java.sql.Timestamp;

// official announcements that admin posts on the public feed
/**
 * Entity model representing Announcement data structure.
 * 
 * @author Prashant
 * @version 1.0
 */
public class Announcement {
    private int id;
    private int adminId;
    private String title;
    private String message;
    private String icon;
    private boolean isActive;
    private Timestamp createdAt;

    /**
     * Executes the Announcement operation.
     *
     */
    public Announcement() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getAdminId() { return adminId; }
    public void setAdminId(int adminId) { this.adminId = adminId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }

    public boolean getIsActive() { return isActive; }
    public void setIsActive(boolean isActive) { this.isActive = isActive; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
