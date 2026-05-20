package com.civicsathy.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/citizen/*")
/**
 * Utility class providing helper methods for AuthFilter.
 * 
 * @author Aastha
 * @version 1.0
 */
public class AuthFilter implements Filter {

    @Override
    /**
     * Executes the init operation.
     *
     * @param filterConfig The filterConfig object/value.
     * @throws ServletException if an exception occurs.
     */
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    /**
     * Executes the doFilter operation.
     *
     * @param request The request object/value.
     * @param response The response object/value.
     * @param chain The chain object/value.
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
        boolean loggedIn = session != null && session.getAttribute("loggedInUser") != null;

        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/citizen/login.jsp?error=Please login to access this page");
        }
    }

    @Override
    /**
     * Executes the destroy operation.
     *
     */
    public void destroy() {
    }
}
