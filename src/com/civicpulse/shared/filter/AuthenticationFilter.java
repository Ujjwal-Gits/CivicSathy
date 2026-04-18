package com.civicpulse.shared.filter;

import com.civicpulse.shared.util.SessionUtil;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/** Auth filter — redirects unauthenticated citizens to login. */
@WebFilter(urlPatterns = {"/citizen/dashboard", "/citizen/complaint/*", "/citizen/my-complaints", "/citizen/profile"})
public class AuthenticationFilter implements Filter {
    @Override public void init(FilterConfig fc) {}
    @Override public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpReq = (HttpServletRequest) req;
        if (SessionUtil.isLoggedIn(httpReq)) { chain.doFilter(req, res); }
        else { ((HttpServletResponse) res).sendRedirect(httpReq.getContextPath() + "/citizen/login"); }
    }
    @Override public void destroy() {}
}
