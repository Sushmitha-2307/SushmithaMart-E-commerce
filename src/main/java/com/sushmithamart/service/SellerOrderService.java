package com.sushmithamart.service;

import com.sushmithamart.dao.SellerOrderDAO;

import java.util.List;
import java.util.Map;

public class SellerOrderService {

    private final SellerOrderDAO sellerOrderDAO;

    public SellerOrderService() {
        sellerOrderDAO = new SellerOrderDAO();
    }

    public List<Map<String, Object>> getSellerOrders(int sellerId) {
        return sellerOrderDAO.getSellerOrders(sellerId);
    }
}