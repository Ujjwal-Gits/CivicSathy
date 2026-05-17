package com.civicsathy.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter used to protect citizen pages from unauthorized access.
 *
 * <p>This filter checks whether a user is logged in before
 * allowing access to protected pages. Public pages such as
 * login, register, feed, and track pages can be accessed
 * without authentication.</p>
 *
 * @author Aastha
 * @version 1.0
 */
@WebFilter("/citizen/*")
public class AuthFilter implements Filter {

    @Override
    /**
     * Initializes the filter.
     *
     * @param filterConfig filter configuration object
     * @throws ServletException if initialization fails
     */
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    /**
     * Checks user authentication before processing requests.
     *
     * @param request client request object
     * @param response server response object
     * @param chain filter chain object
     * @throws IOException if an input or output error occurs
     * @throws ServletException if a servlet error occurs
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
     * Destroys the filter before shutdown.
     */
    public void destroy() {
    }
}