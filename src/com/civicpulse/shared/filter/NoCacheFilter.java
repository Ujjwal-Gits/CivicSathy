package com.civicpulse.shared.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/** Prevents browser caching of protected pages. */
@WebFilter(urlPatterns = {"/citizen/*", "/admin/*"})
public class NoCacheFilter implements Filter {
    @Override public void init(FilterConfig fc) {}
    @Override public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse r = (HttpServletResponse) res;
        r.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        r.setHeader("Pragma", "no-cache");
        r.setDateHeader("Expires", 0);
        chain.doFilter(req, res);
    }
    @Override public void destroy() {}
}
