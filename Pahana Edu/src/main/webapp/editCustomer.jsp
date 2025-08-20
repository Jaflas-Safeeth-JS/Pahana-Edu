<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pahanaedu.model.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Customer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 450px;
            margin: 50px auto;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            font-size: 22px;
            margin-bottom: 20px;
            color: #333;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
            color: #555;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        button {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        .back-link {
            display: block;
            margin-top: 15px;
            text-align: center;
            font-size: 14px;
        }

        .back-link a {
            color: #007BFF;
            text-decoration: none;
        }

        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%
    Customer c = (Customer) request.getAttribute("customer");
    if (c == null) {
%>
    <div class="container">
        <h1>Customer not found</h1>
        <div class="back-link"><a href="CustomerListServlet">Back to Customer List</a></div>
    </div>
<%
    } else {
%>
    <div class="container">
        <h1>Edit Customer - <%= c.getAccountNumber() %></h1>
        <form method="post" action="EditCustomerServlet">
            <input type="hidden" name="accountNumber" value="<%= c.getAccountNumber() %>">

            <label>Name:</label>
            <input type="text" name="name" value="<%= c.getName() %>" required>

            <label>Address:</label>
            <input type="text" name="address" value="<%= c.getAddress() %>" required>

            <label>Phone:</label>
            <input type="text" name="phone" value="<%= c.getPhone() %>" required>

            <label>Units Consumed:</label>
            <input type="number" name="unitsConsumed" value="<%= c.getUnitsConsumed() %>" min="0" required>

            <button type="submit">Update Customer</button>
        </form>

        <div class="back-link">
            <a href="CustomerListServlet">← Back to Customer List</a>
        </div>
    </div>
<% } %>
</body>
</html>
