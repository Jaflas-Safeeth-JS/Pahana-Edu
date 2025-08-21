<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<jsp:include page="header.jsp" />

<html>
<head>
    <title>Customer List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #667eea;
            color: white;
        }
        input[type="text"] {
            padding: 6px;
            width: 250px;
        }
        button, .add-btn {
            padding: 6px 12px;
            background-color: #764ba2;
            color: white;
            border: none;
            cursor: pointer;
            margin-bottom: 10px;
        }
        button:hover, .add-btn:hover {
            opacity: 0.9;
        }
        
        .add-btn { text-decoration: none; margin-left: 10px; }
    </style>
</head>
<body>

<h1>Customer List</h1>



<form method="get" action="CustomerListServlet">
    <input type="text" name="query" placeholder="Search by Account No or Name"
           value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>">
    <button type="submit">Search</button>
    <a href="addCustomer" class="add-btn">+ Add Customer</a>
</form>

<br>

<%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    if (customers == null || customers.isEmpty()) {
%>
    <p>No customers found.</p>
<%
    } else {
%>
    <table>
        <tr>
            <th>Account No</th>
            <th>Name</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Units Consumed</th>
            <th>Actions</th>
        </tr>
        <% for (Customer c : customers) { %>
        <tr>
            <td><%= c.getAccountNumber() %></td>
            <td><%= c.getName() %></td>
            <td><%= c.getAddress() %></td>
            <td><%= c.getPhone() %></td>
            <td><%= c.getUnitsConsumed() %></td>
            <td>
                <a href="EditCustomerServlet?acc=<%= c.getAccountNumber() %>">Edit</a> |
                <a href="DeleteCustomerServlet?acc=<%= c.getAccountNumber() %>"
                   onclick="return confirm('Are you sure you want to delete this customer?');">Delete</a>
            </td>
        </tr>
        <% } %>
    </table>
<% } %>

</body>
</html>
