package com.civicpulse.citizen.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Handles upvote/affected toggle via AJAX.
 * POST /citizen/complaint/upvote
 * Returns JSON: { success: true, newCount: 39 }
 */
@WebServlet("/citizen/complaint/upvote")
public class UpvoteComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Get complaintId and userId, toggle upvote
        response.setContentType("application/json");
        response.getWriter().write("{\"success\": true}");
    }
}
