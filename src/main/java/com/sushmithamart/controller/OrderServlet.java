package com.sushmithamart.controller;

import com.sushmithamart.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderService orderService = new OrderService();

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        try {

            int userId = Integer.parseInt(
                request.getParameter("userId")
            );

            double totalAmount = Double.parseDouble(
                request.getParameter("totalAmount")
            );

            boolean result =
                orderService.createOrder(userId, totalAmount);

            if (result) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/order-success.jsp"
                );

            } else {

                response.sendRedirect(
                    request.getContextPath()
                    + "/checkout.jsp?error=OrderFailed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                request.getContextPath()
                + "/checkout.jsp?error=OrderFailed"
            );
        }
    }
}