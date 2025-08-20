package com.pahanaedu.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.pahanaedu.dao.CustomerDAO;

import java.io.IOException;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO = new CustomerDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accNo = request.getParameter("acc");

        if (customerDAO.deleteCustomer(accNo)) {
            response.sendRedirect("CustomerListServlet?success=Customer deleted successfully");
        } else {
            response.sendRedirect("CustomerListServlet?error=Failed to delete customer");
        }
    }
}
