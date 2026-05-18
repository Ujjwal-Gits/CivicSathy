package com.civicsathy.controller;

import com.civicsathy.dao.TaskDAO;
import com.civicsathy.model.Task;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet controller handling HTTP requests and responses for AdminTasksServlet operations.
 * 
 * @author Riwaz
 * @version 1.0
 */
@WebServlet("/admin/tasks")
public class AdminTasksServlet extends HttpServlet {
    private TaskDAO taskDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        taskDAO = new TaskDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Task> tasks = taskDAO.getAllTasks();
        request.setAttribute("assignedTasks", tasks);

        request.getRequestDispatcher("/admin/tasks.jsp").forward(request, response);
    }
}
