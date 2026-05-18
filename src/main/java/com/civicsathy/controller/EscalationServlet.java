package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.model.Complaint;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

// loads the escalation page showing tickets pending over 48 hours
/**
 * Servlet controller handling HTTP requests and responses for EscalationServlet operations.
 * 
 * @author Prashant
 * @version 1.0
 */
@WebServlet("/admin/escalations")
public class EscalationServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;

}
