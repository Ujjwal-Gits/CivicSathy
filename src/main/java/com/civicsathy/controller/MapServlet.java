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

// loads complaint data with GPS coordinates for the admin map page
/**
 * Servlet controller handling HTTP requests and responses for MapServlet operations.
 * 
 * @author Riwaz
 * @version 1.0
 */
@WebServlet("/admin/map-data")
public class MapServlet extends HttpServlet {
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

        // get all complaints that have GPS coordinates
        List<Complaint> mapComplaints = complaintDAO.getComplaintsWithLocation();
        request.setAttribute("mapComplaints", mapComplaints);

        // get ward counts for the heatmap overlay
        request.setAttribute("wardCounts", complaintDAO.getCountByWard());

        request.getRequestDispatcher("/admin/map.jsp").forward(request, response);
    }
}
