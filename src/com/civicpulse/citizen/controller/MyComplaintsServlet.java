package com.civicpulse.citizen.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Lists complaints submitted by the logged-in citizen.
 * GET /citizen/my-complaints
 */
@WebServlet("/citizen/my-complaints")
public class MyComplaintsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Get logged-in user ID, fetch their complaints
        request.getRequestDispatcher("/citizen/my-complaints.jsp").forward(request, response);
    }
}
