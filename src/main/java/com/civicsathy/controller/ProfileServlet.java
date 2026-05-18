package com.civicsathy.controller;

import com.civicsathy.dao.UserDAO;
import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.dao.NotificationDAO;
import com.civicsathy.model.User;
import com.civicsathy.model.Complaint;
import com.civicsathy.model.Notification;
import com.civicsathy.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


// handles profile viewing and updating
/**
 * Servlet controller handling HTTP requests and responses for ProfileServlet operations.
 *
 * @author Aastha
 * @version 1.0
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO;
    private ComplaintDAO complaintDAO;
    private NotificationDAO notificationDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        userDAO = new UserDAO();
        complaintDAO = new ComplaintDAO();
        notificationDAO = new NotificationDAO();
    }

    // load profile page with user data
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/citizen/login.jsp");
            return;
        }

        // refresh user data from database
        User freshUser = userDAO.getUserById(user.getId());
        request.setAttribute("userProfile", freshUser);

        // get their complaint stats
        List<Complaint> userComplaints = complaintDAO.getComplaintsByUserId(user.getId());
        request.setAttribute("myComplaints", userComplaints);

        // load notifications for navbar
        java.util.List<Notification> notifications = notificationDAO.getByUserId(user.getId());
        request.setAttribute("notifications", notifications);
        request.setAttribute("unreadCount", notificationDAO.getUnreadCount(user.getId()));

        request.getRequestDispatcher("/citizen/profile.jsp").forward(request, response);
    }

    // handle profile update form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/citizen/login.jsp");
            return;
        }

        // update basic info
        user.setFullName(request.getParameter("fullName"));
        user.setContactNo(request.getParameter("phone"));
        user.setWardNo(request.getParameter("wardNo"));
        user.setLocation(request.getParameter("location"));

        userDAO.updateProfile(user);

        // update password if provided
        String newPassword = request.getParameter("newPassword");
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            String hashed = PasswordUtil.hashPassword(newPassword);
            userDAO.updatePassword(user.getId(), hashed);
        }

        // update session with new data
        request.getSession().setAttribute("loggedInUser", user);
        response.sendRedirect(request.getContextPath() + "/profile?success=Profile updated");
    }
}
