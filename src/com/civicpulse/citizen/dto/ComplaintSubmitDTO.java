package com.civicpulse.citizen.dto;

/**
 * DTO for incoming complaint submission form data.
 */
public class ComplaintSubmitDTO {
    private String title;
    private String description;
    private int categoryId;
    private int ward;
    private String locationText;
    // Image handled separately via Part

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public int getWard() { return ward; }
    public void setWard(int ward) { this.ward = ward; }

    public String getLocationText() { return locationText; }
    public void setLocationText(String locationText) { this.locationText = locationText; }
}
