<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ page import="com.civicsathy.dao.TaskDAO" %>
    <%@ page import="com.civicsathy.model.Task" %>
      <%@ page import="com.civicsathy.dao.InventoryDAO" %>
        <%@ page import="com.civicsathy.model.Vehicle" %>
          <%@ page import="com.civicsathy.model.Team" %>
            <%@ page import="com.civicsathy.dao.ComplaintDAO" %>
              <%@ page import="com.civicsathy.model.Complaint" %>
                <%@ page import="com.civicsathy.dao.StatusHistoryDAO" %>
                  <%@ page import="com.civicsathy.model.StatusHistory" %>
                    <%@ page import="com.civicsathy.dao.ResolutionReportDAO" %>
                      <%@ page import="com.civicsathy.model.ResolutionReport" %>
                        <%@ page import="java.util.List" %>
                          <%@ page import="java.text.SimpleDateFormat" %>
                            <% String idStr=request.getParameter("id"); Complaint complaint=null; Task
                              existingTask=null; List<Vehicle>
                              availVehicles = null;
                              List<Team> availTeams = null;
                                List<StatusHistory> statusHistory = null;
                                  ResolutionReport resolutionReport = null;
                                  long inProgressTime = 0;

                                  if (idStr != null) {
                                  try {
                                  ComplaintDAO dao = new ComplaintDAO();
                                  complaint = dao.getById(Integer.parseInt(idStr));

                                  if (complaint != null) {
                                  TaskDAO taskDAO = new TaskDAO();
                                  existingTask =
                                  taskDAO.getTaskByComplaintId(complaint.getId());

                                  InventoryDAO invDAO = new InventoryDAO();
                                  availVehicles = invDAO.getAvailableVehicles();
                                  availTeams = invDAO.getAvailableTeams();

                                  StatusHistoryDAO shDAO = new StatusHistoryDAO();
                                  statusHistory =
                                  shDAO.getByComplaintId(complaint.getId());

                                  ResolutionReportDAO rrDAO = new
                                  ResolutionReportDAO();
                                  resolutionReport =
                                  rrDAO.getByComplaintId(complaint.getId());

                                  if (statusHistory != null) {
                                  for (StatusHistory sh : statusHistory) {
                                  if (sh.getNewStatus() != null &&
                                  sh.getNewStatus().toLowerCase().contains("progress"))
                                  {
                                  inProgressTime = sh.getCreatedAt().getTime();
                                  break;
                                  }
                                  }
                                  }
                                  }
                                  } catch(Exception e){}
                                  }
                                  if (complaint == null) {
                                  response.sendRedirect("complaints.jsp?error=Ticket not found");
                                  return;
                                  }
                                  %>
                                  <!DOCTYPE html>
                                  <html lang="en">

                                  <head>
                                    <meta charset="UTF-8">
                                    <meta name="viewport" content="width=device-width,initial-scale=1">
                                    <title>CivicSathy - Active Ticket</title>
                                    <link
                                      href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap"
                                      rel="stylesheet">
                                    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
                                    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
                                    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
                                    <style>
                                      * {
                                        box-sizing: border-box;
                                        margin: 0;
                                        padding: 0;
                                      }

                                      body {
                                        font-family: 'DM Sans', sans-serif;
                                        background: #F5F5F7;
                                        color: #0A0A0A;
                                        -webkit-font-smoothing: antialiased;
                                        display: flex;
                                        min-height: 100vh;
                                        overflow: hidden;
                                      }

                                      a {
                                        text-decoration: none;
                                        color: inherit;
                                      }

                                      button {
                                        cursor: pointer;
                                        font-family: inherit;
                                      }

                                      .sidebar {
                                        width: 240px;
                                        flex-shrink: 0;
                                        background: #fff;
                                        border-right: 1px solid #E8E8ED;
                                        display: flex;
                                        flex-direction: column;
                                        height: 100vh;
                                      }

                                      .sb-brand {
                                        padding: 20px 20px 16px;
                                        border-bottom: 1px solid #E8E8ED;
                                      }

                                      .sb-logo {
                                        font-size: 18px;
                                        font-weight: 700;
                                        letter-spacing: -.3px;
                                      }

                                      .sb-logo span {
                                        color: #005B96;
                                      }

                                      .sb-badge {
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 4px;
                                        margin-top: 4px;
                                        padding: 2px 8px;
                                        background: #EBF5FF;
                                        border-radius: 3px;
                                        font-size: 9px;
                                        font-weight: 700;
                                        color: #005B96;
                                        text-transform: uppercase;
                                        letter-spacing: .08em;
                                      }

                                      .sb-nav {
                                        flex: 1;
                                        padding: 16px 12px;
                                        overflow-y: auto;
                                      }

                                      .sb-sec {
                                        font-size: 10px;
                                        font-weight: 700;
                                        color: #86868B;
                                        text-transform: uppercase;
                                        letter-spacing: .08em;
                                        padding: 0 8px;
                                        margin: 16px 0 8px;
                                      }

                                      .sb-sec:first-child {
                                        margin-top: 0;
                                      }

                                      .sb-item {
                                        display: flex;
                                        align-items: center;
                                        gap: 10px;
                                        padding: 10px;
                                        border-radius: 6px;
                                        font-size: 13px;
                                        font-weight: 500;
                                        color: #0A0A0A;
                                        margin-bottom: 4px;
                                        transition: background .15s;
                                      }

                                      .sb-item:hover {
                                        background: #F5F5F7;
                                      }

                                      .sb-item.active {
                                        background: #EBF5FF;
                                        color: #005B96;
                                        font-weight: 600;
                                      }

                                      .sb-item.danger {
                                        color: #D93025;
                                      }

                                      .sb-item.danger:hover {
                                        background: #FEF2F2;
                                      }

                                      .badge-red {
                                        margin-left: auto;
                                        background: #D93025;
                                        color: #fff;
                                        font-size: 10px;
                                        font-weight: 700;
                                        padding: 2px 6px;
                                        border-radius: 4px;
                                      }

                                      .sb-footer {
                                        padding: 16px;
                                        border-top: 1px solid #E8E8ED;
                                      }

                                      .sb-logout {
                                        display: flex;
                                        align-items: center;
                                        gap: 8px;
                                        width: 100%;
                                        padding: 10px;
                                        background: none;
                                        border: none;
                                        border-radius: 6px;
                                        font-size: 13px;
                                        font-weight: 600;
                                        color: #86868B;
                                      }

                                      .sb-logout:hover {
                                        background: #FEF2F2;
                                        color: #D93025;
                                      }

                                      .main {
                                        flex: 1;
                                        display: flex;
                                        flex-direction: column;
                                        min-width: 0;
                                        height: 100vh;
                                      }

                                      .topbar {
                                        background: #fff;
                                        border-bottom: 1px solid #E8E8ED;
                                        padding: 0 32px;
                                        height: 60px;
                                        display: flex;
                                        align-items: center;
                                        flex-shrink: 0;
                                      }

                                      .tb-title {
                                        font-size: 16px;
                                        font-weight: 700;
                                      }

                                      .tb-sub {
                                        font-size: 13px;
                                        color: #86868B;
                                        margin-left: 12px;
                                        border-left: 1px solid #E8E8ED;
                                        padding-left: 12px;
                                      }

                                      .content {
                                        flex: 1;
                                        padding: 32px;
                                        overflow-y: auto;
                                        display: grid;
                                        grid-template-columns: 2fr 1fr;
                                        gap: 24px;
                                        align-items: start;
                                      }

                                      .panel {
                                        background: #fff;
                                        border: 1px solid #E8E8ED;
                                        border-radius: 8px;
                                        padding: 24px;
                                        margin-bottom: 24px;
                                      }

                                      .panel-hd {
                                        font-size: 13px;
                                        font-weight: 700;
                                        color: #86868B;
                                        text-transform: uppercase;
                                        letter-spacing: .05em;
                                        margin-bottom: 20px;
                                        display: flex;
                                        align-items: center;
                                        gap: 8px;
                                      }

                                      .panel-hd-split {
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        margin-bottom: 20px;
                                      }

                                      .panel-hd-split .panel-hd {
                                        margin-bottom: 0;
                                      }

                                      .btn-edit {
                                        font-size: 12px;
                                        padding: 6px 14px;
                                        background: #fff;
                                        color: #005B96;
                                        border: 1px solid #005B96;
                                        border-radius: 6px;
                                        font-weight: 600;
                                        text-transform: none;
                                        letter-spacing: normal;
                                        display: inline-flex;
                                        align-items: center;
                                        gap: 6px;
                                        text-decoration: none;
                                        transition: all .15s;
                                        white-space: nowrap;
                                      }

                                      .btn-edit:hover {
                                        background: #EBF5FF;
                                      }

                                      .alert-success {
                                        background: #D1FAE5;
                                        border: 1px solid #6EE7B7;
                                        color: #065F46;
                                        padding: 12px 16px;
                                        border-radius: 6px;
                                        font-size: 13px;
                                        font-weight: 600;
                                        margin-bottom: 16px;
                                      }

                                      .alert-error {
                                        background: #FEF2F2;
                                        border: 1px solid #FECACA;
                                        color: #D93025;
                                        padding: 12px 16px;
                                        border-radius: 6px;
                                        font-size: 13px;
                                        font-weight: 600;
                                        margin-bottom: 16px;
                                      }

                                      .field {
                                        margin-bottom: 16px;
                                      }

                                      .field label {
                                        display: block;
                                        font-size: 11px;
                                        font-weight: 700;
                                        color: #86868B;
                                        margin-bottom: 6px;
                                        text-transform: uppercase;
                                        letter-spacing: .05em;
                                      }

                                      .input-base {
                                        width: 100%;
                                        height: 40px;
                                        border: 1px solid #E8E8ED;
                                        border-radius: 6px;
                                        padding: 0 12px;
                                        font-size: 13px;
                                        font-family: inherit;
                                        color: #0A0A0A;
                                        outline: none;
                                        background: #fff;
                                      }

                                      .input-base:focus {
                                        border-color: #005B96;
                                        box-shadow: 0 0 0 3px #EBF5FF;
                                      }

                                      .btn-success {
                                        background: #1A7F4B;
                                        color: #fff;
                                        border: none;
                                        height: 40px;
                                        padding: 0 20px;
                                        border-radius: 6px;
                                        font-size: 13px;
                                        font-weight: 600;
                                      }

                                      /* MOBILE OVERRIDES */
                                      .m-header {
                                        display: none;
                                      }

                                      .m-sidebar {
                                        display: none;
                                      }

                                      @media(max-width:900px) {
                                        body {
                                          display: block !important;
                                          overflow: visible;
                                        }

                                        .m-header {
                                          width: 100%;
                                          box-sizing: border-box;
                                        }

                                        .sidebar {
                                          display: none !important;
                                        }

                                        .topbar {
                                          display: none !important;
                                        }

                                        .main {
                                          height: auto;
                                          min-height: 100vh;
                                          overflow: visible;
                                        }

                                        .content {
                                          padding: 16px;
                                          padding-bottom: 60px;
                                          grid-template-columns: 1fr !important;
                                          display: flex;
                                          flex-direction: column;
                                        }

                                        .panel {
                                          padding: 16px;
                                        }

                                        .m-header {
                                          display: flex;
                                          align-items: center;
                                          gap: 12px;
                                          height: 60px;
                                          background: #fff;
                                          border-bottom: 1px solid #E8E8ED;
                                          padding: 0 16px;
                                          position: sticky;
                                          top: 0;
                                          z-index: 2001;
                                        }

                                        .m-burger {
                                          width: 40px;
                                          height: 40px;
                                          display: flex;
                                          align-items: center;
                                          justify-content: center;
                                          background: #F5F5F7;
                                          border-radius: 8px;
                                          color: #1D1D1F;
                                        }

                                        .m-logo {
                                          font-size: 17px;
                                          font-weight: 700;
                                          letter-spacing: -.3px;
                                        }

                                        .m-logo span {
                                          color: #005B96;
                                        }

                                        .m-sidebar {
                                          display: flex;
                                          flex-direction: column;
                                          position: fixed;
                                          top: 0;
                                          left: -280px;
                                          width: 280px;
                                          height: 100vh;
                                          background: #fff;
                                          z-index: 2000;
                                          transition: .3s cubic-bezier(0.4, 0, 0.2, 1);
                                          visibility: hidden;
                                        }

                                        .m-sidebar.show {
                                          left: 0;
                                          visibility: visible;
                                          box-shadow: 20px 0 50px rgba(0, 0, 0, 0.15);
                                        }

                                        .m-overlay {
                                          display: none;
                                          position: fixed;
                                          top: 0;
                                          left: 0;
                                          right: 0;
                                          bottom: 0;
                                          background: rgba(0, 0, 0, 0.5);
                                          backdrop-filter: blur(2px);
                                          z-index: 1999;
                                        }

                                        .m-overlay.show {
                                          display: block;
                                        }
                                      }

                                      .chip {
                                        display: inline-block;
                                        padding: 4px 10px;
                                        background: #FEF2F2;
                                        color: #D93025;
                                        border-radius: 4px;
                                        font-size: 11px;
                                        font-weight: 700;
                                      }

                                      .ai-box {
                                        background: #F0FBFF;
                                        border: 1px solid #BAE6FD;
                                        border-radius: 8px;
                                        padding: 24px;
                                      }

                                      .ai-title {
                                        font-size: 14px;
                                        font-weight: 700;
                                        color: #005B96;
                                        display: flex;
                                        align-items: center;
                                        gap: 6px;
                                        margin-bottom: 16px;
                                      }

                                      .ai-row {
                                        display: flex;
                                        justify-content: space-between;
                                        font-size: 13px;
                                        margin-bottom: 12px;
                                        border-bottom: 1px dashed #BAE6FD;
                                        padding-bottom: 6px;
                                      }

                                      .ai-row span:last-child {
                                        font-weight: 600;
                                      }

                                      .btn-primary {
                                        background: #0A0A0A;
                                        color: #fff;
                                        border: none;
                                        height: 40px;
                                        padding: 0 20px;
                                        border-radius: 6px;
                                        font-size: 13px;
                                        font-weight: 600;
                                      }

                                      .activity-log {
                                        background: #fff;
                                        border: 1px solid #E8E8ED;
                                        border-radius: 8px;
                                        padding: 20px;
                                        margin-top: 20px;
                                      }

                                      .activity-log-title {
                                        font-size: 13px;
                                        font-weight: 700;
                                        color: #86868B;
                                        text-transform: uppercase;
                                        letter-spacing: .05em;
                                        margin-bottom: 16px;
                                        display: flex;
                                        align-items: center;
                                        gap: 8px;
                                      }

                                      .activity-scroll {
                                        max-height: 360px;
                                        overflow-y: auto;
                                        padding-right: 4px;
                                      }

                                      .activity-scroll::-webkit-scrollbar {
                                        width: 4px;
                                      }

                                      .activity-scroll::-webkit-scrollbar-track {
                                        background: #F5F5F7;
                                        border-radius: 2px;
                                      }

                                      .activity-scroll::-webkit-scrollbar-thumb {
                                        background: #C4C4C4;
                                        border-radius: 2px;
                                      }

                                      .activity-item {
                                        border-left: 3px solid #005B96;
                                        padding: 8px 0 8px 14px;
                                        margin-bottom: 14px;
                                        position: relative;
                                      }

                                      .activity-item:last-child {
                                        margin-bottom: 0;
                                      }

                                      .activity-meta {
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        margin-bottom: 4px;
                                      }

                                      .activity-badge {
                                        font-size: 10px;
                                        font-weight: 700;
                                        padding: 2px 8px;
                                        border-radius: 4px;
                                        display: inline-block;
                                      }

                                      .badge-assigned {
                                        background: #D5F9FF;
                                        color: #005B96;
                                      }

                                      .badge-resolved {
                                        background: #D1FAE5;
                                        color: #065F46;
                                      }

                                      .badge-pending {
                                        background: #FEF3C7;
                                        color: #B45309;
                                      }

                                      .badge-escalated {
                                        background: #FEF2F2;
                                        color: #D93025;
                                      }

                                      .badge-progress {
                                        background: #EDE9FE;
                                        color: #6D28D9;
                                      }

                                      .activity-time {
                                        font-size: 11px;
                                        color: #86868B;
                                      }

                                      .activity-comment {
                                        font-size: 12px;
                                        color: #4B5563;
                                        line-height: 1.5;
                                        margin-top: 4px;
                                      }

                                      .activity-user {
                                        font-size: 11px;
                                        color: #86868B;
                                        font-weight: 600;
                                      }
                                    </style>
                                  </head>

                                  <body>
                                    <aside class="sidebar">
                                      <div class="sb-brand">
                                        <div class="sb-logo">
                                          Civic<span>Sathy</span></div>
                                        <div class="sb-badge"><i data-lucide="shield-check"
                                            style="width:10px;height:10px;"></i>
                                          Admin Portal</div>
                                      </div>
                                      <nav class="sb-nav">
                                        <div class="sb-sec">Overview</div>
                                        <a class="sb-item"
                                          href="${pageContext.request.contextPath}/admin/dashboard-stats"><i
                                            data-lucide="layout-dashboard" style="width:18px;height:18px;"></i>
                                          Dashboard</a>
                                        <a class="sb-item" href="${pageContext.request.contextPath}/admin/complaints"><i
                                            data-lucide="list-checks" style="width:18px;height:18px;"></i>
                                          All Tickets</a>
                                        <div class="sb-sec">Management</div>
                                        <a class="sb-item" href="${pageContext.request.contextPath}/admin/tasks"><i
                                            data-lucide="clipboard-list" style="width:18px;height:18px;"></i>
                                          Assigned Tasks</a>
                                        <a class="sb-item danger"
                                          href="${pageContext.request.contextPath}/admin/escalations"><i
                                            data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i>
                                          Escalations <span class="badge-red">
                                            <%= new com.civicsathy.dao.ComplaintDAO().getEscalatedCount() %>
                                          </span></a>
                                        <div class="sb-sec">Analytics & Map
                                        </div>
                                        <a class="sb-item" href="${pageContext.request.contextPath}/admin/map-data"><i
                                            data-lucide="map" style="width:18px;height:18px;"></i>
                                          Ward Heatmap</a>
                                        <div class="sb-sec">Communications</div>
                                        <a class="sb-item" href="announcements.jsp"><i data-lucide="radio"
                                            style="width:18px;height:18px;"></i>
                                          Broadcast</a>
                                        <div class="sb-sec">System</div>
                                        <a class="sb-item" href="teams.jsp"><i data-lucide="users"
                                            style="width:18px;height:18px;"></i>
                                          Team Management</a>
                                        <a class="sb-item" href="settings.jsp"><i data-lucide="settings"
                                            style="width:18px;height:18px;"></i>
                                          Profile & Settings</a>
                                      </nav>
                                      <div class="sb-footer"><a href="${pageContext.request.contextPath}/logout"><button
                                            class="sb-logout"><i data-lucide="log-out"
                                              style="width:16px;height:16px;"></i>
                                            Sign Out</button></a></div>
                                    </aside>

                                    <!-- MOBILE HEADER -->
                                    <div class="m-header">
                                      <button class="m-burger" onclick="toggleMSB()"><i data-lucide="menu"
                                          style="width:20px;"></i></button>
                                      <div class="m-logo">Civic<span>Sathy</span>
                                      </div>
                                    </div>

                                    <!-- MOBILE SIDEBAR -->
                                    <div class="m-overlay" id="mOverlay" onclick="toggleMSB()"></div>
                                    <div class="m-sidebar" id="mSidebar">
                                      <div class="sb-brand">
                                        <div
                                          style="display:flex;align-items:center;justify-content:space-between;width:100%;">
                                          <div class="sb-logo">
                                            Civic<span>Sathy</span></div>
                                          <button onclick="toggleMSB()"
                                            style="background:none;border:none;color:#86868B;"><i data-lucide="x"
                                              style="width:20px;"></i></button>
                                        </div>
                                        <div class="sb-badge"><i data-lucide="shield-check"
                                            style="width:10px;height:10px;"></i>
                                          Admin Portal</div>
                                      </div>
                                      <nav class="sb-nav">
                                        <div class="sb-sec">Overview</div>
                                        <a class="sb-item"
                                          href="${pageContext.request.contextPath}/admin/dashboard-stats"><i
                                            data-lucide="layout-dashboard" style="width:18px;height:18px;"></i>
                                          Dashboard</a>
                                        <a class="sb-item active"
                                          href="${pageContext.request.contextPath}/admin/complaints"><i
                                            data-lucide="list-checks" style="width:18px;height:18px;"></i>
                                          All Tickets</a>
                                        <div class="sb-sec">Management</div>
                                        <a class="sb-item" href="${pageContext.request.contextPath}/admin/tasks"><i
                                            data-lucide="clipboard-list" style="width:18px;height:18px;"></i>
                                          Assigned Tasks</a>
                                        <a class="sb-item danger"
                                          href="${pageContext.request.contextPath}/admin/escalations"><i
                                            data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i>
                                          Escalations</a>
                                        <div class="sb-sec">Analytics & Map
                                        </div>
                                        <a class="sb-item" href="${pageContext.request.contextPath}/admin/map-data"><i
                                            data-lucide="map" style="width:18px;height:18px;"></i>
                                          Ward Heatmap</a>
                                        <div class="sb-sec">System</div>
                                        <a class="sb-item" href="settings.jsp"><i data-lucide="settings"
                                            style="width:18px;height:18px;"></i>
                                          Settings</a>
                                      </nav>
                                      <div class="sb-footer"><a href="${pageContext.request.contextPath}/logout"><button
                                            class="sb-logout"><i data-lucide="log-out"
                                              style="width:16px;height:16px;"></i>
                                            Sign Out</button></a></div>
                                    </div>

                                    <div class="main">
                                      <header class="topbar"><span class="tb-title">Ticket #<%=
                                            complaint.getTrackingId() %>
                                        </span><span class="tb-sub">
                                          <%= complaint.getTitle() %>
                                        </span></header>
                                      <div class="content">
                                        <div>
                                          <% String successMsg=request.getParameter("success"); %>
                                            <% String errorMsg=request.getParameter("error"); %>
                                              <% if (successMsg !=null) { %>
                                                <div class="alert-success">
                                                  <%= successMsg %>
                                                </div>
                                                <% } %>
                                                  <% if (errorMsg !=null) { %>
                                                    <div class="alert-error">
                                                      <%= errorMsg %>
                                                    </div>
                                                    <% } %>
                                                      <div class="panel">
                                                        <div class="panel-hd">
                                                          <i data-lucide="file-text" style="width:16px;"></i>
                                                          Complaint
                                                          Details
                                                        </div>
                                                        <p style="font-size:14px;line-height:1.6;margin-bottom:24px;">
                                                          "<%= complaint.getDescription() %>
                                                            "
                                                        </p>

                                                        <% if (complaint.getImagePath() !=null &&
                                                          !complaint.getImagePath().isEmpty()) { %>
                                                          <div style="margin-bottom:24px;">
                                                            <div
                                                              style="font-size:11px;color:#86868B;font-weight:700;margin-bottom:8px;">
                                                              IMAGE
                                                              EVIDENCE
                                                            </div>
                                                            <img
                                                              src="${pageContext.request.contextPath}/uploads/<%= complaint.getImagePath() %>"
                                                              alt="Complaint Image"
                                                              style="max-width:100%;max-height:300px;border-radius:8px;border:1px solid #E8E8ED;object-fit:cover;">
                                                          </div>
                                                          <% } %>

                                                            <div style="display:flex;gap:24px;flex-wrap:wrap;">
                                                              <div>
                                                                <div
                                                                  style="font-size:11px;color:#86868B;font-weight:700;">
                                                                  REPORTED
                                                                  BY
                                                                </div>
                                                                <div style="font-size:14px;font-weight:600;">
                                                                  <%= complaint.getIsAnonymous() ? "Anonymous Citizen" :
                                                                    (complaint.getUserName() !=null ?
                                                                    complaint.getUserName() : "Citizen" ) %>
                                                                </div>
                                                              </div>
                                                              <div>
                                                                <div
                                                                  style="font-size:11px;color:#86868B;font-weight:700;">
                                                                  WARD
                                                                </div>
                                                                <div style="font-size:14px;font-weight:600;">
                                                                  Ward
                                                                  <%= complaint.getWardNo() %>
                                                                </div>
                                                              </div>
                                                              <div>
                                                                <div
                                                                  style="font-size:11px;color:#86868B;font-weight:700;">
                                                                  CATEGORY
                                                                </div>
                                                                <div style="font-size:14px;font-weight:600;">
                                                                  <%= complaint.getCategoryName() %>
                                                                </div>
                                                              </div>
                                                              <div>
                                                                <div
                                                                  style="font-size:11px;color:#86868B;font-weight:700;">
                                                                  STATUS
                                                                </div>
                                                                <div class="chip">
                                                                  <%= complaint.getStatus() %>
                                                                </div>
                                                              </div>
                                                              <div>
                                                                <div
                                                                  style="font-size:11px;color:#86868B;font-weight:700;">
                                                                  AFFECTED
                                                                </div>
                                                                <div style="font-size:14px;font-weight:600;">
                                                                  <%= complaint.getAffectedCount() %>
                                                                </div>
                                                              </div>
                                                            </div>

                                                            <div
                                                              style="margin-top:24px;background:#F5F5F7;padding:12px;border-radius:6px;">
                                                              <div
                                                                style="font-size:11px;color:#86868B;font-weight:700;margin-bottom:4px;">
                                                                LOCATION
                                                              </div>
                                                              <div
                                                                style="font-size:13px;font-weight:600;margin-bottom:4px;">
                                                                <%= complaint.getLocationText() !=null ?
                                                                  complaint.getLocationText() : "Not specified" %>
                                                              </div>
                                                              <div
                                                                style="font-size:12px;color:#4B5563;margin-bottom:12px;">
                                                                Coordinates:
                                                                <%= complaint.getLatitude() %>
                                                                  ,
                                                                  <%= complaint.getLongitude() %>
                                                              </div>
                                                              <% if (complaint.getLatitude() !=0 &&
                                                                complaint.getLongitude() !=0) { %>
                                                                <div id="ticketMap"
                                                                  style="height:220px;border-radius:6px;border:1px solid #E8E8ED;">
                                                                </div>
                                                                <script>
                                                                  document.addEventListener('DOMContentLoaded', function () {
                                                                    var lat = <%= complaint.getLatitude() %>;
                                                                    var lng = <%= complaint.getLongitude() %>;
                                                                    var map = L.map('ticketMap').setView([lat, lng], 16);
                                                                    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                                                                      maxZoom: 19,
                                                                      attribution: '&copy; OpenStreetMap'
                                                                    }).addTo(map);
                                                                    L.marker([lat, lng]).addTo(map)
                                                                      .bindPopup('<b><%= complaint.getTitle().replace("'", "\\'" ) %></b><br><%= complaint.getLocationText() != null ? complaint.getLocationText().replace("'", "\\'" ) : "" %>')
                                                                      .openPopup();
                                                                    L.circle([lat, lng], { radius: 80, color: '#D93025', fillColor: '#D93025', fillOpacity: 0.15 }).addTo(map);
                                                                    setTimeout(function () { map.invalidateSize(); }, 300);
                                                                  });
                                                                </script>
                                                                <% } %>
                                                            </div>
                                                      </div>

                                                      <% boolean isEditMode="true"
                                                        .equals(request.getParameter("edit")); %>
                                                        <div class="panel">
                                                          <% if (existingTask !=null && !isEditMode) { %>
                                                            <div class="panel-hd-split">
                                                              <div class="panel-hd">
                                                                <i data-lucide="calendar-check" style="width:16px;"></i>
                                                                Assigned
                                                                Task
                                                                Summary
                                                              </div>
                                                              <a href="?id=<%= complaint.getId() %>&edit=true"
                                                                class="btn-edit"><i data-lucide="pencil"
                                                                  style="width:12px;"></i>
                                                                Edit
                                                                Assignment</a>
                                                            </div>
                                                            <p style="font-size:12px;color:#86868B;margin-bottom:16px;">
                                                              This
                                                              ticket
                                                              has
                                                              already
                                                              been
                                                              assigned.
                                                              View
                                                              details
                                                              below.
                                                            </p>

                                                            <div
                                                              style="background:#F0FBFF;border:1px solid #BAE6FD;padding:16px;border-radius:6px;margin-bottom:16px;">
                                                              <div
                                                                style="display:flex;justify-content:space-between;margin-bottom:12px;">
                                                                <div>
                                                                  <div
                                                                    style="font-size:11px;color:#86868B;font-weight:700;">
                                                                    DATE
                                                                  </div>
                                                                  <div style="font-weight:600;">
                                                                    <%= existingTask.getAssignedDate() %>
                                                                  </div>
                                                                </div>
                                                                <div>
                                                                  <div
                                                                    style="font-size:11px;color:#86868B;font-weight:700;">
                                                                    TIME
                                                                  </div>
                                                                  <div style="font-weight:600;">
                                                                    <%= existingTask.getAssignedTime() %>
                                                                  </div>
                                                                </div>
                                                                <div>
                                                                  <div
                                                                    style="font-size:11px;color:#86868B;font-weight:700;">
                                                                    STATUS
                                                                  </div>
                                                                  <span style="font-weight:700;color:#005B96;">
                                                                    <%= existingTask.getStatus() %>
                                                                  </span>
                                                                </div>
                                                              </div>
                                                              <hr
                                                                style="border:0;border-top:1px solid #E8E8ED;margin:12px 0;">
                                                              <div style="margin-bottom:8px;">
                                                                <div
                                                                  style="font-size:11px;color:#86868B;font-weight:700;">
                                                                  DEPLOYED
                                                                  TEAMS
                                                                </div>
                                                                <div style="font-size:13px;font-weight:500;">
                                                                  <%= existingTask.getDisplayTeams() !=null ?
                                                                    existingTask.getDisplayTeams() : "None" %>
                                                                </div>
                                                              </div>
                                                              <div>
                                                                <div
                                                                  style="font-size:11px;color:#86868B;font-weight:700;">
                                                                  DEPLOYED
                                                                  VEHICLES
                                                                </div>
                                                                <div style="font-size:13px;font-weight:500;">
                                                                  <%= existingTask.getDisplayVehicles() !=null ?
                                                                    existingTask.getDisplayVehicles() : "None" %>
                                                                </div>
                                                              </div>
                                                            </div>

                                                            <% } else { %>
                                                              <form id="manualAssignForm"
                                                                action="${pageContext.request.contextPath}/admin/assign-task"
                                                                method="post">
                                                                <div class="panel-hd">
                                                                  <i data-lucide="calendar" style="width:16px;"></i>
                                                                  Manual
                                                                  Task
                                                                  Assignment
                                                                </div>
                                                                <p
                                                                  style="font-size:12px;color:#86868B;margin-bottom:16px;">
                                                                  Schedule
                                                                  and
                                                                  deploy
                                                                  field
                                                                  personnel
                                                                  and
                                                                  vehicles
                                                                  to
                                                                  resolve
                                                                  this
                                                                  complaint.
                                                                </p>
                                                                <input type="hidden" name="ticketId"
                                                                  value="<%= complaint.getId() %>">

                                                                <div style="display:flex;gap:16px;margin-bottom:16px;">
                                                                  <div class="field" style="flex:1;">
                                                                    <label>Severity</label>
                                                                    <select name="severity" id="formSeverity"
                                                                      class="input-base"
                                                                      style="width:100%;height:40px;padding:0 12px;"
                                                                      required>
                                                                      <option value="">
                                                                        Select
                                                                        Severity...
                                                                      </option>
                                                                      <option value="LOW">
                                                                        LOW
                                                                      </option>
                                                                      <option value="MEDIUM">
                                                                        MEDIUM
                                                                      </option>
                                                                      <option value="HIGH">
                                                                        HIGH
                                                                      </option>
                                                                      <option value="CRITICAL">
                                                                        CRITICAL
                                                                      </option>
                                                                    </select>
                                                                  </div>
                                                                </div>

                                                                <div style="display:flex;gap:16px;margin-bottom:16px;">
                                                                  <div class="field" style="flex:1;">
                                                                    <label>Assigned
                                                                      Date</label>
                                                                    <input type="date" name="assignedDate"
                                                                      class="input-base" required>
                                                                  </div>
                                                                  <div class="field" style="flex:1;">
                                                                    <label>Assigned
                                                                      Time</label>
                                                                    <input type="time" name="assignedTime"
                                                                      class="input-base" required>
                                                                  </div>
                                                                </div>

                                                                <div class="field" style="margin-bottom:16px;">
                                                                  <label>Equipment
                                                                    <span style="color:#86868B;font-weight:400;">(comma
                                                                      separated)</span></label>
                                                                  <input type="text" name="equipment" id="formEquipment"
                                                                    class="input-base"
                                                                    placeholder="e.g. Excavator, Road Roller, Traffic Cones"
                                                                    style="width:100%;">
                                                                </div>

                                                                <div
                                                                  style="border:1px solid #E8E8ED;padding:12px;border-radius:6px;margin-bottom:16px;">
                                                                  <label
                                                                    style="font-weight:600;display:block;margin-bottom:8px;">Vehicles
                                                                    &
                                                                    Equipment</label>
                                                                  <div id="vehicleContainer">
                                                                    <div
                                                                      style="display:flex;gap:16px;margin-bottom:8px;"
                                                                      class="veh-row">
                                                                      <select name="vehicleIds[]" id="formVehicle"
                                                                        class="input-base" style="flex:2;">
                                                                        <option value="">
                                                                          Select
                                                                          Vehicle...
                                                                        </option>
                                                                        <% if (availVehicles !=null) { for (Vehicle v :
                                                                          availVehicles) { %>
                                                                          <option value="<%= v.getId() %>"
                                                                            data-name="<%= v.getVehicleName() %>">
                                                                            <%= v.getVehicleName() %>
                                                                              (Avail:
                                                                              <%= v.getAvailableCount() %>
                                                                                )
                                                                          </option>
                                                                          <% } } %>
                                                                      </select>
                                                                      <input type="number" name="vehicleCounts[]"
                                                                        id="formVehicleCount" class="input-base" min="1"
                                                                        placeholder="Qty" style="flex:1;">
                                                                    </div>
                                                                  </div>
                                                                  <button type="button" onclick="addVehicleRow()"
                                                                    style="background:none;border:none;color:#005B96;font-size:12px;font-weight:600;">+
                                                                    Add
                                                                    Another
                                                                    Vehicle</button>
                                                                </div>

                                                                <div
                                                                  style="border:1px solid #E8E8ED;padding:12px;border-radius:6px;margin-bottom:16px;">
                                                                  <label
                                                                    style="font-weight:600;display:block;margin-bottom:8px;">Teams
                                                                    &
                                                                    Personnel</label>
                                                                  <div id="teamContainer">
                                                                    <div
                                                                      style="display:flex;gap:16px;margin-bottom:8px;"
                                                                      class="team-row">
                                                                      <select name="teamIds[]" id="formTeam"
                                                                        class="input-base" style="flex:2;">
                                                                        <option value="">
                                                                          Select
                                                                          Team...
                                                                        </option>
                                                                        <% if (availTeams !=null) { for (Team tm :
                                                                          availTeams) { %>
                                                                          <option value="<%= tm.getId() %>"
                                                                            data-name="<%= tm.getTeamName() %>">
                                                                            <%= tm.getTeamName() %>
                                                                              (Avail:
                                                                              <%= tm.getAvailableCount() %>
                                                                                )
                                                                          </option>
                                                                          <% } } %>
                                                                      </select>
                                                                      <input type="number" name="teamCounts[]"
                                                                        id="formTeamCount" class="input-base" min="1"
                                                                        placeholder="Personnel Qty" style="flex:1;">
                                                                    </div>
                                                                  </div>
                                                                  <button type="button" onclick="addTeamRow()"
                                                                    style="background:none;border:none;color:#005B96;font-size:12px;font-weight:600;">+
                                                                    Add
                                                                    Another
                                                                    Team</button>
                                                                </div>

                                                                <button type="submit" class="btn-primary"
                                                                  style="margin-top:8px;">Assign
                                                                  Task
                                                                  &
                                                                  Deploy
                                                                  Team</button>
                                                              </form>

                                                              <script>
                                                                function addVehicleRow() {
                                                                  var container = document.getElementById('vehicleContainer');
                                                                  var clone = container.children[0].cloneNode(true);
                                                                  clone.querySelector('select').value = '';
                                                                  clone.querySelector('input').value = '';
                                                                  container.appendChild(clone);
                                                                }
                                                                function addTeamRow() {
                                                                  var container = document.getElementById('teamContainer');
                                                                  var clone = container.children[0].cloneNode(true);
                                                                  clone.querySelector('select').value = '';
                                                                  clone.querySelector('input').value = '';
                                                                  container.appendChild(clone);
                                                                }
                                                              </script>
                                                              <% } %>
                                                        </div>

                                                        <div class="panel" id="statusSection">
                                                          <form
                                                            action="${pageContext.request.contextPath}/admin/update-ticket"
                                                            method="post">
                                                            <div class="panel-hd">
                                                              <i data-lucide="check-circle" style="width:16px;"></i>
                                                              Update
                                                              Status
                                                              &
                                                              Report
                                                            </div>
                                                            <input type="hidden" name="ticketId"
                                                              value="<%= complaint.getId() %>">

                                                            <div style="display:flex;gap:16px;margin-bottom:16px;">
                                                              <div class="field" style="flex:1;margin-bottom:0;">
                                                                <label>New
                                                                  Status</label>
                                                                <select name="status" class="input-base"
                                                                  style="width:100%;height:40px;padding:0 12px;">
                                                                  <option value="PENDING" <%="PENDING"
                                                                    .equalsIgnoreCase(complaint.getStatus())
                                                                    ? "selected" : "" %>
                                                                    >Pending
                                                                  </option>
                                                                  <option value="In Progress" <%="In Progress"
                                                                    .equalsIgnoreCase(complaint.getStatus())
                                                                    || "IN_PROGRESS"
                                                                    .equalsIgnoreCase(complaint.getStatus())
                                                                    ? "selected" : "" %>
                                                                    >In
                                                                    Progress
                                                                  </option>
                                                                  <option value="Resolved" <%="Resolved"
                                                                    .equalsIgnoreCase(complaint.getStatus())
                                                                    || "RESOLVED"
                                                                    .equalsIgnoreCase(complaint.getStatus())
                                                                    ? "selected" : "" %>
                                                                    >Resolved
                                                                  </option>
                                                                  <option value="Escalated" <%="Escalated"
                                                                    .equalsIgnoreCase(complaint.getStatus())
                                                                    || "ESCALATED"
                                                                    .equalsIgnoreCase(complaint.getStatus())
                                                                    ? "selected" : "" %>
                                                                    >Escalated
                                                                  </option>
                                                                </select>
                                                              </div>
                                                            </div>

                                                            <div class="field">
                                                              <label>Admin
                                                                Comment
                                                                /
                                                                Status
                                                                Update
                                                                Reason</label><textarea name="comment"
                                                                class="input-base"
                                                                style="height:80px;padding:12px;resize:vertical;"
                                                                placeholder="Describe work done or reason for status change..."></textarea>
                                                            </div>

                                                            <div id="resolutionFields"
                                                              style="display:none;margin-top:16px;padding:16px;background:#F9FAFB;border-radius:8px;border:1px solid #E8E8ED;">
                                                              <div
                                                                style="font-size:12px;font-weight:700;color:#005B96;margin-bottom:12px;text-transform:uppercase;letter-spacing:.05em;">
                                                                Resolution
                                                                Report
                                                                Details
                                                              </div>
                                                              <div class="field">
                                                                <label>Final
                                                                  Work
                                                                  Summary</label><textarea name="workDone"
                                                                  class="input-base" style="height:60px;"></textarea>
                                                              </div>
                                                              <div style="display:flex;gap:12px;">
                                                                <div class="field" style="flex:1;">
                                                                  <label>Hours
                                                                    Taken</label><input type="number" step="0.1"
                                                                    name="hoursTaken" id="hoursTaken" class="input-base"
                                                                    placeholder="0.0">
                                                                </div>
                                                                <div class="field" style="flex:1;">
                                                                  <label>Total
                                                                    Cost
                                                                    (NPR)</label><input type="number"
                                                                    name="costEstimate" class="input-base"
                                                                    placeholder="Optional">
                                                                </div>
                                                              </div>
                                                              <div class="field">
                                                                <label>Team
                                                                  Deployed</label>
                                                                <input type="text" name="teamDeployed"
                                                                  class="input-base"
                                                                  value="<%= existingTask != null ? existingTask.getDisplayTeams() : "" %>">
                                                              </div>
                                                            </div>

                                                            <button type="submit" class="btn-success"
                                                              style="width:100%;margin-top:12px;">Save
                                                              Changes
                                                              &
                                                              Update
                                                              Ticket</button>

                                                            <% if (resolutionReport !=null) { %>
                                                              <div
                                                                style="margin-top:16px;padding:12px;border:1px solid #D1FAE5;background:#ECFDF5;border-radius:8px;display:flex;align-items:center;justify-content:space-between;">
                                                                <div
                                                                  style="font-size:12px;color:#065F46;font-weight:600;">
                                                                  Resolution
                                                                  report
                                                                  is
                                                                  available
                                                                  for
                                                                  this
                                                                  ticket.
                                                                </div>
                                                                <a href="${pageContext.request.contextPath}/download-issue-report?id=<%= complaint.getId() %>"
                                                                  class="btn-sm"
                                                                  style="background:#065F46;color:#fff;border:none;"><i
                                                                    data-lucide="download" style="width:14px;"></i>
                                                                  Download
                                                                  PDF</a>
                                                              </div>
                                                              <% } %>
                                                          </form>
                                                          <script>
                                                            document.querySelector('select[name="status"]').addEventListener('change', function () {
                                                              var resFields = document.getElementById('resolutionFields');
                                                              if (this.value.toLowerCase() === 'resolved') {
                                                                resFields.style.display = 'block';
                                                                var startTime = <%= inProgressTime %>;
                                                                if (startTime > 0) {
                                                                  var now = Date.now();
                                                                  var hrs = (now - startTime) / (1000 * 60 * 60);
                                                                  document.getElementById('hoursTaken').value = Math.max(0.1, hrs.toFixed(1));
                                                                }
                                                              } else {
                                                                resFields.style.display = 'none';
                                                              }
                                                            });
                                                          </script>
                                                        </div>
                                        </div>
                                        <div>
                                          <div class="ai-box" id="aiBox">
                                            <div class="ai-title"><i data-lucide="sparkles" style="width:18px;"></i>
                                              AI Recommendation</div>
                                            <div id="aiContent">
                                              <% if (complaint.getAiSeverity() !=null &&
                                                !complaint.getAiSeverity().isEmpty()) { %>
                                                <div class="ai-row">
                                                  <span>Team</span><span id="aiTeam">
                                                    <%= complaint.getAiTeamSuggestion() %>
                                                  </span>
                                                </div>
                                                <div class="ai-row">
                                                  <span>Size</span><span id="aiSize">
                                                    <%= complaint.getAiTeamSize() %> Members
                                                  </span>
                                                </div>
                                                <div class="ai-row">
                                                  <span>Equipment</span><span id="aiEquip">
                                                    <%= complaint.getAiEquipment() %>
                                                  </span>
                                                </div>
                                                <div class="ai-row">
                                                  <span>Severity</span><span id="aiSev"
                                                    style="color:#D93025;font-weight:700;">
                                                    <%= complaint.getAiSeverity() %>
                                                  </span>
                                                </div>

                                                <button type="button" class="btn-primary"
                                                  style="width:100%;margin-top:20px;"
                                                  onclick="approveAi('<%= complaint.getAiSeverity() %>', '<%= complaint.getAiTeamSuggestion() %>', '<%= complaint.getAiEquipment() != null ? complaint.getAiEquipment().replace("'", "") : "" %>'
                                                  , '<%= complaint.getAiTeamSize() %>' )">Approve</button>
                                                <button type="button" onclick="runAiAnalysis()"
                                                  style="background:none;border:none;color:#005B96;font-size:12px;font-weight:600;cursor:pointer;width:100%;text-align:center;margin-top:12px;">Re-analyze
                                                  with AI</button>
                                                <% } else { %>
                                                  <div
                                                    style="font-size:13px;color:#86868B;padding:10px 0;text-align:center;">
                                                    No AI analysis
                                                    available for
                                                    this ticket.
                                                  </div>
                                                  <button type="button" onclick="runAiAnalysis()" class="btn-primary"
                                                    style="width:100%;display:inline-flex;align-items:center;justify-content:center;gap:8px;margin-top:8px;"><i
                                                      data-lucide="bot" style="width:16px;"></i>
                                                    Assigned by
                                                    Ai</button>
                                                  <% } %>
                                            </div>
                                            <!-- Loading state (hidden by default) -->
                                            <div id="aiLoading"
                                              style="display:none;text-align:center;padding:30px 10px;">
                                              <div
                                                style="display:inline-block;width:32px;height:32px;border:3px solid #E8E8ED;border-top:3px solid #005B96;border-radius:50%;animation:spin 1s linear infinite;">
                                              </div>
                                              <div
                                                style="margin-top:12px;font-size:13px;color:#86868B;font-weight:600;">
                                                Scanning complaint &
                                                image with AI...</div>
                                              <div style="margin-top:4px;font-size:11px;color:#86868B;">
                                                This may take a few
                                                seconds</div>
                                            </div>
                                            <style>
                                              @keyframes spin {
                                                0% {
                                                  transform: rotate(0deg);
                                                }

                                                100% {
                                                  transform: rotate(360deg);
                                                }
                                              }
                                            </style>
                                            <script>
                                              function approveAi(severity, teamName, equipment, teamSize, vehicleName, vehicleCount) {
                                                var sevEl = document.getElementById('formSeverity');
                                                if (sevEl) { for (var i = 0; i < sevEl.options.length; i++) { if (sevEl.options[i].value === severity) { sevEl.selectedIndex = i; break; } } }
                                                var eqEl = document.getElementById('formEquipment');
                                                if (eqEl) eqEl.value = equipment || '';
                                                var teamEl = document.getElementById('formTeam');
                                                if (teamEl) {
                                                  for (var i = 0; i < teamEl.options.length; i++) {
                                                    var dn = teamEl.options[i].getAttribute('data-name');
                                                    if (dn && dn.toLowerCase().indexOf(teamName.toLowerCase()) !== -1) { teamEl.selectedIndex = i; break; }
                                                  }
                                                }
                                                var tcEl = document.getElementById('formTeamCount');
                                                if (tcEl) tcEl.value = teamSize || '';

                                                var vehEl = document.getElementById('formVehicle');
                                                if (vehEl && vehicleName && vehicleName !== 'None') {
                                                  for (var i = 0; i < vehEl.options.length; i++) {
                                                    var dn = vehEl.options[i].getAttribute('data-name');
                                                    if (dn && dn.toLowerCase().indexOf(vehicleName.toLowerCase()) !== -1) { vehEl.selectedIndex = i; break; }
                                                  }
                                                }
                                                var vcEl = document.getElementById('formVehicleCount');
                                                if (vcEl && vehicleName && vehicleName !== 'None') vcEl.value = vehicleCount || '';

                                                var form = document.getElementById('manualAssignForm');
                                                if (form) form.scrollIntoView({ behavior: 'smooth' });
                                              }

                                              function runAiAnalysis() {
                                                document.getElementById('aiContent').style.display = 'none';
                                                document.getElementById('aiLoading').style.display = 'block';

                                                fetch('${pageContext.request.contextPath}/admin/analyze-ai', {
                                                  method: 'POST',
                                                  headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                                  body: 'ticketId=<%= complaint.getId() %>&ajax=true'
                                                })
                                                  .then(function (resp) { return resp.json(); })
                                                  .then(function (data) {
                                                    document.getElementById('aiLoading').style.display = 'none';
                                                    if (data.status === 'success') {
                                                      var sevColor = '#B45309';
                                                      if (data.severity === 'HIGH' || data.severity === 'CRITICAL') sevColor = '#D93025';
                                                      else if (data.severity === 'LOW') sevColor = '#1A7F4B';
                                                      var eq = (data.equipment || '').replace(/'/g, '');
                                                      var tn = (data.team_suggestion || '').replace(/'/g, '');
                                                      var vn = (data.vehicle_suggestion || '').replace(/'/g, '');

                                                      var vehDisplay = data.vehicle_suggestion;
                                                      if (data.vehicle_suggestion && data.vehicle_suggestion !== 'None') {
                                                        vehDisplay += ' (' + data.vehicle_count + ')';
                                                      }

                                                      var html = '<div class="ai-row"><span>Team</span><span>' + data.team_suggestion + ' (' + data.team_size + ' members)</span></div>'
                                                        + '<div class="ai-row"><span>Vehicle</span><span>' + vehDisplay + '</span></div>'
                                                        + '<div class="ai-row"><span>Equipment</span><span>' + data.equipment + '</span></div>'
                                                        + '<div class="ai-row"><span>Severity</span><span style="color:' + sevColor + ';font-weight:700;">' + data.severity + '</span></div>'
                                                        + '<button type="button" class="btn-primary" style="width:100%;margin-top:20px;" onclick="approveAi(\'' + data.severity + '\', \'' + tn + '\', \'' + eq + '\', \'' + data.team_size + '\', \'' + vn + '\', \'' + data.vehicle_count + '\')">Approve</button>'
                                                        + '<button type="button" onclick="runAiAnalysis()" style="background:none;border:none;color:#005B96;font-size:12px;font-weight:600;cursor:pointer;width:100%;text-align:center;margin-top:12px;">Re-analyze with AI</button>';

                                                      document.getElementById('aiContent').innerHTML = html;
                                                      document.getElementById('aiContent').style.display = 'block';
                                                      lucide.createIcons();
                                                    } else {
                                                      document.getElementById('aiContent').innerHTML = '<div style="color:#D93025;font-size:13px;padding:10px 0;text-align:center;">' + (data.message || 'AI Analysis Failed') + '</div>'
                                                        + '<button type="button" onclick="runAiAnalysis()" class="btn-primary" style="width:100%;margin-top:8px;display:inline-flex;align-items:center;justify-content:center;gap:8px;"><i data-lucide="bot" style="width:16px;"></i> Try Again</button>';
                                                      document.getElementById('aiContent').style.display = 'block';
                                                      lucide.createIcons();
                                                    }
                                                  })
                                                  .catch(function (err) {
                                                    document.getElementById('aiLoading').style.display = 'none';
                                                    document.getElementById('aiContent').innerHTML = '<div style="color:#D93025;font-size:13px;padding:10px 0;text-align:center;">Network error. Please try again.</div>'
                                                      + '<button type="button" onclick="runAiAnalysis()" class="btn-primary" style="width:100%;margin-top:8px;display:inline-flex;align-items:center;justify-content:center;gap:8px;"><i data-lucide="bot" style="width:16px;"></i> Try Again</button>';
                                                    document.getElementById('aiContent').style.display = 'block';
                                                    lucide.createIcons();
                                                  });
                                              }
                                            </script>
                                          </div>

                                          <div class="activity-log">
                                            <div class="activity-log-title">
                                              <i data-lucide="message-square" style="width:16px;"></i>
                                              Admin Activity Log
                                            </div>
                                            <% if (statusHistory !=null && !statusHistory.isEmpty()) { %>
                                              <div class="activity-scroll">
                                                <% SimpleDateFormat sdf=new SimpleDateFormat("MMM dd, yyyy hh:mm a"); %>
                                                  <% for (StatusHistory sh : statusHistory) { String
                                                    badgeClass="badge-pending" ; String ns=sh.getNewStatus() !=null ?
                                                    sh.getNewStatus().toUpperCase() : "" ; if (ns.contains("ASSIGNED"))
                                                    badgeClass="badge-assigned" ; else if (ns.contains("RESOLVED"))
                                                    badgeClass="badge-resolved" ; else if (ns.contains("PROGRESS"))
                                                    badgeClass="badge-progress" ; else if (ns.contains("ESCALATED"))
                                                    badgeClass="badge-escalated" ; %>
                                                    <div class="activity-item">
                                                      <div class="activity-meta">
                                                        <span class="activity-badge <%= badgeClass %>">
                                                          <%= sh.getNewStatus() %>
                                                        </span>
                                                        <span class="activity-time">
                                                          <%= sh.getCreatedAt() !=null ? sdf.format(sh.getCreatedAt())
                                                            : "" %>
                                                        </span>
                                                      </div>
                                                      <% if (sh.getComment() !=null && !sh.getComment().isEmpty()) { %>
                                                        <div class="activity-comment">
                                                          <%= sh.getComment() %>
                                                        </div>
                                                        <% } %>
                                                          <div class="activity-user">
                                                            by
                                                            <%= sh.getChangedByName() !=null ? sh.getChangedByName()
                                                              : "System" %>
                                                          </div>
                                                    </div>
                                                    <% } %>
                                              </div>
                                              <% } else { %>
                                                <div
                                                  style="font-size:13px;color:#86868B;padding:10px 0;text-align:center;">
                                                  No activity recorded
                                                  yet.</div>
                                                <% } %>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                    <script>
                                      lucide.createIcons();

                                      function toggleMSB() {
                                        document.getElementById('mSidebar').classList.toggle('show');
                                        document.getElementById('mOverlay').classList.toggle('show');
                                      }
                                    </script>
                                  </body>

                                  </html>