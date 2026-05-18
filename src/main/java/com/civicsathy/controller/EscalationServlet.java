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

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        complaintDAO = new ComplaintDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // get all complaints that are past the 48 hour deadline
        List<Complaint> escalated = complaintDAO.getEscalatedComplaints();
        request.setAttribute("escalatedComplaints", escalated);
        request.setAttribute("escalatedCount", escalated.size());

        request.getRequestDispatcher("/admin/escalations.jsp").forward(request, response);
    }
}
