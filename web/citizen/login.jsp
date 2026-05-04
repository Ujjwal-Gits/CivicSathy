<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy - Citizen Login</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'DM Sans',sans-serif;background:#F5F5F7;min-height:100vh;display:flex;align-items:center;justify-content:center;padding:24px;-webkit-font-smoothing:antialiased;}
.card{background:#fff;border:1px solid #E8E8ED;border-radius:8px;width:100%;max-width:420px;padding:40px;}
.logo{font-size:22px;font-weight:700;letter-spacing:-.4px;margin-bottom:5px;}.logo span{color:#005B96;}
.sub{font-size:13px;color:#86868B;margin-bottom:28px;}
.field{margin-bottom:16px;}.field label{display:block;font-size:12px;font-weight:600;margin-bottom:5px;}
.field input{width:100%;height:42px;border:1px solid #E8E8ED;border-radius:4px;padding:0 12px;font-size:13px;font-family:inherit;outline:none;transition:border-color .15s;}
.field input:focus{border-color:#005B96;}
.btn{width:100%;height:44px;background:#005B96;color:#fff;border:none;border-radius:4px;font-size:14px;font-weight:600;font-family:inherit;cursor:pointer;margin-top:8px;}
.link-row{text-align:center;font-size:12px;color:#86868B;margin-top:16px;}
.link-row a{color:#005B96;font-weight:600;text-decoration:none;}
</style>
</head>
<body>
<div class="card">
  <div class="logo">Civic<span>Sathy</span></div>
  <div class="sub">Citizen Portal - Itahari Sub-Metropolitan City</div>
  <!-- login form that sends data to the login servlet -->
  <form action="${pageContext.request.contextPath}/login" method="POST">
    <div class="field"><label>Email Address</label><input type="email" name="email" required placeholder="your@email.com"></div>
    <div class="field"><label>Password</label><input type="password" name="password" required placeholder="Enter your password"></div>
    <button type="submit" class="btn">Sign In</button>
  </form>
  <div class="link-row">New here? <a href="register.jsp">Create Account</a></div>
  <div class="link-row" style="margin-top:8px;">Municipality staff? <a href="admin-login.jsp">Admin Login &rarr;</a></div>
</div>
</body>
</html>
