package com.civicpulse.citizen.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Handles new complaint submission.
 * POST /citizen/complaint/submit
 */
@WebServlet("/citizen/complaint/submit")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize = 5 * 1024 * 1024,        // 5 MB
    maxRequestSize = 10 * 1024 * 1024     // 10 MB
)
public class SubmitComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Read form fields into ComplaintSubmitDTO
        // TODO: Call ComplaintService.submitComplaint(dto, userId)
        // TODO: Handle file upload via FileUploadUtil
        // TODO: Redirect to dashboard with success message (PRG pattern)
        response.sendRedirect(request.getContextPath() + "/citizen/dashboard");
    }
}
