package com.sushmithamart.controller;

import com.sushmithamart.service.CartService;
import com.sushmithamart.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartService cartService = new CartService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // User login check
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        String action = request.getParameter("action");
        String productIdParam = request.getParameter("productId");
        String quantityParam = request.getParameter("quantity");

        // Check required values
        if (action == null || productIdParam == null || quantityParam == null) {
            response.sendRedirect("cart");
            return;
        }

        try {

            int productId = Integer.parseInt(productIdParam);
            int quantity = Integer.parseInt(quantityParam);

            boolean result = false;

            // ADD PRODUCT
            if ("add".equals(action)) {

                result = cartService.addToCart(
                        userId,
                        productId,
                        quantity
                );

            }

            // REMOVE PRODUCT
            else if ("remove".equals(action)) {

                result = cartService.removeFromCart(
                        userId,
                        productId
                );

            }

            // UPDATE QUANTITY
            else if ("update".equals(action)) {

                result = cartService.updateQuantity(
                        userId,
                        productId,
                        quantity
                );
            }

            // After action → Cart page
            response.sendRedirect("cart");

        } catch (NumberFormatException e) {

            response.sendRedirect("cart");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // User login check
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        // Get user's cart items
        request.setAttribute(
                "cartItems",
                cartService.getCartItems(userId)
        );

        // Open cart.jsp
        request.getRequestDispatcher("cart.jsp")
               .forward(request, response);
    }
}