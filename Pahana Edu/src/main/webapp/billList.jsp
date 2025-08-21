<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.model.Bill" %>
<%@ page import="com.pahanaedu.dao.BillDAO" %>
<%@ page import="com.pahanaedu.model.BillItem" %>
<%@ page import="com.pahanaedu.dao.BookDAO" %>
<%@ page import="com.pahanaedu.model.Book" %>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Bills</title>
    <style>
        body { font-family: Arial, sans-serif;  }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #667eea; color: white; }
        input[type="text"] { padding: 6px; width: 250px; }
        button { padding: 6px 12px; background-color: #764ba2; color: white; border: none; cursor: pointer; }
        button:hover { opacity: 0.9; }
        .bill-items { margin-top: 10px; border: 1px solid #ccc; padding: 10px; }
    </style>
</head>
<body>

<h1>All Bills</h1>

<form method="get" action="BillListServlet">
    <input type="text" name="search" placeholder="Search by Account No or Customer Name"
           value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>">
    <button type="submit">Search</button>
</form>

<%
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
    BillDAO billDAO = new BillDAO();
    BookDAO bookDAO = new BookDAO();

    if (bills == null || bills.isEmpty()) {
%>
    <p>No bills found.</p>
<%
    } else {
%>
    <table>
        <tr>
            <th>Bill ID</th>
            <th>Customer Acc No</th>
            <th>Bill Date</th>
            <th>Total</th>
            <th>Items</th>
        </tr>
        <%
            for (Bill bill : bills) {
                List<BillItem> items = billDAO.getBillItems(bill.getId());
        %>
        <tr>
            <td><%= bill.getId() %></td>
            <td><%= bill.getCustomerAccNo() %></td>
            <td><%= bill.getBillDate() %></td>
            <td>Rs. <%= bill.getTotal() %></td>
            <td>
                <div class="bill-items">
                    <ul>
                        <%
                            for (BillItem item : items) {
                                Book b = bookDAO.getBookById(item.getBookId());
                        %>
                            <li><%= b.getTitle() %> (ISBN: <%= b.getIsbn() %>) - Qty: <%= item.getQuantity() %>, Unit Price: Rs. <%= item.getUnitPrice() %>, Total: Rs. <%= item.getLineTotal() %></li>
                        <% } %>
                    </ul>
                </div>
            </td>
            <td>
    <a href="BillDetailsServlet?id=<%= bill.getId() %>">View Details</a>
</td>
            
        </tr>
        <% } %>
    </table>
<% } %>

</body>
</html>
