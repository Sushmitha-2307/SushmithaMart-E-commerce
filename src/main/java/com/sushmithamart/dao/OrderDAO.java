package com.sushmithamart.dao;

import com.sushmithamart.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class OrderDAO {

    public boolean createOrder(int userId, double totalAmount) {

        String sql =
                "INSERT INTO orders (user_id, total_amount, status) " +
                "VALUES (?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setDouble(2, totalAmount);
            statement.setString(3, "PLACED");

            int rows = statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean updateOrderStatus(int orderId, String status) {

        String sql =
                "UPDATE orders SET status = ? WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setInt(2, orderId);

            int rows = statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}