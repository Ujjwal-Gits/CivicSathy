<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.civicsathy.model.User" %>
<%
  // Ensure this page was loaded via the Servlet
  if (request.getAttribute("myComplaints") == null) {
    response.sendRedirect(request.getContextPath() + "/my-dashboard");
    return;
  }

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
  <title>CivicSathy — My Dashboard</title>
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
    .notif-dd-hd{padding:14px 16px;border-bottom:1px solid #E8E8ED;font-size:13px;font-weight:700;color:#1D1D1F;display:flex;justify-content:space-between;align-items:center;}
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
    .main{flex:1;padding:32px;}
    .mh{display:flex;justify-content:space-between;align-items:flex-end;margin-bottom:24px;}
    .mh-title{font-size:22px;font-weight:700;letter-spacing:-.3px;color:#1D1D1F;}
    .mh-sub{font-size:13px;color:#86868B;margin-top:4px;}

    .stats-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:24px;}
    .stat-box{background:#fff;border:1px solid #E8E8ED;border-radius:10px;padding:20px;}
    .stat-val{font-size:24px;font-weight:700;line-height:1;}
    .stat-lbl{font-size:12px;font-weight:600;color:#86868B;margin-top:6px;text-transform:uppercase;}

    .table-card{background:#fff;border:1px solid #E8E8ED;border-radius:10px;overflow:hidden;}
    .table{width:100%;border-collapse:collapse;}
    .table th{background:#F9FAFB;text-align:left;padding:12px 20px;font-size:11px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.05em;border-bottom:1px solid #E8E8ED;}
    .table td{padding:16px 20px;font-size:13px;color:#1D1D1F;border-bottom:1px solid #E8E8ED;vertical-align:middle;}
    .table tr:last-child td{border-bottom:none;}
    .table tr:hover{background:#F9FAFB;}

    .badge{font-size:10px;font-weight:700;text-transform:uppercase;letter-spacing:.03em;padding:4px 8px;border-radius:4px;display:inline-block;}
    .b-prog{background:#EBF5FF;color:#005B96;}
    .b-pend{background:#FEF3C7;color:#B45309;}
    .b-res{background:#D1FAE5;color:#065F46;}
    .b-esc{background:#FEE2E2;color:#991B1B;}
    .b-closed{background:#F3F4F6;color:#374151;}

    .btn-sm{background:#F5F5F7;border:1px solid #E8E8ED;color:#4B5563;padding:6px 12px;border-radius:6px;font-size:12px;font-weight:600;display:inline-flex;align-items:center;gap:4px;}
    .btn-sm:hover{background:#E8E8ED;}
    .btn-sm.reopen{color:#D93025;border-color:#FECACA;background:#FEF2F2;}
    .btn-sm.reopen:hover{background:#FEE2E2;}

    /* MOBILE TOPBAR */
    .m-topbar{display:none;}
    /* MOBILE BOTTOM NAV */
    .m-bnav{display:none;}/* Mobile View */
    @media(max-width:768px){
      .sidebar{display:none;}.topbar{display:none;}
      .m-topbar{display:flex;align-items:center;justify-content:space-between;padding:12px 16px;background:#fff;border-bottom:1px solid #E8E8ED;position:sticky;top:0;z-index:100;width:100%;}
      .main{padding:16px;padding-bottom:100px;width:100%;overflow-x:hidden;}
      .mh{flex-direction:column;align-items:flex-start;gap:8px;margin-bottom:20px;}
      .mh-title{font-size:18px;width:100%;word-break:break-word;}
      .mh-sub{font-size:12px;width:100%;}

      .stats-grid{grid-template-columns:1fr 1fr;gap:10px;margin-bottom:20px;}
      .stat-box{padding:14px;border-radius:8px;}
      .stat-val{font-size:18px;}
      .stat-lbl{font-size:9px;margin-top:4px;}

      /* Responsive Table Cards */
      .table-card{border:none;background:transparent;}
      .table-wrap{overflow:visible;}
      .table thead { display: none; }
      .table, .table tbody, .table tr, .table td { display: block; width: 100%; }
      .table tr { margin-bottom: 12px; border: 1px solid #E8E8ED; border-radius: 10px; padding: 12px; background: #fff; box-shadow: 0 2px 6px rgba(0,0,0,0.03); }
      .table td { border: none; padding: 6px 0; display: flex; justify-content: space-between; align-items: flex-start; font-size: 12px; gap: 10px; }
      .table td::before { content: attr(data-label); font-weight: 700; color: #86868B; text-transform: uppercase; font-size: 9px; min-width: 80px; text-align: left; margin-top: 2px; }
      .table td:last-child { border-top: 1px solid #F5F5F7; margin-top: 8px; padding-top: 12px; justify-content: flex-end; }

      .badge{padding:2px 6px;font-size:9px;}
      .btn-sm{padding:5px 10px;font-size:11px;}

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
  </div>
</header>

<!-- MOBILE TOPBAR -->
<header class="m-topbar">
  <div class="tb-logo" style="font-size:17px;transform:translateY(1px);">Civic<span>Sathy</span></div>
  <div class="tb-right">
    <button class="btn-sos" style="padding:6px 10px;font-size:11px;" onclick="document.getElementById('sosModalMobile').style.display='flex'"><i data-lucide="phone" style="width:12px;"></i> SOS</button>
    <a href="${pageContext.request.contextPath}/profile"><button class="profile-btn" style="padding:5px 10px;font-size:11px;"><i data-lucide="user" style="width:12px;"></i> <%= loggedInUser.getFullName().split(" ")[0] %></button></a>
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
      <a href="${pageContext.request.contextPath}/my-dashboard" class="sb-item active"><i data-lucide="layout-dashboard" style="width:16px;"></i> My Dashboard</a>
      <a href="${pageContext.request.contextPath}/profile" class="sb-item"><i data-lucide="user" style="width:16px;"></i> Profile Settings</a>
      <div class="sb-sec">Quick Contacts</div>
      <a href="tel:100" class="sb-item red"><i data-lucide="siren" style="width:16px;"></i> Emergency: 100</a>
      <a href="tel:101" class="sb-item red"><i data-lucide="flame" style="width:16px;"></i> Fire Brigade: 101</a>
      <a href="tel:102" class="sb-item red"><i data-lucide="heart-pulse" style="width:16px;"></i> Ambulance: 102</a>
    </nav>
  </aside>

  <!-- MAIN -->
  <main class="main">
    <div class="mh">
      <div>
        <h1 class="mh-title">Welcome, <%= loggedInUser.getFullName().split(" ")[0] %></h1>
        <div class="mh-sub">Manage your reported issues and monitor progress.</div>
      </div>
    </div>

    <div class="stats-grid">
      <div class="stat-box">
        <div class="stat-val">${totalCount}</div>
        <div class="stat-lbl">Total Reports</div>
      </div>
      <div class="stat-box">
        <div class="stat-val" style="color:#005B96;">${inProgressCount}</div>
        <div class="stat-lbl">In Progress</div>
      </div>
      <div class="stat-box">
        <div class="stat-val" style="color:#B45309;">${pendingCount}</div>
        <div class="stat-lbl">Pending</div>
      </div>
      <div class="stat-box">
        <div class="stat-val" style="color:#1A7F4B;">${resolvedCount}</div>
        <div class="stat-lbl">Resolved</div>
      </div>
    </div>

    <div class="table-card">
      <div class="table-wrap">
        <table class="table">
          <thead>
          <tr>
            <th>Ticket ID</th>
            <th>Category</th>
            <th>Title</th>
            <th>Date</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
          <%
            java.util.List<com.civicsathy.model.Complaint> myComplaints =
                    (java.util.List<com.civicsathy.model.Complaint>) request.getAttribute("myComplaints");
            if (myComplaints != null && !myComplaints.isEmpty()) {
              for (com.civicsathy.model.Complaint c : myComplaints) {
                String s = c.getStatus() != null ? c.getStatus().toUpperCase() : "PENDING";
                String badgeClass = "b-pend";
                if (s.contains("PROGRESS") || s.equals("ASSIGNED")) badgeClass = "b-prog";
                else if (s.equals("RESOLVED")) badgeClass = "b-res";
                else if (s.equals("CLOSED")) badgeClass = "b-closed";
                else if (s.equals("ESCALATED")) badgeClass = "b-esc";
          %>
          <tr>
            <td data-label="Ticket ID" style="font-weight:700;">#<%= c.getTrackingId() %></td>
            <td data-label="Category"><%= c.getCategoryName() != null ? c.getCategoryName() : "General" %></td>
            <td data-label="Title"><%= c.getTitle() != null ? c.getTitle() : "Untitled" %></td>
            <td data-label="Date"><%= c.getCreatedAt() != null ? new java.text.SimpleDateFormat("MMM dd, yyyy").format(c.getCreatedAt()) : "—" %></td>
            <td data-label="Status"><div class="badge <%= badgeClass %>"><%= c.getStatus() %></div></td>
            <td data-label="Actions">
              <div style="display:flex;align-items:center;gap:6px;">
                <a href="${pageContext.request.contextPath}/track?id=<%= c.getTrackingId() %>"><button class="btn-sm"><i data-lucide="eye" style="width:14px;"></i> View</button></a>
                <% if ("RESOLVED".equalsIgnoreCase(c.getStatus())) { %>
                <a href="${pageContext.request.contextPath}/download-issue-report?id=<%= c.getId() %>"><button class="btn-sm" style="border-color:#1A7F4B;color:#1A7F4B;"><i data-lucide="file-text" style="width:14px;"></i> Report</button></a>

                <!-- Resolve Confirmation Dropdown -->
                <div style="position:relative;">
                  <button class="btn-sm" style="background:#005B96;color:#fff;border:none;" onclick="this.nextElementSibling.classList.toggle('show')">Confirm <i data-lucide="chevron-down" style="width:12px;"></i></button>
                  <div class="profile-dd" style="top:32px;right:0;width:140px;padding:4px;">
                    <form action="${pageContext.request.contextPath}/my-dashboard" method="POST">
                      <input type="hidden" name="complaintId" value="<%= c.getId() %>">
                      <input type="hidden" name="action" value="confirm">
                      <button type="submit" class="dd-item" style="width:100%;background:none;border:none;padding:8px 10px;text-align:left;color:#065F46;font-weight:600;"><i data-lucide="check-circle" style="width:14px;"></i> Accepted</button>
                    </form>
                    <form action="${pageContext.request.contextPath}/my-dashboard" method="POST">
                      <input type="hidden" name="complaintId" value="<%= c.getId() %>">
                      <input type="hidden" name="action" value="reopen">
                      <button type="submit" class="dd-item red" style="width:100%;background:none;border:none;padding:8px 10px;text-align:left;font-weight:600;"><i data-lucide="refresh-cw" style="width:14px;"></i> Report Again</button>
                    </form>
                  </div>
                </div>
                <% } %>
              </div>
            </td>
          </tr>
          <%
            }
          } else {
          %>
          <tr>
            <td colspan="6" style="text-align:center;color:#86868B;padding:30px;">You haven't submitted any complaints yet.</td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </main>
</div>

<!-- MOBILE BOTTOM NAV -->
<nav class="m-bnav">
  <a href="${pageContext.request.contextPath}/feed" class="mn"><i data-lucide="layout-grid" style="width:20px;"></i>Feed</a>
  <a href="${pageContext.request.contextPath}/track" class="mn"><i data-lucide="compass" style="width:20px;"></i>Track</a>
  <div class="mfab-w"><a href="${pageContext.request.contextPath}/citizen/submit.jsp" class="mfab"><i data-lucide="camera" style="width:24px;"></i></a></div>
  <a href="javascript:void(0)" onclick="document.getElementById('sosModalFull').style.display='flex'" class="mn red"><i data-lucide="siren" style="width:20px;"></i>Emergency</a>
  <a href="${pageContext.request.contextPath}/my-dashboard" class="mn active"><i data-lucide="user" style="width:20px;"></i>Dashboard</a>
</nav>

<script>lucide.createIcons();</script>
</body>
</html>