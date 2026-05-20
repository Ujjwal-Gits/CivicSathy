package com.civicsathy.dao;

import com.civicsathy.model.Complaint;
import com.civicsathy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// handles all database operations for complaints
/**
 * Data Access Object for handling database operations related to ComplaintDAO.
 * 
 * @author Ujjwal
 * @version 1.0
 */
public class ComplaintDAO {

    // get dashboard stats grouped by status
    /**
     * Retrieves the Stats.
     *
     * @return The resulting Integer>.
     */
    public Map<String, Integer> getStats() {
        Map<String, Integer> stats = new HashMap<>();
        String sql = "SELECT status, COUNT(*) as count FROM complaints GROUP BY status";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                stats.put(rs.getString("status"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }

    // get total number of complaints
    /**
     * Retrieves the TotalCount.
     *
     * @return The resulting int.
     */
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM complaints";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // count complaints resolved today
    /**
     * Retrieves the ResolvedTodayCount.
     *
     * @return The resulting int.
     */
    public int getResolvedTodayCount() {
        String sql = "SELECT COUNT(*) FROM complaints WHERE status = 'RESOLVED' AND DATE(created_at) = CURDATE()";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // insert a new complaint into the database
    /**
     * Inserts a new Complaint into the database.
     *
     * @param complaint The complaint object/value.
     * @return The resulting boolean.
     */
    public boolean insertComplaint(Complaint complaint) {
        String sql = "INSERT INTO complaints (tracking_id, user_id, category_id, title, description, " +
                     "ward_no, location_text, latitude, longitude, image_path, is_anonymous) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, complaint.getTrackingId());
            stmt.setInt(2, complaint.getUserId());
            stmt.setInt(3, complaint.getCategoryId());
            stmt.setString(4, complaint.getTitle());
            stmt.setString(5, complaint.getDescription());
            stmt.setInt(6, complaint.getWardNo());
            stmt.setString(7, complaint.getLocationText());
            stmt.setDouble(8, complaint.getLatitude());
            stmt.setDouble(9, complaint.getLongitude());
            stmt.setString(10, complaint.getImagePath());
            stmt.setBoolean(11, complaint.getIsAnonymous());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        complaint.setId(rs.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQL ERROR IN insertComplaint: " + e.getMessage());
            return false;
        }
    }

    // get all complaints with category name joined
    /**
     * Retrieves the AllComplaints.
     *
     * @return The resulting List<Complaint>.
     */
    public List<Complaint> getAllComplaints() {
        List<Complaint> list = new ArrayList<>();
        String sql = "SELECT c.*, cat.name as category_name, u.full_name as user_name " +
                     "FROM complaints c " +
                     "LEFT JOIN categories cat ON c.category_id = cat.id " +
                     "LEFT JOIN users u ON c.user_id = u.id " +
                     "ORDER BY c.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapComplaint(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // get complaints for a specific user (for their dashboard)
    /**
     * Retrieves the ComplaintsByUserId.
     *
     * @param userId The userId object/value.
     * @return The resulting List<Complaint>.
     */
    public List<Complaint> getComplaintsByUserId(int userId) {
        List<Complaint> list = new ArrayList<>();
        String sql = "SELECT c.*, cat.name as category_name FROM complaints c " +
                     "LEFT JOIN categories cat ON c.category_id = cat.id " +
                     "WHERE c.user_id = ? ORDER BY c.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapComplaint(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // find a complaint by its tracking id (for the public tracker)
    /**
     * Retrieves the ByTrackingId.
     *
     * @param trackingId The trackingId object/value.
     * @return The resulting Complaint.
     */
    public Complaint getByTrackingId(String trackingId) {
        String sql = "SELECT c.*, cat.name as category_name, u.full_name as user_name " +
                     "FROM complaints c " +
                     "LEFT JOIN categories cat ON c.category_id = cat.id " +
                     "LEFT JOIN users u ON c.user_id = u.id " +
                     "WHERE c.tracking_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, trackingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapComplaint(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // find a complaint by its database id
    /**
     * Retrieves the ById.
     *
     * @param id The id object/value.
     * @return The resulting Complaint.
     */
    public Complaint getById(int id) {
        String sql = "SELECT c.*, cat.name as category_name, u.full_name as user_name " +
                     "FROM complaints c " +
                     "LEFT JOIN categories cat ON c.category_id = cat.id " +
                     "LEFT JOIN users u ON c.user_id = u.id " +
                     "WHERE c.id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapComplaint(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // update the status of a complaint
    /**
     * Updates the Status records.
     *
     * @param id The id object/value.
     * @param status The status object/value.
     * @return The resulting boolean.
     */
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE complaints SET status = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // update the complaint with AI analysis details
    /**
     * Updates the AIAnalysis records.
     *
     * @param id The id object/value.
     * @param severity The severity object/value.
     * @param teamSuggestion The teamSuggestion object/value.
     * @param equipment The equipment object/value.
     * @param estimatedHours The estimatedHours object/value.
     * @param teamSize The teamSize object/value.
     * @return The resulting boolean.
     */
    public boolean updateAIAnalysis(int id, String severity, String teamSuggestion, String equipment, double estimatedHours, int teamSize) {
        String sql = "UPDATE complaints SET ai_severity = ?, ai_team_suggestion = ?, ai_equipment = ?, ai_estimated_hours = ?, ai_team_size = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, severity);
            stmt.setString(2, teamSuggestion);
            stmt.setString(3, equipment);
            stmt.setDouble(4, estimatedHours);
            stmt.setInt(5, teamSize);
            stmt.setInt(6, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // assign a team to a complaint
    /**
     * Executes the assignTeam operation.
     *
     * @param complaintId The complaintId object/value.
     * @param teamId The teamId object/value.
     * @return The resulting boolean.
     */
    public boolean assignTeam(int complaintId, int teamId) {
        String sql = "UPDATE complaints SET assigned_team_id = ?, status = 'ASSIGNED' WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, teamId);
            stmt.setInt(2, complaintId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // toggle an affected vote (add if not voted, remove if already voted)
    /**
     * Executes the toggleAffectedVote operation.
     *
     * @param complaintId The complaintId object/value.
     * @param userId The userId object/value.
     * @return The resulting String.
     */
    public String toggleAffectedVote(int complaintId, int userId) {
        String checkVote = "SELECT id FROM affected_votes WHERE complaint_id = ? AND user_id = ?";
        String deleteVote = "DELETE FROM affected_votes WHERE complaint_id = ? AND user_id = ?";
        String insertVote = "INSERT INTO affected_votes (complaint_id, user_id) VALUES (?, ?)";
        String updateCountAdd = "UPDATE complaints SET affected_count = affected_count + 1 WHERE id = ?";
        String updateCountSub = "UPDATE complaints SET affected_count = GREATEST(0, affected_count - 1) WHERE id = ?";
        String getCount = "SELECT affected_count FROM complaints WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection()) {
            // Check if vote exists
            try (PreparedStatement stmt = conn.prepareStatement(checkVote)) {
                stmt.setInt(1, complaintId);
                stmt.setInt(2, userId);
                ResultSet rs = stmt.executeQuery();
                
                String action;
                if (rs.next()) {
                    // Already voted, so remove it
                    try (PreparedStatement stmtDel = conn.prepareStatement(deleteVote)) {
                        stmtDel.setInt(1, complaintId);
                        stmtDel.setInt(2, userId);
                        stmtDel.executeUpdate();
                    }
                    try (PreparedStatement stmtUpdate = conn.prepareStatement(updateCountSub)) {
                        stmtUpdate.setInt(1, complaintId);
                        stmtUpdate.executeUpdate();
                    }
                    action = "REMOVED";
                } else {
                    // Not voted, so add it
                    try (PreparedStatement stmtIns = conn.prepareStatement(insertVote)) {
                        stmtIns.setInt(1, complaintId);
                        stmtIns.setInt(2, userId);
                        stmtIns.executeUpdate();
                    }
                    try (PreparedStatement stmtUpdate = conn.prepareStatement(updateCountAdd)) {
                        stmtUpdate.setInt(1, complaintId);
                        stmtUpdate.executeUpdate();
                    }
                    action = "ADDED";
                }
                
                // get the real count from DB
                int count = 0;
                try (PreparedStatement stmtCount = conn.prepareStatement(getCount)) {
                    stmtCount.setInt(1, complaintId);
                    ResultSet rsCount = stmtCount.executeQuery();
                    if (rsCount.next()) count = rsCount.getInt("affected_count");
                }
                return action + ":" + count;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "ERROR:0";
        }
    }
    
    // get a list of complaint IDs that a user has voted on as affected
    /**
     * Retrieves the UserAffectedComplaintIds.
     *
     * @param userId The userId object/value.
     * @return The resulting List<Integer>.
     */
    public List<Integer> getUserAffectedComplaintIds(int userId) {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT complaint_id FROM affected_votes WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("complaint_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // get complaints that are older than 48 hours and still pending (for escalation)
    /**
     * Retrieves the EscalatedComplaints.
     *
     * @return The resulting List<Complaint>.
     */
    public List<Complaint> getEscalatedComplaints() {
        List<Complaint> list = new ArrayList<>();
        String sql = "SELECT c.*, cat.name as category_name, u.full_name as user_name " +
                     "FROM complaints c " +
                     "LEFT JOIN categories cat ON c.category_id = cat.id " +
                     "LEFT JOIN users u ON c.user_id = u.id " +
                     "WHERE c.status = 'ESCALATED' " +
                     "OR (c.status IN ('PENDING', 'ASSIGNED', 'IN_PROGRESS') AND c.created_at < NOW() - INTERVAL 48 HOUR) " +
                     "ORDER BY c.created_at ASC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapComplaint(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // automatically update status to 'ESCALATED' for tickets older than 48 hours
    /**
     * Executes the autoEscalateTickets operation.
     *
     * @return The resulting int.
     */
    public int autoEscalateTickets() {
        String sql = "UPDATE complaints SET status = 'ESCALATED' " +
                     "WHERE status IN ('PENDING', 'ASSIGNED', 'IN_PROGRESS') " +
                     "AND created_at < NOW() - INTERVAL 48 HOUR";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // get count of escalated complaints for the sidebar badge
    /**
     * Retrieves the EscalatedCount.
     *
     * @return The resulting int.
     */
    public int getEscalatedCount() {
        String sql = "SELECT COUNT(*) FROM complaints " +
                     "WHERE status = 'ESCALATED' " +
                     "OR (status IN ('PENDING', 'ASSIGNED', 'IN_PROGRESS') AND created_at < NOW() - INTERVAL 48 HOUR)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // get complaints with GPS coordinates for the map
    /**
     * Retrieves the ComplaintsWithLocation.
     *
     * @return The resulting List<Complaint>.
     */
    public List<Complaint> getComplaintsWithLocation() {
        List<Complaint> list = new ArrayList<>();
        String sql = "SELECT c.*, cat.name as category_name FROM complaints c " +
                     "LEFT JOIN categories cat ON c.category_id = cat.id " +
                     "WHERE c.latitude IS NOT NULL AND c.longitude IS NOT NULL " +
                     "AND c.status != 'CLOSED' " +
                     "ORDER BY c.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapComplaint(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // get complaint count grouped by ward for the heatmap
    /**
     * Retrieves the CountByWard.
     *
     * @return The resulting Integer>.
     */
    public Map<Integer, Integer> getCountByWard() {
        Map<Integer, Integer> wardCounts = new HashMap<>();
        String sql = "SELECT ward_no, COUNT(*) as count FROM complaints GROUP BY ward_no ORDER BY count DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                wardCounts.put(rs.getInt("ward_no"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return wardCounts;
    }

    // get complaint count grouped by category for the charts
    /**
     * Retrieves the CountByCategory.
     *
     * @return The resulting Integer>.
     */
    public Map<String, Integer> getCountByCategory() {
        Map<String, Integer> catCounts = new HashMap<>();
        String sql = "SELECT cat.name, COUNT(*) as count FROM complaints c " +
                     "LEFT JOIN categories cat ON c.category_id = cat.id " +
                     "GROUP BY cat.name ORDER BY count DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                catCounts.put(rs.getString("name"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return catCounts;
    }

    // helper method to map a ResultSet row to a Complaint object
    private Complaint mapComplaint(ResultSet rs) throws SQLException {
        Complaint c = new Complaint();
        c.setId(rs.getInt("id"));
        c.setTrackingId(rs.getString("tracking_id"));
        c.setUserId(rs.getInt("user_id"));
        c.setCategoryId(rs.getInt("category_id"));
        c.setTitle(rs.getString("title"));
        c.setDescription(rs.getString("description"));
        c.setWardNo(rs.getInt("ward_no"));
        c.setLocationText(rs.getString("location_text"));
        c.setLatitude(rs.getDouble("latitude"));
        c.setLongitude(rs.getDouble("longitude"));
        c.setImagePath(rs.getString("image_path"));
        c.setIsAnonymous(rs.getBoolean("is_anonymous"));
        c.setStatus(rs.getString("status"));
        c.setSeverity(rs.getString("severity"));
        c.setAffectedCount(rs.getInt("affected_count"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        try { c.setUpdatedAt(rs.getTimestamp("updated_at")); } catch (SQLException e) {}

        // New AI and Assignment Columns
        try {
            c.setAssignedTeamId(rs.getInt("assigned_team_id"));
            if (rs.wasNull()) c.setAssignedTeamId(null);
        } catch (SQLException e) {}
        try { c.setAiSeverity(rs.getString("ai_severity")); } catch (SQLException e) {}
        try { c.setAiTeamSuggestion(rs.getString("ai_team_suggestion")); } catch (SQLException e) {}
        try { c.setAiEquipment(rs.getString("ai_equipment")); } catch (SQLException e) {}
        try { c.setAiEstimatedHours(rs.getDouble("ai_estimated_hours")); } catch (SQLException e) {}
        try { c.setAiTeamSize(rs.getInt("ai_team_size")); } catch (SQLException e) {}

        // try to get joined fields if they exist
        try { c.setCategoryName(rs.getString("category_name")); } catch (SQLException e) {}
        try { c.setUserName(rs.getString("user_name")); } catch (SQLException e) {}

        return c;
    }

    // Check if there is an existing complaint of the same category within 20 meters
    /**
     * Executes the checkDuplicateComplaint operation.
     *
     * @param categoryId The categoryId object/value.
     * @param latitude The latitude object/value.
     * @param longitude The longitude object/value.
     * @return The resulting boolean.
     */
    public boolean checkDuplicateComplaint(int categoryId, double latitude, double longitude) {
        // Haversine formula to calculate distance in meters (6371000 is Earth radius in meters)
        String sql = "SELECT id FROM complaints WHERE category_id = ? " +
                "AND (6371000 * acos(cos(radians(?)) * cos(radians(latitude)) * " +
                "cos(radians(longitude) - radians(?)) + sin(radians(?)) * " +
                "sin(radians(latitude)))) <= 20 LIMIT 1";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            stmt.setDouble(2, latitude);
            stmt.setDouble(3, longitude);
            stmt.setDouble(4, latitude);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return true; // Found a duplicate
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
