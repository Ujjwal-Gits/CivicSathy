package com.civicpulse.shared.util;

import com.civicpulse.shared.config.AppConstants;
import com.civicpulse.shared.model.User;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/** Session management — login/logout helpers. */
public class SessionUtil {
    public static User getLoggedInUser(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return s == null ? null : (User) s.getAttribute(AppConstants.SESSION_USER);
    }
    public static boolean isLoggedIn(HttpServletRequest req) { return getLoggedInUser(req) != null; }
    public static boolean hasRole(HttpServletRequest req, String role) {
        User u = getLoggedInUser(req);
        return u != null && role.equals(u.getRole());
    }
    public static int getUserId(HttpServletRequest req) {
        User u = getLoggedInUser(req);
        return u != null ? u.getId() : -1;
    }
    public static void setLoggedInUser(HttpServletRequest req, User user) {
        HttpSession s = req.getSession(true);
        s.setAttribute(AppConstants.SESSION_USER, user);
        s.setAttribute(AppConstants.SESSION_USER_ID, user.getId());
        s.setAttribute(AppConstants.SESSION_USER_ROLE, user.getRole());
    }
    public static void logout(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        if (s != null) s.invalidate();
    }
}
