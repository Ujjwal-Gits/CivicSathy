<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="com.civicsathy.model.Complaint" %>
<%
    List<Complaint> mapComplaints = (List<Complaint>) request.getAttribute("mapComplaints");
    Map<Integer, Integer> wardCounts = (Map<Integer, Integer>) request.getAttribute("wardCounts");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy - Live Map</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script src="https://leaflet.github.io/Leaflet.heat/dist/leaflet-heat.js"></script>
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
.map-container{flex:1;border-radius:8px;overflow:hidden;position:relative;}
#itahariMap{width:100%;height:100%;}
.overlay-ui{position:absolute;top:16px;left:16px;background:#fff;padding:16px;border-radius:8px;border:1px solid #E8E8ED;box-shadow:0 10px 25px rgba(0,0,0,0.08);width:240px;z-index:1000;}
.overlay-title{font-size:13px;font-weight:700;margin-bottom:12px;padding-bottom:10px;border-bottom:1px solid #E8E8ED;}
.ward-row{display:flex;justify-content:space-between;font-size:12px;padding:6px 0;border-bottom:1px solid #F5F5F7;}
.ward-row:last-child{border:none;}
.ward-count{font-weight:700;color:#D93025;}

/* MOBILE OVERRIDES */
.m-header{display:none;}.m-sidebar{display:none;}
@media(max-width:768px){
  body{display:block !important; overflow:visible;}
  .m-header{width:100%; box-sizing:border-box;}
  .sidebar{display:none !important;}
  .topbar{display:none !important;}
  .main{height:auto;min-height:100vh;overflow:visible;}
  .content{padding:12px;height:500px;}
  
  .m-header{display:flex;align-items:center;gap:12px;height:60px;background:#fff;border-bottom:1px solid #E8E8ED;padding:0 16px;position:sticky;top:0;z-index:2001;}
  .m-burger{width:40px;height:40px;display:flex;align-items:center;justify-content:center;background:#F5F5F7;border-radius:8px;color:#1D1D1F;}
  .m-logo{font-size:17px;font-weight:700;letter-spacing:-.3px;}.m-logo span{color:#005B96;}
  
  .m-sidebar{display:flex;flex-direction:column;position:fixed;top:0;left:-280px;width:280px;height:100vh;background:#fff;z-index:2000;transition:.3s cubic-bezier(0.4, 0, 0.2, 1);visibility:hidden;}
  .m-sidebar.show{left:0;visibility:visible;box-shadow:20px 0 50px rgba(0,0,0,0.15);}
  .m-overlay{display:none;position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.5);backdrop-filter:blur(2px);z-index:1999;}
  .m-overlay.show{display:block;}
  
  .overlay-ui{position:relative;top:0;left:0;width:100%;box-shadow:none;margin-top:16px;z-index:1;}
  .map-container{height:400px;min-height:400px;}
  #itahariMap{height:400px !important;}
}
</style>
</head>
<body>
<aside class="sidebar">
  <div class="sb-brand"><div class="sb-logo">Civic<span>Sathy</span></div><div class="sb-badge"><i data-lucide="shield-check" style="width:10px;height:10px;"></i> Admin Portal</div></div>
  <nav class="sb-nav">
    <div class="sb-sec">Overview</div>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/dashboard-stats"><i data-lucide="layout-dashboard" style="width:18px;height:18px;"></i> Dashboard</a>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/complaints"><i data-lucide="list-checks" style="width:18px;height:18px;"></i> All Tickets</a>
    <div class="sb-sec">Management</div>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/tasks"><i data-lucide="clipboard-list" style="width:18px;height:18px;"></i> Assigned Tasks</a>
    <a class="sb-item danger" href="${pageContext.request.contextPath}/admin/escalations"><i data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i> Escalations <span class="badge-red"><%= new com.civicsathy.dao.ComplaintDAO().getEscalatedCount() %></span></a>
    <div class="sb-sec">Analytics & Map</div>
    <a class="sb-item active" href="${pageContext.request.contextPath}/admin/map-data"><i data-lucide="map" style="width:18px;height:18px;"></i> Ward Heatmap</a>
    <div class="sb-sec">Communications</div>
    <a class="sb-item" href="announcements.jsp"><i data-lucide="radio" style="width:18px;height:18px;"></i> Broadcast</a>
    <div class="sb-sec">System</div>
    <a class="sb-item" href="teams.jsp"><i data-lucide="users" style="width:18px;height:18px;"></i> Team Management</a>
    <a class="sb-item" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i> Profile & Settings</a>
  </nav>
  <div class="sb-footer"><a href="${pageContext.request.contextPath}/logout"><button class="sb-logout"><i data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
</aside>

<!-- MOBILE HEADER -->
<div class="m-header">
  <button class="m-burger" onclick="toggleMSB()"><i data-lucide="menu" style="width:20px;"></i></button>
  <div class="m-logo">Civic<span>Sathy</span></div>
</div>

<!-- MOBILE SIDEBAR -->
<div class="m-overlay" id="mOverlay" onclick="toggleMSB()"></div>
<div class="m-sidebar" id="mSidebar">
  <div class="sb-brand">
    <div style="display:flex;align-items:center;justify-content:space-between;width:100%;">
      <div class="sb-logo">Civic<span>Sathy</span></div>
      <button onclick="toggleMSB()" style="background:none;border:none;color:#86868B;"><i data-lucide="x" style="width:20px;"></i></button>
    </div>
    <div class="sb-badge"><i data-lucide="shield-check" style="width:10px;height:10px;"></i> Admin Portal</div>
  </div>
  <nav class="sb-nav">
    <div class="sb-sec">Overview</div>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/dashboard-stats"><i data-lucide="layout-dashboard" style="width:18px;height:18px;"></i> Dashboard</a>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/complaints"><i data-lucide="list-checks" style="width:18px;height:18px;"></i> All Tickets</a>
    <div class="sb-sec">Management</div>
    <a class="sb-item" href="${pageContext.request.contextPath}/admin/tasks"><i data-lucide="clipboard-list" style="width:18px;height:18px;"></i> Assigned Tasks</a>
    <a class="sb-item danger" href="${pageContext.request.contextPath}/admin/escalations"><i data-lucide="flag-triangle-right" style="width:18px;height:18px;"></i> Escalations</a>
    <div class="sb-sec">Analytics & Map</div>
    <a class="sb-item active" href="${pageContext.request.contextPath}/admin/map-data"><i data-lucide="map" style="width:18px;height:18px;"></i> Ward Heatmap</a>
    <div class="sb-sec">System</div>
    <a class="sb-item" href="settings.jsp"><i data-lucide="settings" style="width:18px;height:18px;"></i> Settings</a>
  </nav>
  <div class="sb-footer"><a href="${pageContext.request.contextPath}/logout"><button class="sb-logout"><i data-lucide="log-out" style="width:16px;height:16px;"></i> Sign Out</button></a></div>
</div>

<div class="main">
  <header class="topbar"><span class="tb-title">Live Ward Heatmap — Itahari Sub-Metropolitan</span></header>
  <div class="content">
    <div class="map-container">
      <div id="itahariMap"></div>

      <!-- ward stats overlay -->
      <div class="overlay-ui">
        <div class="overlay-title">Map Filters</div>
        <div style="margin-bottom:16px;">
          <label style="font-size:11px;font-weight:700;color:#86868B;display:block;margin-bottom:6px;">Filter by Ward</label>
          <select id="wardFilter" onchange="updateMap()" style="width:100%;padding:8px;border:1px solid #E8E8ED;border-radius:6px;font-size:13px;font-family:inherit;font-weight:600;outline:none;background:#F5F5F7;">
            <option value="all">All Wards</option>
            <% for(int i=1; i<=20; i++) { %>
            <option value="<%= i %>">Ward <%= i %></option>
            <% } %>
          </select>
        </div>
        <div class="overlay-title">Complaints by Ward</div>
        <div class="scroll-area" style="max-height:200px;overflow-y:auto;padding-right:4px;">
        <% if (wardCounts != null) {
            for (Map.Entry<Integer, Integer> entry : wardCounts.entrySet()) { %>
          <div class="ward-row">
            <span>Ward <%= entry.getKey() %></span>
            <span class="ward-count"><%= entry.getValue() %></span>
          </div>
        <% } } else { %>
          <div style="font-size:12px;color:#86868B;">No data yet</div>
        <% } %>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
lucide.createIcons();
function toggleMSB() {
  document.getElementById('mSidebar').classList.toggle('show');
  document.getElementById('mOverlay').classList.toggle('show');
}

// initialize leaflet map centered on itahari
var map = L.map('itahariMap').setView([26.6615, 87.2773], 14);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors',
    maxZoom: 19
}).addTo(map);

// Data structure for filtering
var allComplaints = [
<% if (mapComplaints != null) {
    for (Complaint c : mapComplaints) {
        if (c.getLatitude() != 0 && c.getLongitude() != 0) { %>
    {
        lat: <%= c.getLatitude() %>,
        lng: <%= c.getLongitude() %>,
        ward: <%= c.getWardNo() %>,
        title: '<%= (c.getTitle() != null ? c.getTitle().replace("'", "`") : "Untitled Issue") %>',
        status: '<%= c.getStatus() %>',
        tracking: '<%= c.getTrackingId() %>',
        category: '<%= c.getCategoryName() %>',
        id: <%= c.getId() %>,
        color: '<%= "PENDING".equals(c.getStatus()) ? "#B45309" : "IN_PROGRESS".equals(c.getStatus()) ? "#005B96" : "#D93025" %>'
    },
<%      }
    }
} %>
];

var markerGroup = L.layerGroup().addTo(map);
var heatLayer = null;

function updateMap() {
    var selectedWard = document.getElementById('wardFilter').value;
    markerGroup.clearLayers();
    if (heatLayer) map.removeLayer(heatLayer);

    var filtered = allComplaints.filter(c => selectedWard === 'all' || c.ward == selectedWard);
    
    // Add Markers
    filtered.forEach(c => {
        var m = L.circleMarker([c.lat, c.lng], {
            radius: 8,
            fillColor: c.color,
            color: '#fff',
            weight: 2,
            opacity: 1,
            fillOpacity: 0.8
        }).addTo(markerGroup);

        m.bindPopup(
            '<strong>' + c.title + '</strong><br>' +
            'Ward: ' + c.ward + ' | ' + c.category + '<br>' +
            'Status: ' + c.status + '<br>' +
            '#' + c.tracking + '<br>' +
            '<a href="ticket.jsp?id=' + c.id + '" style="display:inline-block;margin-top:6px;padding:4px 10px;background:#005B96;color:#fff;border-radius:4px;font-size:11px;font-weight:600;text-decoration:none;">View Details &rarr;</a>'
        );
    });

    // Add Heatmap
    var heatPoints = filtered.map(c => [c.lat, c.lng, 0.5]);
    if (heatPoints.length > 0) {
        heatLayer = L.heatLayer(heatPoints, {
            radius: 25,
            blur: 15,
            maxZoom: 17,
            gradient: { 0.4: 'blue', 0.65: 'lime', 1: 'red' }
        }).addTo(map);
    }

    // Auto-zoom
    if (selectedWard !== 'all' && filtered.length > 0) {
        var group = new L.featureGroup(filtered.map(c => L.marker([c.lat, c.lng])));
        map.fitBounds(group.getBounds(), { padding: [40, 40], maxZoom: 15 });
    } else if (selectedWard === 'all') {
        map.setView([26.6615, 87.2773], 14);
    }
}

// Initial load
updateMap();
</script>
</body>
</html>
