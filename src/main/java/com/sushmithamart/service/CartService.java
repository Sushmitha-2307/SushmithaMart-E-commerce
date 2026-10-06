package com.sushmithamart.service;

import com.sushmithamart.dao.CartDAO;
import java.util.List;
import java.util.Map;

public class CartService {

    private final CartDAO cartDAO;

    public CartService() {
        cartDAO = new CartDAO();
    }

    public boolean addToCart(int userId, int productId, int quantity) {
        if (userId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }
        return cartDAO.addToCart(userId, productId, quantity);
    }

    public boolean removeFromCart(int userId, int productId) {
        if (userId <= 0 || productId <= 0) {
            return false;
        }
        cartDAO.removeFromCart(userId, productId);
        return true;
    }

    public boolean updateQuantity(int userId, int productId, int quantity) {
        if (userId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }
        return cartDAO.updateQuantity(userId, productId, quantity);
    }

    public List<Map<String, Object>> getCartItems(int userId) {
        if (userId <= 0) {
            return new java.util.ArrayList<>();
        }
        return cartDAO.getCartItems(userId);
    }
}