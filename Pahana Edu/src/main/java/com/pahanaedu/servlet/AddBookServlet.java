package com.pahanaedu.servlet;

import com.pahanaedu.dao.BookDAO;
import com.pahanaedu.model.Book;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String isbn = request.getParameter("isbn").trim();
        String title = request.getParameter("title").trim();
        String author = request.getParameter("author").trim();
        String publisher = request.getParameter("publisher").trim();
        String priceStr = request.getParameter("price").trim();
        String stockStr = request.getParameter("stock").trim();
        
     // --------- SERVER-SIDE VALIDATION ---------
        if (!isbn.matches("^[a-zA-Z0-9-]{5,}$")) {
            response.sendRedirect("addBook.jsp?error=Invalid ISBN format (alphanumeric, min 5 chars)");
            return;
        }
        if (!title.matches(".*[a-zA-Z].*")) {
            response.sendRedirect("addBook.jsp?error=Title must contain letters");
            return;
        }
        if (!author.matches(".*[a-zA-Z].*")) {
            response.sendRedirect("addBook.jsp?error=Author must contain letters");
            return;
        }

        double price;
        int stock;
        try {
            price = Double.parseDouble(priceStr);
            stock = Integer.parseInt(stockStr);

            if (price <= 0) {
                response.sendRedirect("addBook.jsp?error=Price must be greater than 0");
                return;
            }
            if (stock < 0) {
                response.sendRedirect("addBook.jsp?error=Stock cannot be negative");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("addBook.jsp?error=Invalid number format for price or stock");
            return;
        }

        // Check for duplicate ISBN
        if (bookDAO.isDuplicateISBN(isbn)) {
            // Redirect back to addBook.jsp with error message
            response.sendRedirect("addBook.jsp?error=ISBN already exists!");
            return;
        }

        Book book = new Book(0, isbn, title, author, publisher, price, stock);
        boolean success = bookDAO.addBook(book);

        if (success) {
            response.sendRedirect("BookListServlet?success=Book added successfully");
        } else {
            response.sendRedirect("addBook.jsp?error=Failed to add book");
        }
    }
}
