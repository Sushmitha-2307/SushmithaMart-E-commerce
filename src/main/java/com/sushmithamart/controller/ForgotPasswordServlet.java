package com.sushmithamart.controller;

import com.sushmithamart.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect("forgot-password.jsp?error=Please+enter+your+email");
            return;
        }

        UserDAO userDAO = new UserDAO();

        request.getSession().setAttribute("resetEmail", email);

        response.sendRedirect("reset-password.jsp");
    }
}