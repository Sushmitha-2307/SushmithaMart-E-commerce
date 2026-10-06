package com.sushmithamart.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.sushmithamart.dao.OrderItemDAO;
import com.sushmithamart.model.OrderItem;
import com.sushmithamart.model.Seller;

@WebServlet("/orderItem")
public class OrderItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderItemDAO orderItemDAO;

    public void init() {
        orderItemDAO = new OrderItemDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));
        int sellerId = Integer.parseInt(request.getParameter("sellerId"));

        boolean isAdded = orderItemDAO.addOrderItem(orderId, productId, quantity, price, sellerId);

        if (isAdded) {
            response.sendRedirect("orderSuccess.jsp");
        } else {
            response.sendRedirect("orderError.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Seller seller = (Seller) session.getAttribute("loggedSeller");

        if (seller != null) {
            int sellerId = seller.getId();
            List<OrderItem> sellerOrderItems = orderItemDAO.getOrderItemsBySeller(sellerId);
            request.setAttribute("sellerOrderItems", sellerOrderItems);
            request.getRequestDispatcher("sellerDashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect("sellerLogin.jsp");
        }
    }
}