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

  