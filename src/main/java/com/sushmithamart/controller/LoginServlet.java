package com.sushmithamart.controller;

import com.sushmithamart.model.User;
import com.sushmithamart.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userService.loginUser(email, password);

        if (user != null) {

            HttpSession session = request.getSession(true);

            session.setAttribute("user", user);

            String userRole = user.getRole();

            System.out.println("LOGIN ROLE=[" + userRole + "]");

            // SELLER
            if ("SELLER".equalsIgnoreCase(userRole)) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/seller-dashboard.jsp"
                );

            }

            // ADMIN
            else if ("ADMIN".equalsIgnoreCase(userRole)) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/admin-dashboard.jsp"
                );

            }

            // BUYER
            else {

                response.sendRedirect(
                    request.getContextPath()
                    + "/home.jsp"
                );
            }

        } else {

            response.sendRedirect(
                request.getContextPath()
                + "/login.jsp?error=Incorrect%20password"
            );
        }
    }
}