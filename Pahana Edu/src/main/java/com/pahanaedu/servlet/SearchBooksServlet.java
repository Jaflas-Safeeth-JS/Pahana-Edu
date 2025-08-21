package com.pahanaedu.servlet;

import com.pahanaedu.dao.BookDAO;
import com.pahanaedu.model.Book;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/searchBooks")
public class SearchBooksServlet extends HttpServlet {
    private final BookDAO dao = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String q = req.getParameter("q");
        if (q == null) q = "";
        List<Book> list = dao.searchBooks(q);

        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();
        out.print("[");
        for (int i = 0; i < list.size(); i++) {
            Book b = list.get(i);
            out.print("{");
            out.printf("\"id\":%d,", b.getId());
            out.printf("\"isbn\":\"%s\",", escape(b.getIsbn()));
            out.printf("\"title\":\"%s\",", escape(b.getTitle()));
            out.printf("\"price\":%s,", String.valueOf(b.getPrice()));
            out.printf("\"stock\":%d", b.getStock());
            out.print("}");
            if (i < list.size() - 1) out.print(",");
        }
        out.print("]");
        out.flush();
    }

    private String escape(String s) {
        return s.replace("\\", "\\\\").replace("\"","\\\"");
    }
}
