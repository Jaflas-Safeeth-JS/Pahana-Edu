<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.pahanaedu.model.Book" %>
<jsp:include page="header.jsp" />
<%
    String role = (String) session.getAttribute("role");
%>
<html>
<head>
    <title>Manage Books</title>
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
    <h2>Manage Books</h2>

    <div class="search-box">
        <form action="BookListServlet" method="get">
            <input type="text" name="search" placeholder="Search by ISBN or Title">
            <button type="submit">Search</button>
            <% if ("admin".equals(role)) { %>
            <a href="addBook.jsp" class="add-btn">+ Add Book</a>
            <% } %>
        </form>
    </div>

    <table>
        <tr>
            <th>ID</th>
            <th>ISBN</th>
            <th>Title</th>
            <th>Author</th>
            <th>Publisher</th>
            <th>Price</th>
            <th>Stock</th>
            <% if ("admin".equals(role)) { %>
            <th>Actions</th>
            <% } %>
        </tr>
        <%
            List<Book> books = (List<Book>) request.getAttribute("books");
            if (books != null && !books.isEmpty()) {
                for (Book book : books) {
        %>
        <tr>
            <td><%= book.getId() %></td>
            <td><%= book.getIsbn() %></td>
            <td><%= book.getTitle() %></td>
            <td><%= book.getAuthor() %></td>
            <td><%= book.getPublisher() %></td>
            <td><%= book.getPrice() %></td>
            <td><%= book.getStock() %></td>
            <% if ("admin".equals(role)) { %>
            <td>
            
                <a href="EditBookServlet?id=<%= book.getId() %>">Edit</a> |
                <a href="DeleteBookServlet?id=<%= book.getId() %>"
                   onclick="return confirm('Are you sure you want to delete this book?')">Delete</a>   
            </td>
            <% } %>
        </tr>
        <% } } else { %>
        <tr>
            <td colspan="8" style="text-align:center;">No books found.</td>
        </tr>
        <% } %>
    </table>
</body>
</html>
