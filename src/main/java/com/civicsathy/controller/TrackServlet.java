package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.dao.StatusHistoryDAO;
import com.civicsathy.dao.NotificationDAO;
import com.civicsathy.model.Complaint;
import com.civicsathy.model.StatusHistory;
import com.civicsathy.model.Notification;
import com.civicsathy.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

// handles complaint tracking by ticket id (no login needed)
/**
 * Servlet controller handling HTTP requests and responses for TrackServlet operations.
 * 
 * @author Prashant
 * @version 1.0
 */
@WebServlet("/track")
public class TrackServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;
    private StatusHistoryDAO statusHistoryDAO;
    private NotificationDAO notificationDAO;

}
