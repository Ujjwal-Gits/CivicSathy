package com.civicsathy.model;

import java.sql.Timestamp;

/**
 * Entity model representing Comment data structure.
 * 
 * @author Prashant
 * @version 1.0
 */
public class Comment {
	private int id;
	private int complaintId;
	private int userId;
	private String commentText;
	private Timestamp createdAt;
    
	// joined fields
	private String userName;

	public int getId() { return id; }
	public void setId(int id) { this.id = id; }

	public int getComplaintId() { return complaintId; }
	public void setComplaintId(int complaintId) { this.complaintId = complaintId; }

	public int getUserId() { return userId; }
	public void setUserId(int userId) { this.userId = userId; }

	public String getCommentText() { return commentText; }
	public void setCommentText(String commentText) { this.commentText = commentText; }

	public Timestamp getCreatedAt() { return createdAt; }
	public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

	public String getUserName() { return userName; }
	public void setUserName(String userName) { this.userName = userName; }
}
