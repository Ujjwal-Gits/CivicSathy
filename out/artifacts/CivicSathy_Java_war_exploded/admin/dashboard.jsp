<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy - Dashboard</title>
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
</style>
</head>
<body>
<aside class="sidebar">
  <div class="sb-brand"><div class="sb-logo">Civic<span>Sathy</span></div><div class="sb-badge"><i data-lucide="shield-check" style="width:10px;height:10px;"></i> Admin Portal</div></div>
  <nav class="sb-nav">
    <div class="sb-sec">Overview</div>
    <a class="sb-item active" href="dashboard.jsp"><i data-lucide="layout-dashboard" style="width:18px;height:18px;"></i> Dashboard</a>
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
    <a class="sb-item" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i> Profile & Settings</a>
  </nav>
  <div class="sb-footer"><a href="../citizen/admin-login.jsp"><button class="sb-logout"><i data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
</aside>
<div class="main">
  <header class="topbar">
    <div><span class="tb-title">Analytics Dashboard</span><span class="tb-sub">Itahari Sub-Metropolitan City</span></div>
  </header>
  <div class="content">

    <!-- (7) ESCALATION ALERT -->
    <div class="alert">
      <i data-lucide="alert-triangle" style="width:18px;height:18px;color:#D93025;flex-shrink:0;"></i>
      <p><strong>5 tickets</strong> have exceeded the 48-hour SLA threshold and require immediate escalation.</p>
      <a href="complaints.jsp">Review Now &rarr;</a>
    </div>

    <!-- (1) ANALYTICS METRICS -->
    <div class="metrics">
      <div class="metric"><div class="m-val">246</div><div class="m-lbl">Total Reports</div><div class="m-sub up"><i data-lucide="trending-up" style="width:12px;"></i> +12 today</div></div>
      <div class="metric"><div class="m-val" style="color:#C77B17;">54</div><div class="m-lbl">Pending</div><div class="m-sub dn"><i data-lucide="trending-up" style="width:12px;"></i> +5 from yesterday</div></div>
      <div class="metric"><div class="m-val" style="color:#005B96;">22</div><div class="m-lbl">In Progress</div><div class="m-sub">Across 8 teams</div></div>
      <div class="metric"><div class="m-val" style="color:#1A7F4B;">170</div><div class="m-lbl">Resolved</div><div class="m-sub up"><i data-lucide="trending-up" style="width:12px;"></i> 82% rate</div></div>
      <div class="metric"><div class="m-val" style="color:#005B96;">3.2h</div><div class="m-lbl">Avg Resolution</div><div class="m-sub up"><i data-lucide="trending-down" style="width:12px;"></i> 15% faster</div></div>
    </div>

    <!-- ROW: CATEGORY CHARTS + WARD CHARTS + LIVE MAP -->
    <div class="g3">
      <!-- (1) Category Breakdown -->
      <div class="panel">
        <div class="panel-hd"><i data-lucide="bar-chart-3" style="width:14px;"></i> Reports by Category</div>
        <div class="bar-item"><div class="bar-top"><span>Roads</span><span>82</span></div><div class="bar-bg"><div class="bar-fill" style="width:82%;background:#005B96;"></div></div></div>
        <div class="bar-item"><div class="bar-top"><span>Garbage</span><span>61</span></div><div class="bar-bg"><div class="bar-fill" style="width:61%;background:#C77B17;"></div></div></div>
        <div class="bar-item"><div class="bar-top"><span>Water</span><span>45</span></div><div class="bar-bg"><div class="bar-fill" style="width:45%;background:#38BDF8;"></div></div></div>
        <div class="bar-item"><div class="bar-top"><span>Electricity</span><span>33</span></div><div class="bar-bg"><div class="bar-fill" style="width:33%;background:#818CF8;"></div></div></div>
        <div class="bar-item"><div class="bar-top"><span>Flooding</span><span>15</span></div><div class="bar-bg"><div class="bar-fill" style="width:15%;background:#1A7F4B;"></div></div></div>
        <div class="bar-item"><div class="bar-top"><span>Safety</span><span>10</span></div><div class="bar-bg"><div class="bar-fill" style="width:10%;background:#D93025;"></div></div></div>
      </div>
      <!-- (1) Ward Breakdown -->
      <div class="panel">
        <div class="panel-hd"><i data-lucide="map-pin" style="width:14px;"></i> Top Wards</div>
        <div class="bar-item"><div class="bar-top"><span>Ward 14</span><span>52</span></div><div class="bar-bg"><div class="bar-fill" style="width:100%;background:#D93025;"></div></div></div>
        <div class="bar-item"><div class="bar-top"><span>Ward 5</span><span>38</span></div><div class="bar-bg"><div class="bar-fill" style="width:73%;background:#C77B17;"></div></div></div>
        <div class="bar-item"><div class="bar-top"><span>Ward 8</span><span>30</span></div><div class="bar-bg"><div class="bar-fill" style="width:58%;background:#005B96;"></div></div></div>
        <div class="bar-item"><div class="bar-top"><span>Ward 3</span><span>22</span></div><div class="bar-bg"><div class="bar-fill" style="width:42%;background:#818CF8;"></div></div></div>
      </div>
      <!-- (1) Live Map Preview -->
      <div class="panel">
        <div class="panel-hd"><i data-lucide="radio" style="width:14px;"></i> Live Complaints</div>
        <div class="map-mini">
          <div style="font-size:10px;color:#005B96;opacity:0.3;font-weight:700;">ITAHARI MAP</div>
          <div class="dot" style="top:25%;left:35%;"></div>
          <div class="dot" style="top:55%;left:60%;width:16px;height:16px;"></div>
          <div class="dot" style="top:70%;left:25%;"></div>
        </div>
        <a href="map.jsp" style="font-size:12px;color:#005B96;font-weight:600;">Open Full Heatmap &rarr;</a>
      </div>
    </div>

    <!-- ROW: RECENT TICKETS + NOTIFICATIONS + ACTIVITY LOG -->
    <div class="g3">
      <!-- (2)(3) Recent Tickets -->
      <div class="panel">
        <div class="panel-hd"><i data-lucide="list-checks" style="width:14px;"></i> Recent Tickets <a href="complaints.jsp" style="margin-left:auto;font-size:11px;color:#005B96;font-weight:600;">View All &rarr;</a></div>
        <div class="mini-item"><div><div style="font-size:13px;font-weight:600;">Potholes near Itahari Chowk</div><div style="font-size:11px;color:#86868B;">Ward 14 &middot; Roads &middot; #TCK-8921 &middot; 2h ago</div></div><span class="chip c-esc">Escalated</span></div>
        <div class="mini-item"><div><div style="font-size:13px;font-weight:600;">Garbage at bus park junction</div><div style="font-size:11px;color:#86868B;">Ward 5 &middot; Garbage &middot; #TCK-8920 &middot; 5h ago</div></div><span class="chip c-pend">Pending</span></div>
        <div class="mini-item"><div><div style="font-size:13px;font-weight:600;">Water pipe burst Dharan Rd</div><div style="font-size:11px;color:#86868B;">Ward 8 &middot; Water &middot; #TCK-8919 &middot; 8h ago</div></div><span class="chip c-prog">In Progress</span></div>
        <div class="mini-item"><div><div style="font-size:13px;font-weight:600;">Street light Biratnagar Rd</div><div style="font-size:11px;color:#86868B;">Ward 3 &middot; Electricity &middot; #TCK-8918 &middot; 1d ago</div></div><span class="chip c-res">Resolved</span></div>
      </div>
      <!-- (7) Priority Notifications -->
      <div class="panel">
        <div class="panel-hd"><i data-lucide="bell" style="width:14px;"></i> Priority Alerts</div>
        <div class="n-item">
          <div class="n-icon" style="background:#FEF2F2;color:#D93025;"><i data-lucide="flame" style="width:14px;"></i></div>
          <div><div style="font-size:12px;font-weight:600;">Flood Risk - Ward 5</div><div style="font-size:11px;color:#86868B;">12 new complaints in the past hour.</div></div>
        </div>
        <div class="n-item">
          <div class="n-icon" style="background:#FEF3C7;color:#B45309;"><i data-lucide="truck" style="width:14px;"></i></div>
          <div><div style="font-size:12px;font-weight:600;">Resource Shortage</div><div style="font-size:11px;color:#86868B;">All sanitation trucks occupied.</div></div>
        </div>
        <div class="n-item">
          <div class="n-icon" style="background:#D1FAE5;color:#065F46;"><i data-lucide="check-circle" style="width:14px;"></i></div>
          <div><div style="font-size:12px;font-weight:600;">TCK-8918 Resolved</div><div style="font-size:11px;color:#86868B;">Biratnagar Rd light fixed.</div></div>
        </div>
      </div>
      <!-- Activity History -->
      <div class="panel">
        <div class="panel-hd"><i data-lucide="history" style="width:14px;"></i> Activity Log</div>
        <div class="log-item"><div style="font-size:12px;"><strong>Ujjwal Khatri</strong> resolved <a href="ticket.jsp" style="color:#005B96;font-weight:600;">#TCK-8918</a></div><div class="log-time">10 min ago</div></div>
        <div class="log-item"><div style="font-size:12px;"><strong>Sita Thapa</strong> escalated <a href="#" style="color:#005B96;font-weight:600;">#TCK-8921</a> severity to High</div><div class="log-time">1 hour ago</div></div>
        <div class="log-item"><div style="font-size:12px;"><strong>System</strong> auto-flagged 5 tickets past 48h SLA</div><div class="log-time">3 hours ago</div></div>
        <div class="log-item"><div style="font-size:12px;"><strong>Ramesh Poudel</strong> added 2 new sanitation trucks</div><div class="log-time">Yesterday</div></div>
      </div>
    </div>

    <!-- (10) AI WEEKLY SUMMARY -->
    <div class="panel" style="background:#F0FBFF;border-color:#BAE6FD;">
      <div class="panel-hd" style="color:#005B96;"><i data-lucide="sparkles" style="width:14px;"></i> AI Weekly Summary Report <span style="margin-left:auto;font-size:11px;font-weight:500;">Auto-generated &middot; Oct 5 - Oct 12</span></div>
      <div style="display:grid;grid-template-columns:repeat(5,1fr);gap:16px;font-size:13px;">
        <div><div style="font-weight:700;font-size:20px;">120</div><div style="color:#86868B;font-size:11px;">Total Complaints</div></div>
        <div><div style="font-weight:700;font-size:20px;">Roads</div><div style="color:#86868B;font-size:11px;">Top Category (45%)</div></div>
        <div><div style="font-weight:700;font-size:20px;">Ward 14</div><div style="color:#86868B;font-size:11px;">Most Impacted</div></div>
        <div><div style="font-weight:700;font-size:20px;">82%</div><div style="color:#86868B;font-size:11px;">Resolution Rate</div></div>
        <div><div style="font-weight:700;font-size:20px;color:#D93025;">5</div><div style="color:#86868B;font-size:11px;">Unresolved Flagged</div></div>
      </div>
    </div>

  </div>
</div>
<script>lucide.createIcons();</script>
</body>
</html>
