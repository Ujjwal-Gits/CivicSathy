package com.civicpulse.shared.listener;

import com.civicpulse.shared.config.DatabaseConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.File;

/** App lifecycle listener — loads DB driver, creates upload dirs on startup. */
@WebListener
public class AppContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext ctx = sce.getServletContext();
        try { Class.forName(DatabaseConfig.DRIVER_CLASS); ctx.log("CivicPulse: MySQL driver loaded."); }
        catch (ClassNotFoundException e) { ctx.log("CivicPulse: FATAL — " + e.getMessage()); }

        String uploads = ctx.getRealPath("/uploads/complaints/");
        File dir = new File(uploads);
        if (!dir.exists()) dir.mkdirs();
        ctx.log("CivicPulse: App initialized.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        sce.getServletContext().log("CivicPulse: Shutting down.");
    }
}
