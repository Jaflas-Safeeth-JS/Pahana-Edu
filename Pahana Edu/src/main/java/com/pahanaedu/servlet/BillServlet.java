package com.pahanaedu.servlet;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.model.BillItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/billing")
public class BillServlet extends HttpServlet {
    private final BillDAO billDAO = new BillDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Show the billing page
        req.getRequestDispatcher("bill.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String customerAccNo = req.getParameter("customerAccNo");
        String[] bookIds = req.getParameterValues("bookId");
        String[] quantities = req.getParameterValues("quantity");
        String[] prices = req.getParameterValues("price");

        if (customerAccNo == null || customerAccNo.trim().isEmpty()) {
            resp.sendRedirect("billing?error=Please select a customer");
            return;
        }
        if (bookIds == null || bookIds.length == 0) {
            resp.sendRedirect("billing?error=Please add at least one book");
            return;
        }

        List<BillItem> items = new ArrayList<>();
        try {
            for (int i = 0; i < bookIds.length; i++) {
                int bookId = Integer.parseInt(bookIds[i]);
                int qty = Integer.parseInt(quantities[i]);
                double price = Double.parseDouble(prices[i]);

                BillItem item = new BillItem();
                item.setBookId(bookId);
                item.setQuantity(qty);
                item.setUnitPrice(price);
                item.setLineTotal(qty * price);
                items.add(item);
            }

            int billId = billDAO.createBill(customerAccNo, items);
            resp.sendRedirect("billSuccess.jsp?billId=" + billId);

        } catch (NumberFormatException e) {
            resp.sendRedirect("billing?error=Invalid numbers in form");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendRedirect("billing?error=" + encode(e.getMessage()));
        }
    }

    private String encode(String s) {
        return s == null ? "" : s.replace(" ", "%20");
    }
}
