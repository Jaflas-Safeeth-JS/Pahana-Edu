package com.pahanaedu.servlet;

import com.pahanaedu.dao.BookDAO;
import com.pahanaedu.model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/BookListServlet")
public class BookListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");

        List<Book> books;
        if (search != null && !search.trim().isEmpty()) {
            books = bookDAO.searchBooks(search);   // search by ISBN or title
        } else {
            books = bookDAO.getAllBooks();        // show all books
        }

        request.setAttribute("books", books);
        request.getRequestDispatcher("items.jsp").forward(request, response);
    }
}
