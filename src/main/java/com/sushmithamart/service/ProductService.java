package com.sushmithamart.service;

import com.sushmithamart.dao.ProductDAO;
import com.sushmithamart.model.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductService {

    private final ProductDAO productDAO;

    public ProductService() {
        productDAO = new ProductDAO();
    }

    // ==============================
    // ADD PRODUCT
    // ==============================
    public boolean addProduct(Product product) {

        if (product == null) {
            return false;
        }

        if (product.getName() == null ||
            product.getName().trim().isEmpty()) {
            return false;
        }

        if (product.getPrice() <= 0 ||
            product.getQuantity() < 0 ||
            product.getSellerId() <= 0) {
            return false;
        }

        return productDAO.addProduct(product);
    }


    // ==============================
    // GET ALL PRODUCTS
    // ==============================
    public List<Product> getAllProducts() {

        return productDAO.getAllProducts();
    }


    // ==============================
    // GET SELLER PRODUCTS
    // ==============================
    public List<Product> getProductsBySeller(int sellerId) {

        if (sellerId <= 0) {
            return new ArrayList<>();
        }

        return productDAO.getProductsBySeller(sellerId);
    }


    // ==============================
    // GET PRODUCT BY ID
    // ==============================
    public Product getProductById(int productId) {

        if (productId <= 0) {
            return null;
        }

        return productDAO.getProductById(productId);
    }


    // ==============================
    // UPDATE PRODUCT
    // ==============================
    public boolean updateProduct(Product product) {

        if (product == null ||
            product.getId() <= 0 ||
            product.getSellerId() <= 0) {
            return false;
        }

        return productDAO.updateProduct(product);
    }


    // ==============================
    // DELETE PRODUCT
    // ==============================
    public boolean deleteProduct(int productId, int sellerId) {

        if (productId <= 0 || sellerId <= 0) {
            return false;
        }

        return productDAO.deleteProduct(productId, sellerId);
    }
}