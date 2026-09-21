package com.sushmithamart.dao;

import com.sushmithamart.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CartDAO {

    // =========================================================
    // ADD TO CART
    // =========================================================
    public boolean addToCart(int userId, int productId, int quantity) {

        // Check whether product is already in cart
        String checkSql =
                "SELECT quantity FROM cart " +
                "WHERE user_id = ? AND product_id = ?";

        String insertSql =
                "INSERT INTO cart (user_id, product_id, quantity) " +
                "VALUES (?, ?, ?)";

        String updateSql =
                "UPDATE cart SET quantity = quantity + ? " +
                "WHERE user_id = ? AND product_id = ?";

        try (Connection con = DBConnection.getConnection()) {

            // First check existing cart item
            try (PreparedStatement checkPs =
                         con.prepareStatement(checkSql)) {

                checkPs.setInt(1, userId);
                checkPs.setInt(2, productId);

                try (ResultSet rs = checkPs.executeQuery()) {

                    if (rs.next()) {

                        // Product already exists
                        try (PreparedStatement updatePs =
                                     con.prepareStatement(updateSql)) {

                            updatePs.setInt(1, quantity);
                            updatePs.setInt(2, userId);
                            updatePs.setInt(3, productId);

                            return updatePs.executeUpdate() > 0;
                        }

                    } else {

                        // Product does not exist
                        try (PreparedStatement insertPs =
                                     con.prepareStatement(insertSql)) {

                            insertPs.setInt(1, userId);
                            insertPs.setInt(2, productId);
                            insertPs.setInt(3, quantity);

                            return insertPs.executeUpdate() > 0;
                        }
                    }
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // REMOVE FROM CART
    // =========================================================
    public boolean removeFromCart(int userId, int productId) {

        String sql =
                "DELETE FROM cart " +
                "WHERE user_id = ? AND product_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // UPDATE QUANTITY
    // =========================================================
    public boolean updateQuantity(
            int userId,
            int productId,
            int quantity) {

        String sql =
                "UPDATE cart SET quantity = ? " +
                "WHERE user_id = ? AND product_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, userId);
            ps.setInt(3, productId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // GET CART ITEMS
    // =========================================================
    public List<Map<String, Object>> getCartItems(int userId) {

        List<Map<String, Object>> items =
                new ArrayList<>();

        String sql =
                "SELECT c.product_id, " +
                "c.quantity, " +
                "p.name, " +
                "p.price " +
                "FROM cart c " +
                "INNER JOIN products p " +
                "ON c.product_id = p.id " +
                "WHERE c.user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Map<String, Object> item =
                            new HashMap<>();

                    item.put(
                            "productId",
                            rs.getInt("product_id")
                    );

                    item.put(
                            "quantity",
                            rs.getInt("quantity")
                    );

                    item.put(
                            "name",
                            rs.getString("name")
                    );

                    item.put(
                            "price",
                            rs.getDouble("price")
                    );

                    items.add(item);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return items;
    }
}