<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Admin Sidebar Include - Used by all admin pages --%>
<style>
.admin-sidebar{width:220px;flex-shrink:0;background:#111111;min-height:100vh;display:flex;flex-direction:column;position:sticky;top:0;height:100vh;overflow-y:auto;}
.sb-brand{padding:20px 16px 16px;border-bottom:1px solid #222;}
.sb-logo{font-size:17px;font-weight:700;letter-spacing:-.3px;color:#fff;}
.sb-logo span{color:#005B96;}
.sb-badge{font-size:9px;color:#555;text-transform:uppercase;letter-spacing:.1em;margin-top:2px;}
.sb-nav{flex:1;padding:12px 10px;}
.sb-section{font-size:9px;font-weight:700;color:#444;text-transform:uppercase;letter-spacing:.1em;padding:0 8px;margin:14px 0 6px;}
.sb-section:first-child{margin-top:4px;}
.sb-item{display:flex;align-items:center;gap:9px;padding:8px 8px;border-radius:4px;font-size:12px;font-weight:500;color:#888;text-decoration:none;margin-bottom:2px;transition:all .1s;}
.sb-item:hover{background:#1A1A1A;color:#fff;}
.sb-item.active{background:#1A3A5C;color:#fff;}
.sb-item.alert{color:#D93025;}
.sb-item.alert:hover{background:#2A0A0A;color:#D93025;}
.sb-footer{padding:14px 10px;border-top:1px solid #1A1A1A;}
.sb-user{display:flex;align-items:center;gap:8px;padding:8px;border-radius:4px;}
.sb-avatar{width:30px;height:30px;border-radius:50%;background:#1A3A5C;display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:700;color:#005B96;border:1px solid #1E4A7A;}
.sb-name{font-size:12px;font-weight:600;color:#ccc;line-height:1.2;}
.sb-role{font-size:10px;color:#555;}
.sb-logout{display:flex;align-items:center;gap:7px;width:100%;padding:7px 8px;background:none;border:none;border-radius:4px;font-size:12px;font-weight:600;color:#555;cursor:pointer;font-family:inherit;margin-top:4px;}
.sb-logout:hover{background:#1A1A1A;color:#D93025;}
</style>

<aside class="admin-sidebar">
  <div class="sb-brand">
    <div class="sb-logo">Civic<span>Sathy</span></div>
    <div class="sb-badge">Municipality Portal</div>
  </div>
  <nav class="sb-nav">
    <div class="sb-section">Overview</div>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="sb-item ${requestScope['currentPage']=='dashboard'?'active':''}">
      <i data-lucide="layout-dashboard" style="width:14px;height:14px;"></i> Dashboard
    </a>
    <a href="${pageContext.request.contextPath}/admin/complaints" class="sb-item ${requestScope['currentPage']=='complaints'?'active':''}">
      <i data-lucide="list-checks" style="width:14px;height:14px;"></i> All Complaints
    </a>
    <div class="sb-section">Management</div>
    <a href="${pageContext.request.contextPath}/admin/teams" class="sb-item ${requestScope['currentPage']=='teams'?'active':''}">
      <i data-lucide="users" style="width:14px;height:14px;"></i> Teams
    </a>
    <a href="#" class="sb-item">
      <i data-lucide="flag-triangle-right" style="width:14px;height:14px;"></i> Escalations
      <span style="margin-left:auto;background:#D93025;color:#fff;font-size:9px;font-weight:700;padding:1px 6px;border-radius:3px;">3</span>
    </a>
    <div class="sb-section">Analytics</div>
    <a href="#" class="sb-item"><i data-lucide="bar-chart-3" style="width:14px;height:14px;"></i> Reports</a>
    <a href="#" class="sb-item"><i data-lucide="map" style="width:14px;height:14px;"></i> Ward Heatmap</a>
    <div class="sb-section">System</div>
    <a href="#" class="sb-item"><i data-lucide="settings" style="width:14px;height:14px;"></i> Settings</a>
    <a href="#" class="sb-item alert"><i data-lucide="alert-triangle" style="width:14px;height:14px;"></i> High Priority (5)</a>
  </nav>
  <div class="sb-footer">
    <div class="sb-user">
      <div class="sb-avatar">A</div>
      <div><div class="sb-name">${sessionScope.adminName != null ? sessionScope.adminName : 'Admin'}</div><div class="sb-role">Ward Officer</div></div>
    </div>
    <form method="post" action="${pageContext.request.contextPath}/admin/logout">
      <button type="submit" class="sb-logout"><i data-lucide="log-out" style="width:13px;height:13px;"></i> Sign Out</button>
    </form>
  </div>
</aside>


