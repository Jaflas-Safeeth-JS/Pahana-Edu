package com.pahanaedu.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.model.User;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        CustomerDAO customerDAO = new CustomerDAO();
        UserDAO userDAO = new UserDAO();

        // 1) Account must exist
        if (!customerDAO.accountExists(accountNumber)) {
            response.sendRedirect("signup.jsp?error=Invalid Account Number. Please visit the shop first.");
            return;
        }

        // 2) Only one login per customer
        if (userDAO.accountAlreadyHasUser(accountNumber)) {
            response.sendRedirect("signup.jsp?error=This Account Number already has a login. Please log in.");
            return;
        }

        // 3) Check username/email uniqueness
        if (userDAO.userExists(username, email)) {
            response.sendRedirect("signup.jsp?error=Username or Email already exists.");
            return;
        }

        // 4) Check password confirmation
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("signup.jsp?error=Passwords do not match.");
            return;
        }

        // 5) Create user
        User user = new User(username, password, email, firstName, lastName, "customer");
        user.setPhone(phone);
        user.setAddress(address);

        if (userDAO.createUser(user, accountNumber)) {
            response.sendRedirect("login.jsp?success=Account created successfully! Please login.");
        } else {
            response.sendRedirect("signup.jsp?error=Failed to create account.");
        }
    }


}