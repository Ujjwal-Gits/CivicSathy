<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.civicsathy.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    boolean isLoggedIn = loggedInUser != null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
    <title>CivicSathy - Emergency Contacts</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
    <style>
        /* Base Styles */
        *{box-sizing:border-box;margin:0;padding:0;}
        body{font-family:'DM Sans',sans-serif;background:#F5F5F7;color:#1D1D1F;-webkit-font-smoothing:antialiased;}
        a{text-decoration:none;color:inherit;}button{cursor:pointer;font-family:inherit;border:none;}

        /* MOBILE TOPBAR */
        .m-topbar{display:flex;align-items:center;justify-content:space-between;padding:10px 16px;background:#fff;border-bottom:1px solid #E8E8ED;position:sticky;top:0;z-index:100;}
        .tb-logo{font-size:17px;font-weight:700;letter-spacing:-.3px;}.tb-logo span{color:#005B96;}
        .btn-back{width:36px;height:36px;display:flex;align-items:center;justify-content:center;color:#1D1D1F;background:none;border-radius:6px;margin-right:8px;}

        /* MAIN CONTENT */
        .main{padding:16px;padding-bottom:100px;max-width:600px;margin:0 auto;}
        .page-title{font-size:20px;font-weight:700;margin-bottom:16px;color:#D93025;display:flex;align-items:center;gap:8px;}

        .contact-card{background:#fff;border:1px solid #E8E8ED;border-radius:8px;padding:16px;margin-bottom:12px;display:flex;align-items:center;justify-content:space-between;}
        .c-info{display:flex;flex-direction:column;}
        .c-name{font-size:14px;font-weight:700;color:#1D1D1F;margin-bottom:4px;}
        .c-num{font-size:13px;color:#86868B;}
        .btn-call{background:#EBF5FF;color:#005B96;border:1px solid #BAE6FD;width:40px;height:40px;border-radius:50%;display:flex;align-items:center;justify-content:center;transition:.15s;}
        .btn-call.red{background:#FEF2F2;color:#D93025;border-color:#FECACA;}
        .btn-call:active{transform:scale(0.95);}

        .section-title{font-size:12px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.08em;margin:24px 0 12px;padding-left:4px;}

        /* MOBILE BOTTOM NAV */
        .m-bnav{display:flex;align-items:center;justify-content:space-around;position:fixed;bottom:0;left:0;right:0;z-index:1000;background:#fff;height:64px;padding:0 8px;border-top:1px solid #E8E8ED;padding-bottom:env(safe-area-inset-bottom);}
        .mn{display:flex;flex-direction:column;align-items:center;justify-content:center;gap:4px;flex:1;font-size:9px;font-weight:700;text-transform:uppercase;letter-spacing:.04em;color:#86868B;}
        .mn.active{color:#005B96;}.mn.red{color:#D93025;}
        .mfab-w{display:flex;flex-direction:column;align-items:center;justify-content:center;flex:1;}
        .mfab{width:48px;height:48px;background:#005B96;border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;transform:translateY(-12px);box-shadow:0 4px 8px rgba(0,91,150,.25);}

        /* Desktop hide */
        @media(min-width:769px){
            .m-topbar, .m-bnav{display:none;}
            .main{padding-top:40px;}
            .btn-back{display:flex;background:#fff;border:1px solid #E8E8ED;}
            .top-row{display:flex;align-items:center;}
        }
    </style>
</head>
<body>

<header class="m-topbar">
    <div style="display:flex;align-items:center;">
        <button class="btn-back" onclick="history.back()"><i data-lucide="arrow-left" style="width:20px;"></i></button>
        <div class="tb-logo">Civic<span>Sathy</span></div>
    </div>
</header>

<main class="main">
    <div class="top-row">
        <button class="btn-back" onclick="history.back()" style="display:none;" id="d-back"><i data-lucide="arrow-left" style="width:20px;"></i></button>
        <h1 class="page-title"><i data-lucide="siren" style="width:24px;"></i> Emergency Contacts</h1>
    </div>

    <div class="section-title">Emergency Services</div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Police Emergency</div><div class="c-num">100</div></div>
        <a href="tel:100" class="btn-call red"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Fire Brigade Emergency</div><div class="c-num">101</div></div>
        <a href="tel:101" class="btn-call red"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Ambulance Emergency</div><div class="c-num">102</div></div>
        <a href="tel:102" class="btn-call red"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Traffic Police</div><div class="c-num">103</div></div>
        <a href="tel:103" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>

    <div class="section-title">Helplines</div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Disaster Helpline</div><div class="c-num">1149</div></div>
        <a href="tel:1149" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Flood & Landslide Helpline</div><div class="c-num">1141</div></div>
        <a href="tel:1141" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Women Helpline</div><div class="c-num">1091</div></div>
        <a href="tel:1091" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Child Helpline</div><div class="c-num">1098</div></div>
        <a href="tel:1098" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Nepal Red Cross Hotline</div><div class="c-num">1130</div></div>
        <a href="tel:1130" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Tourist Police</div><div class="c-num">1144</div></div>
        <a href="tel:1144" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Armed Police Force (APF)</div><div class="c-num">1114</div></div>
        <a href="tel:1114" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>

    <div class="section-title">Ambulance Services</div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Lal Bahadur Katwal Ambulance</div><div class="c-num">9805303071</div></div>
        <a href="tel:9805303071" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Dharan Ambulance Service</div><div class="c-num">9811070889</div></div>
        <a href="tel:9811070889" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Dharan Ghopa Ambulance</div><div class="c-num">9749223854</div></div>
        <a href="tel:9749223854" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Sukuna Samudayik Ambulance</div><div class="c-num">9819379555</div></div>
        <a href="tel:9819379555" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>

    <div class="section-title">Hospitals</div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Apex Hospital</div><div class="c-num">025-580029</div></div>
        <a href="tel:025-580029" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Vedanta Hospital</div><div class="c-num">025-587584</div></div>
        <a href="tel:025-587584" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">MRS Pranami Hospital</div><div class="c-num">025-580930</div></div>
        <a href="tel:025-580930" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Samudayik Aspataal</div><div class="c-num">025-582012</div></div>
        <a href="tel:025-582012" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Itahari Medical Clinic</div><div class="c-num">025-581112</div></div>
        <a href="tel:025-581112" class="btn-call"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>

    <div class="section-title">Fire Stations</div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Itahari Fire Brigade</div><div class="c-num">101</div></div>
        <a href="tel:101" class="btn-call red"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
    <div class="contact-card">
        <div class="c-info"><div class="c-name">Dharan Fire Station</div><div class="c-num">025-570199</div></div>
        <a href="tel:025-570199" class="btn-call red"><i data-lucide="phone" style="width:18px;"></i></a>
    </div>
</main>

<!-- MOBILE BOTTOM NAV -->
<nav class="m-bnav">
    <a href="${pageContext.request.contextPath}/feed" class="mn"><i data-lucide="layout-grid" style="width:20px;"></i>Feed</a>
    <a href="${pageContext.request.contextPath}/track" class="mn"><i data-lucide="compass" style="width:20px;"></i>Track</a>
    <div class="mfab-w"><a href="${pageContext.request.contextPath}/citizen/submit.jsp" class="mfab"><i data-lucide="camera" style="width:24px;"></i></a></div>
    <a href="${pageContext.request.contextPath}/citizen/contacts.jsp" class="mn active red"><i data-lucide="siren" style="width:20px;"></i>Emergency</a>
    <a href="${pageContext.request.contextPath}/profile" class="mn"><i data-lucide="user" style="width:20px;"></i>Profile</a>
</nav>

<script>
    lucide.createIcons();
    if(window.innerWidth >= 769){
        document.getElementById('d-back').style.display = 'flex';
    }
</script>
</body>
</html>
