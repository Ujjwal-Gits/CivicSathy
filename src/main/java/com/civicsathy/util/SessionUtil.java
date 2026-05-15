package com.civicsathy.util;

import com.civicsathy.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Utility class providing helper methods for SessionUtil.
 *
 * @author Ujjwal
 * @version 1.0
 */
public class SessionUtil {
    /**
     * Checks if a user is currently logged in.
     * @param request The HTTP request.
     * @return true if logged in, false otherwise.
     */
    public static boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("loggedInUser") != null;
    }

    /**
     * Retrieves the logged-in user object from the session.
     * @param request The HTTP request.
     * @return The User object or null.
     */
    public static User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (User) session.getAttribute("loggedInUser");
        }
        return null;
    }
}


