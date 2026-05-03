<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setAttribute("currentPage","dashboard"); %>
<jsp:include page="/WEB-INF/includes/header.jsp"/>
<style>
body{background:#0F0F0F;}
.admin-layout{display:flex;min-height:100vh;}
.admin-main{flex:1;display:flex;flex-direction:column;min-width:0;}
.admin-topbar{background:#161616;border-bottom:1px solid #222;padding:0 28px;height:56px;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:20;}
.tb-title{font-size:15px;font-weight:700;color:#fff;letter-spacing:-.15px;}
.tb-right{display:flex;align-items:center;gap:10px;}
.tb-btn{display:flex;align-items:center;gap:6px;padding:0 14px;height:34px;border-radius:4px;border:none;font-size:12px;font-weight:600;font-family:inherit;cursor:pointer;}
.tb-btn-ghost{background:#1A1A1A;color:#888;border:1px solid #2A2A2A;}
.tb-btn-primary{background:#005B96;color:#fff;}
.content{padding:28px;}
/* Alert banner */
.alert-banner{background:#1A0808;border:1px solid #4A1010;border-radius:6px;padding:12px 16px;display:flex;align-items:center;gap:10px;margin-bottom:24px;}
.alert-banner p{font-size:12px;color:#F87171;font-weight:500;}
.alert-banner a{font-size:12px;color:#F87171;font-weight:700;margin-left:auto;text-decoration:underline;}
/* Metric Cards */
.metrics{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-bottom:28px;}
.metric{background:#161616;border:1px solid #222;border-radius:6px;padding:18px;}
.metric-val{font-size:32px;font-weight:700;letter-spacing:-.5px;color:#fff;line-height:1;}
.metric-lbl{font-size:11px;color:#555;text-transform:uppercase;letter-spacing:.07em;margin-top:6px;font-weight:600;}
.metric-change{font-size:11px;margin-top:8px;display:flex;align-items:center;gap:4px;}
.change-up{color:#4ADE80;}
.change-dn{color:#F87171;}
/* FORMS */
.field{margin-bottom:12px;}
.field label{display:block;font-size:11px;font-weight:700;color:#86868B;margin-bottom:6px;text-transform:uppercase;letter-spacing:.05em;}
.input-base{width:100%;height:38px;border:1px solid #E8E8ED;border-radius:4px;padding:0 12px;font-size:13px;font-family:inherit;color:#0A0A0A;outline:none;transition:border-color .15s;background:#fff;}
.input-base:focus{border-color:#005B96;}
.input-base:disabled{background:#F5F5F7;color:#86868B;}
/* Grid */
.grid2{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-bottom:20px;}
.panel{background:#161616;border:1px solid #222;border-radius:6px;padding:20px;}
.panel-title{font-size:12px;font-weight:700;color:#888;text-transform:uppercase;letter-spacing:.07em;margin-bottom:16px;display:flex;align-items:center;justify-content:space-between;}
.panel-title a{font-size:11px;color:#005B96;font-weight:600;text-transform:none;letter-spacing:0;}
/* Recent complaints mini-list */
.mini-list{display:flex;flex-direction:column;gap:10px;}
.mini-item{display:flex;align-items:center;justify-content:space-between;padding:10px 0;border-bottom:1px solid #1A1A1A;}
.mini-item:last-child{border:none;}
.mini-title{font-size:12px;font-weight:600;color:#ccc;margin-bottom:2px;}
.mini-meta{font-size:10px;color:#555;}
.mini-status{padding:2px 7px;border-radius:3px;font-size:9px;font-weight:700;text-transform:uppercase;flex-shrink:0;}
.s-prog{background:#0A2A3F;color:#005B96;}
.s-pend{background:#2A1F00;color:#F59E0B;}
.s-res{background:#0A2A1A;color:#4ADE80;}
/* Stat bars (category breakdown) */
.cat-bar{margin-bottom:12px;}
.cat-bar-top{display:flex;justify-content:space-between;font-size:11px;color:#888;margin-bottom:4px;}
.cat-bar-top span:last-child{font-weight:700;color:#ccc;}
.bar-bg{height:4px;background:#1A1A1A;border-radius:2px;}
.bar-fill{height:4px;border-radius:2px;background:#005B96;}
/* Team status */
.team-row{display:flex;align-items:center;justify-content:space-between;padding:8px 0;border-bottom:1px solid #1A1A1A;}
.team-row:last-child{border:none;}
.team-name{font-size:12px;font-weight:600;color:#ccc;}
.team-jobs{font-size:11px;color:#555;margin-top:1px;}
.team-status{font-size:10px;font-weight:700;padding:2px 7px;border-radius:3px;}
.t-busy{background:#2A1A00;color:#F59E0B;}
.t-free{background:#0A2A1A;color:#4ADE80;}
@media(max-width:1024px){.metrics{grid-template-columns:repeat(2,1fr);}.grid2{grid-template-columns:1fr;}}
</style>

<div class="admin-layout">
  <jsp:include page="/WEB-INF/includes/admin-sidebar.jsp"/>
  <div class="admin-main">
    <header class="admin-topbar">
      <div class="tb-title">Dashboard</div>
      <div class="tb-right">
        <button class="tb-btn tb-btn-ghost"><i data-lucide="download" style="width:13px;height:13px;"></i> Export Report</button>
        <button class="tb-btn tb-btn-primary"><i data-lucide="refresh-cw" style="width:13px;height:13px;"></i> Refresh</button>
      </div>
    </header>
    <div class="content">

      <!-- this is alert banner -->
      <div class="alert-banner">
        <i data-lucide="alert-triangle" style="width:15px;height:15px;color:#F87171;flex-shrink:0;"></i>
        <p><strong>5 complaints</strong> have exceeded the 48-hour response threshold and require immediate escalation.</p>
        <a href="${pageContext.request.contextPath}/admin/complaints?filter=escalated">Review Now →</a>
      </div>

      <!-- this is metric cards -->
      <div class="metrics">
        <div class="metric">
          <div class="metric-val">${stats.totalComplaints != null ? stats.totalComplaints : '246'}</div>
          <div class="metric-lbl">Total Reports</div>
          <div class="metric-change change-up"><i data-lucide="trending-up" style="width:11px;height:11px;"></i> +12 today</div>
        </div>
        <div class="metric">
          <div class="metric-val" style="color:#F59E0B;">${stats.pendingCount != null ? stats.pendingCount : '54'}</div>
          <div class="metric-lbl">Pending</div>
          <div class="metric-change change-dn"><i data-lucide="trending-up" style="width:11px;height:11px;"></i> +5 from yesterday</div>
        </div>
        <div class="metric">
          <div class="metric-val" style="color:#005B96;">${stats.inProgressCount != null ? stats.inProgressCount : '22'}</div>
          <div class="metric-lbl">In Progress</div>
          <div class="metric-change" style="color:#555;">Across 8 teams</div>
        </div>
        <div class="metric">
          <div class="metric-val" style="color:#4ADE80;">${stats.resolvedToday != null ? stats.resolvedToday : '38'}</div>
          <div class="metric-lbl">Resolved Today</div>
          <div class="metric-change change-up"><i data-lucide="trending-up" style="width:11px;height:11px;"></i> 15% faster</div>
        </div>
      </div>

    <!-- this is profile & add member -->
    <div class="grid-2">
      <!-- this is profile panel -->
      <div class="panel">
        <div class="panel-hd">Municipality Profile</div>
        <div style="display:flex;flex-direction:column;gap:4px;">
           <div class="field"><label>Municipality Name</label><input type="text" class="input-base" value="Kathmandu Metropolitan City"></div>
           <div class="field"><label>Main Auth Email</label><input type="email" class="input-base" value="admin@kathmandu.gov.np"></div>
           <div class="field"><label>Ward Number</label><input type="text" class="input-base" value="Central Head Office" disabled></div>
           <button class="tb-btn tb-primary" style="width:max-content;margin-top:4px;">Update Profile</button>
        </div>
      </div>

      <!-- this is add member panel -->
      <div class="panel">
        <div class="panel-hd">Add Staff Member</div>
        <div style="display:flex;flex-direction:column;gap:4px;">
           <div class="field"><label>Staff Email</label><input type="email" class="input-base" placeholder="staff@kathmandu.gov.np"></div>
           <div class="field"><label>Assigned Ward</label>
             <select class="input-base">
               <option>Select Ward</option>
               <option>Ward 1</option>
               <option>Ward 2</option>
             </select>
           </div>
           <div class="field"><label>Verification Code</label><input type="text" class="input-base" placeholder="Enter 6-digit code sent to Main Email"></div>
           <button class="tb-btn tb-primary" style="width:max-content;margin-top:4px;">Authorize Member</button>
        </div>
      </div>
    </div>

    <div class="grid2">
        <!-- this is recent complaints -->
        <div class="panel">
          <div class="panel-title">Recent Complaints <a href="${pageContext.request.contextPath}/admin/complaints">View All →</a></div>
          <div class="mini-list">
            <div class="mini-item">
              <div><div class="mini-title">Large cracks on Kalanki bridge</div><div class="mini-meta">Ward 14 · Infrastructure · 2h ago</div></div>
              <span class="mini-status s-prog">In Progress</span>
            </div>
            <div class="mini-item">
              <div><div class="mini-title">Uncollected garbage Ward 5</div><div class="mini-meta">Ward 5 · Sanitation · 5h ago</div></div>
              <span class="mini-status s-pend">Pending</span>
            </div>
            <div class="mini-item">
              <div><div class="mini-title">Broken street light Chabahil</div><div class="mini-meta">Ward 10 · Electricity · 1d ago</div></div>
              <span class="mini-status s-res">Resolved</span>
            </div>
            <div class="mini-item">
              <div><div class="mini-title">Flooding near Balkhu bridge</div><div class="mini-meta">Ward 8 · Flooding · 3h ago</div></div>
              <span class="mini-status s-pend">Pending</span>
            </div>
          </div>
        </div>

        <!-- this is right side stack -->
        <div style="display:flex;flex-direction:column;gap:16px;">
          <!-- this is category breakdown -->
          <div class="panel">
            <div class="panel-title">Reports by Category</div>
            <div class="cat-bar"><div class="cat-bar-top"><span>Infrastructure</span><span>82</span></div><div class="bar-bg"><div class="bar-fill" style="width:82%;"></div></div></div>
            <div class="cat-bar"><div class="cat-bar-top"><span>Sanitation</span><span>61</span></div><div class="bar-bg"><div class="bar-fill" style="width:61%;background:#F59E0B;"></div></div></div>
            <div class="cat-bar"><div class="cat-bar-top"><span>Water Supply</span><span>45</span></div><div class="bar-bg"><div class="bar-fill" style="width:45%;background:#38BDF8;"></div></div></div>
            <div class="cat-bar"><div class="cat-bar-top"><span>Flooding</span><span>33</span></div><div class="bar-bg"><div class="bar-fill" style="width:33%;background:#818CF8;"></div></div></div>
            <div class="cat-bar"><div class="cat-bar-top"><span>Electricity</span><span>25</span></div><div class="bar-bg"><div class="bar-fill" style="width:25%;background:#34D399;"></div></div></div>
          </div>
          <!-- this is team status -->
          <div class="panel">
            <div class="panel-title">Team Status <a href="${pageContext.request.contextPath}/admin/teams">Manage →</a></div>
            <div class="team-row"><div><div class="team-name">Road Repair Unit A</div><div class="team-jobs">3 active jobs</div></div><span class="team-status t-busy">Busy</span></div>
            <div class="team-row"><div><div class="team-name">Sanitation Team B</div><div class="team-jobs">1 active job</div></div><span class="team-status t-busy">Busy</span></div>
            <div class="team-row"><div><div class="team-name">Water Services</div><div class="team-jobs">Available</div></div><span class="team-status t-free">Free</span></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script>lucide.createIcons();</script>
<jsp:include page="/WEB-INF/includes/footer.jsp"/>


