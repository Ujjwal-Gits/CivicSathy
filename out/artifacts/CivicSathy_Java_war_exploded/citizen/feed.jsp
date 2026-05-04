<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy — Public Feed</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<style>
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'DM Sans',sans-serif;background:#F5F5F7;color:#1D1D1F;-webkit-font-smoothing:antialiased;display:flex;flex-direction:column;min-height:100vh;}
a{text-decoration:none;color:inherit;}button{cursor:pointer;font-family:inherit;border:none;}

/* TOPBAR - matches admin */
.topbar{width:100%;height:60px;background:#fff;border-bottom:1px solid #E8E8ED;display:flex;align-items:center;justify-content:space-between;padding:0 24px;position:sticky;top:0;z-index:100;}
.tb-left{display:flex;flex-direction:column;}
.tb-logo{font-size:18px;font-weight:700;letter-spacing:-.3px;line-height:1.1;}.tb-logo span{color:#005B96;}
.tb-sub{font-size:9px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.08em;}
.tb-right{display:flex;align-items:center;gap:8px;}
.tb-icon{width:36px;height:36px;background:none;border-radius:6px;display:flex;align-items:center;justify-content:center;color:#86868B;position:relative;}.tb-icon:hover{background:#F5F5F7;color:#1D1D1F;}
.notif-dot{position:absolute;top:6px;right:6px;width:8px;height:8px;background:#D93025;border-radius:50%;border:2px solid #fff;}
.btn-sos{background:#D93025;color:#fff;padding:8px 14px;border-radius:6px;font-size:12px;font-weight:700;display:flex;align-items:center;gap:5px;}
.btn-login-top{background:#005B96;color:#fff;padding:8px 14px;border-radius:6px;font-size:12px;font-weight:600;display:flex;align-items:center;gap:5px;}

/* LAYOUT */
.app{display:flex;flex:1;}

/* SIDEBAR - matches admin 240px */
.sidebar{width:240px;flex-shrink:0;background:#fff;border-right:1px solid #E8E8ED;display:flex;flex-direction:column;height:calc(100vh - 60px);position:sticky;top:60px;overflow-y:auto;}
.sb-top{padding:16px 12px;}
.btn-report{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;padding:10px;background:#005B96;color:#fff;border-radius:6px;font-size:13px;font-weight:600;transition:.15s;}.btn-report:hover{background:#004A7C;}
.sb-nav{flex:1;padding:8px 12px;overflow-y:auto;}
.sb-sec{font-size:10px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.08em;padding:0 8px;margin:16px 0 8px;}.sb-sec:first-child{margin-top:0;}
.sb-item{display:flex;align-items:center;gap:10px;padding:10px;border-radius:6px;font-size:13px;font-weight:500;color:#1D1D1F;margin-bottom:2px;transition:.15s;}
.sb-item:hover{background:#F5F5F7;}.sb-item.active{background:#EBF5FF;color:#005B96;font-weight:600;}
.sb-item.red{color:#D93025;}.sb-item.red:hover{background:#FEF2F2;}

/* MAIN */
.main{flex:1;display:flex;min-width:0;}
.feed-col{flex:1;padding:24px 28px;overflow-y:auto;height:calc(100vh - 60px);}
.right-col{width:280px;flex-shrink:0;padding:24px 20px 24px 0;height:calc(100vh - 60px);overflow-y:auto;position:sticky;top:60px;}

/* FEED HEADER */
.fh{display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px;}
.fh-title{font-size:20px;font-weight:700;letter-spacing:-.3px;}
.fh-sub{font-size:12px;color:#86868B;margin-top:2px;}
.fh-btns{display:flex;gap:6px;}
.fbtn{display:flex;align-items:center;gap:5px;padding:7px 12px;border-radius:6px;font-size:12px;font-weight:600;background:#fff;border:1px solid #E8E8ED;color:#4B5563;}
.fbtn.active{background:#005B96;color:#fff;border-color:#005B96;}

/* TABS */
.tabs{display:flex;gap:0;margin-bottom:20px;overflow-x:auto;scrollbar-width:none;}.tabs::-webkit-scrollbar{display:none;}
.tab{padding:7px 14px;font-size:12px;font-weight:600;border:1px solid #E8E8ED;background:#fff;color:#4B5563;white-space:nowrap;cursor:pointer;}
.tab:first-child{border-radius:6px 0 0 6px;}.tab:last-child{border-radius:0 6px 6px 0;}.tab+.tab{border-left:none;}
.tab.active{background:#1D1D1F;color:#fff;border-color:#1D1D1F;}

/* CARDS */
.card{background:#fff;border:1px solid #E8E8ED;border-radius:8px;padding:20px;margin-bottom:14px;}
.c-top{display:flex;justify-content:space-between;align-items:center;margin-bottom:8px;}
.c-cat{display:flex;align-items:center;gap:6px;font-size:11px;font-weight:700;color:#4B5563;text-transform:uppercase;letter-spacing:.04em;}
.dot{width:8px;height:8px;border-radius:50%;flex-shrink:0;}
.badge{font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:.03em;padding:4px 8px;border-radius:4px;}
.b-prog{background:#EBF5FF;color:#005B96;}.b-pend{background:#FEF3C7;color:#B45309;}.b-res{background:#D1FAE5;color:#065F46;}
.c-title{font-size:15px;font-weight:700;line-height:1.35;margin-bottom:6px;}
.c-desc{font-size:13px;color:#6B7280;line-height:1.5;margin-bottom:12px;}
.c-img{width:100%;max-height:400px;object-fit:cover;border-radius:10px;margin:14px 0;border:1px solid #E8E8ED;}
.c-meta{display:flex;align-items:center;gap:14px;font-size:11px;color:#86868B;margin-bottom:14px;flex-wrap:wrap;}
.c-meta div{display:flex;align-items:center;gap:4px;}
.c-foot{display:flex;align-items:center;gap:8px;padding-top:12px;border-top:1px solid #F0F0F0;flex-wrap:wrap;}
.pill{display:inline-flex;align-items:center;gap:4px;padding:5px 10px;border-radius:6px;font-size:11px;font-weight:700;}
.p-blue{background:#EBF5FF;color:#005B96;cursor:pointer;transition:.15s;}.p-blue:hover{background:#D1EFFF;}
.p-grey{background:#F5F5F7;color:#4B5563;}
.vlink{margin-left:auto;font-size:12px;font-weight:700;color:#005B96;display:flex;align-items:center;gap:2px;}

/* DUPLICATE ALERT */
.dup-alert{background:#FEF3C7;border:1px solid #FDE68A;border-radius:6px;padding:10px 14px;margin-bottom:14px;display:flex;align-items:center;gap:8px;font-size:12px;color:#92400E;font-weight:600;}

/* RIGHT PANEL */
.r-panel{background:#fff;border:1px solid #E8E8ED;border-radius:8px;padding:16px;margin-bottom:16px;}
.r-hd{font-size:10px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.08em;margin-bottom:14px;}
.st-row{display:flex;justify-content:space-between;font-size:13px;color:#4B5563;margin-bottom:10px;}.st-row:last-child{margin-bottom:0;}
.st-val{font-weight:700;font-size:14px;}
/* Notifications */
.n-item{padding:10px 0;border-bottom:1px solid #F5F5F7;}.n-item:last-child{border:none;}
.n-title{font-size:12px;font-weight:600;color:#1D1D1F;}.n-time{font-size:10px;color:#86868B;margin-top:2px;}
/* Resolve Confirm */
.resolve-banner{background:#D1FAE5;border:1px solid #6EE7B7;border-radius:8px;padding:14px;margin-bottom:14px;}
.resolve-q{font-size:13px;font-weight:600;color:#065F46;margin-bottom:10px;}
.resolve-btns{display:flex;gap:8px;}
.rbtn{padding:6px 14px;border-radius:6px;font-size:12px;font-weight:700;}
.rbtn-yes{background:#065F46;color:#fff;}.rbtn-no{background:#fff;color:#D93025;border:1px solid #FECACA;}

/* MOBILE TOPBAR */
.m-topbar{display:none;}
/* MOBILE BOTTOM NAV */
.m-bnav{display:none;}

/* RESPONSIVE */
@media(max-width:1100px){.right-col{display:none;}}
@media(max-width:768px){
  .sidebar{display:none;}.topbar{display:none;}
  .m-topbar{display:flex;align-items:center;justify-content:space-between;padding:10px 16px;background:#fff;border-bottom:1px solid #E8E8ED;position:sticky;top:0;z-index:100;}
  .feed-col{padding:16px;height:auto;}
  .fh-btns{display:none;}
  .c-img{height:140px;}
  .m-bnav{display:flex;align-items:center;justify-content:space-around;position:fixed;bottom:0;left:0;right:0;z-index:100;background:#fff;height:64px;padding:0 8px;border-top:1px solid #E8E8ED;padding-bottom:env(safe-area-inset-bottom);}
  .mn{display:flex;flex-direction:column;align-items:center;justify-content:center;gap:4px;flex:1;font-size:9px;font-weight:700;text-transform:uppercase;letter-spacing:.04em;color:#86868B;}
  .mn.active{color:#005B96;}.mn.red{color:#D93025;}
  .mfab-w{display:flex;flex-direction:column;align-items:center;justify-content:center;flex:1;}
  .mfab{width:48px;height:48px;background:#005B96;border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;transform:translateY(-12px);box-shadow:0 4px 8px rgba(0,91,150,.25);}
  .feed-col{padding-bottom:80px;}
}
</style>
</head>
<body>

<!-- DESKTOP TOPBAR -->
<header class="topbar">
  <div class="tb-left"><div class="tb-logo">Civic<span>Sathy</span></div><div class="tb-sub">Itahari Sub-Metropolitan</div></div>
  <div class="tb-right">
    <button class="tb-icon"><i data-lucide="search" style="width:18px;"></i></button>
    <button class="tb-icon"><i data-lucide="bell" style="width:18px;"></i><span class="notif-dot"></span></button>
    <button class="btn-sos"><i data-lucide="phone" style="width:13px;"></i> SOS</button>
    <a href="login.jsp"><button class="btn-login-top"><i data-lucide="log-in" style="width:13px;"></i> Login</button></a>
  </div>
</header>

<!-- MOBILE TOPBAR -->
<header class="m-topbar">
  <div class="tb-logo" style="font-size:17px;">Civic<span>Sathy</span></div>
  <div class="tb-right">
    <button class="btn-sos" style="padding:6px 10px;font-size:11px;"><i data-lucide="phone" style="width:12px;"></i> SOS</button>
    <a href="login.jsp"><button class="btn-login-top" style="padding:6px 10px;font-size:11px;"><i data-lucide="log-in" style="width:12px;"></i> Login</button></a>
  </div>
</header>

<div class="app">

<!-- SIDEBAR -->
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
<!-- FEED -->
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

  <!-- DUPLICATE DETECTION ALERT (Feature 9) -->
  <div class="dup-alert"><i data-lucide="copy" style="width:16px;flex-shrink:0;"></i> A similar complaint about road cracks in Ward 14 was reported 3 hours ago. <a href="#" style="color:#92400E;font-weight:700;margin-left:auto;white-space:nowrap;">View →</a></div>

  <!-- CARD 1 - WITH IMAGE (Features 1,2,3,4,12) -->
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
    <!-- Admin Update Thread (Feature 12) -->
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

  <!-- CARD 2 - RESOLVE CONFIRMATION (Feature 8) -->
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

  <!-- CARD 3 - RESOLVED + CONFIRMATION FLOW (Feature 8) -->
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

<!-- RIGHT PANEL -->
<div class="right-col">
  <div class="r-panel">
    <div class="r-hd">Today's Stats</div>
    <div class="st-row"><span>Total Reports</span><span class="st-val" style="color:#1D1D1F;">246</span></div>
    <div class="st-row"><span>Resolved Today</span><span class="st-val" style="color:#1A7F4B;">38</span></div>
    <div class="st-row"><span>Pending</span><span class="st-val" style="color:#B45309;">54</span></div>
    <div class="st-row"><span>In Progress</span><span class="st-val" style="color:#005B96;">22</span></div>
  </div>
  <!-- NOTIFICATIONS (Feature 11) -->
  <div class="r-panel">
    <div class="r-hd">Notifications</div>
    <div class="n-item"><div class="n-title">Your complaint #TCK-8921 is now In Progress</div><div class="n-time">30 min ago</div></div>
    <div class="n-item"><div class="n-title">Admin posted an update on #TCK-8920</div><div class="n-time">2 hours ago</div></div>
    <div class="n-item"><div class="n-title">#TCK-8918 marked as Resolved — confirm?</div><div class="n-time">1 day ago</div></div>
  </div>
  <!-- OFFICIAL ANNOUNCEMENTS -->
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

</div><!-- /main -->
</div><!-- /app -->

<!-- MOBILE BOTTOM NAV -->
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
