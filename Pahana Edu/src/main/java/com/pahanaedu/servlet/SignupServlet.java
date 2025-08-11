package com.pahanaedu.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

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
        
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        if (userDAO.userExists(username, email)) {
            response.sendRedirect("signup.jsp?error=Username or Email already exists. Please try another.");
            return; // Stop execution
        }
       
        
        
        User user = new User(username, password, email, firstName, lastName, "customer");
        user.setPhone(phone);
        user.setAddress(address);
        
        
        if (userDAO.createUser(user)) {
            response.sendRedirect("login.jsp?success=Account created successfully! Please login.");
        } else {
            response.sendRedirect("signup.jsp?error=Registration failed. Please try again.");
        }
    }
}