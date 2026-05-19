<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.civicsathy.model.Task" %>
<%
    List<Task> tasks = (List<Task>) request.getAttribute("assignedTasks");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy - Assigned Tasks</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
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
.topbar{background:#fff;border-bottom:1px solid #E8E8ED;padding:0 32px;height:60px;display:flex;align-items:center;flex-shrink:0;}
.tb-title{font-size:16px;font-weight:700;}
.content{flex:1;padding:32px;overflow-y:auto;}
.table-wrap{background:#fff;border:1px solid #E8E8ED;border-radius:8px;overflow-x:auto;}
table{width:100%;border-collapse:collapse;min-width:900px;}
th,td{padding:14px 16px;text-align:left;font-size:13px;border-bottom:1px solid #E8E8ED;}
th{font-weight:700;color:#86868B;text-transform:uppercase;font-size:11px;letter-spacing:.05em;background:#FBFBFD;}
tr:last-child td{border-bottom:none;}
tr:hover{background:#F9FAFB;}
.btn-view{padding:6px 12px;background:#fff;border:1px solid #E8E8ED;border-radius:4px;font-size:12px;font-weight:600;color:#005B96;text-decoration:none;display:inline-flex;align-items:center;gap:6px;}.btn-view:hover{border-color:#005B96;background:#F0FBFF;}
.empty{text-align:center;padding:60px 20px;color:#86868B;font-size:14px;}
.chip{padding:4px 8px;border-radius:4px;font-size:10px;font-weight:700;display:inline-block;text-transform:uppercase;}
.c-pend{background:#FEF3C7;color:#B45309;}
.c-prog{background:#D5F9FF;color:#005B96;}
.c-res{background:#D1FAE5;color:#065F46;}
.c-esc{background:#FEE2E2;color:#991B1B;}

/* MOBILE OVERRIDES */
.m-header{display:none;}.m-sidebar{display:none;}
@media(max-width:768px){
  body{display:block !important; overflow:visible;}
  .m-header{width:100%; box-sizing:border-box;}
  .sidebar{display:none !important;}
  .topbar{display:none !important;}
  .main{height:auto;min-height:100vh;overflow:visible;}
  .content{padding:16px;padding-bottom:60px;}
  
  .m-header{display:flex;align-items:center;gap:12px;height:60px;background:#fff;border-bottom:1px solid #E8E8ED;padding:0 16px;position:sticky;top:0;z-index:2001;}
  .m-burger{width:40px;height:40px;display:flex;align-items:center;justify-content:center;background:#F5F5F7;border-radius:8px;color:#1D1D1F;}
  .m-logo{font-size:17px;font-weight:700;letter-spacing:-.3px;}.m-logo span{color:#005B96;}
  
  .m-sidebar{display:flex;flex-direction:column;position:fixed;top:0;left:-280px;width:280px;height:100vh;background:#fff;z-index:2000;transition:.3s cubic-bezier(0.4, 0, 0.2, 1);visibility:hidden;}
  .m-sidebar.show{left:0;visibility:visible;box-shadow:20px 0 50px rgba(0,0,0,0.15);}
  .m-overlay{display:none;position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.5);backdrop-filter:blur(2px);z-index:1999;}
  .m-overlay.show{display:block;}
}
</style>
</head>
<body>
<aside class="sidebar">
  <div class="sb-brand"><div class="sb-logo">Civic<span>Sathy</span></div><div class="sb-badge"><i data-lucide="shield-check" style="width:10px;height:10px;"></i> Admin Portal</div></div>
  <nav class="sb-nav">
    <div class="sb-sec">Overview</div>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/dashboard-stats"><i data-lucide="layout-dashboard" style="width:18px;height:18px;"></i> Dashboard</a>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/complaints"><i data-lucide="list-checks" style="width:18px;height:18px;"></i> All Tickets</a>
    <div class="sb-sec">Management</div>
    <a class="sb-item active" href="${pageContext.request.contextPath}/admin/tasks"><i data-lucide="clipboard-list" style="width:18px;height:18px;"></i> Assigned Tasks</a>
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
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/dashboard-stats"><i data-lucide="layout-dashboard" style="width:18px;height:18px;"></i> Dashboard</a>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/complaints"><i data-lucide="list-checks" style="width:18px;height:18px;"></i> All Tickets</a>
    <div class="sb-sec">Management</div>
    <a class="sb-item active" href="${pageContext.request.contextPath}/admin/tasks"><i data-lucide="clipboard-list" style="width:18px;height:18px;"></i> Assigned Tasks</a>
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
      <div>
        <div class="tb-title">Field Task Assignments</div>
        <div style="font-size:12px;color:#86868B;margin-top:4px;">Manage and monitor resources deployed to active tickets.</div>
      </div>
  </header>
  <div class="content">

    <% if (tasks != null && !tasks.isEmpty()) { %>
    <div class="table-wrap">
      <table>
        <thead><tr><th>Task ID</th><th>Ticket Info</th><th>Date & Time</th><th>Department & Personnel</th><th>Vehicle</th><th>Status</th><th>Action</th></tr></thead>
        <tbody>
          <% for (Task t : tasks) { 
                String st = t.getStatus() != null ? t.getStatus().toUpperCase() : "ASSIGNED";
                String cCls = "c-pend";
                if (st.contains("PROGRESS")) cCls = "c-prog";
                else if (st.equals("RESOLVED") || st.equals("CLOSED")) cCls = "c-res";
                else if (st.equals("ESCALATED")) cCls = "c-esc";
          %>
          <tr>
            <td><strong>TSK-<%= String.format("%04d", t.getId()) %></strong></td>
            <td>
                <div style="font-weight:600;"><%= t.getComplaintTitle() %></div>
                <div style="font-size:11px;color:#86868B;">#<%= t.getTrackingId() %> &middot; Ward <%= t.getWardNo() %> &middot; <%= t.getCategoryName() %></div>
            </td>
            <td>
                <div style="font-weight:600;"><%= t.getAssignedDate() %></div>
                <div style="font-size:11px;color:#86868B;"><%= t.getAssignedTime() %></div>
            </td>
            <td>
                <div style="font-weight:600;"><%= t.getDisplayTeams() != null ? t.getDisplayTeams() : "None" %></div>
            </td>
            <td>
                <div style="font-weight:600;"><%= t.getDisplayVehicles() != null ? t.getDisplayVehicles() : "None" %></div>
            </td>
            <td><span class="chip <%= cCls %>"><%= st %></span></td>
            <td><a href="${pageContext.request.contextPath}/admin/ticket.jsp?id=<%= t.getComplaintId() %>" class="btn-view"><i data-lucide="eye" style="width:14px;"></i> View Ticket Details</a></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
    <% } else { %>
    <div class="empty">
      <i data-lucide="clipboard-x" style="width:40px;height:40px;color:#86868B;margin-bottom:12px;"></i>
      <div style="font-weight:700;color:#0A0A0A;margin-bottom:4px;">No Tasks Assigned</div>
      <div>You haven't assigned any field work tasks yet.</div>
    </div>
    <% } %>

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
