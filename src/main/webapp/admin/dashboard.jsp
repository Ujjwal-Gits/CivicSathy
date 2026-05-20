<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy - Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script src="https://leaflet.github.io/Leaflet.heat/dist/leaflet-heat.js"></script>
<style>
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'DM Sans',sans-serif;background:#F5F5F7;color:#0A0A0A;-webkit-font-smoothing:antialiased;display:flex;min-height:100vh;overflow:hidden;}
a{text-decoration:none;color:inherit;}button{cursor:pointer;font-family:inherit;}
.sidebar{width:240px;flex-shrink:0;background:#fff;border-right:1px solid #E8E8ED;display:flex;flex-direction:column;height:100vh;}
.sb-brand{padding:20px 20px 16px;border-bottom:1px solid #E8E8ED;}
.sb-logo{font-size:18px;font-weight:700;letter-spacing:-.3px;}.sb-logo span{color:#005B96;}
.sb-badge{display:inline-flex;align-items:center;gap:4px;margin-top:4px;padding:2px 8px;background:#EBF5FF;border-radius:3px;font-size:9px;font-weight:700;color:#005B96;text-transform:uppercase;letter-spacing:.08em;}
.sb-nav{flex:1;padding:16px 12px;overflow-y:auto;}
.sb-sec{font-size:10px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.08em;padding:0 8px;margin:16px 0 8px;}.sb-sec:first-child{margin-top:0;}
.sb-item{display:flex;align-items:center;gap:10px;padding:10px;border-radius:6px;font-size:13px;font-weight:500;color:#0A0A0A;margin-bottom:4px;transition:background .15s;}
.sb-item:hover{background:#F5F5F7;}.sb-item.active{background:#EBF5FF;color:#005B96;font-weight:600;}
.sb-item.danger{color:#D93025;}.sb-item.danger:hover{background:#FEF2F2;}
.badge-red{margin-left:auto;background:#D93025;color:#fff;font-size:10px;font-weight:700;padding:2px 6px;border-radius:4px;}
.sb-footer{padding:16px;border-top:1px solid #E8E8ED;}
.sb-logout{display:flex;align-items:center;gap:8px;width:100%;padding:10px;background:none;border:none;border-radius:6px;font-size:13px;font-weight:600;color:#86868B;}.sb-logout:hover{background:#FEF2F2;color:#D93025;}
.main{flex:1;display:flex;flex-direction:column;min-width:0;height:100vh;}
.topbar{background:#fff;border-bottom:1px solid #E8E8ED;padding:0 32px;height:60px;display:flex;align-items:center;justify-content:space-between;flex-shrink:0;}
.tb-title{font-size:16px;font-weight:700;}.tb-sub{font-size:12px;color:#86868B;margin-left:8px;}
.content{flex:1;padding:28px 32px;overflow-y:auto;}
.panel{background:#fff;border:1px solid #E8E8ED;border-radius:8px;padding:20px;margin-bottom:20px;}
.panel-hd{font-size:12px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.05em;margin-bottom:16px;display:flex;align-items:center;gap:6px;}
/* METRICS */
.metrics{display:grid;grid-template-columns:repeat(5,1fr);gap:14px;margin-bottom:20px;}
.metric{background:#fff;border:1px solid #E8E8ED;border-radius:8px;padding:20px;}
.m-val{font-size:28px;font-weight:700;letter-spacing:-1px;line-height:1;}
.m-lbl{font-size:11px;color:#86868B;font-weight:700;margin-top:6px;text-transform:uppercase;letter-spacing:.04em;}
.m-sub{font-size:11px;margin-top:6px;display:flex;align-items:center;gap:4px;}
.up{color:#1A7F4B;}.dn{color:#D93025;}
/* ALERT */
.alert{display:flex;align-items:center;gap:12px;background:#FEF2F2;border:1px solid #FECACA;border-radius:8px;padding:14px 16px;margin-bottom:20px;}
.alert p{font-size:13px;color:#D93025;font-weight:500;}
.alert a{margin-left:auto;font-size:12px;font-weight:700;color:#D93025;white-space:nowrap;}
/* GRID */
.g2{display:grid;grid-template-columns:1fr 1fr;gap:20px;margin-bottom:20px;}
.g3{display:grid;grid-template-columns:2fr 1fr 1fr;gap:20px;margin-bottom:20px;}
/* BAR */
.bar-item{margin-bottom:10px;}.bar-top{display:flex;justify-content:space-between;font-size:12px;color:#86868B;margin-bottom:4px;}.bar-top span:last-child{font-weight:700;color:#0A0A0A;}
.bar-bg{height:6px;background:#F0F0F0;border-radius:3px;}.bar-fill{height:6px;border-radius:3px;}
/* LOG */
.log-item{padding:10px 0;border-bottom:1px solid #F5F5F7;}.log-item:last-child{border:none;}
.log-time{font-size:10px;color:#86868B;margin-top:3px;}
/* MINI TABLE */
.mini-item{display:flex;align-items:center;justify-content:space-between;padding:10px 0;border-bottom:1px solid #F5F5F7;}.mini-item:last-child{border:none;}
.chip{padding:3px 8px;border-radius:4px;font-size:10px;font-weight:700;}
.c-esc{background:#FEF2F2;color:#D93025;}.c-pend{background:#FEF3C7;color:#B45309;}.c-prog{background:#D5F9FF;color:#005B96;}.c-res{background:#D1FAE5;color:#065F46;}
/* NOTIFY */
.n-item{display:flex;gap:10px;padding:10px 0;border-bottom:1px solid #F5F5F7;}.n-item:last-child{border:none;}
.n-icon{width:30px;height:30px;border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0;}
/* MAP MINI */
.map-mini{background:#EBF5FF;border:1px solid #BAE6FD;border-radius:8px;height:200px;display:flex;align-items:center;justify-content:center;position:relative;overflow:hidden;margin-bottom:12px;}
.dot{position:absolute;width:12px;height:12px;background:rgba(217,48,37,0.6);border:2px solid #D93025;border-radius:50%;animation:pulse 2s infinite;}
@keyframes pulse{0%{box-shadow:0 0 0 0 rgba(217,48,37,0.7);}70%{box-shadow:0 0 0 10px rgba(217,48,37,0);}100%{box-shadow:0 0 0 0 rgba(217,48,37,0);}}
@media(max-width:1200px){.metrics{grid-template-columns:repeat(3,1fr);}.g3{grid-template-columns:1fr;}}
@media(max-width:900px){.metrics{grid-template-columns:1fr 1fr;}.g2{grid-template-columns:1fr;}.sidebar{display:none;}}

/* MOBILE OVERRIDES */
.m-header{display:none;}.m-sidebar{display:none;}
@media(max-width:768px){
  body{display:block !important; overflow:visible;}
  .m-header{width:100%; box-sizing:border-box;}
  .alert{flex-direction:column; align-items:flex-start; gap:8px;}
  .alert a{margin-left:0; margin-top:4px;}
  .sidebar{display:none !important;}
  .topbar{display:none !important;}
  .main{height:auto;min-height:100vh;overflow:visible;}
  .content{padding:16px;padding-bottom:60px;}
  .metrics{grid-template-columns:1fr 1fr;gap:10px;}
  .metric{padding:15px;}
  .m-val{font-size:22px;}
  .g2, .g3{grid-template-columns:1fr !important;gap:16px;}
  .panel{padding:16px;}
  
  .m-header{display:flex;align-items:center;gap:12px;height:60px;background:#fff;border-bottom:1px solid #E8E8ED;padding:0 16px;position:sticky;top:0;z-index:2001;}
  .m-burger{width:40px;height:40px;display:flex;align-items:center;justify-content:center;background:#F5F5F7;border-radius:8px;color:#1D1D1F;}
  .m-logo{font-size:17px;font-weight:700;letter-spacing:-.3px;}.m-logo span{color:#005B96;}
  
  .m-sidebar{display:flex;flex-direction:column;position:fixed;top:0;left:-280px;width:280px;height:100vh;background:#fff;z-index:2000;transition:.3s cubic-bezier(0.4, 0, 0.2, 1);visibility:hidden;}
  .m-sidebar.show{left:0;visibility:visible;box-shadow:20px 0 50px rgba(0,0,0,0.15);}
  .m-overlay{display:none;position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.5);backdrop-filter:blur(2px);z-index:1999;}
  .m-overlay.show{display:block;}
  
  .ai-grid{grid-template-columns:repeat(2,1fr) !important;gap:16px !important;}
  .ai-grid div:last-child{grid-column: span 2; border-top: 1px solid #E8E8ED; padding-top: 12px; margin-top: 4px;}
}
.scroll-area{max-height:340px;overflow-y:auto;padding-right:8px;}.scroll-area::-webkit-scrollbar{width:4px;}.scroll-area::-webkit-scrollbar-track{background:#f1f1f1;}.scroll-area::-webkit-scrollbar-thumb{background:#ccc;border-radius:10px;}
</style>
</head>
<body>
<aside class="sidebar">
  <div class="sb-brand"><div class="sb-logo">Civic<span>Sathy</span></div><div class="sb-badge"><i data-lucide="shield-check" style="width:10px;height:10px;"></i> Admin Portal</div></div>
  <nav class="sb-nav">
    <div class="sb-sec">Overview</div>
    <a class="sb-item active" href="${pageContext.request.contextPath}/admin/dashboard-stats"><i data-lucide="layout-dashboard" style="width:18px;height:18px;"></i> Dashboard</a>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/complaints"><i data-lucide="list-checks" style="width:18px;height:18px;"></i> All Tickets</a>
    <div class="sb-sec">Management</div>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/tasks"><i data-lucide="clipboard-list" style="width:18px;height:18px;"></i> Assigned Tasks</a>
    <a class="sb-item danger" href="${pageContext.request.contextPath}/admin/escalations"><i data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i> Escalations <span class="badge-red"><%= new com.civicsathy.dao.ComplaintDAO().getEscalatedCount() %></span></a>
    <div class="sb-sec">Analytics & Map</div>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/map-data"><i data-lucide="map" style="width:18px;height:18px;"></i> Ward Heatmap</a>
    <div class="sb-sec">Communications</div>
    <a class="sb-item" href="announcements.jsp"><i data-lucide="radio" style="width:18px;height:18px;"></i> Broadcast</a>
    <div class="sb-sec">System</div>
    <a class="sb-item" href="teams.jsp"><i data-lucide="users" style="width:18px;height:18px;"></i> Team Management</a>
    <a class="sb-item" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i> Profile & Settings</a>
  </nav>
  <div class="sb-footer"><a href="${pageContext.request.contextPath}/logout"><button class="sb-logout"><i data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
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
      <button onclick="toggleMSB()" style="background:none;border:none;color:#86868B;"><i data-lucide="x" style="width:20px;"></i></button>
    </div>
    <div class="sb-badge"><i data-lucide="shield-check" style="width:10px;height:10px;"></i> Admin Portal</div>
  </div>
  <nav class="sb-nav">
    <div class="sb-sec">Overview</div>
    <a class="sb-item active" href="${pageContext.request.contextPath}/admin/dashboard-stats"><i data-lucide="layout-dashboard" style="width:18px;height:18px;"></i> Dashboard</a>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/complaints"><i data-lucide="list-checks" style="width:18px;height:18px;"></i> All Tickets</a>
    <div class="sb-sec">Management</div>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/tasks"><i data-lucide="clipboard-list" style="width:18px;height:18px;"></i> Assigned Tasks</a>
    <a class="sb-item danger" href="${pageContext.request.contextPath}/admin/escalations"><i data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i> Escalations</a>
    <div class="sb-sec">Analytics & Map</div>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/map-data"><i data-lucide="map" style="width:18px;height:18px;"></i> Ward Heatmap</a>
    <div class="sb-sec">System</div>
    <a class="sb-item" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i> Settings</a>
  </nav>
  <div class="sb-footer"><a href="${pageContext.request.contextPath}/logout"><button class="sb-logout"><i data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
</div>

<div class="main">
  <header class="topbar">
    <div><span class="tb-title">Analytics Dashboard</span><span class="tb-sub">Itahari Sub-Metropolitan City</span></div>
  </header>
  <div class="content">

    <!-- (7) ESCALATION ALERT -->
    <div class="alert">
      <i data-lucide="alert-triangle" style="width:18px;height:18px;color:#D93025;flex-shrink:0;"></i>
      <p><strong>${escalatedCount != null ? escalatedCount : 0} tickets</strong> have exceeded the 48-hour SLA threshold and require immediate escalation.</p>
      <a href="${pageContext.request.contextPath}/admin/complaints">Review Now &rarr;</a>
    </div>

    <!-- (1) ANALYTICS METRICS -->
    <div class="metrics">
      <div class="metric"><div class="m-val">${totalCount != null ? totalCount : 0}</div><div class="m-lbl">Total Reports</div></div>
      <div class="metric"><div class="m-val" style="color:#C77B17;">${pendingCount != null ? pendingCount : 0}</div><div class="m-lbl">Pending</div></div>
      <div class="metric"><div class="m-val" style="color:#005B96;">${inProgressCount != null ? inProgressCount : 0}</div><div class="m-lbl">In Progress</div></div>
      <div class="metric"><div class="m-val" style="color:#1A7F4B;">${resolvedCount != null ? resolvedCount : 0}</div><div class="m-lbl">Resolved</div></div>
      <div class="metric"><div class="m-val" style="color:#D93025;">${escalatedCountStat != null ? escalatedCountStat : 0}</div><div class="m-lbl">Escalated</div></div>
    </div>

    <!-- ROW: CATEGORY CHARTS + WARD CHARTS + LIVE MAP -->
    <div class="g3">
      <!-- (1) Category Breakdown -->
      <div class="panel">
        <div class="panel-hd"><i data-lucide="bar-chart-3" style="width:14px;"></i> Reports by Category</div>
        <%
            java.util.Map<String, Integer> catCounts = (java.util.Map<String, Integer>) request.getAttribute("categoryCounts");
            int maxCat = 1;
            if (catCounts != null) {
                for (Integer count : catCounts.values()) if (count > maxCat) maxCat = count;
                for (java.util.Map.Entry<String, Integer> entry : catCounts.entrySet()) {
                    int w = (entry.getValue() * 100) / maxCat;
        %>
        <div class="bar-item"><div class="bar-top"><span><%= entry.getKey() %></span><span><%= entry.getValue() %></span></div><div class="bar-bg"><div class="bar-fill" style="width:<%= w %>%;background:#005B96;"></div></div></div>
        <%      }
            } else { %>
        <div style="font-size:12px;color:#86868B;padding:10px 0;">No data available</div>
        <% } %>
      </div>
      <!-- (1) Ward Breakdown -->
      <div class="panel">
        <div class="panel-hd"><i data-lucide="map-pin" style="width:14px;"></i> Top Wards</div>
        <%
            java.util.Map<Integer, Integer> wardCounts = (java.util.Map<Integer, Integer>) request.getAttribute("wardCounts");
            int maxWard = 1;
            if (wardCounts != null) {
                for (Integer count : wardCounts.values()) if (count > maxWard) maxWard = count;
                for (java.util.Map.Entry<Integer, Integer> entry : wardCounts.entrySet()) {
                    int w = (entry.getValue() * 100) / maxWard;
        %>
        <div class="bar-item"><div class="bar-top"><span>Ward <%= entry.getKey() %></span><span><%= entry.getValue() %></span></div><div class="bar-bg"><div class="bar-fill" style="width:<%= w %>%;background:#C77B17;"></div></div></div>
        <%      }
            } else { %>
        <div style="font-size:12px;color:#86868B;padding:10px 0;">No data available</div>
        <% } %>
      </div>
      <!-- (1) Live Map Preview -->
      <div class="panel">
        <div class="panel-hd">
          <i data-lucide="radio" style="width:14px;"></i> Live Complaints Heatmap
          <select id="wardFilter" onchange="updateHeatmap()" style="margin-left:auto;font-size:10px;padding:2px 4px;border:1px solid #E8E8ED;border-radius:4px;background:#F5F5F7;font-family:inherit;font-weight:600;outline:none;">
            <option value="all">All Wards</option>
            <% for(int i=1; i<=20; i++) { %>
            <option value="<%= i %>">Ward <%= i %></option>
            <% } %>
          </select>
        </div>
        <div id="itahariMap" style="height:200px;border:1px solid #BAE6FD;border-radius:8px;margin-bottom:12px;z-index:1;"></div>
        <a href="${pageContext.request.contextPath}/admin/map-data" style="font-size:12px;color:#005B96;font-weight:600;">Open Full Heatmap &rarr;</a>
      </div>
    </div>

    <!-- ROW: RECENT TICKETS + NOTIFICATIONS + ACTIVITY LOG -->
    <div class="g3">
      <!-- (2)(3) Recent Tickets -->
      <div class="panel">
        <div class="panel-hd"><i data-lucide="list-checks" style="width:14px;"></i> Recent Tickets <a href="${pageContext.request.contextPath}/admin/complaints" style="margin-left:auto;font-size:11px;color:#005B96;font-weight:600;">View All &rarr;</a></div>
        <div class="scroll-area">
        <%
            java.util.List<com.civicsathy.model.Complaint> recent = (java.util.List<com.civicsathy.model.Complaint>) request.getAttribute("recentComplaints");
            if (recent != null && !recent.isEmpty()) {
                for (com.civicsathy.model.Complaint c : recent) {
                    String chipClass = "c-pend";
                    if ("In Progress".equalsIgnoreCase(c.getStatus())) chipClass = "c-prog";
                    else if ("Resolved".equalsIgnoreCase(c.getStatus())) chipClass = "c-res";
                    else if ("Escalated".equalsIgnoreCase(c.getStatus())) chipClass = "c-esc";
        %>
        <div class="mini-item" style="cursor:pointer;" onclick="window.location.href='ticket.jsp?id=<%= c.getId() %>'"><div><div style="font-size:13px;font-weight:600;"><%= c.getTitle() %></div><div style="font-size:11px;color:#86868B;">Ward <%= c.getWardNo() %> &middot; <%= c.getCategoryName() %> &middot; #<%= c.getTrackingId() %></div></div><span class="chip <%= chipClass %>"><%= c.getStatus() %></span></div>
        <%      }
            } else { %>
        <div style="font-size:12px;color:#86868B;padding:10px 0;">No recent tickets found.</div>
        <% } %>
        </div>
      </div>
      <!-- (7) Priority Notifications -->
      <div class="panel">
        <div class="panel-hd"><i data-lucide="bell" style="width:14px;"></i> Priority Alerts</div>
        <div class="scroll-area">
        <%
            // Show escalated tickets as priority alerts
            java.util.List<com.civicsathy.model.Complaint> allForAlerts = (java.util.List<com.civicsathy.model.Complaint>) request.getAttribute("recentComplaints");
            int escalatedNum = (request.getAttribute("escalatedCount") != null) ? (Integer)request.getAttribute("escalatedCount") : 0;
            int pendingNum = (request.getAttribute("pendingCount") != null) ? (Integer)request.getAttribute("pendingCount") : 0;
            int resolvedNum = (request.getAttribute("resolvedCount") != null) ? (Integer)request.getAttribute("resolvedCount") : 0;
        %>
        <% if (escalatedNum > 0) { %>
        <a href="${pageContext.request.contextPath}/admin/escalations" style="display:block;">
        <div class="n-item">
          <div class="n-icon" style="background:#FEF2F2;color:#D93025;"><i data-lucide="alert-triangle" style="width:14px;"></i></div>
          <div><div style="font-size:12px;font-weight:600;"><%= escalatedNum %> Escalated Tickets</div><div style="font-size:11px;color:#86868B;">Tickets pending over 48 hours need attention.</div></div>
        </div>
        </a>
        <% } %>
        <% if (pendingNum > 0) { %>
        <a href="${pageContext.request.contextPath}/admin/complaints" style="display:block;">
        <div class="n-item">
          <div class="n-icon" style="background:#FEF3C7;color:#B45309;"><i data-lucide="clock" style="width:14px;"></i></div>
          <div><div style="font-size:12px;font-weight:600;"><%= pendingNum %> Pending Tickets</div><div style="font-size:11px;color:#86868B;">Awaiting review and assignment.</div></div>
        </div>
        </a>
        <% } %>
        <% if (resolvedNum > 0) { %>
        <div class="n-item">
          <div class="n-icon" style="background:#D1FAE5;color:#065F46;"><i data-lucide="check-circle" style="width:14px;"></i></div>
          <div><div style="font-size:12px;font-weight:600;"><%= resolvedNum %> Resolved</div><div style="font-size:11px;color:#86868B;">Successfully resolved complaints.</div></div>
        </div>
        <% } %>
        <% if (escalatedNum == 0 && pendingNum == 0 && resolvedNum == 0) { %>
        <div style="font-size:12px;color:#86868B;padding:10px 0;">No priority alerts at this time.</div>
        <% } %>
        </div>
      </div>
      <!-- Activity History -->
      <div class="panel">
        <div class="panel-hd"><i data-lucide="history" style="width:14px;"></i> Activity Log</div>
        <div class="scroll-area">
        <%
            java.util.List<com.civicsathy.model.StatusHistory> actLog = (java.util.List<com.civicsathy.model.StatusHistory>) request.getAttribute("activityLog");
            if (actLog != null && !actLog.isEmpty()) {
                for (com.civicsathy.model.StatusHistory sh : actLog) {
                    // calculate time ago
                    long diffMs = System.currentTimeMillis() - sh.getCreatedAt().getTime();
                    long diffMins = diffMs / 60000;
                    String timeAgo;
                    if (diffMins < 1) timeAgo = "Just now";
                    else if (diffMins < 60) timeAgo = diffMins + " min ago";
                    else if (diffMins < 1440) timeAgo = (diffMins / 60) + " hours ago";
                    else timeAgo = (diffMins / 1440) + " days ago";
                    
                    String who = sh.getChangedByName() != null ? sh.getChangedByName() : "System";
                    String action = "updated";
                    if ("Resolved".equalsIgnoreCase(sh.getNewStatus())) action = "resolved";
                    else if ("In Progress".equalsIgnoreCase(sh.getNewStatus())) action = "started work on";
                    else if ("Escalated".equalsIgnoreCase(sh.getNewStatus())) action = "escalated";
                    else if ("Pending".equalsIgnoreCase(sh.getNewStatus())) action = "set to pending";
        %>
        <div class="log-item"><div style="font-size:12px;"><strong><%= who %></strong> <%= action %> <a href="ticket.jsp?id=<%= sh.getComplaintId() %>" style="color:#005B96;font-weight:600;">#<%= sh.getTrackingId() != null ? sh.getTrackingId() : sh.getComplaintId() %></a></div><div class="log-time"><%= timeAgo %></div></div>
        <%      }
            } else { %>
        <div style="font-size:12px;color:#86868B;padding:10px 0;">No activity yet.</div>
        <% } %>
        </div>
      </div>
    </div>

    <!-- (10) AI WEEKLY SUMMARY -->
    <div class="panel" style="background:#F0FBFF;border-color:#BAE6FD;">
      <div class="panel-hd" style="color:#005B96;">
        <i data-lucide="sparkles" style="width:14px;"></i> AI Analytics Summary
        <a href="${pageContext.request.contextPath}/admin/generate-report" target="_blank" style="margin-left:auto;font-size:11px;color:#005B96;font-weight:600;display:flex;align-items:center;gap:4px;">
          <i data-lucide="download-cloud" style="width:14px;"></i> Download PDF Report
        </a>
      </div>
      <div class="ai-grid" style="display:grid;grid-template-columns:repeat(5,1fr);gap:16px;font-size:13px;">
        <div><div style="font-weight:700;font-size:20px;">${aiTotalComplaints}</div><div style="color:#86868B;font-size:11px;">Total Complaints</div></div>
        <div><div style="font-weight:700;font-size:20px;">${aiTopCategory}</div><div style="color:#86868B;font-size:11px;">Top Category (${aiTopCategoryPct}%)</div></div>
        <div><div style="font-weight:700;font-size:20px;">Ward ${aiTopWard}</div><div style="color:#86868B;font-size:11px;">Most Impacted</div></div>
        <div><div style="font-weight:700;font-size:20px;">${aiResolutionRate}%</div><div style="color:#86868B;font-size:11px;">Resolution Rate</div></div>
        <div><div style="font-weight:700;font-size:20px;color:#D93025;">${escalatedCount}</div><div style="color:#86868B;font-size:11px;">Unresolved Flagged</div></div>
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

  // Initialize Map
  var map = L.map('itahariMap', { zoomControl: false }).setView([26.6647, 87.2718], 13);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; OpenStreetMap'
  }).addTo(map);

  // All Heatmap Data with Ward Info
  var allPoints = [
      <% 
         java.util.List<com.civicsathy.model.Complaint> mapData = (java.util.List<com.civicsathy.model.Complaint>) request.getAttribute("allComplaintsForMap");
         if (mapData != null) {
             for (com.civicsathy.model.Complaint c : mapData) {
                 if (c.getLatitude() != 0 && c.getLongitude() != 0) {
      %>
      {lat: <%= c.getLatitude() %>, lng: <%= c.getLongitude() %>, ward: <%= c.getWardNo() %>},
      <% 
                 }
             }
         }
      %>
  ];

  var heatLayer = null;

  function updateHeatmap() {
      var selectedWard = document.getElementById('wardFilter').value;
      
      // Remove existing layer
      if (heatLayer) {
          map.removeLayer(heatLayer);
      }

      // Filter points
      var filteredPoints = allPoints
          .filter(p => selectedWard === 'all' || p.ward == selectedWard)
          .map(p => [p.lat, p.lng, 0.5]);

      // Add new layer
      if (filteredPoints.length > 0) {
          heatLayer = L.heatLayer(filteredPoints, {
              radius: 20,
              blur: 15,
              maxZoom: 17,
              gradient: { 0.4: 'blue', 0.65: 'lime', 1: 'red' }
          }).addTo(map);
          
          // Auto-zoom to ward if filtered
          if (selectedWard !== 'all') {
              var group = new L.featureGroup(filteredPoints.map(p => L.marker([p[0], p[1]])));
              map.fitBounds(group.getBounds(), { padding: [20, 20], maxZoom: 14 });
          } else {
              map.setView([26.6647, 87.2718], 13);
          }
      }
  }

  // Initial load
  updateHeatmap();
</script>
</body>
</html>
