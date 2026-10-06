package com.sushmithamart.service;

import com.sushmithamart.dao.OrderItemDAO;

public class OrderItemService {

    private OrderItemDAO orderItemDAO;

    public OrderItemService() {
        this.orderItemDAO = new OrderItemDAO();
    }

    public boolean addOrderItem(int orderId, int productId, int quantity, double price, int sellerId) {
        return orderItemDAO.addOrderItem(orderId, productId, quantity, price, sellerId);
    }
}