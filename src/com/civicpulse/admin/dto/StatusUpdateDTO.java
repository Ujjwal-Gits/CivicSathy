package com.civicpulse.admin.dto;

/**
 * DTO for incoming status update requests.
 */
public class StatusUpdateDTO {
    private int complaintId;
    private String newStatus;
    private String remarks;

    public int getComplaintId() { return complaintId; }
    public void setComplaintId(int complaintId) { this.complaintId = complaintId; }

    public String getNewStatus() { return newStatus; }
    public void setNewStatus(String newStatus) { this.newStatus = newStatus; }

    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }
}
