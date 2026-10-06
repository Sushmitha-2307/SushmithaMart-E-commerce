package com.sushmithamart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.sushmithamart.util.DBConnection;
import com.sushmithamart.model.OrderItem;

public class OrderItemDAO {

    public boolean addOrderItem(int orderId, int productId, int quantity, double price, int sellerId) {
        boolean isAdded = false;
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price, seller_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(sql)) {

            preparedStatement.setInt(1, orderId);
            preparedStatement.setInt(2, productId);
            preparedStatement.setInt(3, quantity);
            preparedStatement.setDouble(4, price);
            preparedStatement.setInt(5, sellerId);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                isAdded = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isAdded;
    }

    public List<OrderItem> getOrderItemsBySeller(int sellerId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE seller_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(sql)) {

            preparedStatement.setInt(1, sellerId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(resultSet.getInt("id"));
                    item.setOrderId(resultSet.getInt("order_id"));
                    item.setProductId(resultSet.getInt("product_id"));
                    item.setQuantity(resultSet.getInt("quantity"));
                    item.setPrice(resultSet.getDouble("price"));
                    item.setSellerId(resultSet.getInt("seller_id"));
                    orderItems.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderItems;
    }
}