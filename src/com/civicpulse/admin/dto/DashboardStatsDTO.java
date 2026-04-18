package com.civicpulse.admin.dto;

/**
 * DTO for admin dashboard overview statistics.
 */
public class DashboardStatsDTO {
    private int totalComplaints;
    private int pendingCount;
    private int inProgressCount;
    private int resolvedCount;
    private int rejectedCount;
    private int totalUsers;
    private int todayComplaints;

    public int getTotalComplaints() { return totalComplaints; }
    public void setTotalComplaints(int totalComplaints) { this.totalComplaints = totalComplaints; }

    public int getPendingCount() { return pendingCount; }
    public void setPendingCount(int pendingCount) { this.pendingCount = pendingCount; }

    public int getInProgressCount() { return inProgressCount; }
    public void setInProgressCount(int inProgressCount) { this.inProgressCount = inProgressCount; }

    public int getResolvedCount() { return resolvedCount; }
    public void setResolvedCount(int resolvedCount) { this.resolvedCount = resolvedCount; }

    public int getRejectedCount() { return rejectedCount; }
    public void setRejectedCount(int rejectedCount) { this.rejectedCount = rejectedCount; }

    public int getTotalUsers() { return totalUsers; }
    public void setTotalUsers(int totalUsers) { this.totalUsers = totalUsers; }

    public int getTodayComplaints() { return todayComplaints; }
    public void setTodayComplaints(int todayComplaints) { this.todayComplaints = todayComplaints; }
}
