package com.civicpulse.citizen.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Single complaint detail view.
 * GET /citizen/complaint/detail?id=123
 */
@WebServlet("/citizen/complaint/detail")
public class ComplaintDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Get complaint ID from request parameter
        // TODO: Fetch full complaint detail via ComplaintService
        request.getRequestDispatcher("/citizen/complaint-detail.jsp").forward(request, response);
    }
}
