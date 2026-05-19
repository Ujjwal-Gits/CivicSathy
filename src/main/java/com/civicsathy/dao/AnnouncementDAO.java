package com.civicsathy.dao;

import com.civicsathy.model.Announcement;
import com.civicsathy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// handles official announcements that admin posts
/**
 * Data Access Object for handling database operations related to AnnouncementDAO.
 * 
 * @author Prashant
 * @version 1.0
 */
public class AnnouncementDAO {

    // get all active announcements for the public feed
    /**
     * Retrieves the ActiveAnnouncements.
     *
     * @return The resulting List<Announcement>.
     */
    public List<Announcement> getActiveAnnouncements() {
        List<Announcement> list = new ArrayList<>();
        String sql = "SELECT * FROM announcements WHERE is_active = TRUE ORDER BY created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Announcement a = new Announcement();
                a.setId(rs.getInt("id"));
                a.setAdminId(rs.getInt("admin_id"));
                a.setTitle(rs.getString("title"));
                a.setMessage(rs.getString("message"));
                a.setIcon(rs.getString("icon"));
                a.setIsActive(rs.getBoolean("is_active"));
                a.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
