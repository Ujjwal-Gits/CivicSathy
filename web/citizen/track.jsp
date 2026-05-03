<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy — Track Complaint</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<link rel="stylesheet" href="../assets/css/citizen.css">
</head>
<body>

<!-- this is top menu -->
<header class="topbar">
  <div class="tb-left"><div class="tb-logo">Civic<span>Sathy</span></div><div class="tb-sub">Itahari Sub-Metropolitan</div></div>
  <div class="tb-right">
    <button class="tb-icon"><i data-lucide="bell" style="width:18px;"></i></button>
    <button class="btn-sos"><i data-lucide="phone" style="width:13px;"></i> SOS</button>
    <a href="login.jsp"><button class="btn-login"><i data-lucide="log-in" style="width:13px;"></i> Login</button></a>
  </div>
</header>

<!-- this is mobile top menu -->
<header class="m-topbar">
  <div class="tb-logo" style="font-size:17px;">Civic<span>Sathy</span></div>
  <div class="tb-right">
    <a href="login.jsp"><button class="btn-login" style="padding:6px 10px;font-size:11px;"><i data-lucide="log-in" style="width:12px;"></i> Login</button></a>
  </div>
</header>

<div class="app">
  <!-- this is left menu -->
  <aside class="sidebar">
    <div class="sb-top"><a href="submit.jsp"><button class="btn-report"><i data-lucide="plus-circle" style="width:16px;"></i> Report an Issue</button></a></div>
    <nav class="sb-nav">
      <div class="sb-sec">Navigation</div>
      <a href="feed.jsp" class="sb-item"><i data-lucide="layout-grid" style="width:16px;"></i> Public Feed</a>
      <a href="track.jsp" class="sb-item active"><i data-lucide="search" style="width:16px;"></i> Track Complaint</a>
      <a href="dashboard.jsp" class="sb-item"><i data-lucide="layout-dashboard" style="width:16px;"></i> My Dashboard</a>
      <a href="profile.jsp" class="sb-item"><i data-lucide="user" style="width:16px;"></i> Profile Settings</a>
      <div class="sb-sec">Quick Contacts</div>
      <a href="tel:100" class="sb-item red"><i data-lucide="siren" style="width:16px;"></i> Emergency: 100</a>
      <a href="tel:101" class="sb-item red"><i data-lucide="flame" style="width:16px;"></i> Fire Brigade: 101</a>
      <a href="tel:102" class="sb-item red"><i data-lucide="heart-pulse" style="width:16px;"></i> Ambulance: 102</a>
    </nav>
  </aside>

  <!-- this is main part -->
  <main class="main">
    <div class="track-box">
      
      <div class="search-card">
        <div class="sc-title">Track Ticket Status</div>
        <div class="sc-sub">Enter your ticket ID to view progress (No login required)</div>
        <div class="search-wrap">
          <input type="text" placeholder="e.g. TCK-8921" value="TCK-8921">
          <button class="btn-track">Track</button>
        </div>
      </div>

      <div class="timeline-card">
        <div class="tc-header">
          <div class="tc-id">Ticket #TCK-8921</div>
          <div class="badge">In Progress</div>
        </div>

        <div class="tl">
          
          <div class="t-item">
            <div class="t-dot done"><i data-lucide="check" style="width:12px;"></i></div>
            <div class="t-title">Complaint Submitted</div>
            <div class="t-desc">Ticket created for "Large cracks appearing on Itahari main bridge".</div>
            <div class="t-time">Oct 24, 09:30 AM</div>
          </div>

          <div class="t-item">
            <div class="t-dot done"><i data-lucide="check" style="width:12px;"></i></div>
            <div class="t-title">Assigned to Department</div>
            <div class="t-desc">Assigned to Infrastructure & Road Maintenance.</div>
            <div class="t-time">Oct 24, 10:15 AM</div>
          </div>

          <div class="t-item">
            <div class="t-dot active"><i data-lucide="truck" style="width:12px;"></i></div>
            <div class="t-title">Team Dispatched (In Progress)</div>
            <div class="t-desc">Road Maintenance Team A is currently working on site.</div>
            <div class="t-time">Oct 24, 11:30 AM</div>
          </div>

          <div class="t-item">
            <div class="t-dot"><i data-lucide="clock" style="width:12px;color:#86868B;"></i></div>
            <div class="t-title" style="color:#86868B;">Resolved</div>
            <div class="t-desc" style="color:#86868B;">Pending completion by field team.</div>
          </div>

        </div>
      </div>

    </div>
  </main>
</div>

<!-- this is mobile bottom menu -->
<nav class="m-bnav">
  <a href="feed.jsp" class="mn"><i data-lucide="layout-grid" style="width:20px;"></i>Feed</a>
  <a href="track.jsp" class="mn active"><i data-lucide="compass" style="width:20px;"></i>Track</a>
  <div class="mfab-w"><a href="submit.jsp" class="mfab"><i data-lucide="camera" style="width:24px;"></i></a></div>
  <a href="tel:100" class="mn red"><i data-lucide="siren" style="width:20px;"></i>Emergency</a>
  <a href="login.jsp" class="mn"><i data-lucide="user" style="width:20px;"></i>Profile</a>
</nav>

<script>lucide.createIcons();</script>
</body>
</html>




