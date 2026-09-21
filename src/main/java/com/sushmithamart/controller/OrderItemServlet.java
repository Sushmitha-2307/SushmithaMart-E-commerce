package com.sushmithamart.controller;

import com.sushmithamart.service.OrderItemService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/order-item")
public class OrderItemServlet extends HttpServlet {

    private OrderItemService orderItemService = new OrderItemService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));

        boolean result = orderItemService.addOrderItem(
                orderId,
                productId,
                quantity,
                price
        );

        if (result) {
            response.sendRedirect("buyer/dashboard.jsp?success=Order Item Added");
        } else {
            response.sendRedirect("cart.jsp?error=Failed");
        }
    }
}