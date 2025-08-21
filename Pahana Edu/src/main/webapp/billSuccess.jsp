<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bill Saved</title>
<style>
    body { font-family: Arial, sans-serif; background:#f4f6f9; }
    .wrap { max-width: 600px; margin: 60px auto; background:#fff; padding: 24px; border-radius: 12px; box-shadow: 0 6px 18px rgba(0,0,0,.08); text-align:center; }
    a { display:inline-block; margin-top: 12px; padding: 10px 14px; background:#667eea; color:#fff; text-decoration:none; border-radius:10px; }
</style>
</head>
<body>
<div class="wrap">
    <h2>Bill Created Successfully</h2>
    <p>Bill ID: <strong><%= request.getParameter("billId") %></strong></p>
    <a href="billing">Create Another Bill</a>
</div>
</body>
</html>
