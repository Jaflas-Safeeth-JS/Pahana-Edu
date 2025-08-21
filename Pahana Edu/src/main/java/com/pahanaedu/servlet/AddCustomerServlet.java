package com.pahanaedu.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;

@WebServlet("/addCustomer")
public class AddCustomerServlet extends HttpServlet {
	
	 private static final long serialVersionUID = 1L;
	    private CustomerDAO customerDAO = new CustomerDAO();

	    // Show Add Customer page with next account number
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        String newAccount = customerDAO.generateNextAccountNumber();
	        request.setAttribute("generatedAccount", newAccount);
	        request.getRequestDispatcher("addCustomer.jsp").forward(request, response);
	    }

	    // Handle form submission
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        String accountNumber = customerDAO.generateNextAccountNumber(); // always get next
	        String name = request.getParameter("name");
	        String address = request.getParameter("address");
	        String phone = request.getParameter("phone");
	        int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));

	        Customer customer = new Customer(accountNumber, name, address, phone, unitsConsumed);
	        
	        boolean success = customerDAO.addCustomer(customer);

	        if (success) {
	            response.sendRedirect("CustomerListServlet?success=Customer added successfully");
	        } else {
	            response.sendRedirect("addCustomer.jsp?error=Failed to add Customer");
	        }
	    }

	     
}