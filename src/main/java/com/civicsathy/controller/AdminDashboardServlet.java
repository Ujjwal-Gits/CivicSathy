package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.dao.StatusHistoryDAO;
import com.civicsathy.model.Complaint;
import com.civicsathy.model.StatusHistory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

// loads all the data needed for the admin dashboard page
/**
 * Servlet controller handling HTTP requests and responses for AdminDashboardServlet operations.
 * 
 * @author Riwaz
 * @version 1.0
 */
@WebServlet("/admin/dashboard-stats")
public class AdminDashboardServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;
    private StatusHistoryDAO statusHistoryDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        complaintDAO = new ComplaintDAO();
        statusHistoryDAO = new StatusHistoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // check and update escalated tickets
        complaintDAO.autoEscalateTickets();

        // get counts by status
        Map<String, Integer> rawStats = complaintDAO.getStats();
        java.util.Map<String, Integer> stats = new java.util.HashMap<>();
        for (java.util.Map.Entry<String, Integer> entry : rawStats.entrySet()) {
            if (entry.getKey() != null) {
                String key = entry.getKey().toUpperCase().replace(" ", "_");
                stats.put(key, stats.getOrDefault(key, 0) + entry.getValue());
            }
        }
        
        request.setAttribute("pendingCount", stats.getOrDefault("PENDING", 0));
        request.setAttribute("inProgressCount", stats.getOrDefault("IN_PROGRESS", 0));
        request.setAttribute("assignedCount", stats.getOrDefault("ASSIGNED", 0));
        request.setAttribute("resolvedCount", stats.getOrDefault("RESOLVED", 0));
        request.setAttribute("escalatedCountStat", stats.getOrDefault("ESCALATED", 0));

        int total = complaintDAO.getTotalCount();
        request.setAttribute("totalCount", total);

        // get escalated count for the alert banner
        int escalated = complaintDAO.getEscalatedCount();
        request.setAttribute("escalatedCount", escalated);

        // get counts by category for the bar chart
        Map<String, Integer> catCounts = complaintDAO.getCountByCategory();
        request.setAttribute("categoryCounts", catCounts);

        // get counts by ward for the ward chart
        request.setAttribute("wardCounts", complaintDAO.getCountByWard());

        // get recent complaints for the table
        List<Complaint> allComplaints = complaintDAO.getAllComplaints();
        int limit = Math.min(5, allComplaints.size());
        request.setAttribute("recentComplaints", allComplaints.subList(0, limit));
        request.setAttribute("allComplaintsForMap", allComplaints);

        // get activity log (recent status changes)
        List<StatusHistory> activityLog = statusHistoryDAO.getRecentActivity();
        request.setAttribute("activityLog", activityLog);

        // AI Weekly Summary - compute from real data
        int resolved = stats.getOrDefault("RESOLVED", 0);
        int resRate = total > 0 ? (resolved * 100) / total : 0;
        request.setAttribute("aiTotalComplaints", total);
        request.setAttribute("aiResolutionRate", resRate);
        request.setAttribute("aiEscalatedCount", escalated);

        // find top category
        String topCat = "N/A";
        int topCatCount = 0;
        if (catCounts != null) {
            for (Map.Entry<String, Integer> entry : catCounts.entrySet()) {
                if (entry.getValue() > topCatCount) {
                    topCatCount = entry.getValue();
                    topCat = entry.getKey();
                }
            }
        }
        int topCatPct = total > 0 ? (topCatCount * 100) / total : 0;
        request.setAttribute("aiTopCategory", topCat);
        request.setAttribute("aiTopCategoryPct", topCatPct);

        // find top ward
        Map<Integer, Integer> wardCounts = complaintDAO.getCountByWard();
        int topWard = 0;
        int topWardCount = 0;
        if (wardCounts != null) {
            for (Map.Entry<Integer, Integer> entry : wardCounts.entrySet()) {
                if (entry.getValue() > topWardCount) {
                    topWardCount = entry.getValue();
                    topWard = entry.getKey();
                }
            }
        }
        request.setAttribute("aiTopWard", topWard);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
