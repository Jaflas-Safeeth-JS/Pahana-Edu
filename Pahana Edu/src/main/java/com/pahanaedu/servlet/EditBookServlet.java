package com.pahanaedu.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pahanaedu.dao.BookDAO;
import com.pahanaedu.model.Book;

@WebServlet("/EditBookServlet")
public class EditBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO = new BookDAO();

    // Show the edit page with book details
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Book book = bookDAO.getBookById(id); // Make sure this method exists in BookDAO
            if (book != null) {
                request.setAttribute("book", book);
                request.getRequestDispatcher("editBook.jsp").forward(request, response);
            } else {
                response.sendRedirect("items.jsp?error=Book not found");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("items.jsp?error=Invalid book ID");
        }
    }

    // Handle the update after form submission
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String isbn = request.getParameter("isbn");
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String publisher = request.getParameter("publisher");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            Book book = new Book(id, isbn, title, author, publisher, price, stock);

            if (bookDAO.updateBook(book)) {
                response.sendRedirect("BookListServlet?success=Book updated successfully");
            } else {
                response.sendRedirect("BookListServlet?error=Failed to update book");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookListServlet?error=Invalid input data");
        }
    }
}
