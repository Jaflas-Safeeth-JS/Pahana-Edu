package com.pahanaedu.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.authenticate(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            session.setAttribute("accountNumber", user.getAccountNumber());  // ✅ store acc no
            session.setAttribute("fullName", user.getFirstName() + " " + user.getLastName());

            // Redirect based on role
            switch (user.getRole()) {
                case "admin":
                    response.sendRedirect("adminDashboard.jsp");
                    break;
                case "cashier":
                    response.sendRedirect("cashierDashboard.jsp");
                    break;
                case "customer":
                    response.sendRedirect("customerDashboard.jsp");
                    break;
                default:
                    response.sendRedirect("login.jsp?error=Unknown role");
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid Username or Password");
        }
    }

}
