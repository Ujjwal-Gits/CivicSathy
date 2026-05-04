<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy - All Tickets</title>
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
.filter-bar{display:flex;gap:12px;margin-bottom:20px;flex-wrap:wrap;}
.f-ctrl{height:40px;border:1px solid #E8E8ED;border-radius:6px;padding:0 12px;font-size:13px;outline:none;background:#fff;font-family:inherit;}
.f-ctrl:focus{border-color:#005B96;}
.table-wrap{background:#fff;border:1px solid #E8E8ED;border-radius:8px;overflow-x:auto;}
table{width:100%;border-collapse:collapse;min-width:900px;}
th,td{padding:14px 16px;text-align:left;font-size:13px;border-bottom:1px solid #E8E8ED;}
th{font-weight:700;color:#86868B;text-transform:uppercase;font-size:11px;letter-spacing:.05em;background:#FBFBFD;}
tr:last-child td{border-bottom:none;}
tr:hover{background:#F0FBFF;}
.sev{display:inline-block;padding:3px 8px;border-radius:4px;font-size:10px;font-weight:700;}
.s-high{background:#FEF2F2;color:#D93025;}.s-med{background:#FEF3C7;color:#B45309;}.s-low{background:#D1FAE5;color:#065F46;}
.btn-view{padding:6px 12px;background:#fff;border:1px solid #E8E8ED;border-radius:4px;font-size:12px;font-weight:600;color:#005B96;text-decoration:none;}.btn-view:hover{border-color:#005B96;}
</style>
</head>
<body>
<aside class="sidebar">
  <div class="sb-brand"><div class="sb-logo">Civic<span>Sathy</span></div><div class="sb-badge"><i data-lucide="shield-check" style="width:10px;height:10px;"></i> Admin Portal</div></div>
  <nav class="sb-nav">
    <div class="sb-sec">Overview</div>
    <a class="sb-item" href="dashboard.jsp"><i data-lucide="layout-dashboard" style="width:18px;height:18px;"></i> Dashboard</a>
    <a class="sb-item active" href="complaints.jsp"><i data-lucide="list-checks" style="width:18px;height:18px;"></i> All Tickets</a>
    <div class="sb-sec">Management</div>
    <a class="sb-item" href="ticket.jsp"><i data-lucide="inbox" style="width:18px;height:18px;"></i> Active Ticket</a>
    <a class="sb-item danger" href="complaints.jsp"><i data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i> Escalations <span class="badge-red">5</span></a>
    <div class="sb-sec">Analytics & Map</div>
    <a class="sb-item" href="map.jsp"><i data-lucide="map" style="width:18px;height:18px;"></i> Ward Heatmap</a>
    <div class="sb-sec">Communications</div>
    <a class="sb-item" href="announcements.jsp"><i data-lucide="radio" style="width:18px;height:18px;"></i> Broadcast</a>
    <div class="sb-sec">System</div>
    <a class="sb-item" href="teams.jsp"><i data-lucide="users" style="width:18px;height:18px;"></i> Team Management</a>
    <a class="sb-item" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i> Profile & Settings</a>
  </nav>
  <div class="sb-footer"><a href="admin-login.jsp"><button class="sb-logout"><i data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
</aside>
<div class="main">
  <header class="topbar"><span class="tb-title">All Tickets & Complaints</span></header>
  <div class="content">
    <div class="filter-bar">
      <input type="text" class="f-ctrl" placeholder="Search ID or Title..." style="flex:1;min-width:200px;">
      <select class="f-ctrl"><option>All Categories</option><option>Roads</option><option>Garbage</option><option>Water</option><option>Electricity</option><option>Flooding</option><option>Safety</option></select>
      <select class="f-ctrl"><option>All Severities</option><option>High</option><option>Medium</option><option>Low</option></select>
      <select class="f-ctrl"><option>All Wards</option><option>Ward 1</option><option>Ward 5</option><option>Ward 14</option></select>
      <select class="f-ctrl"><option>Any Status</option><option>Pending</option><option>In Progress</option><option>Resolved</option><option>Escalated</option></select>
    </div>
    <div class="table-wrap">
      <table>
        <thead><tr><th>Ticket ID</th><th>Date</th><th>Title</th><th>Category</th><th>Ward</th><th>Severity</th><th>Affected</th><th>Status</th><th>Action</th></tr></thead>
        <tbody>
          <tr>
            <td><strong>#TCK-8921</strong></td><td style="color:#86868B;">Oct 12, 10:30 AM</td><td style="font-weight:600;">Large potholes near Itahari Chowk</td><td>Roads</td><td>14</td>
            <td><span class="sev s-high">High</span></td><td>42</td><td><span style="color:#D93025;font-weight:700;">Escalated</span></td><td><a href="ticket.jsp" class="btn-view">Manage</a></td>
          </tr>
          <tr>
            <td><strong>#TCK-8920</strong></td><td style="color:#86868B;">Oct 12, 09:15 AM</td><td style="font-weight:600;">Uncollected garbage near bus park</td><td>Garbage</td><td>5</td>
            <td><span class="sev s-med">Medium</span></td><td>15</td><td><span style="color:#B45309;font-weight:600;">Pending</span></td><td><a href="ticket.jsp" class="btn-view">Manage</a></td>
          </tr>
          <tr>
            <td><strong>#TCK-8919</strong></td><td style="color:#86868B;">Oct 11, 04:20 PM</td><td style="font-weight:600;">Water pipe burst near Dharan Road</td><td>Water</td><td>8</td>
            <td><span class="sev s-low">Low</span></td><td>8</td><td><span style="color:#005B96;font-weight:600;">In Progress</span></td><td><a href="ticket.jsp" class="btn-view">Manage</a></td>
          </tr>
          <tr>
            <td><strong>#TCK-8918</strong></td><td style="color:#86868B;">Oct 11, 02:00 PM</td><td style="font-weight:600;">Street light not working Biratnagar Rd</td><td>Electricity</td><td>3</td>
            <td><span class="sev s-med">Medium</span></td><td>20</td><td><span style="color:#1A7F4B;font-weight:600;">Resolved</span></td><td><a href="ticket.jsp" class="btn-view">Manage</a></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>
<script>lucide.createIcons();</script>
</body>
</html>
