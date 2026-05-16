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
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email") != null
                ? request.getParameter("email").trim()
                : "";

        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        try {
            String hashedPassword = PasswordUtil.hashPassword(password);
            User user = userDAO.login(email, hashedPassword);

            if (user != null) {

                if ("on".equals(rememberMe)) {
                    Cookie emailCookie = new Cookie("savedEmail", email);
                    emailCookie.setMaxAge(7 * 24 * 60 * 60);
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);
                }

                response.sendRedirect(request.getContextPath() + "/citizen/feed.jsp");

            } else {
                request.getRequestDispatcher("/citizen/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.getRequestDispatcher("/citizen/login.jsp").forward(request, response);
        }
    }
}