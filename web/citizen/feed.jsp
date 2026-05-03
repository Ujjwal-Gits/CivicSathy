<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy — Public Feed</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<link rel="stylesheet" href="../assets/css/citizen.css">
</head>
<body>

<!-- this is top menu -->
<header class="topbar">
  <div class="tb-left"><div class="tb-logo">Civic<span>Sathy</span></div><div class="tb-sub">Itahari Sub-Metropolitan</div></div>
  <div class="tb-right">
    <button class="tb-icon"><i data-lucide="search" style="width:18px;"></i></button>
    <button class="tb-icon"><i data-lucide="bell" style="width:18px;"></i><span class="notif-dot"></span></button>
    <button class="btn-sos"><i data-lucide="phone" style="width:13px;"></i> SOS</button>
    <a href="login.jsp"><button class="btn-login-top"><i data-lucide="log-in" style="width:13px;"></i> Login</button></a>
  </div>
</header>

<!-- this is mobile top menu -->
<header class="m-topbar">
  <div class="tb-logo" style="font-size:17px;">Civic<span>Sathy</span></div>
  <div class="tb-right">
    <button class="btn-sos" style="padding:6px 10px;font-size:11px;"><i data-lucide="phone" style="width:12px;"></i> SOS</button>
    <a href="login.jsp"><button class="btn-login-top" style="padding:6px 10px;font-size:11px;"><i data-lucide="log-in" style="width:12px;"></i> Login</button></a>
  </div>
</header>

<div class="app">

<!-- this is left menu -->
<aside class="sidebar">
  <div class="sb-top"><a href="submit.jsp"><button class="btn-report"><i data-lucide="plus-circle" style="width:16px;"></i> Report an Issue</button></a></div>
  <nav class="sb-nav">
    <div class="sb-sec">Navigation</div>
    <a href="feed.jsp" class="sb-item active"><i data-lucide="layout-grid" style="width:16px;"></i> Public Feed</a>
    <a href="track.jsp" class="sb-item"><i data-lucide="search" style="width:16px;"></i> Track Complaint</a>
    <a href="dashboard.jsp" class="sb-item"><i data-lucide="layout-dashboard" style="width:16px;"></i> My Dashboard</a>
    <a href="profile.jsp" class="sb-item"><i data-lucide="user" style="width:16px;"></i> Profile Settings</a>
    <div class="sb-sec">Quick Contacts</div>
    <a href="tel:100" class="sb-item red"><i data-lucide="siren" style="width:16px;"></i> Emergency: 100</a>
    <a href="tel:101" class="sb-item red"><i data-lucide="flame" style="width:16px;"></i> Fire Brigade: 101</a>
    <a href="tel:102" class="sb-item red"><i data-lucide="heart-pulse" style="width:16px;"></i> Ambulance: 102</a>
  </nav>
</aside>

<div class="main">
<!-- this is feed -->
<div class="feed-col">

  <div class="fh">
    <div><h1 class="fh-title">Public Feed</h1><div class="fh-sub">24 reports · Sorted by recent activity</div></div>
    <div class="fh-btns">
      <button class="fbtn active"><i data-lucide="clock" style="width:13px;"></i> Recent</button>
      <button class="fbtn"><i data-lucide="trending-up" style="width:13px;"></i> Most Affected</button>
      <button class="fbtn"><i data-lucide="sliders-horizontal" style="width:13px;"></i> Filter</button>
    </div>
  </div>

  <div class="tabs">
    <div class="tab active">All Issues</div><div class="tab">Roads</div><div class="tab">Garbage</div><div class="tab">Water</div><div class="tab">Electricity</div><div class="tab">Flooding</div><div class="tab">Safety</div>
  </div>

  <!-- this is duplicate detection alert (feature 9) -->
  <div class="dup-alert"><i data-lucide="copy" style="width:16px;flex-shrink:0;"></i> A similar complaint about road cracks in Ward 14 was reported 3 hours ago. <a href="#" style="color:#92400E;font-weight:700;margin-left:auto;white-space:nowrap;">View →</a></div>

  <!-- this is card 1 - with image (features 1,2,3,4,12) -->
  <div class="card">
    <div class="c-top">
      <div class="c-cat"><div class="dot" style="background:#C77B17;"></div> Infrastructure</div>
      <div class="badge b-prog">In Progress</div>
    </div>
    <h2 class="c-title">Large cracks appearing on Itahari main bridge</h2>
    <img src="https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?auto=format&fit=crop&w=800&q=80" alt="Bridge cracks" class="c-img">
    <p class="c-desc">The cracks have widened significantly over the last 48 hours. Heavy vehicles are slowing down causing major traffic congestion during peak hours.</p>
    <div class="c-meta">
      <div><i data-lucide="map-pin" style="width:13px;"></i> Itahari Chowk, Ward 14</div>
      <div><i data-lucide="clock" style="width:13px;"></i> 2 hours ago</div>
      <div><i data-lucide="user-x" style="width:13px;"></i> Anonymous</div>
    </div>
    <!-- this is admin reply -->
    <div style="background:#F0FBFF;border:1px solid #BAE6FD;border-radius:6px;padding:10px 14px;margin-bottom:12px;font-size:12px;color:#005B96;">
      <strong>Admin Update:</strong> Road Maintenance Team A has been dispatched. ETA 2 hours.
      <div style="font-size:10px;color:#86868B;margin-top:4px;">— Ujjwal Rupakheti, 30 min ago</div>
    </div>
    <div class="c-foot">
      <div class="pill p-blue" onclick="this.innerHTML='<i data-lucide=\'users\' style=\'width:13px;\'></i> 43 AFFECTED'; lucide.createIcons();"><i data-lucide="users" style="width:13px;"></i> 42 AFFECTED — I'm Affected Too</div>
      <div class="pill p-grey"><i data-lucide="message-square" style="width:13px;"></i> 8 Comments</div>
      <a href="#" class="vlink">View Details <i data-lucide="chevron-right" style="width:14px;"></i></a>
    </div>
  </div>

  <!-- this is card 2 - resolve confirmation (feature 8) -->
  <div class="card">
    <div class="c-top">
      <div class="c-cat"><div class="dot" style="background:#1A7F4B;"></div> Sanitation</div>
      <div class="badge b-pend">Pending</div>
    </div>
    <h2 class="c-title">Uncollected garbage piling near Ward 5 junction</h2>
    <p class="c-desc">Garbage has not been collected for 3 days. Strong odor is spreading to nearby houses and shops, posing a serious health risk.</p>
    <div class="c-meta">
      <div><i data-lucide="map-pin" style="width:13px;"></i> Ward 5</div>
      <div><i data-lucide="clock" style="width:13px;"></i> 5 hours ago</div>
    </div>
    <div class="c-foot">
      <div class="pill p-blue"><i data-lucide="users" style="width:13px;"></i> 15 AFFECTED</div>
      <div class="pill p-grey"><i data-lucide="message-square" style="width:13px;"></i> 3 Comments</div>
      <a href="#" class="vlink">View Details <i data-lucide="chevron-right" style="width:14px;"></i></a>
    </div>
  </div>

  <!-- this is card 3 - resolved + confirmation flow (feature 8) -->
  <div class="card">
    <div class="c-top">
      <div class="c-cat"><div class="dot" style="background:#005B96;"></div> Water Supply</div>
      <div class="badge b-res">Resolved</div>
    </div>
    <h2 class="c-title">Broken water pipe flooding the street</h2>
    <p class="c-desc">A main water pipe burst near the ring road. Municipality repair team arrived and resolved the issue within 6 hours.</p>
    <div class="c-meta">
      <div><i data-lucide="map-pin" style="width:13px;"></i> Ward 10</div>
      <div><i data-lucide="clock" style="width:13px;"></i> 1 day ago</div>
    </div>
    <div class="c-foot">
      <div class="pill p-blue"><i data-lucide="users" style="width:13px;"></i> 31 AFFECTED</div>
      <div class="pill p-grey"><i data-lucide="message-square" style="width:13px;"></i> 12 Comments</div>
      <a href="#" class="vlink">View Details <i data-lucide="chevron-right" style="width:14px;"></i></a>
    </div>
  </div>

</div>

<!-- this is right panel -->
<div class="right-col">
  <div class="r-panel">
    <div class="r-hd">Today's Stats</div>
    <div class="st-row"><span>Total Reports</span><span class="st-val" style="color:#1D1D1F;">246</span></div>
    <div class="st-row"><span>Resolved Today</span><span class="st-val" style="color:#1A7F4B;">38</span></div>
    <div class="st-row"><span>Pending</span><span class="st-val" style="color:#B45309;">54</span></div>
    <div class="st-row"><span>In Progress</span><span class="st-val" style="color:#005B96;">22</span></div>
  </div>
  <!-- this is notifications (feature 11) -->
  <div class="r-panel">
    <div class="r-hd">Notifications</div>
    <div class="n-item"><div class="n-title">Your complaint #TCK-8921 is now In Progress</div><div class="n-time">30 min ago</div></div>
    <div class="n-item"><div class="n-title">Admin posted an update on #TCK-8920</div><div class="n-time">2 hours ago</div></div>
    <div class="n-item"><div class="n-title">#TCK-8918 marked as Resolved — confirm?</div><div class="n-time">1 day ago</div></div>
  </div>
  <!-- this is notice board -->
  <div class="r-panel" style="background:linear-gradient(to bottom right, #005B96, #003F6B); color:#fff; border:none;">
    <div class="r-hd" style="color:#BAE6FD;">Official Announcements</div>
    <div style="margin-bottom:12px;">
      <div style="font-size:13px;font-weight:700;margin-bottom:4px;display:flex;align-items:center;gap:6px;"><i data-lucide="megaphone" style="width:14px;color:#BAE6FD;"></i> Road Closure Notice</div>
      <div style="font-size:11px;opacity:0.9;line-height:1.4;">Main highway near Milan Chowk will be closed for maintenance this weekend. Please use alternate routes.</div>
    </div>
    <div style="padding-top:12px;border-top:1px solid rgba(255,255,255,0.15);">
      <div style="font-size:13px;font-weight:700;margin-bottom:4px;display:flex;align-items:center;gap:6px;"><i data-lucide="droplets" style="width:14px;color:#BAE6FD;"></i> Water Supply Alert</div>
      <div style="font-size:11px;opacity:0.9;line-height:1.4;">Scheduled water supply interruption in Ward 10 tomorrow from 10 AM to 2 PM.</div>
    </div>
  </div>
</div>

</div><!-- this is /main -->
</div><!-- this is /app -->

<!-- this is mobile bottom menu -->
<nav class="m-bnav">
  <a href="feed.jsp" class="mn active"><i data-lucide="layout-grid" style="width:20px;"></i>Feed</a>
  <a href="track.jsp" class="mn"><i data-lucide="compass" style="width:20px;"></i>Track</a>
  <div class="mfab-w"><a href="submit.jsp" class="mfab"><i data-lucide="camera" style="width:24px;"></i></a></div>
  <a href="tel:100" class="mn red"><i data-lucide="siren" style="width:20px;"></i>Emergency</a>
  <a href="login.jsp" class="mn"><i data-lucide="user" style="width:20px;"></i>Profile</a>
</nav>

<script>lucide.createIcons();</script>
</body>
</html>




