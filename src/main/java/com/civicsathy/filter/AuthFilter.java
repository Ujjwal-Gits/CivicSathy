package com.civicsathy.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter responsible for handling authentication
 * and access control for citizen-related pages.
 *
 * <p>This filter checks whether a user session exists
 * before allowing access to protected resources.
 * Public pages such as login, registration, feed,
 * and tracking pages are accessible without authentication.</p>
 *
 * @author Aastha
 * @version 1.0
 */
@WebFilter("/citizen/*")
public class AuthFilter implements Filter {

    @Override
    /**
     * Initializes the filter configuration.
     *
     * @param filterConfig configuration object provided by the servlet container
     * @throws ServletException if filter initialization fails
     */
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    /**
     * Filters incoming requests and validates
     * whether the user is authenticated.
     *
     * <p>If the requested page is public, the request
     * proceeds without authentication. Otherwise,
     * the filter checks the session for a logged-in user.</p>
     *
     * @param request  incoming client request
     * @param response outgoing server response
     * @param chain    filter chain for passing request and response
     * @throws IOException if an input/output error occurs
     * @throws ServletException if servlet processing fails
     */
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

    @Override
    /**
     * Cleans up filter resources before destruction.
     */
    public void destroy() {
    }
}