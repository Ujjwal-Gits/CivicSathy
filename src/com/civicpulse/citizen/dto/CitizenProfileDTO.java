package com.civicpulse.citizen.dto;

/**
 * DTO for citizen profile display and edit.
 */
public class CitizenProfileDTO {
    private int id;
    private String fullName;
    private String email;
    private String phone;
    private int ward;
    private String avatarUrl;
    private int totalComplaints;
    private int resolvedComplaints;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public int getWard() { return ward; }
    public void setWard(int ward) { this.ward = ward; }

    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }

    public int getTotalComplaints() { return totalComplaints; }
    public void setTotalComplaints(int totalComplaints) { this.totalComplaints = totalComplaints; }

    public int getResolvedComplaints() { return resolvedComplaints; }
    public void setResolvedComplaints(int resolvedComplaints) { this.resolvedComplaints = resolvedComplaints; }
}
