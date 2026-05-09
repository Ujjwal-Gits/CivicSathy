<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy — Track Complaint</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<style>
/* Base Styles */
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'DM Sans',sans-serif;background:#F5F5F7;color:#1D1D1F;-webkit-font-smoothing:antialiased;display:flex;flex-direction:column;min-height:100vh;}
a{text-decoration:none;color:inherit;}button{cursor:pointer;font-family:inherit;border:none;}

/* TOPBAR */
.topbar{width:100%;height:60px;background:#fff;border-bottom:1px solid #E8E8ED;display:flex;align-items:center;justify-content:space-between;padding:0 24px;position:sticky;top:0;z-index:100;}
.tb-left{display:flex;flex-direction:column;}
.tb-logo{font-size:18px;font-weight:700;letter-spacing:-.3px;line-height:1.1;}.tb-logo span{color:#005B96;}
.tb-sub{font-size:9px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.08em;}
.tb-right{display:flex;align-items:center;gap:8px;}
.tb-icon{width:36px;height:36px;background:none;border-radius:6px;display:flex;align-items:center;justify-content:center;color:#86868B;position:relative;}.tb-icon:hover{background:#F5F5F7;color:#1D1D1F;}
.btn-sos{background:#D93025;color:#fff;padding:8px 14px;border-radius:6px;font-size:12px;font-weight:700;display:flex;align-items:center;gap:5px;}
.btn-login{background:#005B96;color:#fff;padding:8px 14px;border-radius:6px;font-size:12px;font-weight:600;display:flex;align-items:center;gap:5px;}

/* APP LAYOUT */
.app{display:flex;flex:1;}
.sidebar{width:240px;flex-shrink:0;background:#fff;border-right:1px solid #E8E8ED;display:flex;flex-direction:column;height:calc(100vh - 60px);position:sticky;top:60px;overflow-y:auto;}
.sb-top{padding:16px 12px;}
.btn-report{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;padding:10px;background:#005B96;color:#fff;border-radius:6px;font-size:13px;font-weight:600;transition:.15s;}.btn-report:hover{background:#004A7C;}
.sb-nav{flex:1;padding:8px 12px;overflow-y:auto;}
.sb-sec{font-size:10px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.08em;padding:0 8px;margin:16px 0 8px;}.sb-sec:first-child{margin-top:0;}
.sb-item{display:flex;align-items:center;gap:10px;padding:10px;border-radius:6px;font-size:13px;font-weight:500;color:#1D1D1F;margin-bottom:2px;transition:.15s;}
.sb-item:hover{background:#F5F5F7;}.sb-item.active{background:#EBF5FF;color:#005B96;font-weight:600;}
.sb-item.red{color:#D93025;}.sb-item.red:hover{background:#FEF2F2;}

/* MAIN CONTENT */
.main{flex:1;padding:32px;display:flex;flex-direction:column;align-items:center;}
.track-box{width:100%;max-width:600px;}
.search-card{background:#fff;border:1px solid #E8E8ED;border-radius:12px;padding:24px;margin-bottom:24px;}
.sc-title{font-size:18px;font-weight:700;letter-spacing:-.3px;margin-bottom:4px;}
.sc-sub{font-size:13px;color:#86868B;margin-bottom:20px;}
.search-wrap{display:flex;gap:12px;}
.search-wrap input{flex:1;height:48px;border:1px solid #E8E8ED;border-radius:6px;padding:0 16px;font-size:15px;font-family:inherit;outline:none;transition:.2s;}
.search-wrap input:focus{border-color:#005B96;}
.btn-track{background:#005B96;color:#fff;padding:0 24px;border-radius:6px;font-size:14px;font-weight:700;}
.btn-track:hover{background:#004A7C;}

/* TIMELINE */
.timeline-card{background:#fff;border:1px solid #E8E8ED;border-radius:12px;padding:24px;}
.tc-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;padding-bottom:16px;border-bottom:1px solid #E8E8ED;}
.tc-id{font-size:16px;font-weight:700;color:#1D1D1F;}
.badge{font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:.03em;padding:4px 8px;border-radius:4px;background:#EBF5FF;color:#005B96;}

.tl{position:relative;padding-left:32px;}
.tl::before{content:'';position:absolute;left:11px;top:8px;bottom:8px;width:2px;background:#E8E8ED;}
.t-item{position:relative;margin-bottom:24px;}.t-item:last-child{margin-bottom:0;}
.t-dot{position:absolute;left:-32px;top:4px;width:24px;height:24px;border-radius:50%;background:#F5F5F7;border:2px solid #E8E8ED;display:flex;align-items:center;justify-content:center;z-index:2;}
.t-dot.active{background:#005B96;border-color:#BAE6FD;color:#fff;}
.t-dot.done{background:#1A7F4B;border-color:#A7F3D0;color:#fff;}
.t-title{font-size:14px;font-weight:700;color:#1D1D1F;margin-bottom:4px;}
.t-desc{font-size:13px;color:#4B5563;}
.t-time{font-size:11px;color:#86868B;margin-top:6px;}

/* MOBILE TOPBAR */
.m-topbar{display:none;}
/* MOBILE BOTTOM NAV */
.m-bnav{display:none;}

/* RESPONSIVE */
@media(max-width:768px){
  .sidebar{display:none;}.topbar{display:none;}
  .m-topbar{display:flex;align-items:center;justify-content:space-between;padding:10px 16px;background:#fff;border-bottom:1px solid #E8E8ED;position:sticky;top:0;z-index:100;}
  .main{padding:16px;padding-bottom:100px;}
  .m-bnav{display:flex;align-items:center;justify-content:space-around;position:fixed;bottom:0;left:0;right:0;z-index:100;background:#fff;height:64px;padding:0 8px;border-top:1px solid #E8E8ED;padding-bottom:env(safe-area-inset-bottom);}
  .mn{display:flex;flex-direction:column;align-items:center;justify-content:center;gap:4px;flex:1;font-size:9px;font-weight:700;text-transform:uppercase;letter-spacing:.04em;color:#86868B;}
  .mn.active{color:#005B96;}.mn.red{color:#D93025;}
  .mfab-w{display:flex;flex-direction:column;align-items:center;justify-content:center;flex:1;}
  .mfab{width:48px;height:48px;background:#005B96;border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;transform:translateY(-12px);box-shadow:0 4px 8px rgba(0,91,150,.25);}
}
</style>
</head>
<body>

<!-- DESKTOP TOPBAR -->
<header class="topbar">
  <div class="tb-left"><div class="tb-logo">Civic<span>Sathy</span></div><div class="tb-sub">Itahari Sub-Metropolitan</div></div>
  <div class="tb-right">
    <button class="tb-icon"><i data-lucide="bell" style="width:18px;"></i></button>
    <button class="btn-sos"><i data-lucide="phone" style="width:13px;"></i> SOS</button>
    <a href="login.jsp"><button class="btn-login"><i data-lucide="log-in" style="width:13px;"></i> Login</button></a>
  </div>
</header>

<!-- MOBILE TOPBAR -->
<header class="m-topbar">
  <div class="tb-logo" style="font-size:17px;">Civic<span>Sathy</span></div>
  <div class="tb-right">
    <a href="login.jsp"><button class="btn-login" style="padding:6px 10px;font-size:11px;"><i data-lucide="log-in" style="width:12px;"></i> Login</button></a>
  </div>
</header>

<div class="app">
  <!-- SIDEBAR -->
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

  <!-- MAIN -->
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

<!-- MOBILE BOTTOM NAV -->
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
