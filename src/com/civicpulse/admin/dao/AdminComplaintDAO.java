package com.civicpulse.admin.dao;

import com.civicpulse.shared.exception.DatabaseException;
import com.civicpulse.shared.model.Complaint;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Admin-extended complaint DAO.
 * Filtering, pagination, status updates, assignment.
 */
public class AdminComplaintDAO {

    public List<Complaint> findAllFiltered(int offset, int limit, String statusFilter, String categoryFilter) throws DatabaseException {
        // TODO: Build dynamic SQL with optional WHERE clauses
        return new ArrayList<>();
    }

    public int getTotalCount(String statusFilter, String categoryFilter) throws DatabaseException {
        // TODO: COUNT with optional filters
        return 0;
    }

    public void updateStatus(int complaintId, String newStatus) throws DatabaseException {
        String sql = "UPDATE complaints SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
        // TODO: Implement
    }

    public void assignTo(int complaintId, int adminUserId) throws DatabaseException {
        String sql = "UPDATE complaints SET assigned_to = ? WHERE id = ?";
        // TODO: Implement
    }

    public Map<String, Integer> getStatusCounts() throws DatabaseException {
        String sql = "SELECT status, COUNT(*) as cnt FROM complaints GROUP BY status";
        // TODO: Return map like { "PENDING": 24, "IN_PROGRESS": 12, ... }
        return null;
    }
}
