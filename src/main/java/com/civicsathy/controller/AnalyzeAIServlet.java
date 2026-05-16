package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.dao.InventoryDAO;
import com.civicsathy.model.Complaint;
import com.civicsathy.model.Team;
import com.civicsathy.model.Vehicle;
import com.civicsathy.service.GeminiService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

/**
 * Servlet controller handling HTTP requests and responses for AnalyzeAIServlet operations.
 * 
 * @author Ujjwal
 * @version 1.0
 */
@WebServlet("/admin/analyze-ai")
public class AnalyzeAIServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;
    private InventoryDAO inventoryDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        complaintDAO = new ComplaintDAO();
        inventoryDAO = new InventoryDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ticketIdStr = request.getParameter("ticketId");
        boolean isAjax = "true".equals(request.getParameter("ajax"));

        if (ticketIdStr == null || ticketIdStr.isEmpty()) {
            if (isAjax) { sendJsonError(response, "Invalid Ticket ID"); } 
            else { response.sendRedirect(request.getContextPath() + "/admin/complaints?error=Invalid+Ticket+ID"); }
            return;
        }

        try {
            int ticketId = Integer.parseInt(ticketIdStr);
            Complaint complaint = complaintDAO.getById(ticketId);

            if (complaint == null) {
                if (isAjax) { sendJsonError(response, "Ticket not found"); }
                else { response.sendRedirect(request.getContextPath() + "/admin/complaints?error=Ticket+not+found"); }
                return;
            }

            // Get full image path if image exists
            String fullImagePath = null;
            if (complaint.getImagePath() != null && !complaint.getImagePath().isEmpty() && !complaint.getImagePath().equals("unknown")) {
                fullImagePath = request.getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + complaint.getImagePath();
            }

            String categoryName = complaint.getCategoryName() != null ? complaint.getCategoryName() : "Civic Issue";

            // Fetch available teams from database to provide to AI
            List<Team> teams = inventoryDAO.getAvailableTeams();
            StringBuilder teamList = new StringBuilder();
            for (Team t : teams) {
                if (t.getAvailableCount() > 0) {
                    teamList.append("- ").append(t.getTeamName())
                            .append(" (").append(t.getAvailableCount()).append(" members available)\n");
                }
            }
            
            // Fetch available vehicles from database to provide to AI
            List<Vehicle> vehicles = inventoryDAO.getAvailableVehicles();
            StringBuilder vehicleList = new StringBuilder();
            for (Vehicle v : vehicles) {
                if (v.getAvailableCount() > 0) {
                    vehicleList.append("- ").append(v.getVehicleName())
                            .append(" (").append(v.getAvailableCount()).append(" available)\n");
                }
            }

            // Call Gemini API with available teams and vehicles
            Map<String, Object> aiResult = GeminiService.analyzeComplaint(
                    complaint.getTitle(), complaint.getDescription(), categoryName, fullImagePath, teamList.toString(), vehicleList.toString());

            String severity = (String) aiResult.get("severity");

            if (severity != null && !severity.isEmpty()) {
                String teamSuggestion = (String) aiResult.get("team_suggestion");
                String equipment = (String) aiResult.get("equipment");
                int teamSize = aiResult.get("team_size") != null ? (Integer) aiResult.get("team_size") : 2;
                String vehicleSuggestion = (String) aiResult.get("vehicle_suggestion");
                int vehicleCount = aiResult.get("vehicle_count") != null ? (Integer) aiResult.get("vehicle_count") : 1;

                // Save to DB (hours no longer needed, we'll keep the vehicle stuff transient for now)
                complaintDAO.updateAIAnalysis(ticketId, severity, teamSuggestion, equipment, 0.0, teamSize);

                if (isAjax) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print("{\"status\":\"success\"," +
                              "\"severity\":\"" + escapeJson(severity) + "\"," +
                              "\"team_suggestion\":\"" + escapeJson(teamSuggestion) + "\"," +
                              "\"equipment\":\"" + escapeJson(equipment) + "\"," +
                              "\"team_size\":" + teamSize + "," +
                              "\"vehicle_suggestion\":\"" + escapeJson(vehicleSuggestion) + "\"," +
                              "\"vehicle_count\":" + vehicleCount + "}");
                    out.flush();
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/ticket?id=" + ticketId + "&success=AI+Analysis+Complete");
                }
            } else {
                if (isAjax) { sendJsonError(response, "AI analysis returned no results. Check server logs and API key."); }
                else { response.sendRedirect(request.getContextPath() + "/admin/ticket?id=" + ticketId + "&error=AI+Analysis+Failed"); }
            }

        } catch (Exception e) {
            e.printStackTrace();
            if (isAjax) { sendJsonError(response, "Error: " + e.getMessage()); }
            else { response.sendRedirect(request.getContextPath() + "/admin/ticket?id=" + ticketIdStr + "&error=Error+running+AI+Analysis"); }
        }
    }

    private void sendJsonError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"status\":\"error\",\"message\":\"" + escapeJson(message) + "\"}");
        out.flush();
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
    }
}
