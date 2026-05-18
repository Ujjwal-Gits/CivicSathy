package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.model.Complaint;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Servlet controller handling HTTP requests and responses for DuplicateCheckServlet operations.
 * 
 * @author Ujjwal
 * @version 1.0
 */
@WebServlet("/api/check-duplicates")
public class DuplicateCheckServlet extends HttpServlet {
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
        
        String title = request.getParameter("title");
        String latStr = request.getParameter("lat");
        String lngStr = request.getParameter("lng");
        
        response.setContentType("application/json");
        
        if (title == null || title.trim().length() < 3 || latStr == null || lngStr == null) {
            response.getWriter().write("[]");
            return;
        }

        try {
            double lat = Double.parseDouble(latStr);
            double lng = Double.parseDouble(lngStr);

            // Search for similar complaints with title match AND proximity (~200 meters)
            List<Complaint> all = complaintDAO.getAllComplaints();
            List<Complaint> duplicates = all.stream()
                .filter(c -> c.getTitle() != null && c.getTitle().toLowerCase().contains(title.toLowerCase()))
                .filter(c -> {
                    // Simple distance check (approx 0.002 degrees ~ 200m)
                    double dLat = Math.abs(c.getLatitude() - lat);
                    double dLng = Math.abs(c.getLongitude() - lng);
                    return dLat < 0.002 && dLng < 0.002;
                })
                .limit(3)
                .collect(Collectors.toList());

            response.getWriter().write(new Gson().toJson(duplicates));
        } catch (Exception e) {
            response.getWriter().write("[]");
        }
    }
}
