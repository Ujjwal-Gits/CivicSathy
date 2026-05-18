package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.dao.StatusHistoryDAO;
import com.civicsathy.model.Complaint;
import com.civicsathy.model.StatusHistory;
import com.civicsathy.model.User;
import com.civicsathy.service.GeminiService;
import com.civicsathy.util.TrackingIdUtil;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

// this servlet handles when a citizen submits a new complaint
@WebServlet("/submit-complaint")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
/**
 * Servlet controller handling HTTP requests and responses for SubmitComplaintServlet operations.
 * 
 * @author Ujjwal
 * @version 1.0
 */
public class SubmitComplaintServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // check if user is logged in
        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/citizen/login.jsp");
            return;
        }

        // get form data
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String wardNo = request.getParameter("wardNo");
        String locationText = request.getParameter("locationText");
        String latitude = request.getParameter("latitude");
        String longitude = request.getParameter("longitude");
        String isAnonymous = request.getParameter("isAnonymous");

        // handle image upload
        String fileName = null;
        for (Part part : request.getParts()) {
            if (part.getName().equals("imageFile") && part.getSize() > 0) {
                fileName = System.currentTimeMillis() + "_" + extractFileName(part);
                String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                part.write(uploadPath + File.separator + fileName);
            }
        }

        // create the complaint object
        Complaint complaint = new Complaint();
        complaint.setTrackingId(TrackingIdUtil.generate(Integer.parseInt(wardNo)));
        complaint.setUserId(user.getId());
        complaint.setCategoryId(Integer.parseInt(category));
        complaint.setTitle(title);
        complaint.setDescription(description);
        complaint.setWardNo(Integer.parseInt(wardNo));
        complaint.setLocationText(locationText);

        // set GPS coordinates from the javascript frontend
        if (latitude != null && !latitude.isEmpty()) {
            complaint.setLatitude(Double.parseDouble(latitude));
        }
        if (longitude != null && !longitude.isEmpty()) {
            complaint.setLongitude(Double.parseDouble(longitude));
        }

        complaint.setImagePath(fileName);
        complaint.setIsAnonymous("on".equals(isAnonymous));

        // Duplicate Detection: Check if a similar complaint exists within 20 meters
        if (latitude != null && !latitude.isEmpty() && longitude != null && !longitude.isEmpty()) {
            boolean isDuplicate = complaintDAO.checkDuplicateComplaint(
                Integer.parseInt(category), 
                Double.parseDouble(latitude), 
                Double.parseDouble(longitude)
            );
            if (isDuplicate) {
                request.setAttribute("error", "Duplicate Detected: A similar issue has already been reported at this exact location. Our team is aware.");
                request.getRequestDispatcher("/citizen/submit.jsp").forward(request, response);
                return;
            }
        }

        // Call Gemini AI for automated severity analysis
        String categoryName = "Civic Issue"; // You could query CategoryDAO here
        String fullImagePath = null;
        if (fileName != null && !fileName.equals("unknown")) {
            fullImagePath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR + File.separator + fileName;
        }
        Map<String, Object> aiResult = GeminiService.analyzeComplaint(title, description, categoryName, fullImagePath, null, null);
        
        // Only save AI results if the API actually returned data
        String aiSeverity = (String) aiResult.get("severity");
        if (aiSeverity != null && !aiSeverity.isEmpty()) {
            complaint.setAiSeverity(aiSeverity);
            complaint.setAiTeamSuggestion((String) aiResult.get("team_suggestion"));
            complaint.setAiEquipment((String) aiResult.get("equipment"));
            complaint.setAiEstimatedHours(aiResult.get("estimated_hours") != null ? (Double) aiResult.get("estimated_hours") : 0.0);
            complaint.setAiTeamSize(aiResult.get("team_size") != null ? (Integer) aiResult.get("team_size") : 0);
            complaint.setSeverity(aiSeverity);
        }

        // save to database
        if (complaintDAO.insertComplaint(complaint)) {
            // add the first status history entry
            StatusHistory sh = new StatusHistory();
            sh.setComplaintId(complaint.getId());
            sh.setNewStatus("PENDING");
            sh.setChangedBy(user.getId());
            sh.setComment("Complaint submitted by citizen");
            statusHistoryDAO.addEntry(sh);

            response.sendRedirect(request.getContextPath() +
                "/citizen/track.jsp?id=" + complaint.getTrackingId() + "&success=true");
        } else {
            request.setAttribute("error", "Failed to submit complaint. Please try again.");
            request.getRequestDispatcher("/citizen/submit.jsp").forward(request, response);
        }
    }

    // helper to get the filename from the upload
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "unknown";
    }
}
