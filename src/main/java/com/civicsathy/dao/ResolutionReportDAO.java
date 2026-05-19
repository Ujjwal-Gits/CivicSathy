package com.civicsathy.dao;

import com.civicsathy.model.ResolutionReport;
import com.civicsathy.util.DBUtil;
import java.sql.*;

/**
 * Data Access Object for handling database operations related to ResolutionReportDAO.
 * 
 * @author Prashant
 * @version 1.0
 */
public class ResolutionReportDAO {

    /**
     * Executes the addReport operation.
     *
     * @param report The report object/value.
     * @return The resulting boolean.
     */
    public boolean addReport(ResolutionReport report) {
        String sql = "INSERT INTO resolution_reports (complaint_id, work_done, hours_taken, cost_estimate, team_deployed, closed_by) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, report.getComplaintId());
            stmt.setString(2, report.getWorkDone());
            stmt.setDouble(3, report.getHoursTaken());
            stmt.setDouble(4, report.getCostEstimate());
            stmt.setString(5, report.getTeamDeployed());
            stmt.setInt(6, report.getClosedBy());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves the ByComplaintId.
     *
     * @param complaintId The complaintId object/value.
     * @return The resulting ResolutionReport.
     */
    public ResolutionReport getByComplaintId(int complaintId) {
        String sql = "SELECT * FROM resolution_reports WHERE complaint_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, complaintId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ResolutionReport r = new ResolutionReport();
                    r.setId(rs.getInt("id"));
                    r.setComplaintId(rs.getInt("complaint_id"));
                    r.setWorkDone(rs.getString("work_done"));
                    r.setHoursTaken(rs.getDouble("hours_taken"));
                    r.setCostEstimate(rs.getDouble("cost_estimate"));
                    r.setTeamDeployed(rs.getString("team_deployed"));
                    r.setClosedBy(rs.getInt("closed_by"));
                    r.setCreatedAt(rs.getTimestamp("created_at"));
                    return r;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
