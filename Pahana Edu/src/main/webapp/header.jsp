<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="header no-print">
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    if (username == null || role == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pahana Edu Bookshop</title>
    <style>
        /* RESET & BODY */
        html, body {
            margin: 0; padding: 0;
            width: 100%; height: 100%;
            overflow-x: hidden;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
        }
        *, *::before, *::after { box-sizing: border-box; }

        /* HEADER */
        header {
            position: fixed;
            top: 0; left: 0;
            width: 100%; max-width: 100vw;
            height: 60px;
            background: #667eea;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            z-index: 1000;
        }
        header .logo { font-weight: bold; font-size: 1.2rem; }
        header .user-info {
            display: flex; align-items: center; gap: 12px;
            white-space: nowrap; overflow: hidden;
        }
        header .user-info a { color: white; text-decoration: none; font-weight: bold; }

        /* SIDEBAR */
        aside {
            position: fixed;
            top: 60px;
            left: 0;
            width: 220px;
            height: calc(100% - 60px);
            background: #764ba2;
            color: white;
            padding-top: 20px;
            overflow-y: auto;
        }
        aside a {
            display: block;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
        }
        aside a:hover { background: #5a3790; }

        /* MAIN CONTENT */
        main {
            margin-left: 220px;
            margin-top: 60px;
            padding: 20px;
            overflow-x: hidden;
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            aside { width: 180px; }
            main { margin-left: 180px; }
        }
        @media (max-width: 500px) {
            aside { position: relative; width: 100%; height: auto; }
            main { margin-left: 0; margin-top: 0; }
            header { flex-direction: column; height: auto; padding: 10px 20px; }
            header .user-info { margin-top: 5px; }
        }
    </style>
</head>
<body>

<header>
    <div class="logo">Pahana Edu Bookshop</div>
    <div class="user-info">
        <span><%= username %> (<%= role %>)</span>
        <a href="LogoutServlet">Logout</a>
    </div>
</header>

<aside>
    <%
        if ("admin".equals(role)) {
    %>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="CustomerListServlet">Customer Management</a>
        <a href="BookListServlet">Book Management</a>
        <a href="bill.jsp">Billing</a>
        <a href="BillListServlet">Bill Details / Reports</a>
        <a href="help.jsp">Help</a>
    <%
        } else if ("cashier".equals(role)) {
    %>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="CustomerListServlet">Customer Management</a>
        <a href="BookListServlet">Book Management</a>
        <a href="bill.jsp">Billing</a>
        <a href="BillListServlet">Bill Details / Reports</a>
        <a href="help.jsp">Help</a>
    <%
    } else if ("customer".equals(role)) {
    %>
    <a href="BookListServlet">View Available Books</a>
    
    <%
        }
    %>
</aside>
</div>
<main>
<!-- PAGE CONTENT START -->
