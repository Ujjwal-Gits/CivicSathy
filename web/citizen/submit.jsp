<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy — Report an Issue</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<link rel="stylesheet" href="../assets/css/citizen.css">
</head>
<body>
<div class="card">
  <div class="logo">Civic<span>Sathy</span></div>
  <div class="sub">Report a civic issue to Itahari Sub-Metropolitan City</div>
  <div class="upload-area">
    <div class="upload-btn"><i data-lucide="camera" style="width:20px;"></i> Camera</div>
    <div class="upload-btn"><i data-lucide="image" style="width:20px;"></i> Gallery</div>
  </div>
  <div class="field"><label>Title</label><input type="text" placeholder="Brief title of the issue"></div>
  <div class="field"><label>Description</label><textarea style="height:80px;resize:vertical;" placeholder="Describe the problem in detail..."></textarea></div>
  <div class="field"><label>Category</label>
    <select><option>Roads</option><option>Garbage</option><option>Water</option><option>Electricity</option><option>Flooding</option><option>Safety</option><option>Other</option></select>
  </div>
  <div class="field"><label>Ward Number</label><input type="number" placeholder="Enter your ward number"></div>
  <div class="field"><label>GPS Location</label><input type="text" placeholder="Auto-detected from GPS" disabled style="background:#F9FAFB;"></div>
  <div class="toggle-row"><span>Post Anonymously</span><div class="toggle" onclick="this.classList.toggle('on')"></div></div>
  <button class="btn">Submit Report</button>
</div>
<script>lucide.createIcons();</script>
</body>
</html>




