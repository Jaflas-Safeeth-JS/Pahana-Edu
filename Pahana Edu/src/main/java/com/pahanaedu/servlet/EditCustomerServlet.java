package com.pahanaedu.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;

import java.io.IOException;

@WebServlet("/EditCustomerServlet")
public class EditCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO = new CustomerDAO();

    // Display customer info in edit form
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accNo = request.getParameter("acc");
        Customer customer = customerDAO.getCustomerByAccount(accNo);

        if (customer != null) {
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
        } else {
            response.sendRedirect("CustomerListServlet?error=Customer not found");
        }
    }

    // Handle form submission to update customer
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accNo = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));

        Customer customer = new Customer(accNo, name, address, phone, unitsConsumed);

        if (customerDAO.updateCustomer(customer)) {
            response.sendRedirect("CustomerListServlet?success=Customer updated successfully");
        } else {
            response.sendRedirect("CustomerListServlet?error=Failed to update customer");
        }
    }
}
