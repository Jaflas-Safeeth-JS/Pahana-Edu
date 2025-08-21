package com.pahanaedu.servlet;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.BookDAO;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/BillDetailsServlet")
public class BillDetailsServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAO();
    private BookDAO bookDAO = new BookDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String billIdStr = request.getParameter("id");
        if (billIdStr == null || billIdStr.isEmpty()) {
            response.sendRedirect("BillListServlet");
            return;
        }

        int billId = Integer.parseInt(billIdStr);

        // Get bill details
        Bill bill = billDAO.getBillById(billId); // 
        if (bill == null) {
            response.sendRedirect("BillListServlet");
            return;
        }

        // Get items for this bill
        List<BillItem> items = billDAO.getBillItems(billId);
        bill.setItems(items);

        request.setAttribute("bill", bill);
        request.getRequestDispatcher("billDetails.jsp").forward(request, response);
    }
}


