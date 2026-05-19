<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.civicsathy.model.User" %>
<%
  // check if user is logged in
  User loggedInUser = (User) session.getAttribute("loggedInUser");
  if (loggedInUser == null) {
    response.sendRedirect(request.getContextPath() + "/citizen/login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>CivicSathy - Report an Issue</title>
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
    .notif-dot{position:absolute;top:6px;right:6px;width:8px;height:8px;background:#D93025;border-radius:50%;border:2px solid #fff;}

    /* PROFILE DROPDOWN */
    .profile-wrap{position:relative;}
    .profile-btn{display:flex;align-items:center;gap:6px;padding:6px 12px;background:#EBF5FF;border-radius:6px;font-size:12px;font-weight:600;color:#005B96;cursor:pointer;border:1px solid #BAE6FD;}
    .profile-dd{display:none;position:absolute;top:42px;right:0;background:#fff;border:1px solid #E8E8ED;border-radius:6px;box-shadow:0 8px 20px rgba(0,0,0,0.08);width:180px;z-index:200;overflow:hidden;}
    .profile-dd.show{display:block;}
    .dd-name{padding:12px 14px;border-bottom:1px solid #E8E8ED;font-size:12px;font-weight:700;color:#1D1D1F;}
    .dd-item{display:flex;align-items:center;gap:8px;padding:10px 14px;font-size:12px;font-weight:500;color:#4B5563;transition:.15s;}
    .dd-item:hover{background:#F5F5F7;}
    .dd-item.red{color:#D93025;}.dd-item.red:hover{background:#FEF2F2;}
    .notif-dd{display:none;position:absolute;top:42px;right:60px;background:#fff;border:1px solid #E8E8ED;border-radius:8px;box-shadow:0 8px 24px rgba(0,0,0,0.12);width:320px;z-index:200;max-height:400px;overflow-y:auto;}
    .notif-dd.show{display:block;}
    .notif-dd-hd{padding:14px 16px;border-bottom:1px solid #E8E8ED;font-size:13px;font-weight:700;color:#1D1D1F;}
    .notif-item{padding:12px 16px;border-bottom:1px solid #F5F5F7;display:block;text-decoration:none;color:inherit;}
    .notif-item:hover{background:#F9FAFB;}
    .notif-title{font-size:12px;font-weight:600;color:#1D1D1F;margin-bottom:4px;line-height:1.4;}
    .notif-time{font-size:10px;color:#86868B;}
    .notif-empty{padding:24px;text-align:center;font-size:12px;color:#86868B;}

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
    .main{flex:1;padding:32px;display:flex;justify-content:center;}
    .card{background:#fff;border:1px solid #E8E8ED;border-radius:8px;width:100%;max-width:520px;padding:32px;}
    .logo{font-size:20px;font-weight:700;letter-spacing:-.3px;margin-bottom:4px;}.logo span{color:#005B96;}
    .sub{font-size:12px;color:#86868B;margin-bottom:24px;}
    .upload-area{margin-bottom:20px;}
    .upload-btn{width:100%;height:80px;border:2px dashed #E8E8ED;border-radius:8px;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:4px;cursor:pointer;transition:.15s;font-size:11px;color:#86868B;font-weight:600;background:none;}
    .upload-btn:hover{border-color:#005B96;color:#005B96;background:#F0FBFF;}
    .img-preview{max-width:100%;max-height:200px;border-radius:8px;margin-top:10px;display:none;border:1px solid #E8E8ED;}
    .field{margin-bottom:16px;}.field label{display:block;font-size:12px;font-weight:600;margin-bottom:6px;}
    .field input,.field select,.field textarea{width:100%;border:1px solid #E8E8ED;border-radius:6px;padding:10px 12px;font-size:13px;font-family:inherit;outline:none;}
    .field input:focus,.field select:focus,.field textarea:focus{border-color:#005B96;}
    .location-row{display:flex;gap:12px;margin-bottom:16px;}
    .location-row .field{flex:1;margin-bottom:0;}
    .map-box{width:100%;height:200px;border:1px solid #E8E8ED;border-radius:8px;margin-bottom:16px;overflow:hidden;}
    .toggle-row{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;padding:12px 16px;background:#F9FAFB;border-radius:6px;}
    .toggle-row span{font-size:13px;font-weight:600;}
    .toggle{width:40px;height:22px;background:#E8E8ED;border-radius:11px;cursor:pointer;position:relative;transition:.2s;border:none;}
    .toggle::after{content:'';position:absolute;top:2px;left:2px;width:18px;height:18px;background:#fff;border-radius:50%;transition:.2s;}
    .toggle.on{background:#005B96;}.toggle.on::after{left:20px;}
    .btn{width:100%;height:48px;background:#005B96;color:#fff;border:none;border-radius:6px;font-size:15px;font-weight:600;cursor:pointer;}
    .gps-btn{background:#F0FBFF;border:1px solid #BAE6FD;color:#005B96;padding:8px 14px;border-radius:6px;font-size:12px;font-weight:600;cursor:pointer;display:flex;align-items:center;gap:6px;margin-bottom:16px;}
    .success-msg{background:#D1FAE5;color:#065F46;padding:10px;border-radius:6px;font-size:12px;margin-bottom:15px;border:1px solid #A7F3D0;}
    .error-msg{background:#FFEBEB;color:#D32F2F;padding:10px;border-radius:4px;font-size:12px;margin-bottom:15px;border:1px solid #FFD2D2;}

    /* MOBILE TOPBAR */
    .m-topbar{display:none;}
    /* MOBILE BOTTOM NAV */
    .m-bnav{display:none;}

    /* RESPONSIVE */
    @media(max-width:768px){
      .sidebar{display:none;}.topbar{display:none;}
      .m-topbar{display:flex;align-items:center;justify-content:space-between;padding:10px 16px;background:#fff;border-bottom:1px solid #E8E8ED;position:sticky;top:0;z-index:100;}
      .main{padding:16px;padding-bottom:100px;}
      .m-bnav{display:flex;align-items:center;justify-content:space-around;position:fixed;bottom:0;left:0;right:0;z-index:1000;background:#fff;height:64px;padding:0 8px;border-top:1px solid #E8E8ED;padding-bottom:env(safe-area-inset-bottom);}
      .mn{display:flex;flex-direction:column;align-items:center;justify-content:center;gap:4px;flex:1;font-size:9px;font-weight:700;text-transform:uppercase;letter-spacing:.04em;color:#86868B;}
      .mn.active{color:#005B96;}.mn.red{color:#D93025;}
      .mfab-w{display:flex;flex-direction:column;align-items:center;justify-content:center;flex:1;}
      .mfab{width:48px;height:48px;background:#005B96;border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;transform:translateY(-12px);box-shadow:0 4px 8px rgba(0,91,150,.25);}
    }
  </style>
  <!-- leaflet css for the mini map -->
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
</head>
<body>

<!-- DESKTOP TOPBAR -->
<header class="topbar">
  <div class="tb-left"><div class="tb-logo">Civic<span>Sathy</span></div><div class="tb-sub">Itahari Sub-Metropolitan</div></div>
  <div class="tb-right">
    <div style="position:relative;">
      <button class="tb-icon" onclick="document.getElementById('notifDD').classList.toggle('show'); document.getElementById('profileDD').classList.remove('show');"><i data-lucide="bell" style="width:18px;"></i>
        <% if (request.getAttribute("unreadCount") != null && ((Integer)request.getAttribute("unreadCount")) > 0) { %>
        <span class="notif-dot"></span>
        <% } %>
      </button>
      <div class="notif-dd" id="notifDD">
        <div class="notif-dd-hd"><span>Notifications</span></div>
        <%
          java.util.List<com.civicsathy.model.Notification> topNotifs = (java.util.List<com.civicsathy.model.Notification>) request.getAttribute("notifications");
          if (topNotifs != null && !topNotifs.isEmpty()) {
            for (com.civicsathy.model.Notification n : topNotifs) {
              long diffMs = System.currentTimeMillis() - n.getCreatedAt().getTime();
              long diffMins = diffMs / 60000;
              String timeAgo = diffMins < 1 ? "Just now" : (diffMins < 60 ? diffMins + " min ago" : (diffMins < 1440 ? (diffMins / 60) + " hours ago" : (diffMins / 1440) + " days ago"));
        %>
        <a href="${pageContext.request.contextPath}/track?id=<%= n.getComplaintId() %>" class="notif-item">
          <div class="notif-title"><%= n.getMessage() %></div>
          <div class="notif-time"><%= timeAgo %></div>
        </a>
        <% } } else { %>
        <div class="notif-empty">No new notifications.</div>
        <% } %>
      </div>
    </div>
    <button class="btn-sos" onclick="document.getElementById('sosModalDesktop').style.display='flex'"><i data-lucide="phone" style="width:13px;"></i> SOS</button>
    <% if (loggedInUser != null) { %>
    <div class="profile-wrap">
      <div class="profile-btn" onclick="document.getElementById('profileDD').classList.toggle('show'); document.getElementById('notifDD').classList.remove('show');">
        <i data-lucide="user" style="width:14px;"></i> <%= loggedInUser.getFullName().split(" ")[0] %>
        <i data-lucide="chevron-down" style="width:12px;"></i>
      </div>
      <div class="profile-dd" id="profileDD">
        <div class="dd-name"><%= loggedInUser.getFullName() %></div>
        <a href="${pageContext.request.contextPath}/profile" class="dd-item"><i data-lucide="user" style="width:14px;"></i> My Profile</a>
        <a href="${pageContext.request.contextPath}/my-dashboard" class="dd-item"><i data-lucide="layout-dashboard" style="width:14px;"></i> My Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout" class="dd-item red"><i data-lucide="log-out" style="width:14px;"></i> Logout</a>
      </div>
    </div>
    <% } else { %>
    <a href="${pageContext.request.contextPath}/citizen/login.jsp"><button class="profile-btn"><i data-lucide="log-in" style="width:13px;"></i> Login</button></a>
    <% } %>
  </div>
</header>

<!-- MOBILE TOPBAR -->
<header class="m-topbar">
  <div class="tb-logo" style="font-size:17px;transform:translateY(1px);">Civic<span>Sathy</span></div>
  <div class="tb-right">
    <button class="btn-sos" style="padding:6px 10px;font-size:11px;" onclick="document.getElementById('sosModalMobile').style.display='flex'"><i data-lucide="phone" style="width:12px;"></i> SOS</button>
    <% if (loggedInUser != null) { %>
    <a href="${pageContext.request.contextPath}/profile"><button class="profile-btn" style="padding:5px 10px;font-size:11px;"><i data-lucide="user" style="width:12px;"></i> <%= loggedInUser.getFullName().split(" ")[0] %></button></a>
    <% } else { %>
    <a href="${pageContext.request.contextPath}/citizen/login.jsp"><button class="btn-login-top" style="padding:6px 10px;font-size:11px;"><i data-lucide="log-in" style="width:12px;"></i> Login</button></a>
    <% } %>
  </div>
</header>

<!-- SOS MODALS -->
<div id="sosModalMobile" style="display:none;position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.5);z-index:2000;align-items:center;justify-content:center;padding:20px;">
  <div style="background:#fff;border-radius:12px;width:100%;max-width:320px;padding:20px;position:relative;">
    <button onclick="document.getElementById('sosModalMobile').style.display='none'" style="position:absolute;top:10px;right:10px;background:none;border:none;color:#86868B;"><i data-lucide="x" style="width:20px;"></i></button>
    <h3 style="color:#D93025;margin-bottom:16px;font-size:16px;display:flex;align-items:center;gap:6px;"><i data-lucide="siren" style="width:18px;"></i> Emergency (Top 3)</h3>
    <a href="tel:100" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;margin-bottom:8px;"><div style="font-weight:700;font-size:14px;">Police <span style="color:#86868B;font-size:12px;margin-left:4px;">100</span></div><div style="background:#FEF2F2;color:#D93025;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
    <a href="tel:101" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;margin-bottom:8px;"><div style="font-weight:700;font-size:14px;">Fire Brigade <span style="color:#86868B;font-size:12px;margin-left:4px;">101</span></div><div style="background:#FEF2F2;color:#D93025;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
    <a href="tel:102" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;margin-bottom:8px;"><div style="font-weight:700;font-size:14px;">Ambulance <span style="color:#86868B;font-size:12px;margin-left:4px;">102</span></div><div style="background:#FEF2F2;color:#D93025;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
    <a href="${pageContext.request.contextPath}/citizen/contacts.jsp" style="display:block;text-align:center;margin-top:16px;color:#005B96;font-size:13px;font-weight:600;">View All Contacts &rarr;</a>
  </div>
</div>

<div id="sosModalFull" style="display:none;position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.5);z-index:2000;align-items:center;justify-content:center;padding:20px;">
  <div style="background:#fff;border-radius:12px;width:100%;max-width:500px;padding:24px;position:relative;max-height:85vh;overflow-y:auto;">
    <button onclick="document.getElementById('sosModalFull').style.display='none'" style="position:absolute;top:15px;right:15px;background:none;border:none;color:#86868B;"><i data-lucide="x" style="width:20px;"></i></button>
    <h3 style="color:#D93025;margin-bottom:20px;font-size:18px;display:flex;align-items:center;gap:6px;"><i data-lucide="phone-call" style="width:20px;"></i> All Emergency Contacts</h3>
    <div style="display:grid;grid-template-columns:repeat(auto-fit, minmax(140px, 1fr));gap:12px;">
      <a href="tel:100" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Police<br><span style="color:#86868B;font-size:11px;">100</span></div><div style="background:#FEF2F2;color:#D93025;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:101" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Fire Brigade<br><span style="color:#86868B;font-size:11px;">101</span></div><div style="background:#FEF2F2;color:#D93025;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:102" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Ambulance<br><span style="color:#86868B;font-size:11px;">102</span></div><div style="background:#FEF2F2;color:#D93025;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:103" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Traffic Police<br><span style="color:#86868B;font-size:11px;">103</span></div><div style="background:#FEF2F2;color:#D93025;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:1149" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Disaster Helpline<br><span style="color:#86868B;font-size:11px;">1149</span></div><div style="background:#EBF5FF;color:#005B96;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:1141" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Flood Helpline<br><span style="color:#86868B;font-size:11px;">1141</span></div><div style="background:#EBF5FF;color:#005B96;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:1091" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Women Helpline<br><span style="color:#86868B;font-size:11px;">1091</span></div><div style="background:#EBF5FF;color:#005B96;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:1098" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Child Helpline<br><span style="color:#86868B;font-size:11px;">1098</span></div><div style="background:#EBF5FF;color:#005B96;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
    </div>
    <div style="margin-top:16px;text-align:center;">
      <a href="${pageContext.request.contextPath}/citizen/contacts.jsp" style="color:#005B96;font-size:13px;font-weight:600;">View Complete Directory &rarr;</a>
    </div>
  </div>
</div>

<div id="sosModalDesktop" style="display:none;position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.5);z-index:2000;align-items:center;justify-content:center;padding:20px;">
  <div style="background:#fff;border-radius:12px;width:100%;max-width:500px;padding:24px;position:relative;max-height:80vh;overflow-y:auto;">
    <button onclick="document.getElementById('sosModalDesktop').style.display='none'" style="position:absolute;top:15px;right:15px;background:none;border:none;color:#86868B;"><i data-lucide="x" style="width:20px;"></i></button>
    <h3 style="color:#D93025;margin-bottom:20px;font-size:18px;display:flex;align-items:center;gap:6px;"><i data-lucide="phone-call" style="width:20px;"></i> All Emergency Contacts</h3>
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
      <a href="tel:100" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Police<br><span style="color:#86868B;font-size:11px;">100</span></div><div style="background:#FEF2F2;color:#D93025;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:101" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Fire Brigade<br><span style="color:#86868B;font-size:11px;">101</span></div><div style="background:#FEF2F2;color:#D93025;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:102" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Ambulance<br><span style="color:#86868B;font-size:11px;">102</span></div><div style="background:#FEF2F2;color:#D93025;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:103" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Traffic Police<br><span style="color:#86868B;font-size:11px;">103</span></div><div style="background:#FEF2F2;color:#D93025;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:1149" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Disaster Helpline<br><span style="color:#86868B;font-size:11px;">1149</span></div><div style="background:#EBF5FF;color:#005B96;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:1141" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Flood Helpline<br><span style="color:#86868B;font-size:11px;">1141</span></div><div style="background:#EBF5FF;color:#005B96;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:1091" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Women Helpline<br><span style="color:#86868B;font-size:11px;">1091</span></div><div style="background:#EBF5FF;color:#005B96;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
      <a href="tel:1098" style="display:flex;align-items:center;justify-content:space-between;padding:12px;border:1px solid #E8E8ED;border-radius:8px;"><div style="font-weight:700;font-size:13px;">Child Helpline<br><span style="color:#86868B;font-size:11px;">1098</span></div><div style="background:#EBF5FF;color:#005B96;width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;"><i data-lucide="phone" style="width:14px;"></i></div></a>
    </div>
    <div style="margin-top:16px;text-align:center;">
      <a href="${pageContext.request.contextPath}/citizen/contacts.jsp" style="color:#005B96;font-size:13px;font-weight:600;">View Complete Directory &rarr;</a>
    </div>
  </div>
</div>

<div class="app">
  <!-- SIDEBAR -->
  <aside class="sidebar">
    <div class="sb-top"><a href="${pageContext.request.contextPath}/citizen/submit.jsp"><button class="btn-report"><i data-lucide="plus-circle" style="width:16px;"></i> Report an Issue</button></a></div>
    <nav class="sb-nav">
      <div class="sb-sec">Navigation</div>
      <a href="${pageContext.request.contextPath}/feed" class="sb-item"><i data-lucide="layout-grid" style="width:16px;"></i> Public Feed</a>
      <a href="${pageContext.request.contextPath}/track" class="sb-item"><i data-lucide="search" style="width:16px;"></i> Track Complaint</a>
      <a href="${pageContext.request.contextPath}/my-dashboard" class="sb-item"><i data-lucide="layout-dashboard" style="width:16px;"></i> My Dashboard</a>
      <a href="${pageContext.request.contextPath}/profile" class="sb-item"><i data-lucide="user" style="width:16px;"></i> Profile Settings</a>
      <div class="sb-sec">Quick Contacts</div>
      <a href="tel:100" class="sb-item red"><i data-lucide="siren" style="width:16px;"></i> Emergency: 100</a>
      <a href="tel:101" class="sb-item red"><i data-lucide="flame" style="width:16px;"></i> Fire Brigade: 101</a>
      <a href="tel:102" class="sb-item red"><i data-lucide="heart-pulse" style="width:16px;"></i> Ambulance: 102</a>
    </nav>
  </aside>

  <!-- MAIN -->
  <main class="main">
    <div class="card">
      <div class="logo">Civic<span>Sathy</span></div>
      <div class="sub">Report a civic issue to Itahari Sub-Metropolitan City</div>

      <% if (request.getAttribute("error") != null) { %>
      <div class="error-msg"><%= request.getAttribute("error") %></div>
      <% } %>

      <form action="${pageContext.request.contextPath}/submit-complaint" method="POST" enctype="multipart/form-data">

        <!-- image upload -->
        <div class="upload-area">
          <label class="upload-btn" for="imageFile">
            <i data-lucide="camera" style="width:20px;"></i> Click to upload photo evidence
          </label>
          <input type="file" id="imageFile" name="imageFile" accept="image/*" style="display:none;"
                 onchange="previewImage(this)">
          <img id="imgPreview" class="img-preview" alt="Preview">
        </div>

        <div id="duplicateWarning" style="display:none;margin-bottom:16px;padding:12px;background:#FFFBEB;border:1px solid #FEF3C7;border-radius:8px;"></div>
        <div class="field"><label>Complaint Title</label><input type="text" name="title" placeholder="Brief summary of the issue" required></div>

        <div class="field"><label>Description</label>
          <textarea name="description" required style="height:80px;resize:vertical;"
                    placeholder="Describe the problem in detail..."></textarea>
        </div>

        <div class="field"><label>Category</label>
          <select name="category" required>
            <option value="">Select category</option>
            <option value="1">Roads</option>
            <option value="2">Sanitation</option>
            <option value="3">Water</option>
            <option value="4">Electricity</option>
            <option value="5">Flooding</option>
            <option value="6">Safety</option>
            <option value="7">Other</option>
          </select>
        </div>

        <div class="field"><label>Ward Number</label>
          <select name="wardNo" required>
            <option value="">Select ward</option>
            <% for (int i = 1; i <= 20; i++) { %>
            <option value="<%= i %>">Ward <%= i %></option>
            <% } %>
          </select>
        </div>

        <!-- GPS location section -->
        <button type="button" class="gps-btn" onclick="getGPSLocation()">
          <i data-lucide="map-pin" style="width:14px;"></i> Detect My Location via GPS
        </button>

        <!-- map preview showing itahari -->
        <div class="map-box" id="locationMap"></div>

        <div class="location-row">
          <div class="field"><label>Location / Address</label>
            <input type="text" name="locationText" id="locationText"
                   placeholder="Type or GPS will fill this">
          </div>
        </div>

        <!-- hidden fields for GPS coordinates -->
        <input type="hidden" name="latitude" id="latitude">
        <input type="hidden" name="longitude" id="longitude">

        <!-- anonymous toggle -->
        <div class="toggle-row">
          <span>Post Anonymously</span>
          <input type="checkbox" name="isAnonymous" id="anonToggle" style="display:none;">
          <div class="toggle" onclick="toggleAnon()"></div>
        </div>

        <button type="submit" class="btn">Submit Report</button>
      </form>
    </div>
  </main>
</div>

<!-- MOBILE BOTTOM NAV -->
<nav class="m-bnav">
  <a href="${pageContext.request.contextPath}/feed" class="mn"><i data-lucide="layout-grid" style="width:20px;"></i>Feed</a>
  <a href="${pageContext.request.contextPath}/track" class="mn"><i data-lucide="compass" style="width:20px;"></i>Track</a>
  <div class="mfab-w"><a href="${pageContext.request.contextPath}/citizen/submit.jsp" class="mfab" style="background:#005B96;"><i data-lucide="camera" style="width:24px;"></i></a></div>
  <a href="javascript:void(0)" onclick="document.getElementById('sosModalFull').style.display='flex'" class="mn red"><i data-lucide="siren" style="width:20px;"></i>Emergency</a>
  <a href="${pageContext.request.contextPath}/profile" class="mn"><i data-lucide="user" style="width:20px;"></i>Profile</a>
</nav>

<!-- leaflet js for the map -->
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script>
  lucide.createIcons();

  // initialize the map centered on itahari nepal
  var map = L.map('locationMap').setView([26.6615, 87.2773], 14);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap'
  }).addTo(map);

  var marker = null;

  // get GPS location from the browser
  function getGPSLocation() {
    if (navigator.geolocation) {
      // show loading text
      document.getElementById('locationText').value = "Detecting location...";
      navigator.geolocation.getCurrentPosition(function(pos) {
        var lat = pos.coords.latitude;
        var lng = pos.coords.longitude;

        updateLocationFields(lat, lng);

        map.setView([lat, lng], 16);
        if (marker) map.removeLayer(marker);
        marker = L.marker([lat, lng]).addTo(map);
      }, function(err) {
        document.getElementById('locationText').value = "";
        alert('Location Error (' + err.code + '): ' + err.message + '\n\nPlease ensure you have allowed location access in your browser settings.');
      });
    } else {
      alert('GPS not supported by your browser');
    }
  }

  // when user clicks on map, place a marker and reverse geocode
  map.on('click', function(e) {
    var lat = e.latlng.lat;
    var lng = e.latlng.lng;

    updateLocationFields(lat, lng);

    if (marker) map.removeLayer(marker);
    marker = L.marker([lat, lng]).addTo(map);
  });

  // function to update fields and fetch readable address
  function updateLocationFields(lat, lng) {
    document.getElementById('latitude').value = lat;
    document.getElementById('longitude').value = lng;
    document.getElementById('locationText').value = "Fetching address...";

    // Reverse Geocoding using OpenStreetMap Nominatim API
    fetch('https://nominatim.openstreetmap.org/reverse?format=json&lat=' + lat + '&lon=' + lng)
            .then(response => response.json())
            .then(data => {
              if (data && data.display_name) {
                // simplify the address for better readability
                let parts = data.display_name.split(',');
                // take first 3 meaningful parts to avoid excessively long strings
                let shortAddr = parts.slice(0, 3).join(',').trim();
                document.getElementById('locationText').value = shortAddr + " (Lat: " + lat.toFixed(4) + ")";
              } else {
                document.getElementById('locationText').value = 'Lat: ' + lat.toFixed(5) + ', Lng: ' + lng.toFixed(5);
              }
            })
            .catch(err => {
              console.error("Reverse Geocoding failed:", err);
              document.getElementById('locationText').value = 'Lat: ' + lat.toFixed(5) + ', Lng: ' + lng.toFixed(5);
            });
  }

  // show image preview when user selects a file
  function previewImage(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        var preview = document.getElementById('imgPreview');
        preview.src = e.target.result;
        preview.style.display = 'block';
      };
      reader.readAsDataURL(input.files[0]);
    }
  }

  // toggle anonymous checkbox
  function toggleAnon() {
    var toggle = event.target;
    toggle.classList.toggle('on');
    document.getElementById('anonToggle').checked = toggle.classList.contains('on');
  }
  // duplicate detection logic
  let debounceTimer;
  function checkDuplicates() {
    clearTimeout(debounceTimer);
    const title = document.querySelector('input[name="title"]').value;
    const lat = document.getElementById('latitude').value;
    const lng = document.getElementById('longitude').value;
    const dupDiv = document.getElementById('duplicateWarning');

    if (title.length < 4 || !lat || !lng) {
      dupDiv.style.display = 'none';
      return;
    }

    debounceTimer = setTimeout(() => {
      const url = `${pageContext.request.contextPath}/api/check-duplicates?title=` + encodeURIComponent(title) +
              `&lat=` + lat + `&lng=` + lng;
      fetch(url)
              .then(res => res.json())
              .then(data => {
                if (data && data.length > 0) {
                  let html = '<div style="font-weight:700;margin-bottom:8px;color:#92400E;"><i data-lucide="alert-triangle" style="width:14px;display:inline;vertical-align:middle;"></i> Similar issues nearby:</div>';
                  data.forEach(item => {
                    html += `<a href="${pageContext.request.contextPath}/track?id=${item.trackingId}" target="_blank" style="display:block;font-size:12px;color:#005B96;margin-bottom:4px;text-decoration:underline;">#${item.trackingId}: ${item.title}</a>`;
                  });
                  html += '<div style="font-size:11px;margin-top:8px;color:#B45309;">An issue with a similar title was already reported at this location. Please check if it is the same.</div>';
                  dupDiv.innerHTML = html;
                  dupDiv.style.display = 'block';
                  lucide.createIcons();
                } else {
                  dupDiv.style.display = 'none';
                }
              });
    }, 500);
  }

  document.querySelector('input[name="title"]').addEventListener('input', checkDuplicates);
  // Also trigger when location fields change (manually set by the map/GPS functions)
  const observer = new MutationObserver(checkDuplicates);
  observer.observe(document.getElementById('latitude'), { attributes: true });
  observer.observe(document.getElementById('longitude'), { attributes: true });
  // Since value changes via JS don't trigger observer always, we wrap the update function
  const originalUpdateLocation = updateLocationFields;
  updateLocationFields = function(lat, lng) {
    originalUpdateLocation(lat, lng);
    checkDuplicates();
  };
</script>
</body>
</html>
