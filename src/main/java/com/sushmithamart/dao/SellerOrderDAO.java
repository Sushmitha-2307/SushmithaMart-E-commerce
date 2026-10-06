package com.sushmithamart.dao;

import com.sushmithamart.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SellerOrderDAO {

    public List<Map<String, Object>> getSellerOrders(int sellerId) {
        List<Map<String, Object>> orders = new ArrayList<>();

        String sql = "SELECT "
                + "o.id AS order_id, "
                + "o.user_id, "
                + "o.total_amount, "
                + "o.status, "
                + "oi.product_id, "
                + "oi.quantity, "
                + "oi.price, "
                + "p.name AS product_name, "
                + "p.image, "
                + "oi.seller_id "
                + "FROM order_items oi "
                + "JOIN orders o ON oi.order_id = o.id "
                + "JOIN products p ON oi.product_id = p.id "
                + "WHERE oi.seller_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, sellerId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("orderId", rs.getInt("order_id"));
                order.put("userId", rs.getInt("user_id"));
                order.put("totalAmount", rs.getDouble("total_amount"));
                order.put("status", rs.getString("status"));
                order.put("productId", rs.getInt("product_id"));
                order.put("quantity", rs.getInt("quantity"));
                order.put("price", rs.getDouble("price"));
                order.put("productName", rs.getString("product_name"));
                order.put("image", rs.getString("image"));
                order.put("sellerId", rs.getInt("seller_id"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
}