package com.civicpulse.shared.filter;

import com.civicpulse.shared.config.AppConstants;
import com.civicpulse.shared.util.SessionUtil;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/** Admin auth filter — ensures ADMIN role for /admin/* pages. */
@WebFilter(urlPatterns = {"/admin/*"})
public class AdminAuthFilter implements Filter {
    @Override public void init(FilterConfig fc) {}
    @Override public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpReq = (HttpServletRequest) req;
        if (httpReq.getServletPath().equals("/admin/login")) { chain.doFilter(req, res); return; }
        if (SessionUtil.hasRole(httpReq, AppConstants.ROLE_ADMIN)) { chain.doFilter(req, res); }
        else { ((HttpServletResponse) res).sendRedirect(httpReq.getContextPath() + "/admin/login"); }
    }
    @Override public void destroy() {}
}
