package com.civicsathy.dao;

import com.civicsathy.model.Notification;
import com.civicsathy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// handles notification messages for citizens
/**
 * Data Access Object for handling database operations related to NotificationDAO.
 * 
 * @author Prashant
 * @version 1.0
 */
public class NotificationDAO {

    // create a new notification for a user
    /**
     * Executes the addNotification operation.
     *
     * @param userId The userId object/value.
     * @param complaintId The complaintId object/value.
     * @param message The message object/value.
     * @return The resulting boolean.
     */
    public boolean addNotification(int userId, int complaintId, String message) {
        String sql = "INSERT INTO notifications (user_id, complaint_id, message) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, complaintId);
            stmt.setString(3, message);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // get all notifications for a user newest first
    /**
     * Retrieves the ByUserId.
     *
     * @param userId The userId object/value.
     * @return The resulting List<Notification>.
     */
    public List<Notification> getByUserId(int userId) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC LIMIT 20";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Notification n = new Notification();
                n.setId(rs.getInt("id"));
                n.setUserId(rs.getInt("user_id"));
                n.setComplaintId(rs.getInt("complaint_id"));
                n.setMessage(rs.getString("message"));
                n.setIsRead(rs.getBoolean("is_read"));
                n.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(n);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // count unread notifications for the badge number
    /**
     * Retrieves the UnreadCount.
     *
     * @param userId The userId object/value.
     * @return The resulting int.
     */
    public int getUnreadCount(int userId) {
        String sql = "SELECT COUNT(*) FROM notifications WHERE user_id = ? AND is_read = FALSE";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
