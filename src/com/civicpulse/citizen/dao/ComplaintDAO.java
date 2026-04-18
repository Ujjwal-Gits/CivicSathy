package com.civicpulse.citizen.dao;

import com.civicpulse.shared.exception.DatabaseException;
import com.civicpulse.shared.model.Complaint;
import com.civicpulse.shared.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for the complaints table (citizen operations).
 * Handles CRUD operations — no business logic here.
 */
public class ComplaintDAO {

    /**
     * Insert a new complaint.
     * Returns the auto-generated complaint ID.
     */
    public int insert(Complaint complaint) throws DatabaseException {
        String sql = "INSERT INTO complaints (tracking_id, title, description, category_id, status, ward, location_text, latitude, longitude, image_url, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        // TODO: Implement with PreparedStatement
        return 0;
    }

    /**
     * Find a complaint by ID.
     */
    public Complaint findById(int id) throws DatabaseException {
        String sql = "SELECT * FROM complaints WHERE id = ?";
        // TODO: Implement
        return null;
    }

    /**
     * Find a complaint by tracking ID (e.g., "MET-2026-0341").
     */
    public Complaint findByTrackingId(String trackingId) throws DatabaseException {
        String sql = "SELECT * FROM complaints WHERE tracking_id = ?";
        // TODO: Implement
        return null;
    }

    /**
     * Get paginated complaints for the public feed.
     */
    public List<Complaint> findAll(int offset, int limit, String categoryFilter, String sortBy) throws DatabaseException {
        // TODO: Build dynamic SQL with optional category filter and sort
        return new ArrayList<>();
    }

    /**
     * Get complaints submitted by a specific user.
     */
    public List<Complaint> findByUserId(int userId, int offset, int limit) throws DatabaseException {
        String sql = "SELECT * FROM complaints WHERE user_id = ? ORDER BY created_at DESC LIMIT ? OFFSET ?";
        // TODO: Implement
        return new ArrayList<>();
    }

    /**
     * Get total count of complaints (for pagination).
     */
    public int getTotalCount(String categoryFilter) throws DatabaseException {
        // TODO: SELECT COUNT(*) with optional filter
        return 0;
    }

    /**
     * Update the upvote count (denormalized field).
     */
    public void updateUpvoteCount(int complaintId, int newCount) throws DatabaseException {
        String sql = "UPDATE complaints SET upvote_count = ? WHERE id = ?";
        // TODO: Implement
    }
}
