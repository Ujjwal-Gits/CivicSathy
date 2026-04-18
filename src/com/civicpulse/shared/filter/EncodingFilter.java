package com.civicpulse.shared.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

/** Sets UTF-8 encoding on all requests/responses. */
@WebFilter(urlPatterns = {"/*"})
public class EncodingFilter implements Filter {
    @Override public void init(FilterConfig fc) {}
    @Override public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");
        chain.doFilter(req, res);
    }
    @Override public void destroy() {}
}
