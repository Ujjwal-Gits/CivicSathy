package com.civicpulse.citizen.dto;

/**
 * DTO shaped for complaint card display in the feed.
 * Carries only the fields needed for the card component.
 */
public class ComplaintCardDTO {
    private int id;
    private String trackingId;
    private String title;
    private String categoryName;
    private String categoryColor;
    private String status;
    private String locationText;
    private int ward;
    private String imageUrl;
    private int upvoteCount;
    private String timeAgo;
    private boolean userHasUpvoted;

    // --- Getters & Setters ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTrackingId() { return trackingId; }
    public void setTrackingId(String trackingId) { this.trackingId = trackingId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getCategoryColor() { return categoryColor; }
    public void setCategoryColor(String categoryColor) { this.categoryColor = categoryColor; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getLocationText() { return locationText; }
    public void setLocationText(String locationText) { this.locationText = locationText; }

    public int getWard() { return ward; }
    public void setWard(int ward) { this.ward = ward; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public int getUpvoteCount() { return upvoteCount; }
    public void setUpvoteCount(int upvoteCount) { this.upvoteCount = upvoteCount; }

    public String getTimeAgo() { return timeAgo; }
    public void setTimeAgo(String timeAgo) { this.timeAgo = timeAgo; }

    public boolean isUserHasUpvoted() { return userHasUpvoted; }
    public void setUserHasUpvoted(boolean userHasUpvoted) { this.userHasUpvoted = userHasUpvoted; }
}
