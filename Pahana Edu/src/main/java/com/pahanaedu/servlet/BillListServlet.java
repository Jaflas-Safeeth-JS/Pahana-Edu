package com.pahanaedu.servlet;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.model.Bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/BillListServlet")
public class BillListServlet extends HttpServlet {
    private BillDAO billDAO = new BillDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchQuery = request.getParameter("search");
        List<Bill> bills = billDAO.getAllBills(searchQuery);

        request.setAttribute("bills", bills);
        request.setAttribute("searchQuery", searchQuery);
        request.getRequestDispatcher("billList.jsp").forward(request, response);
    }
}
