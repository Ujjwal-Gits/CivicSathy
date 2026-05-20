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

/**
 * Servlet controller handling HTTP requests and responses for AdminComplaintsServlet operations.
 * 
 * @author Saurab
 * @version 1.0
 */
@WebServlet("/admin/complaints")
public class AdminComplaintsServlet extends HttpServlet {
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
        
        List<Complaint> complaints = complaintDAO.getAllComplaints();
        request.setAttribute("complaints", complaints);
        
        request.getRequestDispatcher("/admin/complaints.jsp").forward(request, response);
    }
}
