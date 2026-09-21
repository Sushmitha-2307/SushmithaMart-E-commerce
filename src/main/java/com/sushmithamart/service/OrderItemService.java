package com.sushmithamart.service;

import com.sushmithamart.dao.OrderItemDAO;

public class OrderItemService {

    private OrderItemDAO orderItemDAO = new OrderItemDAO();

    public boolean addOrderItem(int orderId, int productId, int quantity, double price) {
        return orderItemDAO.addOrderItem(orderId, productId, quantity, price);
    }
}