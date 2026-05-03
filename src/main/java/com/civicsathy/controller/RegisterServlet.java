package com.civicsathy.controller;

import com.civicsathy.dao.UserDAO;
import com.civicsathy.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String contactNo = request.getParameter("contactNo");
        String wardNo = request.getParameter("wardNo");
        String location = request.getParameter("location");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/citizen/register.jsp").forward(request, response);
            return;
        }

        User user = new User(fullName, email, contactNo, wardNo, location, password, "CITIZEN");
        
        boolean success = userDAO.registerCitizen(user);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/citizen/login.jsp?registered=true");
        } else {
            request.setAttribute("error", "Registration failed. Email might already exist.");
            request.getRequestDispatcher("/citizen/register.jsp").forward(request, response);
        }
    }
}
