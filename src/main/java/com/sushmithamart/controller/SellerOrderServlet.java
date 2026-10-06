package com.sushmithamart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.sushmithamart.model.User;
import com.sushmithamart.service.SellerOrderService;

@WebServlet("/seller-orders")
public class SellerOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private SellerOrderService sellerOrderService;

    @Override
    public void init() {
        sellerOrderService = new SellerOrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int sellerId = user.getId();

        System.out.println("==========================================");
        System.out.println("LOGGED IN SELLER ID: " + sellerId);

        List<Map<String, Object>> orders = sellerOrderService.getSellerOrders(sellerId);

        System.out.println("FETCHED ORDERS COUNT: " + (orders != null ? orders.size() : 0));
        System.out.println("==========================================");

        request.setAttribute("sellerOrders", orders);
        request.getRequestDispatcher("/seller-orders.jsp").forward(request, response);
    }
}