<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy — Register</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../assets/css/citizen.css">
</head>
<body>
<div class="card">
  <div class="logo">Civic<span>Sathy</span></div>
  <div class="sub">Create your citizen account</div>
  <div class="field"><label>Full Name</label><input type="text" placeholder="Your full name"></div>
  <div class="field"><label>Email Address</label><input type="email" placeholder="your@email.com"></div>
  <div class="field"><label>Contact Number</label><input type="tel" placeholder="e.g. 98XXXXXXXX"></div>
  
  <div class="row">
    <div class="field">
      <label>Ward Number</label>
      <select>
        <option value="" disabled selected>Select Ward</option>
        <option>Ward 1</option>
        <option>Ward 2</option>
        <option>Ward 3</option>
        <option>Ward 4</option>
        <option>Ward 5</option>
        <option>Ward 10</option>
        <option>Ward 14</option>
        <option>Ward 20</option>
      </select>
    </div>
    <div class="field">
      <label>Location / Tole</label>
      <input type="text" placeholder="e.g. Milan Chowk">
    </div>
  </div>

  <div class="field"><label>Password</label><input type="password" placeholder="Create a password"></div>
  <div class="field"><label>Confirm Password</label><input type="password" placeholder="Confirm your password"></div>
  
  <button class="btn">Create Account</button>
  <div class="link-row">Already have an account? <a href="login.jsp">Sign In</a></div>
</div>
</body>
</html>
