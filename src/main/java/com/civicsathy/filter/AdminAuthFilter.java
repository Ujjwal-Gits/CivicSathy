package com.civicsathy.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/admin/*")
/**
 * Utility class providing helper methods for AdminAuthFilter.
 *
 * @author Aastha
 * @version 1.0
 */
public class AdminAuthFilter implements Filter {

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

        HttpSession session = req.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("loggedInUser") != null;
        boolean isAdmin = loggedIn && "ADMIN".equalsIgnoreCase((String) session.getAttribute("userRole"));

        String path = req.getRequestURI();
        if (path.endsWith("login.jsp") || path.endsWith("/login")) {
            chain.doFilter(request, response);
            return;
        }

        if (isAdmin) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/admin/login.jsp?error=Admin access is required");
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
