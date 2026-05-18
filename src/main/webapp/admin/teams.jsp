<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.civicsathy.dao.InventoryDAO" %>
<%@ page import="com.civicsathy.model.Vehicle" %>
<%@ page import="com.civicsathy.model.Team" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy - Team Management</title>
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
.panel{background:#fff;border:1px solid #E8E8ED;border-radius:8px;padding:24px;margin-bottom:24px;}
.panel-hd{font-size:13px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.05em;margin-bottom:20px;display:flex;align-items:center;gap:6px;border-bottom:1px solid #F5F5F7;padding-bottom:12px;}
.field{margin-bottom:16px;}.field label{display:block;font-size:12px;font-weight:700;color:#0A0A0A;margin-bottom:8px;}
.input-base{width:100%;height:44px;border:1px solid #E8E8ED;border-radius:6px;padding:0 14px;font-size:14px;font-family:inherit;color:#0A0A0A;outline:none;background:#fff;}
.input-base:focus{border-color:#005B96;box-shadow:0 0 0 3px #EBF5FF;}
.btn-primary{background:#0A0A0A;color:#fff;border:none;height:44px;padding:0 24px;border-radius:6px;font-size:14px;font-weight:600;display:inline-flex;align-items:center;gap:8px;}
.btn-outline{background:#fff;color:#005B96;border:1px solid #005B96;height:32px;padding:0 16px;border-radius:6px;font-size:12px;font-weight:600;transition:.15s;cursor:pointer;}
.btn-outline:hover{background:#EBF5FF;}
.btn-save{background:#1A7F4B;color:#fff;border:none;height:32px;padding:0 16px;border-radius:6px;font-size:12px;font-weight:600;cursor:pointer;}
.edit-input{width:60px;height:30px;border:1px solid #E8E8ED;border-radius:4px;padding:0 8px;font-size:13px;text-align:center;}
.g2{display:grid;grid-template-columns:1fr 1fr;gap:24px;}
table{width:100%;border-collapse:collapse;}
th,td{padding:14px 16px;text-align:left;font-size:13px;border-bottom:1px solid #E8E8ED;}
th{font-weight:700;color:#86868B;text-transform:uppercase;font-size:11px;letter-spacing:.05em;background:#FBFBFD;}
tr:last-child td{border-bottom:none;}
.add-form{background:#F9FAFB;padding:20px;border-radius:8px;border:1px solid #E8E8ED;margin-top:20px;}

/* MOBILE OVERRIDES */
.m-header{display:none;}.m-sidebar{display:none;}
@media(max-width:768px){
  body{display:block !important; overflow:visible;}
  .m-header{width:100%; box-sizing:border-box;}
  .sidebar{display:none !important;}
  .topbar{display:none !important;}
  .main{height:auto;min-height:100vh;overflow:visible;}
  .content{padding:16px;padding-bottom:60px;}
  .g2{grid-template-columns:1fr !important;gap:16px;}
  .panel{padding:16px;}
  
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
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/tasks"><i data-lucide="clipboard-list" style="width:18px;height:18px;"></i> Assigned Tasks</a>
    <a class="sb-item danger" href="${pageContext.request.contextPath}/admin/escalations"><i data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i> Escalations <span class="badge-red"><%= new com.civicsathy.dao.ComplaintDAO().getEscalatedCount() %></span></a>
    <div class="sb-sec">Analytics & Map</div>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/map-data"><i data-lucide="map" style="width:18px;height:18px;"></i> Ward Heatmap</a>
    <div class="sb-sec">Communications</div>
    <a class="sb-item" href="announcements.jsp"><i data-lucide="radio" style="width:18px;height:18px;"></i> Broadcast</a>
    <div class="sb-sec">System</div>
    <a class="sb-item active" href="teams.jsp"><i data-lucide="users" style="width:18px;height:18px;"></i> Team Management</a>
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
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/tasks"><i data-lucide="clipboard-list" style="width:18px;height:18px;"></i> Assigned Tasks</a>
    <a class="sb-item danger" href="${pageContext.request.contextPath}/admin/escalations"><i data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i> Escalations</a>
    <div class="sb-sec">Analytics & Map</div>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/map-data"><i data-lucide="map" style="width:18px;height:18px;"></i> Ward Heatmap</a>
    <div class="sb-sec">System</div>
    <a class="sb-item active" href="teams.jsp"><i data-lucide="users" style="width:18px;height:18px;"></i> Teams</a>
    <a class="sb-item" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i> Settings</a>
  </nav>
  <div class="sb-footer"><a href="${pageContext.request.contextPath}/logout"><button class="sb-logout"><i data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
</div>

<div class="main">
  <header class="topbar"><span class="tb-title">Team & Resource Management</span></header>
  <div class="content">

    <!-- SECTION 1: VEHICLE INVENTORY -->
    <div class="panel">
      <div class="panel-hd"><i data-lucide="truck" style="width:16px;"></i> Vehicle Inventory</div>
      <p style="font-size:13px;color:#86868B;margin-bottom:20px;">Track all municipality vehicles by name and quantity.</p>
      <div style="border:1px solid #E8E8ED;border-radius:8px;overflow:hidden;">
        <table>
          <thead><tr><th>Vehicle Name</th><th>Total Count</th><th>Available</th><th>Deployed</th><th>Actions</th></tr></thead>
          <tbody>
            <% 
               InventoryDAO invDAO = new InventoryDAO();
               List<Vehicle> vehicles = invDAO.getAvailableVehicles();
               for (Vehicle v : vehicles) { 
                 int deployed = v.getTotalCount() - v.getAvailableCount();
            %>
            <tr id="veh-row-<%= v.getId() %>">
              <td><strong><%= v.getVehicleName() %></strong></td>
              <td id="veh-count-<%= v.getId() %>"><%= v.getTotalCount() %></td>
              <td style="color:#1A7F4B;font-weight:600;"><%= v.getAvailableCount() %></td>
              <td style="color:#D93025;font-weight:600;"><%= deployed %></td>
              <td><button class="btn-outline" onclick="toggleVehEdit(<%= v.getId() %>, <%= v.getTotalCount() %>)">Edit</button></td>
            </tr>
            <tr id="veh-edit-<%= v.getId() %>" style="display:none; background:#F9FAFB;">
              <td colspan="5">
                <form action="${pageContext.request.contextPath}/admin/resource" method="post" style="display:flex;align-items:center;gap:12px;">
                  <input type="hidden" name="action" value="updateVehicle">
                  <input type="hidden" name="id" value="<%= v.getId() %>">
                  <span style="font-size:13px;font-weight:600;">Update Total Count for <%= v.getVehicleName() %>:</span>
                  <input type="number" name="count" class="edit-input" value="<%= v.getTotalCount() %>" required min="<%= deployed %>">
                  <button type="submit" class="btn-save">Save</button>
                  <button type="button" class="btn-outline" style="border:none;" onclick="cancelVehEdit(<%= v.getId() %>)">Cancel</button>
                </form>
              </td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
      <div class="add-form">
        <form action="${pageContext.request.contextPath}/admin/resource" method="post">
          <input type="hidden" name="action" value="addVehicle">
          <div style="font-size:14px;font-weight:700;margin-bottom:12px;">Add New Vehicle</div>
          <div style="display:flex;gap:16px;align-items:flex-end;">
            <div class="field" style="flex:2;margin-bottom:0;"><label>Vehicle Name</label><input type="text" name="name" class="input-base" placeholder="E.g. Crane, Loader" required></div>
            <div class="field" style="flex:1;margin-bottom:0;"><label>Quantity</label><input type="number" name="count" class="input-base" value="1" required min="1"></div>
            <button type="submit" class="btn-primary"><i data-lucide="plus" style="width:14px;"></i> Add</button>
          </div>
        </form>
      </div>
    </div>

    <!-- SECTION 2: FIELD PERSONNEL -->
    <div class="panel">
      <div class="panel-hd"><i data-lucide="hard-hat" style="width:16px;"></i> Field Personnel</div>
      <p style="font-size:13px;color:#86868B;margin-bottom:20px;">Track the number of field workers by department. These personnel do not need computer login access.</p>
      <div style="border:1px solid #E8E8ED;border-radius:8px;overflow:hidden;">
        <table>
          <thead><tr><th>Department</th><th>Total Members</th><th>Available</th><th>On Duty</th><th>Actions</th></tr></thead>
          <tbody>
            <% 
               List<Team> teams = invDAO.getAvailableTeams();
               for (Team t : teams) { 
                 int deployed = t.getMemberCount() - t.getAvailableCount();
            %>
            <tr id="team-row-<%= t.getId() %>">
              <td><strong><%= t.getTeamName() %></strong></td>
              <td><%= t.getMemberCount() %></td>
              <td style="color:#1A7F4B;font-weight:600;"><%= t.getAvailableCount() %></td>
              <td style="color:#D93025;font-weight:600;"><%= deployed %></td>
              <td><button class="btn-outline" onclick="toggleTeamEdit(<%= t.getId() %>, <%= t.getMemberCount() %>)">Edit</button></td>
            </tr>
            <tr id="team-edit-<%= t.getId() %>" style="display:none; background:#F9FAFB;">
              <td colspan="5">
                <form action="${pageContext.request.contextPath}/admin/resource" method="post" style="display:flex;align-items:center;gap:12px;">
                  <input type="hidden" name="action" value="updateTeam">
                  <input type="hidden" name="id" value="<%= t.getId() %>">
                  <span style="font-size:13px;font-weight:600;">Update Total Members for <%= t.getTeamName() %>:</span>
                  <input type="number" name="count" class="edit-input" value="<%= t.getMemberCount() %>" required min="<%= deployed %>">
                  <button type="submit" class="btn-save">Save</button>
                  <button type="button" class="btn-outline" style="border:none;" onclick="cancelTeamEdit(<%= t.getId() %>)">Cancel</button>
                </form>
              </td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
      <div class="add-form">
        <form action="${pageContext.request.contextPath}/admin/resource" method="post">
          <input type="hidden" name="action" value="addTeam">
          <div style="font-size:14px;font-weight:700;margin-bottom:12px;">Add New Department</div>
          <div style="display:flex;gap:16px;align-items:flex-end;">
            <div class="field" style="flex:2;margin-bottom:0;"><label>Department Name</label><input type="text" name="name" class="input-base" placeholder="E.g. Carpenters, Welders" required></div>
            <div class="field" style="flex:1;margin-bottom:0;"><label>Type</label><input type="text" name="type" class="input-base" placeholder="e.g. Sanitation" required></div>
            <div class="field" style="flex:1;margin-bottom:0;"><label>Member Count</label><input type="number" name="count" class="input-base" value="1" required min="1"></div>
            <button type="submit" class="btn-primary"><i data-lucide="plus" style="width:14px;"></i> Add</button>
          </div>
        </form>
      </div>
    </div>

    <!-- SECTION 3: ADMIN SYSTEM USERS -->
    <div class="panel">
      <div class="panel-hd"><i data-lucide="user-plus" style="width:16px;"></i> Add System Administrator</div>
      <p style="font-size:13px;color:#86868B;margin-bottom:20px;">Invite users who need computer login access to this portal. They work from the main city office.</p>
      <div style="display:flex;gap:16px;align-items:flex-end;">
        <div class="field" style="flex:1;margin-bottom:0;"><label>Staff Official Email</label><input type="email" class="input-base" placeholder="staff@itahari.gov.np"></div>
        <div class="field" style="flex:1;margin-bottom:0;"><label>Verification Code</label><input type="text" class="input-base" placeholder="6-digit code from main email"></div>
        <button class="btn-primary">Authorize</button>
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
  function toggleVehEdit(id, count) {
    document.getElementById('veh-row-' + id).style.display = 'none';
    document.getElementById('veh-edit-' + id).style.display = 'table-row';
  }
  function cancelVehEdit(id) {
    document.getElementById('veh-row-' + id).style.display = 'table-row';
    document.getElementById('veh-edit-' + id).style.display = 'none';
  }
  function toggleTeamEdit(id, count) {
    document.getElementById('team-row-' + id).style.display = 'none';
    document.getElementById('team-edit-' + id).style.display = 'table-row';
  }
  function cancelTeamEdit(id) {
    document.getElementById('team-row-' + id).style.display = 'table-row';
    document.getElementById('team-edit-' + id).style.display = 'none';
  }
</script>
</body>
</html>
