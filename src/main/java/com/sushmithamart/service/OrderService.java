package com.sushmithamart.service;

import com.sushmithamart.dao.OrderDAO;

public class OrderService {

    private OrderDAO orderDAO = new OrderDAO();

    public boolean createOrder(int userId, double totalAmount) {
        return orderDAO.createOrder(userId, totalAmount);
    }

    public boolean updateOrderStatus(int orderId, String status) {
        return orderDAO.updateOrderStatus(orderId, status);
    }
}