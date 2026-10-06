package com.sushmithamart.dao;

import com.sushmithamart.model.Product;
import com.sushmithamart.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // ADD PRODUCT
    public boolean addProduct(Product product) {

        String sql =
                "INSERT INTO products " +
                "(name, category, description, price, quantity, seller_id, image) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getCategory());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getQuantity());
            ps.setInt(6, product.getSellerId());

            if (product.getImage() == null ||
                product.getImage().trim().isEmpty()) {

                ps.setNull(7, java.sql.Types.VARCHAR);

            } else {
                ps.setString(7, product.getImage());
            }

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // GET ALL PRODUCTS
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String sql =
                "SELECT * FROM products ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    // GET PRODUCTS BY SELLER
    public List<Product> getProductsBySeller(int sellerId) {

        List<Product> products = new ArrayList<>();

        String sql =
                "SELECT * FROM products " +
                "WHERE seller_id = ? ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, sellerId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }


    // GET PRODUCT BY ID
    public Product getProductById(int productId) {

        String sql =
                "SELECT * FROM products WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapProduct(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // UPDATE PRODUCT
    public boolean updateProduct(Product product) {

        String sql =
                "UPDATE products SET " +
                "name = ?, " +
                "category = ?, " +
                "description = ?, " +
                "price = ?, " +
                "quantity = ?, " +
                "image = ? " +
                "WHERE id = ? AND seller_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getCategory());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getQuantity());

            if (product.getImage() == null ||
                product.getImage().trim().isEmpty()) {

                ps.setNull(6, java.sql.Types.VARCHAR);

            } else {
                ps.setString(6, product.getImage());
            }

            ps.setInt(7, product.getId());
            ps.setInt(8, product.getSellerId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // DELETE PRODUCT
    public boolean deleteProduct(int productId, int sellerId) {

        String sql =
                "DELETE FROM products " +
                "WHERE id = ? AND seller_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            ps.setInt(2, sellerId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // MAP PRODUCT
    private Product mapProduct(ResultSet rs) throws Exception {

        Product product = new Product();

        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setCategory(rs.getString("category"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setQuantity(rs.getInt("quantity"));
        product.setSellerId(rs.getInt("seller_id"));
        product.setImage(rs.getString("image"));

        return product;
    }
}