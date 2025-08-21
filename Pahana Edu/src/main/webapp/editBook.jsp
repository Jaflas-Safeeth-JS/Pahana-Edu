<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pahanaedu.model.Book" %>
<%
    Book book = (Book) request.getAttribute("book");
%>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Book</title>
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
<div class="container">
    <h1>Edit Book</h1>
    <form action="EditBookServlet" method="post">
        <input type="hidden" name="id" value="<%= book.getId() %>">

        <div class="form-group">
            <label>ISBN:</label>
            <input type="text" name="isbn" value="<%= book.getIsbn() %>" required>
        </div>

        <div class="form-group">
            <label>Title:</label>
            <input type="text" name="title" value="<%= book.getTitle() %>" required>
        </div>

        <div class="form-group">
            <label>Author:</label>
            <input type="text" name="author" value="<%= book.getAuthor() %>" required>
        </div>

        <div class="form-group">
            <label>Publisher:</label>
            <input type="text" name="publisher" value="<%= book.getPublisher() %>">
        </div>

        <div class="form-group">
            <label>Price:</label>
            <input type="number" step="0.01" name="price" value="<%= book.getPrice() %>" required>
        </div>

        <div class="form-group">
            <label>Stock:</label>
            <input type="number" name="stock" value="<%= book.getStock() %>" required min="0">
        </div>

        <button type="submit" class="btn">Update Book</button>
    </form>
    <a href="items.jsp" class="back-link">← Back to Manage Books</a>
</div>
</body>
</html>
