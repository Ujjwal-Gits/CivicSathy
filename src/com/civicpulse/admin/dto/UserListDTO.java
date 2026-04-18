package com.civicpulse.admin.dto;

/**
 * DTO for citizen list in admin user management table.
 */
public class UserListDTO {
    private int id;
    private String fullName;
    private String email;
    private String phone;
    private int ward;
    private boolean isActive;
    private int totalComplaints;
    private String joinedDate;

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

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public int getTotalComplaints() { return totalComplaints; }
    public void setTotalComplaints(int totalComplaints) { this.totalComplaints = totalComplaints; }

    public String getJoinedDate() { return joinedDate; }
    public void setJoinedDate(String joinedDate) { this.joinedDate = joinedDate; }
}
