package com.pahanaedu.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;

import java.io.IOException;
import java.util.List;

@WebServlet("/CustomerListServlet")
public class CustomerListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO = new CustomerDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");
        List<Customer> customers;

        if (query != null && !query.trim().isEmpty()) {
            customers = customerDAO.searchCustomers(query.trim());
            request.setAttribute("searchQuery", query.trim());
        } else {
            customers = customerDAO.getAllCustomers();
        }

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("customers.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
