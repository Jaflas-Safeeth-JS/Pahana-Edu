<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Book</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f9; }
        .container {
            width: 90%; max-width: 500px; margin: 40px auto; background: #fff;
            padding: 25px; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h1 { text-align: center; margin-bottom: 20px; }
        form label { display: block; margin-top: 10px; font-weight: bold; }
        form input {
            width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ccc;
            border-radius: 6px; box-sizing: border-box;
        }
        .btn { margin-top: 15px; width: 100%; padding: 10px; background: #28a745; border: none;
            color: white; font-size: 16px; border-radius: 6px; cursor: pointer; }
        .btn:hover { opacity: 0.9; }
        .back-link { display: block; text-align: center; margin-top: 15px; }
    </style>
    
    <script>
    function validateForm() {
        let isbn = document.forms["bookForm"]["isbn"].value.trim();
        let title = document.forms["bookForm"]["title"].value.trim();
        let author = document.forms["bookForm"]["author"].value.trim();
        let price = document.forms["bookForm"]["price"].value;
        let stock = document.forms["bookForm"]["stock"].value;

        // ISBN validation (alphanumeric, at least 5 chars)
        let isbnPattern = /^[a-zA-Z0-9-]{5,}$/;
        if (!isbnPattern.test(isbn)) {
            alert("ISBN must be at least 5 characters long and alphanumeric.");
            return false;
        }

        // Title & Author validation (not empty, not only numbers)
        let textPattern = /[a-zA-Z]/;
        if (!textPattern.test(title)) {
            alert("Title must contain letters.");
            return false;
        }
        if (!textPattern.test(author)) {
            alert("Author must contain letters.");
            return false;
        }

        // Price validation
        if (price <= 0) {
            alert("Price must be greater than 0.");
            return false;
        }

        // Stock validation
        if (stock < 0) {
            alert("Stock cannot be negative.");
            return false;
        }

        return true; // form valid
    }
</script>
    
</head>
<body>
<div class="container">
    <h1>Add New Book</h1>
    
    <% if (request.getParameter("error") != null) { %>
    <div style="color: red; margin-bottom: 10px;">
        <%= request.getParameter("error") %>
    </div>
<% } %>

<% if (request.getParameter("success") != null) { %>
    <div style="color: green; margin-bottom: 10px;">
        <%= request.getParameter("success") %>
    </div>
<% } %>
    
    <form action="AddBookServlet" method="post">
        <label>ISBN:</label>
        <input type="text" name="isbn" required>

        <label>Title:</label>
        <input type="text" name="title" required>

        <label>Author:</label>
        <input type="text" name="author" required>

        <label>Publisher:</label>
        <input type="text" name="publisher">

        <label>Price:</label>
        <input type="number" step="0.01" name="price" required>

        <label>Stock:</label>
        <input type="number" name="stock" required min="0">

        <button type="submit" class="btn">Save Book</button>
    </form>
    <a href="items.jsp" class="back-link">← Back to Manage Books</a>
</div>
</body>
</html>
