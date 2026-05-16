package com.civicsathy.controller;

import com.civicsathy.dao.UserDAO;
import com.civicsathy.model.User;
import com.civicsathy.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/**
 * Servlet controller handling HTTP requests and responses for LoginServlet operations.
 *
 * @author Aastha
 * @version 1.0
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("savedEmail".equals(cookie.getName())) {
                    request.setAttribute("savedEmail", cookie.getValue());
                }
            }
        }
        request.getRequestDispatcher("/citizen/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both email and password");
            request.getRequestDispatcher("/citizen/login.jsp").forward(request, response);
            return;
        }

        try {
            String hashedPassword = PasswordUtil.hashPassword(password);
            User user = userDAO.login(email, hashedPassword);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);
                session.setAttribute("userRole", user.getRole());

                if ("on".equals(rememberMe)) {
                    Cookie emailCookie = new Cookie("savedEmail", email);
                    emailCookie.setMaxAge(7 * 24 * 60 * 60);
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);
                }

                if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard-stats");
                } else {
                    response.sendRedirect(request.getContextPath() + "/citizen/feed.jsp");
                }
            } else {
                request.setAttribute("error", "Invalid email or password. Please check your credentials.");
                request.getRequestDispatcher("/citizen/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Database Error: " + e.getMessage());
            request.getRequestDispatcher("/citizen/login.jsp").forward(request, response);
        }
    }
}
