package com.civicsathy.dao;

import com.civicsathy.model.Comment;
import com.civicsathy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for handling database operations related to CommentDAO.
 * 
 * @author Prashant
 * @version 1.0
 */
public class CommentDAO {

    /**
     * Executes the addComment operation.
     *
     * @param comment The comment object/value.
     * @return The resulting boolean.
     */
    public boolean addComment(Comment comment) {
        String sql = "INSERT INTO comments (complaint_id, user_id, comment_text) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, comment.getComplaintId());
            stmt.setInt(2, comment.getUserId());
            stmt.setString(3, comment.getCommentText());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves the CommentsForComplaint.
     *
     * @param complaintId The complaintId object/value.
     * @return The resulting List<Comment>.
     */
    public List<Comment> getCommentsForComplaint(int complaintId) {
        List<Comment> list = new ArrayList<>();
        String sql = "SELECT c.*, u.full_name as user_name FROM comments c " +
                "LEFT JOIN users u ON c.user_id = u.id " +
                "WHERE c.complaint_id = ? ORDER BY c.created_at ASC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, complaintId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Comment c = new Comment();
                c.setId(rs.getInt("id"));
                c.setComplaintId(rs.getInt("complaint_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setCommentText(rs.getString("comment_text"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                c.setUserName(rs.getString("user_name"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // only the user who posted the comment can delete it
    /**
     * Deletes the Comment from the system.
     *
     * @param commentId The commentId object/value.
     * @param userId The userId object/value.
     * @return The resulting boolean.
     */
    public boolean deleteComment(int commentId, int userId) {
        String sql = "DELETE FROM comments WHERE id = ? AND user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, commentId);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
