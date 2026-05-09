<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy - Profile Settings</title>
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
.panel{background:#fff;border:1px solid #E8E8ED;border-radius:8px;padding:32px;max-width:600px;margin-bottom:24px;}
.panel-hd{font-size:13px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.05em;margin-bottom:24px;border-bottom:1px solid #F5F5F7;padding-bottom:12px;}
.field{margin-bottom:20px;}.field label{display:block;font-size:12px;font-weight:700;color:#0A0A0A;margin-bottom:8px;}
.input-base{width:100%;height:44px;border:1px solid #E8E8ED;border-radius:6px;padding:0 14px;font-size:14px;font-family:inherit;color:#0A0A0A;outline:none;background:#fff;transition:.15s;}
.input-base:focus{border-color:#005B96;box-shadow:0 0 0 3px #EBF5FF;}
.input-base:disabled{background:#F9FAFB;color:#86868B;}
.btn-primary{background:#0A0A0A;color:#fff;border:none;height:44px;padding:0 24px;border-radius:6px;font-size:14px;font-weight:600;display:inline-flex;align-items:center;gap:8px;}
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
    <a class="sb-item" href="teams.jsp"><i data-lucide="users" style="width:18px;height:18px;"></i> Team Management</a>
    <a class="sb-item active" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i> Profile & Settings</a>
  </nav>
  <div class="sb-footer"><a href="admin-login.jsp"><button class="sb-logout"><i data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
</aside>
<div class="main">
  <header class="topbar"><span class="tb-title">Profile Settings</span></header>
  <div class="content">
    <div class="panel">
      <div class="panel-hd">Municipality Configuration</div>
      <p style="font-size:13px;color:#86868B;margin-bottom:24px;">This root profile manages the municipality scope. Profile updates require email verification.</p>
      <div class="field"><label>Municipality Name</label><input type="text" class="input-base" value="Itahari Sub-Metropolitan City"></div>
      <div class="field"><label>Main Administrative Email</label><input type="email" class="input-base" value="admin@itahari.gov.np"></div>
      <div class="field"><label>Administrative Ward Control</label><input type="text" class="input-base" value="Central Level (All Wards)" disabled></div>
      <button class="btn-primary" style="margin-top:8px;">Save Changes</button>
    </div>
  </div>
</div>
<script>lucide.createIcons();</script>
</body>
</html>
