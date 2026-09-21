package com.sushmithamart.controller;

import com.sushmithamart.model.User;
import com.sushmithamart.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User(0, name, email, password, role);

        boolean result = userService.registerUser(user);

        if (result) {
            response.sendRedirect("login.jsp?success=Registration Successful");
        } else {
            response.sendRedirect("register.jsp?error=Registration Failed");
        }
    }
}