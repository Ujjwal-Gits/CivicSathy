package com.civicpulse.admin.service;

import com.civicpulse.admin.dao.AdminComplaintDAO;
import com.civicpulse.admin.dto.ComplaintTableRowDTO;
import com.civicpulse.admin.dto.DashboardStatsDTO;
import com.civicpulse.admin.dto.StatusUpdateDTO;
import com.civicpulse.shared.exception.ServiceException;

import java.util.List;

/**
 * Admin-specific complaint operations.
 * Status changes, assignment, bulk operations.
 */
public class AdminComplaintService {

    private final AdminComplaintDAO adminComplaintDAO = new AdminComplaintDAO();

    public DashboardStatsDTO getDashboardStats() {
        // TODO: Call adminComplaintDAO for aggregate counts
        return new DashboardStatsDTO();
    }

    public List<ComplaintTableRowDTO> getComplaintsForTable(int page, String statusFilter, String categoryFilter) {
        // TODO: Fetch paginated, filtered complaints shaped for table display
        return null;
    }

    public void updateStatus(StatusUpdateDTO dto, int adminUserId) throws ServiceException {
        // TODO: Validate status transition
        // TODO: Update complaint status
        // TODO: Insert into status_history
        // TODO: Create notification for the citizen
    }

    public void assignComplaint(int complaintId, int assignToUserId) throws ServiceException {
        // TODO: Update assigned_to in complaints table
    }
}
