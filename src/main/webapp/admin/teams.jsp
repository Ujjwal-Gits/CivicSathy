<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
.btn-outline{border:1px solid #E8E8ED;background:#fff;padding:6px 14px;border-radius:6px;font-size:12px;font-weight:600;color:#005B96;}.btn-outline:hover{background:#F5F5F7;}
.g2{display:grid;grid-template-columns:1fr 1fr;gap:24px;}
table{width:100%;border-collapse:collapse;}
th,td{padding:14px 16px;text-align:left;font-size:13px;border-bottom:1px solid #E8E8ED;}
th{font-weight:700;color:#86868B;text-transform:uppercase;font-size:11px;letter-spacing:.05em;background:#FBFBFD;}
tr:last-child td{border-bottom:none;}
.add-form{background:#F9FAFB;padding:20px;border-radius:8px;border:1px solid #E8E8ED;margin-top:20px;}
</style>
</head>
<body>
<aside class="sidebar">
  <div class="sb-brand"><div class="sb-logo">Civic<span>Sathy</span></div><div class="sb-badge"><i data-lucide="shield-check" style="width:10px;height:10px;"></i> Admin Portal</div></div>
  <nav class="sb-nav">
    <div class="sb-sec">Overview</div>
    <a class="sb-item" href="dashboard.jsp"><i data-lucide="layout-dashboard" style="width:18px;height:18px;"></i> Dashboard</a>
    <a class="sb-item" href="complaints.jsp"><i data-lucide="list-checks" style="width:18px;height:18px;"></i> All Tickets</a>
    <div class="sb-sec">Management</div>
    <a class="sb-item" href="ticket.jsp"><i data-lucide="inbox" style="width:18px;height:18px;"></i> Active Ticket</a>
    <a class="sb-item danger" href="complaints.jsp"><i data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i> Escalations <span class="badge-red">5</span></a>
    <div class="sb-sec">Analytics & Map</div>
    <a class="sb-item" href="map.jsp"><i data-lucide="map" style="width:18px;height:18px;"></i> Ward Heatmap</a>
    <div class="sb-sec">Communications</div>
    <a class="sb-item" href="announcements.jsp"><i data-lucide="radio" style="width:18px;height:18px;"></i> Broadcast</a>
    <div class="sb-sec">System</div>
    <a class="sb-item active" href="teams.jsp"><i data-lucide="users" style="width:18px;height:18px;"></i> Team Management</a>
    <a class="sb-item" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i> Profile & Settings</a>
  </nav>
  <div class="sb-footer"><a href="admin-login.jsp"><button class="sb-logout"><i data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
</aside>
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
            <tr><td><strong>Fire Truck</strong></td><td>3</td><td style="color:#1A7F4B;font-weight:600;">2</td><td style="color:#D93025;font-weight:600;">1</td><td><button class="btn-outline">Edit</button></td></tr>
            <tr><td><strong>Garbage Collection Truck</strong></td><td>8</td><td style="color:#1A7F4B;font-weight:600;">2</td><td style="color:#D93025;font-weight:600;">6</td><td><button class="btn-outline">Edit</button></td></tr>
            <tr><td><strong>Water Tanker</strong></td><td>4</td><td style="color:#1A7F4B;font-weight:600;">3</td><td style="color:#D93025;font-weight:600;">1</td><td><button class="btn-outline">Edit</button></td></tr>
            <tr><td><strong>Road Roller</strong></td><td>2</td><td style="color:#1A7F4B;font-weight:600;">0</td><td style="color:#D93025;font-weight:600;">2</td><td><button class="btn-outline">Edit</button></td></tr>
            <tr><td><strong>Excavator</strong></td><td>2</td><td style="color:#1A7F4B;font-weight:600;">1</td><td style="color:#D93025;font-weight:600;">1</td><td><button class="btn-outline">Edit</button></td></tr>
            <tr><td><strong>Ambulance</strong></td><td>3</td><td style="color:#1A7F4B;font-weight:600;">2</td><td style="color:#D93025;font-weight:600;">1</td><td><button class="btn-outline">Edit</button></td></tr>
          </tbody>
        </table>
      </div>
      <div class="add-form">
        <div style="font-size:14px;font-weight:700;margin-bottom:12px;">Add New Vehicle</div>
        <div style="display:flex;gap:16px;align-items:flex-end;">
          <div class="field" style="flex:2;margin-bottom:0;"><label>Vehicle Name</label><input type="text" class="input-base" placeholder="E.g. Crane, Loader"></div>
          <div class="field" style="flex:1;margin-bottom:0;"><label>Quantity</label><input type="number" class="input-base" value="1"></div>
          <button class="btn-primary"><i data-lucide="plus" style="width:14px;"></i> Add</button>
        </div>
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
            <tr><td><strong>Firebrigade</strong></td><td>15</td><td style="color:#1A7F4B;font-weight:600;">10</td><td style="color:#D93025;font-weight:600;">5</td><td><button class="btn-outline">Edit</button></td></tr>
            <tr><td><strong>Municipality Police</strong></td><td>45</td><td style="color:#1A7F4B;font-weight:600;">30</td><td style="color:#D93025;font-weight:600;">15</td><td><button class="btn-outline">Edit</button></td></tr>
            <tr><td><strong>Repair Technicians</strong></td><td>12</td><td style="color:#1A7F4B;font-weight:600;">0</td><td style="color:#D93025;font-weight:600;">12</td><td><button class="btn-outline">Edit</button></td></tr>
            <tr><td><strong>Sanitation Workers</strong></td><td>35</td><td style="color:#1A7F4B;font-weight:600;">10</td><td style="color:#D93025;font-weight:600;">25</td><td><button class="btn-outline">Edit</button></td></tr>
            <tr><td><strong>Electricians</strong></td><td>8</td><td style="color:#1A7F4B;font-weight:600;">5</td><td style="color:#D93025;font-weight:600;">3</td><td><button class="btn-outline">Edit</button></td></tr>
            <tr><td><strong>Plumbers</strong></td><td>6</td><td style="color:#1A7F4B;font-weight:600;">4</td><td style="color:#D93025;font-weight:600;">2</td><td><button class="btn-outline">Edit</button></td></tr>
          </tbody>
        </table>
      </div>
      <div class="add-form">
        <div style="font-size:14px;font-weight:700;margin-bottom:12px;">Add New Department</div>
        <div style="display:flex;gap:16px;align-items:flex-end;">
          <div class="field" style="flex:2;margin-bottom:0;"><label>Department Name</label><input type="text" class="input-base" placeholder="E.g. Carpenters, Welders"></div>
          <div class="field" style="flex:1;margin-bottom:0;"><label>Member Count</label><input type="number" class="input-base" value="1"></div>
          <button class="btn-primary"><i data-lucide="plus" style="width:14px;"></i> Add</button>
        </div>
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
<script>lucide.createIcons();</script>
</body>
</html>
