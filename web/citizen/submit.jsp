<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>CivicSathy - Report an Issue</title>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;9..40,500;9..40,600;9..40,700&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<style>
*{box-sizing:border-box;margin:0;padding:0;}
body{font-family:'DM Sans',sans-serif;background:#F5F5F7;min-height:100vh;display:flex;align-items:center;justify-content:center;padding:24px;-webkit-font-smoothing:antialiased;}
.card{background:#fff;border:1px solid #E8E8ED;border-radius:8px;width:100%;max-width:480px;padding:32px;}
.logo{font-size:20px;font-weight:700;letter-spacing:-.3px;margin-bottom:4px;}.logo span{color:#005B96;}
.sub{font-size:12px;color:#86868B;margin-bottom:24px;}
.upload-area{display:flex;gap:12px;margin-bottom:20px;}
.upload-btn{flex:1;height:80px;border:2px dashed #E8E8ED;border-radius:8px;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:4px;cursor:pointer;transition:.15s;font-size:11px;color:#86868B;font-weight:600;background:none;}
.upload-btn:hover{border-color:#005B96;color:#005B96;background:#F0FBFF;}
.field{margin-bottom:16px;}.field label{display:block;font-size:12px;font-weight:600;margin-bottom:6px;}
.field input,.field select,.field textarea{width:100%;border:1px solid #E8E8ED;border-radius:6px;padding:10px 12px;font-size:13px;font-family:inherit;outline:none;}
.field input:focus,.field select:focus,.field textarea:focus{border-color:#005B96;}
.toggle-row{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;padding:12px 16px;background:#F9FAFB;border-radius:6px;}
.toggle-row span{font-size:13px;font-weight:600;}
.toggle{width:40px;height:22px;background:#E8E8ED;border-radius:11px;cursor:pointer;position:relative;transition:.2s;border:none;}
.toggle::after{content:'';position:absolute;top:2px;left:2px;width:18px;height:18px;background:#fff;border-radius:50%;transition:.2s;}
.toggle.on{background:#005B96;}.toggle.on::after{left:20px;}
.btn{width:100%;height:48px;background:#005B96;color:#fff;border:none;border-radius:6px;font-size:15px;font-weight:600;cursor:pointer;}
</style>
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
