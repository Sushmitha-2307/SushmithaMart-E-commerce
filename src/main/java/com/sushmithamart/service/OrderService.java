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
        // 1. Get cart items
        List<Map<String, Object>> cartItems = cartDAO.getCartItems(userId);
        
        if (cartItems == null || cartItems.isEmpty()) {
            return false;
        }

        // 2. Create order
        boolean orderCreated = orderDAO.createOrder(userId, totalAmount);
        
        if (!orderCreated) {
            return false;
        }

        // Get the latest order created by this user.
        int orderId = orderDAO.getLatestOrderId(userId);

        if (orderId <= 0) {
            return false;
        }

        // 3. Insert every cart product into order items
        for (Map<String, Object> item : cartItems) {
            int productId = ((Number) item.get("productId")).intValue();
            int quantity = ((Number) item.get("quantity")).intValue();
            double price = ((Number) item.get("price")).doubleValue();
            int sellerId = ((Number) item.get("sellerId")).intValue();

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

        // 4. Clear cart after successful order
        cartDAO.clearCart(userId);

        return true;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        return orderDAO.updateOrderStatus(orderId, status);
    }
}