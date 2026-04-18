package com.civicpulse.admin.dto;

/**
 * DTO shaped for the admin complaint management table rows.
 */
public class ComplaintTableRowDTO {
    private int id;
    private String trackingId;
    private String title;
    private String categoryName;
    private String status;
    private int ward;
    private int upvoteCount;
    private String submittedBy;
    private String assignedToName;
    private String timeAgo;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTrackingId() { return trackingId; }
    public void setTrackingId(String trackingId) { this.trackingId = trackingId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getWard() { return ward; }
    public void setWard(int ward) { this.ward = ward; }

    public int getUpvoteCount() { return upvoteCount; }
    public void setUpvoteCount(int upvoteCount) { this.upvoteCount = upvoteCount; }

    public String getSubmittedBy() { return submittedBy; }
    public void setSubmittedBy(String submittedBy) { this.submittedBy = submittedBy; }

    public String getAssignedToName() { return assignedToName; }
    public void setAssignedToName(String assignedToName) { this.assignedToName = assignedToName; }

    public String getTimeAgo() { return timeAgo; }
    public void setTimeAgo(String timeAgo) { this.timeAgo = timeAgo; }
}
