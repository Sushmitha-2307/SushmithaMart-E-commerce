package com.sushmithamart.controller;

import com.sushmithamart.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp?error=Session+expired");
            return;
        }

        String email = (String) session.getAttribute("resetEmail");

        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=Please+start+the+password+reset+again");
            return;
        }

        if (newPassword == null || confirmPassword == null ||
                newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty()) {

            response.sendRedirect("reset-password.jsp?error=Please+enter+both+passwords");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("reset-password.jsp?error=Passwords+do+not+match");
            return;
        }

        UserDAO userDAO = new UserDAO();

        boolean updated = userDAO.resetPassword(email, newPassword);

        if (updated) {

            session.removeAttribute("resetEmail");

            response.sendRedirect("login.jsp?success=Password+changed+successfully");

        } else {

            response.sendRedirect("reset-password.jsp?error=Email+not+found");

        }
    }
}