package com.sushmithamart.controller;

import com.sushmithamart.model.Product;
import com.sushmithamart.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private ProductService productService = new ProductService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("add".equals(action)) {

            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Product product = new Product(
                    0, name, description, price, quantity, 0
            );

            boolean result = productService.addProduct(product);

            if (result) {
                response.sendRedirect("seller/dashboard.jsp?success=Product Added");
            } else {
                response.sendRedirect("seller/dashboard.jsp?error=Failed");
            }
        }
    }
}
