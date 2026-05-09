<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy - Ward Heatmap</title>
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
.content{flex:1;padding:32px;overflow:hidden;display:flex;flex-direction:column;}
.map-container{flex:1;background:#EBF5FF;border:1px solid #BAE6FD;border-radius:8px;position:relative;overflow:hidden;}
.overlay-ui{position:absolute;top:24px;left:24px;background:#fff;padding:20px;border-radius:8px;border:1px solid #E8E8ED;box-shadow:0 10px 25px rgba(0,0,0,0.05);width:260px;}
.hotspot{position:absolute;width:40px;height:40px;background:rgba(217,48,37,0.4);border:2px solid #D93025;border-radius:50%;display:flex;align-items:center;justify-content:center;color:#D93025;font-weight:700;font-size:12px;animation:pulse 2s infinite;}
@keyframes pulse{0%{box-shadow:0 0 0 0 rgba(217,48,37,0.7);}70%{box-shadow:0 0 0 15px rgba(217,48,37,0);}100%{box-shadow:0 0 0 0 rgba(217,48,37,0);}}
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
    <a class="sb-item active" href="map.jsp"><i data-lucide="map" style="width:18px;height:18px;"></i> Ward Heatmap</a>
    <div class="sb-sec">Communications</div>
    <a class="sb-item" href="announcements.jsp"><i data-lucide="radio" style="width:18px;height:18px;"></i> Broadcast</a>
    <div class="sb-sec">System</div>
    <a class="sb-item" href="teams.jsp"><i data-lucide="users" style="width:18px;height:18px;"></i> Team Management</a>
    <a class="sb-item" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i> Profile & Settings</a>
  </nav>
  <div class="sb-footer"><a href="admin-login.jsp"><button class="sb-logout"><i data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
</aside>
<div class="main">
  <header class="topbar"><span class="tb-title">Live Ward Heatmap</span></header>
  <div class="content">
    <div class="map-container">
      <div style="position:absolute;inset:0;display:flex;align-items:center;justify-content:center;font-size:28px;color:#005B96;opacity:0.1;font-weight:700;">ITAHARI SUB-METROPOLITAN MAP (MOCK)</div>
      <div class="hotspot" style="top:30%;left:40%;">14</div>
      <div class="hotspot" style="top:50%;left:60%;width:70px;height:70px;font-size:18px;">32</div>
      <div class="hotspot" style="top:70%;left:30%;width:30px;height:30px;font-size:10px;">5</div>
      <div class="overlay-ui">
        <div style="font-size:13px;font-weight:700;margin-bottom:16px;border-bottom:1px solid #E8E8ED;padding-bottom:12px;">Map Filters</div>
        <label style="display:flex;align-items:center;gap:8px;font-size:13px;margin-bottom:12px;"><input type="checkbox" checked> Roads</label>
        <label style="display:flex;align-items:center;gap:8px;font-size:13px;margin-bottom:12px;"><input type="checkbox" checked> Garbage</label>
        <label style="display:flex;align-items:center;gap:8px;font-size:13px;margin-bottom:12px;"><input type="checkbox"> Water</label>
        <label style="display:flex;align-items:center;gap:8px;font-size:13px;margin-bottom:12px;"><input type="checkbox"> Electricity</label>
        <div style="margin-top:16px;padding-top:12px;border-top:1px solid #E8E8ED;font-size:12px;color:#86868B;">Highest Density: Ward 14</div>
      </div>
    </div>
  </div>
</div>
<script>lucide.createIcons();</script>
</body>
</html>
