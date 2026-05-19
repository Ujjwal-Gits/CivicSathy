<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.civicsathy.model.User" %>
<%
    // Ensure this page was loaded via the Servlet
    if (request.getAttribute("complaints") == null && request.getAttribute("announcements") == null) {
        response.sendRedirect(request.getContextPath() + "/feed");
        return;
    }

    User loggedInUser = (User) session.getAttribute("loggedInUser");
    boolean isLoggedIn = (loggedInUser != null);
%>
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
.notif-item{padding:12px 16px;border-bottom:1px solid #F5F5F7;display:block;}
.notif-item:hover{background:#F9FAFB;}
.notif-title{font-size:12px;font-weight:600;color:#1D1D1F;margin-bottom:4px;line-height:1.4;}
.notif-time{font-size:10px;color:#86868B;}
.notif-empty{padding:24px;text-align:center;font-size:12px;color:#86868B;}

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
.b-prog{background:#EBF5FF;color:#005B96;}
.b-pend{background:#FEF3C7;color:#B45309;}
.b-res{background:#D1FAE5;color:#065F46;}
.b-esc{background:#FEE2E2;color:#991B1B;}
.b-closed{background:#F3F4F6;color:#374151;}
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
  .m-bnav{display:flex;align-items:center;justify-content:space-around;position:fixed;bottom:0;left:0;right:0;z-index:1000;background:#fff;height:64px;padding:0 8px;border-top:1px solid #E8E8ED;padding-bottom:env(safe-area-inset-bottom);}
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
    <% if (isLoggedIn) { %>
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
    <a href="${pageContext.request.contextPath}/citizen/login.jsp"><button class="btn-login-top"><i data-lucide="log-in" style="width:13px;"></i> Login</button></a>
    <% } %>
  </div>
</header>

<!-- MOBILE TOPBAR -->
<header class="m-topbar">
  <div class="tb-logo" style="font-size:17px;transform:translateY(1px);">Civic<span>Sathy</span></div>
  <div class="tb-right">
    <button class="btn-sos" style="padding:6px 10px;font-size:11px;" onclick="document.getElementById('sosModalMobile').style.display='flex'"><i data-lucide="phone" style="width:12px;"></i> SOS</button>
    <% if (isLoggedIn) { %>
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
    <a href="${pageContext.request.contextPath}/feed" class="sb-item active"><i data-lucide="layout-grid" style="width:16px;"></i> Public Feed</a>
    <a href="${pageContext.request.contextPath}/track" class="sb-item"><i data-lucide="search" style="width:16px;"></i> Track Complaint</a>
    <a href="${pageContext.request.contextPath}/my-dashboard" class="sb-item"><i data-lucide="layout-dashboard" style="width:16px;"></i> My Dashboard</a>
    <a href="${pageContext.request.contextPath}/profile" class="sb-item"><i data-lucide="user" style="width:16px;"></i> Profile Settings</a>
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
    <div><h1 class="fh-title">Public Feed</h1><div class="fh-sub"><%= request.getAttribute("complaints") != null ? ((java.util.List)request.getAttribute("complaints")).size() : 0 %> reports · Sorted by recent activity</div></div>
    <div class="fh-btns">
      <button class="fbtn active"><i data-lucide="clock" style="width:13px;"></i> Recent</button>
      <button class="fbtn"><i data-lucide="trending-up" style="width:13px;"></i> Most Affected</button>
      <button class="fbtn"><i data-lucide="sliders-horizontal" style="width:13px;"></i> Filter</button>
    </div>
  </div>

  <div class="tabs">
    <div class="tab active">All Issues</div><div class="tab">Roads</div><div class="tab">Garbage</div><div class="tab">Water</div><div class="tab">Electricity</div><div class="tab">Flooding</div><div class="tab">Safety</div>
  </div>

  <% 
    java.util.List<com.civicsathy.model.Complaint> complaintsList = (java.util.List<com.civicsathy.model.Complaint>) request.getAttribute("complaints");
    if (complaintsList != null && !complaintsList.isEmpty()) {
      for (com.civicsathy.model.Complaint c : complaintsList) {
        String s = c.getStatus() != null ? c.getStatus().toUpperCase() : "PENDING";
        String badgeClass = "b-pend";
        if (s.contains("PROGRESS") || s.equals("ASSIGNED")) badgeClass = "b-prog";
        else if (s.equals("RESOLVED")) badgeClass = "b-res";
        else if (s.equals("CLOSED")) badgeClass = "b-closed";
        else if (s.equals("ESCALATED")) badgeClass = "b-esc";
  %>
  <div class="card" id="complaint-<%= c.getId() %>">
    <div class="c-top">
      <div class="c-cat"><div class="dot" style="background:#005B96;"></div> <%= c.getCategoryName() != null ? c.getCategoryName() : "General" %></div>
      <div class="badge <%= badgeClass %>"><%= c.getStatus() %></div>
    </div>
    <h2 class="c-title"><%= c.getTitle() != null ? c.getTitle() : "Untitled" %></h2>
    <% if (c.getImagePath() != null && !c.getImagePath().isEmpty()) { %>
      <img src="${pageContext.request.contextPath}/uploads/<%= c.getImagePath() %>" alt="Issue photo" class="c-img">
    <% } %>
    <p class="c-desc"><%= c.getDescription() %></p>
    <div class="c-meta">
      <div><i data-lucide="map-pin" style="width:13px;"></i> <%= c.getLocationText() != null ? c.getLocationText() : "Ward " + c.getWardNo() %></div>
      <div><i data-lucide="user-x" style="width:13px;"></i> <%= c.getIsAnonymous() ? "Anonymous" : (c.getUserName() != null ? c.getUserName() : "Citizen") %></div>
    </div>
    <% 
        java.util.List<Integer> affectedIds = (java.util.List<Integer>) request.getAttribute("affectedIds");
        boolean isAffected = affectedIds != null && affectedIds.contains(c.getId());
        boolean isLogged = session.getAttribute("loggedInUser") != null;
    %>
    <div class="c-foot" style="border-bottom: 1px solid #E8E8ED; padding-bottom: 15px; margin-bottom: 15px; display:flex; justify-content:flex-start;">
      <div id="affected-container-<%= c.getId() %>">
      <% if (isAffected) { %>
          <button type="button" class="pill" style="background:#EBF5FF;color:#005B96;border:1px solid #BAE6FD;cursor:pointer;font-family:inherit;" onclick="markAffected(<%= c.getId() %>)">
            <i data-lucide="check-circle" style="width:13px;"></i> <span id="affected-count-<%= c.getId() %>"><%= c.getAffectedCount() %></span> I AM AFFECTED
          </button>
      <% } else if (isLogged) { %>
          <button type="button" class="pill p-blue" style="cursor:pointer;border:none;font-family:inherit;" onclick="markAffected(<%= c.getId() %>)">
            <i data-lucide="users" style="width:13px;"></i> <span id="affected-count-<%= c.getId() %>"><%= c.getAffectedCount() %></span> AFFECTED
          </button>
      <% } else { %>
          <button type="button" class="pill p-blue" style="cursor:pointer;border:none;font-family:inherit;" onclick="alert('Please login to mark yourself as affected.')">
            <i data-lucide="users" style="width:13px;"></i> <%= c.getAffectedCount() %> AFFECTED
          </button>
      <% } %>
      </div>
    </div>
    
    <!-- Comment Section -->
    <div class="c-comments" id="comment-list-<%= c.getId() %>" style="font-size:13px; color:#1D1D1F;">
        <% 
            java.util.Map<Integer, java.util.List<com.civicsathy.model.Comment>> commentsMap = 
                (java.util.Map<Integer, java.util.List<com.civicsathy.model.Comment>>) request.getAttribute("commentsMap");
            java.util.List<com.civicsathy.model.Comment> commentsList = commentsMap != null ? commentsMap.get(c.getId()) : null;
            int loggedUserId = loggedInUser != null ? loggedInUser.getId() : -1;
            if (commentsList != null && !commentsList.isEmpty()) {
                for (com.civicsathy.model.Comment comment : commentsList) {
        %>
            <div id="comment-<%= comment.getId() %>" style="margin-bottom:10px; background:#F5F5F7; padding:10px; border-radius:8px; display:flex; justify-content:space-between; align-items:center;">
                <div>
                    <span style="font-weight:700; color:#005B96; margin-right:5px;"><%= (comment.getUserName() != null ? comment.getUserName().split(" ")[0] : "Citizen") %></span>
                    <span><%= comment.getCommentText() %></span>
                </div>
                <% if (comment.getUserId() == loggedUserId) { %>
                <button type="button" onclick="deleteComment(<%= comment.getId() %>)" style="background:none;border:none;color:#D93025;cursor:pointer;font-size:11px;font-weight:600;padding:4px 8px;border-radius:4px;" onmouseover="this.style.background='#FEF2F2'" onmouseout="this.style.background='none'">Delete</button>
                <% } %>
            </div>
        <%      } 
            } else { %>
            <div class="no-comments" style="color:#86868B; margin-bottom:10px; font-style:italic;">No comments yet.</div>
        <%  } %>
    </div>

    <% if (isLogged) { %>
        <div style="display:flex; gap:8px; margin-top:10px;">
            <input type="text" id="comment-input-<%= c.getId() %>" placeholder="Write a comment..." required style="flex:1; border:1px solid #E8E8ED; padding:8px 12px; border-radius:20px; outline:none; font-family:inherit; font-size:13px;">
            <button type="button" onclick="postComment(<%= c.getId() %>)" style="background:#005B96; color:white; border:none; padding:8px 16px; border-radius:20px; cursor:pointer; font-weight:600; font-family:inherit;">Post</button>
        </div>
    <% } else { %>
        <div style="margin-top:10px; padding:10px; background:#F9FAFB; border-radius:8px; text-align:center; color:#86868B;">
            <a href="${pageContext.request.contextPath}/citizen/login.jsp" style="color:#005B96; text-decoration:none; font-weight:600;">Log in</a> to write a comment.
        </div>
    <% } %>
  </div>
  <% 
      }
    } else { 
  %>
    <div style="padding:40px;text-align:center;color:#86868B;background:#fff;border-radius:10px;border:1px solid #E8E8ED;">
      No issues reported yet.
    </div>
  <% } %>

</div>

<!-- RIGHT PANEL -->
<div class="right-col">
  <div class="r-panel">
    <div class="r-hd">Today's Stats</div>
    <div class="st-row"><span>Total Reports</span><span class="st-val" style="color:#1D1D1F;">${totalCount}</span></div>
    <div class="st-row"><span>Resolved Today</span><span class="st-val" style="color:#1A7F4B;">${resolvedTodayCount}</span></div>
    <div class="st-row"><span>Pending</span><span class="st-val" style="color:#B45309;">${pendingCount}</span></div>
    <div class="st-row"><span>In Progress</span><span class="st-val" style="color:#005B96;">${inProgressCount}</span></div>
  </div>
  <!-- BROADCAST MESSAGE -->
  <div class="r-panel" style="background:linear-gradient(to bottom right, #005B96, #003F6B); color:#fff; border:none;">
    <div class="r-hd" style="color:#BAE6FD;"><i data-lucide="radio" style="width:14px;vertical-align:bottom;margin-right:4px;"></i> Broadcast Message</div>
    <%
      java.util.List<com.civicsathy.model.Announcement> annList = 
        (java.util.List<com.civicsathy.model.Announcement>) request.getAttribute("announcements");
      if (annList != null && !annList.isEmpty()) {
        for (int i = 0; i < annList.size(); i++) { 
           com.civicsathy.model.Announcement ann = annList.get(i);
           String extraStyle = (i > 0) ? "padding-top:12px;border-top:1px solid rgba(255,255,255,0.15);" : "";
    %>
    <div style="<%= extraStyle %>margin-bottom:12px;">
      <div style="font-size:13px;font-weight:700;margin-bottom:4px;"><%= ann.getTitle() %></div>
      <div style="font-size:11px;opacity:0.9;line-height:1.4;"><%= ann.getMessage() %></div>
    </div>
    <%  } 
      } else { %>
    <div style="font-size:12px;opacity:0.8;font-style:italic;padding:10px 0;">No active broadcasts at the moment.</div>
    <% } %>
  </div>
</div>

</div><!-- /main -->
</div><!-- /app -->

<!-- MOBILE BOTTOM NAV -->
<nav class="m-bnav">
  <a href="${pageContext.request.contextPath}/feed" class="mn active"><i data-lucide="layout-grid" style="width:20px;"></i>Feed</a>
  <a href="${pageContext.request.contextPath}/track" class="mn"><i data-lucide="compass" style="width:20px;"></i>Track</a>
  <div class="mfab-w"><a href="${pageContext.request.contextPath}/citizen/submit.jsp" class="mfab"><i data-lucide="camera" style="width:24px;"></i></a></div>
  <a href="javascript:void(0)" onclick="document.getElementById('sosModalFull').style.display='flex'" class="mn red"><i data-lucide="siren" style="width:20px;"></i>Emergency</a>
  <a href="${pageContext.request.contextPath}/profile" class="mn"><i data-lucide="user" style="width:20px;"></i>Profile</a>
</nav>

<script>
lucide.createIcons();

function markAffected(id) {
    var btnContainer = document.getElementById('affected-container-' + id);
    
    fetch('${pageContext.request.contextPath}/add-affected?ajax=true&complaintId=' + id, {
        method: 'POST'
    }).then(function(response) { return response.text(); }).then(function(result) {
        var parts = result.trim().split(':');
        var action = parts[0];
        var count = parts[1];
        
        if (action === 'ADDED') {
            btnContainer.innerHTML = '<button type="button" class="pill" style="background:#EBF5FF;color:#005B96;border:1px solid #BAE6FD;cursor:pointer;font-family:inherit;" onclick="markAffected(' + id + ')">'
                + '<i data-lucide="check-circle" style="width:13px;"></i> <span id="affected-count-' + id + '">' + count + '</span> I AM AFFECTED'
                + '</button>';
        } else if (action === 'REMOVED') {
            btnContainer.innerHTML = '<button type="button" class="pill p-blue" style="cursor:pointer;border:none;font-family:inherit;" onclick="markAffected(' + id + ')">'
                + '<i data-lucide="users" style="width:13px;"></i> <span id="affected-count-' + id + '">' + count + '</span> AFFECTED'
                + '</button>';
        }
        lucide.createIcons();
    });
}

function postComment(id) {
    const input = document.getElementById('comment-input-' + id);
    const text = input.value.trim();
    if (!text) return;
    
    const formData = new URLSearchParams();
    formData.append('ajax', 'true');
    formData.append('complaintId', id);
    formData.append('commentText', text);
    
    fetch('${pageContext.request.contextPath}/add-comment', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: formData
    }).then(response => {
        if (response.ok) {
            const list = document.getElementById('comment-list-' + id);
            const noComments = list.querySelector('.no-comments');
            if (noComments) noComments.remove();
            
            const div = document.createElement('div');
            div.style.cssText = 'margin-bottom:10px; background:#F5F5F7; padding:10px; border-radius:8px; display:block;';
            
            const nameSpan = document.createElement('span');
            nameSpan.style.cssText = 'font-weight:700; color:#005B96; margin-right:5px;';
            nameSpan.innerText = 'Me';
            
            const textSpan = document.createElement('span');
            textSpan.style.color = '#1D1D1F';
            textSpan.innerText = text;
            
            div.appendChild(nameSpan);
            div.appendChild(textSpan);
            list.appendChild(div);
            input.value = '';
        }
    });
}

function deleteComment(commentId) {
    if (!confirm('Delete this comment?')) return;
    fetch('${pageContext.request.contextPath}/add-comment', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'action=delete&commentId=' + commentId
    }).then(response => {
        if (response.ok) {
            const el = document.getElementById('comment-' + commentId);
            if (el) el.remove();
        } else {
            alert('Could not delete comment.');
        }
    });
}
</script>
</body>
</html>
