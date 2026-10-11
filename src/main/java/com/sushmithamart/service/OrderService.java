package com.sushmithamart.service;

import java.util.List;
import java.util.Map;

import com.sushmithamart.dao.CartDAO;
import com.sushmithamart.dao.OrderDAO;
import com.sushmithamart.dao.OrderItemDAO;

public class OrderService {

    private final OrderDAO orderDAO;
    private final OrderItemDAO orderItemDAO;
    private final CartDAO cartDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
        this.orderItemDAO = new OrderItemDAO();
        this.cartDAO = new CartDAO();
    }

    public boolean createOrder(int userId, double totalAmount) {

        List<Map<String, Object>> cartItems =
                cartDAO.getCartItems(userId);

        if (cartItems == null || cartItems.isEmpty()) {
            return false;
        }

        double calculatedTotal = 0;

        for (Map<String, Object> item : cartItems) {
            Number quantityValue = (Number) item.get("quantity");
            Number priceValue = (Number) item.get("price");
            Number sellerValue = (Number) item.get("sellerId");

            if (quantityValue == null || priceValue == null
                    || sellerValue == null
                    || ((Number) item.get("productId")) == null) {
                return false;
            }

            int quantity = quantityValue.intValue();
            double price = priceValue.doubleValue();
            int sellerId = sellerValue.intValue();

            if (quantity <= 0 || price < 0 || sellerId <= 0) {
                return false;
            }

            calculatedTotal += price * quantity;
        }

        if (calculatedTotal <= 0) {
            return false;
        }

        boolean orderCreated =
                orderDAO.createOrder(userId, calculatedTotal);

        if (!orderCreated) {
            return false;
        }

        int orderId = orderDAO.getLatestOrderId(userId);

        if (orderId <= 0) {
            return false;
        }

        for (Map<String, Object> item : cartItems) {

            int productId =
                    ((Number) item.get("productId")).intValue();

            int quantity =
                    ((Number) item.get("quantity")).intValue();

            double price =
                    ((Number) item.get("price")).doubleValue();

            int sellerId =
                    ((Number) item.get("sellerId")).intValue();

            boolean itemAdded = orderItemDAO.addOrderItem(
                    orderId,
                    productId,
                    quantity,
                    price,
                    sellerId
            );

            if (!itemAdded) {
                return false;
            }
        }

        cartDAO.clearCart(userId);

        return true;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        return orderDAO.updateOrderStatus(orderId, status);
    }
}