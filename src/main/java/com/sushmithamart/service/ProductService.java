package com.sushmithamart.service;

import com.sushmithamart.dao.ProductDAO;
import com.sushmithamart.model.Product;

public class ProductService {

    private ProductDAO productDAO = new ProductDAO();

    public boolean addProduct(Product product) {
        return productDAO.addProduct(product);
    }

    public boolean updateProduct(Product product) {
        return productDAO.updateProduct(product);
    }

    public boolean deleteProduct(int productId) {
        return productDAO.deleteProduct(productId);
    }
    public java.util.List<Product> getAllProducts() {
    return productDAO.getAllProducts();
}
}
