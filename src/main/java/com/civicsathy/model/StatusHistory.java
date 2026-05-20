package com.civicsathy.model;

import java.sql.Timestamp;

// each row here is one step in the complaint timeline
/**
 * Entity model representing StatusHistory data structure.
 * 
 * @author Saurab
 * @version 1.0
 */
public class StatusHistory {
    private int id;
    private int complaintId;
    private String oldStatus;
    private String newStatus;
    private int changedBy;
    private String comment;
    private Timestamp createdAt;

    // extra field for showing who made the change
    private String changedByName;

    /**
     * Executes the StatusHistory operation.
     *
     */
    public StatusHistory() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getComplaintId() { return complaintId; }
    public void setComplaintId(int complaintId) { this.complaintId = complaintId; }

    public String getOldStatus() { return oldStatus; }
    public void setOldStatus(String oldStatus) { this.oldStatus = oldStatus; }

    public String getNewStatus() { return newStatus; }
    public void setNewStatus(String newStatus) { this.newStatus = newStatus; }

    public int getChangedBy() { return changedBy; }
    public void setChangedBy(int changedBy) { this.changedBy = changedBy; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getChangedByName() { return changedByName; }
    public void setChangedByName(String changedByName) { this.changedByName = changedByName; }

    // extra field for linking to the complaint from activity log
    private String trackingId;
    public String getTrackingId() { return trackingId; }
    public void setTrackingId(String trackingId) { this.trackingId = trackingId; }
}
