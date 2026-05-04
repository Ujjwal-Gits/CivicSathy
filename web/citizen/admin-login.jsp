<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy - Admin Login</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<style>
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'DM Sans',sans-serif;background:#F5F5F7;min-height:100vh;display:flex;align-items:center;justify-content:center;padding:24px;-webkit-font-smoothing:antialiased;}
.card{background:#fff;border:1px solid #E8E8ED;border-radius:8px;width:100%;max-width:400px;padding:40px;}
.logo{font-size:22px;font-weight:700;letter-spacing:-.4px;color:#0A0A0A;margin-bottom:8px;}.logo span{color:#005B96;}
.badge{display:inline-flex;align-items:center;gap:5px;padding:4px 10px;background:#EBF5FF;border:1px solid #BAE6FD;border-radius:4px;font-size:10px;font-weight:700;color:#005B96;text-transform:uppercase;letter-spacing:.08em;margin-bottom:28px;}
.section-lbl{font-size:11px;font-weight:700;color:#86868B;text-transform:uppercase;letter-spacing:.08em;margin-bottom:20px;}
.field{margin-bottom:16px;}.field label{display:block;font-size:12px;font-weight:600;color:#0A0A0A;margin-bottom:5px;}
.field input{width:100%;height:42px;background:#fff;border:1px solid #E8E8ED;border-radius:4px;padding:0 12px;font-size:13px;font-family:inherit;color:#0A0A0A;outline:none;transition:border-color .15s;}
.field input:focus{border-color:#005B96;}
.field input::placeholder{color:#86868B;}
.btn{width:100%;height:44px;background:#005B96;color:#fff;border:none;border-radius:4px;font-size:14px;font-weight:600;font-family:inherit;cursor:pointer;margin-top:8px;}
.note{display:flex;align-items:flex-start;gap:8px;background:#F9FAFB;border:1px solid #E8E8ED;border-radius:4px;padding:10px 12px;margin-top:20px;}
.note p{font-size:11px;color:#6B7280;line-height:1.5;}
.link-row{text-align:center;font-size:12px;color:#86868B;margin-top:16px;}
.link-row a{color:#005B96;font-weight:600;text-decoration:none;}
</style>
</head>
<body>
<div class="card">
  <div class="logo">Civic<span>Sathy</span></div>
  <div class="badge"><i data-lucide="shield-check" style="width:12px;height:12px;"></i> Municipality Staff Portal</div>
  <div class="section-lbl">Secure Sign In</div>
  <!-- admin login form -->
  <form action="${pageContext.request.contextPath}/login" method="POST">
    <div class="field"><label>Official Email</label><input type="email" name="email" required placeholder="staff@itahari.gov.np"></div>
    <div class="field"><label>Password</label><input type="password" name="password" required placeholder="Enter your password"></div>
    <button type="submit" class="btn">Access Dashboard</button>
  </form>
  <div class="note">
    <i data-lucide="lock" style="width:13px;height:13px;color:#86868B;flex-shrink:0;margin-top:1px;"></i>
    <p>This portal is restricted to authorised Itahari Sub-Metropolitan City staff. All access attempts are logged.</p>
  </div>
  <div class="link-row">Not staff? <a href="login.jsp">Citizen Login &rarr;</a></div>
</div>
<script>lucide.createIcons();</script>
</body>
</html>
