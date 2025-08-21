<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Help - System Usage Guidelines</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background: #f9f9f9;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        .section {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        ul {
            margin-left: 20px;
        }
        a.back {
            display: inline-block;
            margin-top: 15px;
            padding: 8px 16px;
            background: #4caf50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h1>System Usage Guidelines</h1>

    <div class="section">
        <h2>🔑 Login</h2>
        <ul>
            <li>Admins, Cashiers, and Customers must log in with their assigned username and password.</li>
            <li>If you are a new customer, ask the cashier/admin to register you first.</li>
        </ul>
    </div>

    <div class="section">
        <h2>👥 Managing Customers</h2>
        <ul>
            <li>Admins/Cashiers can add new customers. An account number (e.g., PEAC01, PEAC02…) is automatically generated.</li>
            <li>Customers can later sign up using their account number.</li>
        </ul>
    </div>

    <div class="section">
        <h2>📚 Managing Books</h2>
        <ul>
            <li>Admins can add, edit, or remove books.</li>
            <li>Each book record must include ISBN, Title, Author, Price, and Stock.</li>
        </ul>
    </div>

    <div class="section">
        <h2>🧾 Billing</h2>
        <ul>
            <li>Cashiers can create bills by searching for books using ISBN or title.</li>
            <li>Click a book from suggestions, enter quantity, and add it to the bill.</li>
            <li>Total amount is calculated automatically.</li>
            <li>Once completed, bills are saved with customer account number and items.</li>
        </ul>
    </div>

    <div class="section">
        <h2>📄 Viewing Bills</h2>
        <ul>
            <li>Go to the Bills section to view all past bills.</li>
            <li>Click on a View Details to see detailed items and totals.</li>
            <li>Use the Print option to get a physical/digital copy.</li>
        </ul>
    </div>

    <div class="section">
        <h2>🔍 Searching</h2>
        <ul>
            <li>Use the search bar in the Bills section to quickly find bills by customer account number or CustomerName.</li>
        </ul>
    </div>

    <a href="home.jsp" class="back">⬅ Back to Home</a>
</body>
</html>
