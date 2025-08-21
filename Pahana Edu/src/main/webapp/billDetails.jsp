<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pahanaedu.model.Bill"%>
<%@ page import="com.pahanaedu.model.BillItem"%>
<%@ page import="com.pahanaedu.dao.BookDAO"%>
<%@ page import="com.pahanaedu.model.Book"%>
<jsp:include page="header.jsp"  />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bill Details</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1, h2 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #667eea; color: white; }
        .back { margin-top: 20px; display: inline-block; padding: 6px 12px; background: #764ba2; color: white; text-decoration: none; }
        .back:hover { opacity: 0.9; }
        .bill-info { margin-top: 20px; }
        @media print {
    .no-print, header {
        display: none !important; 
    }

    body {
        margin-left: -150px; 
        padding: 0;
    }

    .container, table {
        page-break-inside: avoid; 
    }

    table {
        width: 100%;
        border-collapse: collapse;
        font-size: 12pt;
    }

    tr, td, th {
        page-break-inside: avoid;
        page-break-after: auto;
    }

    
    html, body {
        overflow: visible !important;
    }
}
    </style>
</head>
<body>

<h1>Bill Details</h1>

<%
    Bill bill = (Bill) request.getAttribute("bill");
    List<BillItem> items = bill.getItems();
    BookDAO bookDAO = new BookDAO();
%>

<div class="bill-info">
    <p><strong>Bill ID:</strong> <%= bill.getId() %></p>
    <p><strong>Customer Account No:</strong> <%= bill.getCustomerAccNo() %></p>
    <p><strong>Bill Date:</strong> <%= bill.getBillDate() %></p>
</div>

<div style="text-align: right; margin-bottom: 20px;">
    <button onclick="window.print()" class="no-print" style="padding: 8px 16px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer;">Print Bill</button>
</div>

<table>
    <tr>
        <th>ISBN</th>
        <th>Title</th>
        <th>Quantity</th>
        <th>Unit Price</th>
        <th>Line Total</th>
    </tr>
    <%
        double total = 0;
        for (BillItem item : items) {
            Book book = bookDAO.getBookById(item.getBookId());
            total += item.getLineTotal();
    %>
    <tr>
        <td><%= book.getIsbn() %></td>
        <td><%= book.getTitle() %></td>
        <td><%= item.getQuantity() %></td>
        <td>Rs. <%= item.getUnitPrice() %></td>
        <td>Rs. <%= item.getLineTotal() %></td>
    </tr>
    <% } %>
    <tr>
        <th colspan="4" style="text-align:right;">Total:</th>
        <th>Rs. <%= total %></th>
    </tr>
</table>

<a href="BillListServlet" class="back no-print">← Back to Bills</a>

</body>
</html>
