package com.civicsathy.controller;

import com.civicsathy.dao.CommentDAO;
import com.civicsathy.model.Comment;
import com.civicsathy.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// handles both adding and deleting comments
// add: POST /add-comment?action=add&complaintId=X&commentText=Y
// delete: POST /add-comment?action=delete&commentId=X
/**
 * Servlet controller handling HTTP requests and responses for AddCommentServlet operations.
 * 
 * @author Prashant
 * @version 1.0
 */
@WebServlet("/add-comment")
public class AddCommentServlet extends HttpServlet {
    private CommentDAO commentDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        commentDAO = new CommentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // user must be logged in
        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/citizen/login.jsp?error=You must be logged in to comment.");
            return;
        }

        String action = request.getParameter("action");

        // if action is "delete", handle deletion
        if ("delete".equals(action)) {
            String commentIdStr = request.getParameter("commentId");
            if (commentIdStr != null && !commentIdStr.isEmpty()) {
                int commentId = Integer.parseInt(commentIdStr);
                // deleteComment checks user_id, so only owner can delete
                boolean deleted = commentDAO.deleteComment(commentId, user.getId());
                if (deleted) {
                    response.getWriter().write("OK");
                } else {
                    response.setStatus(403);
                    response.getWriter().write("NOT_ALLOWED");
                }
            }
            return;
        }

        // otherwise, handle adding a comment
        String complaintIdStr = request.getParameter("complaintId");
        String commentText = request.getParameter("commentText");
        
        if (complaintIdStr != null && !complaintIdStr.isEmpty() && commentText != null && !commentText.trim().isEmpty()) {
            try {
                int complaintId = Integer.parseInt(complaintIdStr);
                Comment comment = new Comment();
                comment.setComplaintId(complaintId);
                comment.setUserId(user.getId());
                comment.setCommentText(commentText.trim());
                commentDAO.addComment(comment);
                
                // If it's an AJAX request, just return success
                if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With")) || request.getParameter("ajax") != null) {
                    response.getWriter().write("OK");
                    return;
                }
                
                response.sendRedirect(request.getContextPath() + "/feed#complaint-" + complaintId);
                return;
            } catch (NumberFormatException e) {
                // Ignore invalid IDs
            }
        }

        response.sendRedirect(request.getContextPath() + "/feed");
    }
}