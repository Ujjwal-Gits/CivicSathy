<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>CivicSathy - All Tickets</title>
    <link
      href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap"
      rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
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

      .content {
        flex: 1;
        padding: 32px;
        overflow-y: auto;
      }

      .filter-bar {
        display: flex;
        gap: 12px;
        margin-bottom: 20px;
        flex-wrap: wrap;
      }

      .f-ctrl {
        height: 40px;
        border: 1px solid #E8E8ED;
        border-radius: 6px;
        padding: 0 12px;
        font-size: 13px;
        outline: none;
        background: #fff;
        font-family: inherit;
      }

      .f-ctrl:focus {
        border-color: #005B96;
      }

      .table-wrap {
        background: #fff;
        border: 1px solid #E8E8ED;
        border-radius: 8px;
        overflow-x: auto;
      }

      table {
        width: 100%;
        border-collapse: collapse;
        min-width: 900px;
      }

      th,
      td {
        padding: 14px 16px;
        text-align: left;
        font-size: 13px;
        border-bottom: 1px solid #E8E8ED;
      }

      th {
        font-weight: 700;
        color: #86868B;
        text-transform: uppercase;
        font-size: 11px;
        letter-spacing: .05em;
        background: #FBFBFD;
      }

      tr:last-child td {
        border-bottom: none;
      }

      tr:hover {
        background: #F0FBFF;
      }

      .sev {
        display: inline-block;
        padding: 3px 8px;
        border-radius: 4px;
        font-size: 10px;
        font-weight: 700;
      }

      .s-high {
        background: #FEF2F2;
        color: #D93025;
      }

      .s-med {
        background: #FEF3C7;
        color: #B45309;
      }

      .s-low {
        background: #D1FAE5;
        color: #065F46;
      }

      .btn-view {
        padding: 6px 12px;
        background: #fff;
        border: 1px solid #E8E8ED;
        border-radius: 4px;
        font-size: 12px;
        font-weight: 600;
        color: #005B96;
        text-decoration: none;
      }

      .btn-view:hover {
        border-color: #005B96;
      }

      /* MOBILE OVERRIDES */
      .m-header {
        display: none;
      }

      .m-sidebar {
        display: none;
      }

      @media(max-width:768px) {
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
        }

        .filter-bar {
          flex-direction: column;
          gap: 8px;
        }

        .f-ctrl {
          width: 100% !important;
          min-width: 0 !important;
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
    </style>
  </head>

  <body>
    <aside class="sidebar">
      <div class="sb-brand">
        <div class="sb-logo">Civic<span>Sathy</span></div>
        <div class="sb-badge"><i data-lucide="shield-check" style="width:10px;height:10px;"></i> Admin Portal</div>
      </div>
      <nav class="sb-nav">
        <div class="sb-sec">Overview</div>
        <a class="sb-item" href="${pageContext.request.contextPath}/admin/dashboard-stats"><i
            data-lucide="layout-dashboard" style="width:18px;height:18px;"></i> Dashboard</a>
        <a class="sb-item active" href="${pageContext.request.contextPath}/admin/complaints"><i
            data-lucide="list-checks" style="width:18px;height:18px;"></i> All Tickets</a>
        <div class="sb-sec">Management</div>
        <a class="sb-item" href="${pageContext.request.contextPath}/admin/tasks"><i data-lucide="clipboard-list"
            style="width:18px;height:18px;"></i> Assigned Tasks</a>
        <a class="sb-item danger" href="${pageContext.request.contextPath}/admin/escalations"><i
            data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i> Escalations <span class="badge-red">
            <%= new com.civicsathy.dao.ComplaintDAO().getEscalatedCount() %>
          </span></a>
        <div class="sb-sec">Analytics & Map</div>
        <a class="sb-item" href="${pageContext.request.contextPath}/admin/map-data"><i data-lucide="map"
            style="width:18px;height:18px;"></i> Ward Heatmap</a>
        <div class="sb-sec">Communications</div>
        <a class="sb-item" href="announcements.jsp"><i data-lucide="radio" style="width:18px;height:18px;"></i>
          Broadcast</a>
        <div class="sb-sec">System</div>
        <a class="sb-item" href="teams.jsp"><i data-lucide="users" style="width:18px;height:18px;"></i> Team
          Management</a>
        <a class="sb-item" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i> Profile &
          Settings</a>
      </nav>
      <div class="sb-footer"><a href="${pageContext.request.contextPath}/logout"><button class="sb-logout"><i
              data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
    </aside>

    <!-- MOBILE HEADER -->
    <div class="m-header">
      <button class="m-burger" onclick="toggleMSB()"><i data-lucide="menu" style="width:20px;"></i></button>
      <div class="m-logo">Civic<span>Sathy</span></div>
    </div>

    <!-- MOBILE SIDEBAR -->
    <div class="m-overlay" id="mOverlay" onclick="toggleMSB()"></div>
    <div class="m-sidebar" id="mSidebar">
      <div class="sb-brand">
        <div style="display:flex;align-items:center;justify-content:space-between;width:100%;">
          <div class="sb-logo">Civic<span>Sathy</span></div>
          <button onclick="toggleMSB()" style="background:none;border:none;color:#86868B;"><i data-lucide="x"
              style="width:20px;"></i></button>
        </div>
        <div class="sb-badge"><i data-lucide="shield-check" style="width:10px;height:10px;"></i> Admin Portal</div>
      </div>
      <nav class="sb-nav">
        <div class="sb-sec">Overview</div>
        <a class="sb-item" href="${pageContext.request.contextPath}/admin/dashboard-stats"><i
            data-lucide="layout-dashboard" style="width:18px;height:18px;"></i> Dashboard</a>
        <a class="sb-item active" href="${pageContext.request.contextPath}/admin/complaints"><i
            data-lucide="list-checks" style="width:18px;height:18px;"></i> All Tickets</a>
        <div class="sb-sec">Management</div>
        <a class="sb-item" href="${pageContext.request.contextPath}/admin/tasks"><i data-lucide="clipboard-list"
            style="width:18px;height:18px;"></i> Assigned Tasks</a>
        <a class="sb-item danger" href="${pageContext.request.contextPath}/admin/escalations"><i
            data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i> Escalations</a>
        <div class="sb-sec">Analytics & Map</div>
        <a class="sb-item" href="${pageContext.request.contextPath}/admin/map-data"><i data-lucide="map"
            style="width:18px;height:18px;"></i> Ward Heatmap</a>
        <div class="sb-sec">System</div>
        <a class="sb-item" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i>
          Settings</a>
      </nav>
      <div class="sb-footer"><a href="${pageContext.request.contextPath}/logout"><button class="sb-logout"><i
              data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
    </div>

    <div class="main">
      <header class="topbar"><span class="tb-title">All Tickets & Complaints</span></header>
      <div class="content">
        <div class="filter-bar">
          <input type="text" id="searchInp" class="f-ctrl" placeholder="Search ID or Title..."
            style="flex:1;min-width:200px;">
          <select id="catFilter" onchange="filterTable()" class="f-ctrl">
            <option>All Categories</option>
            <option>Water Supply</option>
            <option>Roads & Potholes</option>
            <option>Waste Management</option>
            <option>Street Lights</option>
            <option>Public Health</option>
          </select>
          <select id="sevFilter" onchange="filterTable()" class="f-ctrl">
            <option>All Severities</option>
            <option>High</option>
            <option>Medium</option>
            <option>Low</option>
          </select>
          <select id="wardFilter" onchange="filterTable()" class="f-ctrl">
            <option>All Wards</option>
            <% for(int i=1; i<=20; i++) { %>
              <option>Ward <%= i %>
              </option>
              <% } %>
          </select>
          <select id="statFilter" onchange="filterTable()" class="f-ctrl">
            <option>Any Status</option>
            <option>Pending</option>
            <option>In Progress</option>
            <option>Resolved</option>
            <option>Escalated</option>
          </select>
        </div>
        <div class="table-wrap">
          <table id="complaintsTable">
            <thead>
              <tr>
                <th>Ticket ID</th>
                <th>Date</th>
                <th>Title</th>
                <th>Category</th>
                <th>Ward</th>
                <th>Severity</th>
                <th>Affected</th>
                <th>Status</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <% java.util.List<com.civicsathy.model.Complaint> list = (java.util.List<com.civicsathy.model.Complaint>)
                  request.getAttribute("complaints");
                  if (list != null) {
                  for (com.civicsathy.model.Complaint c : list) {
                  String sevClass = "s-low";
                  if ("High".equalsIgnoreCase(c.getSeverity())) sevClass = "s-high";
                  else if ("Medium".equalsIgnoreCase(c.getSeverity())) sevClass = "s-med";

                  String statColor = "#B45309"; // Pending
                  if ("Resolved".equalsIgnoreCase(c.getStatus())) statColor = "#1A7F4B";
                  else if ("In Progress".equalsIgnoreCase(c.getStatus())) statColor = "#005B96";
                  else if ("Escalated".equalsIgnoreCase(c.getStatus())) statColor = "#D93025";

                  String dateStr = new java.text.SimpleDateFormat("MMM dd, hh:mm a").format(c.getCreatedAt());
                  %>
                  <tr data-cat="<%= c.getCategoryName() %>" data-sev="<%= c.getSeverity() %>"
                    data-ward="Ward <%= c.getWardNo() %>" data-stat="<%= c.getStatus() %>">
                    <td><strong>#<%= c.getTrackingId() %></strong></td>
                    <td style="color:#86868B;">
                      <%= dateStr %>
                    </td>
                    <td class="t-title" style="font-weight:600;">
                      <%= c.getTitle() %>
                    </td>
                    <td>
                      <%= c.getCategoryName() %>
                    </td>
                    <td>
                      <%= c.getWardNo() %>
                    </td>
                    <td><span class="sev <%= sevClass %>">
                        <%= c.getSeverity() !=null ? c.getSeverity() : "N/A" %>
                      </span></td>
                    <td>
                      <%= c.getAffectedCount() %>
                    </td>
                    <td><span style="color:<%= statColor %>;font-weight:600;">
                        <%= c.getStatus() %>
                      </span></td>
                    <td><a href="ticket.jsp?id=<%= c.getId() %>" class="btn-view">Manage</a></td>
                  </tr>
                  <% } } else { %>
                    <tr>
                      <td colspan="9" style="text-align:center;padding:20px;color:#86868B;">No complaints found. <a
                          href="${pageContext.request.contextPath}/admin/complaints" style="color:#005B96;">Load
                          Data</a></td>
                    </tr>
                    <% } %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <script>
      lucide.createIcons();

      function toggleMSB() {
        document.getElementById('mSidebar').classList.toggle('show');
        document.getElementById('mOverlay').classList.toggle('show');
      }