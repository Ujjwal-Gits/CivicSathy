package com.civicsathy.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter to control access to citizen pages.
 *
 * This filter checks whether a user is logged in before
 * accessing protected citizen resources.
 * Public pages such as login, registration, feed,
 * and tracking pages are accessible without authentication.
 *
 * @author Aastha
 * @version 1.0
 */
@WebFilter("/citizen/*")
public class AuthFilter implements Filter {

    /**
     * Filters incoming requests and validates user authentication.
     *
     * @param request  client request object
     * @param response server response object
     * @param chain    filter chain for passing request/response
     * @throws IOException if input or output exception occurs
     * @throws ServletException if servlet exception occurs
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();

        // Allow access to public pages without login
        if (path.endsWith("login.jsp") || path.endsWith("register.jsp") ||
                path.endsWith("feed.jsp") || path.endsWith("track.jsp") ||
                path.endsWith("/login") ||
                path.endsWith("/register")) {

            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);

        boolean loggedIn =
                session != null && session.getAttribute("loggedInUser") != null;

        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath()
                    + "/citizen/login.jsp?error=Please login to access this page");
        }
    }
}