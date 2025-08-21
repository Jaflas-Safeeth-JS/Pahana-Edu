package com.pahanaedu.servlet;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/searchCustomers")
public class SearchCustomersServlet extends HttpServlet {
    private final CustomerDAO dao = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String q = req.getParameter("q");
        if (q == null) q = "";
        List<Customer> list = dao.searchCustomers(q);

        resp.setContentType("application/json; charset=UTF-8");
        PrintWriter out = resp.getWriter();
        out.print("[");
        for (int i = 0; i < list.size(); i++) {
            Customer c = list.get(i);
            out.print("{");
            out.printf("\"accountNumber\":\"%s\",", escape(c.getAccountNumber()));
            out.printf("\"name\":\"%s\",", escape(c.getName()));
            out.printf("\"phone\":\"%s\"", escape(c.getPhone() == null ? "" : c.getPhone()));
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
