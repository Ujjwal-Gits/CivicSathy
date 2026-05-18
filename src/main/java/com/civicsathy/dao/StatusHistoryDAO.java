package com.civicsathy.dao;

import com.civicsathy.model.StatusHistory;
import com.civicsathy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// tracks every status change for the complaint timeline
/**
 * Data Access Object for handling database operations related to StatusHistoryDAO.
 * 
 * @author Saurab
 * @version 1.0
 */
public class StatusHistoryDAO {

    // add a new entry when status changes
    /**
     * Executes the addEntry operation.
     *
     * @param entry The entry object/value.
     * @return The resulting boolean.
     */
    public boolean addEntry(StatusHistory entry) {
        String sql = "INSERT INTO status_history (complaint_id, old_status, new_status, changed_by, comment) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, entry.getComplaintId());
            stmt.setString(2, entry.getOldStatus());
            stmt.setString(3, entry.getNewStatus());
            stmt.setInt(4, entry.getChangedBy());
            stmt.setString(5, entry.getComment());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // get the 10 most recent activity entries across all complaints (for dashboard activity log)
    /**
     * Retrieves the RecentActivity.
     *
     * @return The resulting List<StatusHistory>.
     */
    public List<StatusHistory> getRecentActivity() {
        List<StatusHistory> list = new ArrayList<>();
        String sql = "SELECT sh.*, u.full_name as changed_by_name, c.tracking_id " +
                     "FROM status_history sh " +
                     "LEFT JOIN users u ON sh.changed_by = u.id " +
                     "LEFT JOIN complaints c ON sh.complaint_id = c.id " +
                     "ORDER BY sh.created_at DESC LIMIT 10";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                StatusHistory sh = new StatusHistory();
                sh.setId(rs.getInt("id"));
                sh.setComplaintId(rs.getInt("complaint_id"));
                sh.setOldStatus(rs.getString("old_status"));
                sh.setNewStatus(rs.getString("new_status"));
                sh.setChangedBy(rs.getInt("changed_by"));
                sh.setComment(rs.getString("comment"));
                sh.setCreatedAt(rs.getTimestamp("created_at"));
                sh.setChangedByName(rs.getString("changed_by_name"));
                try { sh.setTrackingId(rs.getString("tracking_id")); } catch (Exception e) {}
                list.add(sh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // get the full timeline for a complaint
    /**
     * Retrieves the ByComplaintId.
     *
     * @param complaintId The complaintId object/value.
     * @return The resulting List<StatusHistory>.
     */
    public List<StatusHistory> getByComplaintId(int complaintId) {
        List<StatusHistory> list = new ArrayList<>();
        String sql = "SELECT sh.*, u.full_name as changed_by_name FROM status_history sh " +
                     "LEFT JOIN users u ON sh.changed_by = u.id " +
                     "WHERE sh.complaint_id = ? ORDER BY sh.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, complaintId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                StatusHistory sh = new StatusHistory();
                sh.setId(rs.getInt("id"));
                sh.setComplaintId(rs.getInt("complaint_id"));
                sh.setOldStatus(rs.getString("old_status"));
                sh.setNewStatus(rs.getString("new_status"));
                sh.setChangedBy(rs.getInt("changed_by"));
                sh.setComment(rs.getString("comment"));
                sh.setCreatedAt(rs.getTimestamp("created_at"));
                sh.setChangedByName(rs.getString("changed_by_name"));
                list.add(sh);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
