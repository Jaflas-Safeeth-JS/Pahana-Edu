<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pahanaedu.dao.CustomerDAO, com.pahanaedu.dao.BookDAO, com.pahanaedu.dao.BillDAO" %>
<jsp:include page="header.jsp" />

<%
    String role = (String) session.getAttribute("role");
    String username = (String) session.getAttribute("username"); 
%>

<h1>Dashboard</h1>
<div style="display:flex; gap:20px; flex-wrap: wrap;">
    <%
        CustomerDAO cdao = new CustomerDAO();
        BookDAO bdao = new BookDAO();
        BillDAO billdao = new BillDAO();

        int totalCustomers = cdao.getTotalCustomers();
        int totalBooks = bdao.getTotalBooks();
        double totalSalesToday = billdao.getTotalSalesToday();
        int totalBillsToday = billdao.getTotalBillsToday();
    %>
    
    <%
        if ("admin".equals(role) || "cashier".equals(role)) {
    %>

    <div style="background:#667eea;color:white;padding:20px;border-radius:12px;flex:1;min-width:200px;">
        <h3>Total Customers</h3>
        <p style="font-size:24px;"><%= totalCustomers %></p>
    </div>

    <div style="background:#764ba2;color:white;padding:20px;border-radius:12px;flex:1;min-width:200px;">
        <h3>Total Books</h3>
        <p style="font-size:24px;"><%= totalBooks %></p>
    </div>

    <div style="background:#28a745;color:white;padding:20px;border-radius:12px;flex:1;min-width:200px;">
        <h3>Total Bills Today</h3>
        <p style="font-size:24px;"><%= totalBillsToday %></p>
    </div>

    <div style="background:#fd7e14;color:white;padding:20px;border-radius:12px;flex:1;min-width:200px;">
        <h3>Total Sales Today</h3>
        <p style="font-size:24px;">Rs. <%= totalSalesToday %></p>
    </div>
</div>

<% } else if ("customer".equals(role)) { %>
    <div class="welcome-box">
        <div class="welcome-card">
            <h1>Welcome, <%= username %>!</h1>
            <p>We’re glad to have you here 🎉</p>
        </div>
    </div>
<% } %>

<style>
    .welcome-box {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 50vh;            
        width: 100%;
    }
    .welcome-card {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 50px 80px;
        border-radius: 20px;
        text-align: center;
        box-shadow: 0 6px 20px rgba(0,0,0,0.2);
    }
    .welcome-card h1 {
        font-size: 50px;
        margin-bottom: 20px;
    }
    .welcome-card p {
        font-size: 22px;
        opacity: 0.9;
    }
</style>


