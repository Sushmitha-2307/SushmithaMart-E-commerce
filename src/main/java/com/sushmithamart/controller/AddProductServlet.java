package com.sushmithamart.controller;

import com.sushmithamart.model.Product;
import com.sushmithamart.model.User;
import com.sushmithamart.dao.ProductDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/add-product")
@MultipartConfig(
fileSizeThreshold = 1024 * 1024,
maxFileSize = 5 * 1024 * 1024,
maxRequestSize = 10 * 1024 * 1024
)
public class AddProductServlet extends HttpServlet {

private static final long serialVersionUID = 1L;

private ProductDAO productDAO = new ProductDAO();

@Override
protected void doPost(HttpServletRequest request,
                       HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    // Login check
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User user = (User) session.getAttribute("user");

    // Seller check
    if (!"SELLER".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    try {

        String name = request.getParameter("name");
        String category = request.getParameter("category");

        double price = Double.parseDouble(
                request.getParameter("price")
        );

        int quantity = Integer.parseInt(
                request.getParameter("stock")
        );

        String description = request.getParameter("description");

        /*
         * Get uploaded image
         */
        Part imagePart = request.getPart("image");

        if (imagePart == null || imagePart.getSize() == 0) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/add-product.jsp?error=Please%20select%20a%20product%20image"
            );
            return;
        }

        /*
         * Get original file name
         */
        String originalFileName = imagePart.getSubmittedFileName();

        if (originalFileName == null || originalFileName.isEmpty()) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/add-product.jsp?error=Invalid%20image"
            );
            return;
        }

        /*
         * Get file extension
         */
        String extension = "";

        int dotIndex = originalFileName.lastIndexOf(".");

        if (dotIndex >= 0) {
            extension = originalFileName.substring(dotIndex)
                    .toLowerCase();
        }

        /*
         * Allow only common image formats
         */
        if (!extension.equals(".jpg")
                && !extension.equals(".jpeg")
                && !extension.equals(".png")
                && !extension.equals(".gif")
                && !extension.equals(".webp")) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/add-product.jsp?error=Only%20JPG%2C%20PNG%2C%20GIF%20or%20WEBP%20images%20are%20allowed"
            );
            return;
        }

        /*
         * Create unique file name
         */
        String fileName = UUID.randomUUID().toString()
                + extension;

        /*
         * Create upload folder inside web application
         */
        String uploadPath = getServletContext()
                .getRealPath("/images/products");

        File uploadDirectory = new File(uploadPath);

        if (!uploadDirectory.exists()) {
            uploadDirectory.mkdirs();
        }

        /*
         * Save image
         */
        imagePart.write(
                new File(uploadDirectory, fileName)
                        .getAbsolutePath()
        );

        /*
         * Image path stored in database
         */
        String image = "images/products/" + fileName;

        /*
         * Create product
         */
        Product product = new Product();

        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setQuantity(quantity);
        product.setSellerId(user.getId());
        product.setImage(image);

        boolean result = productDAO.addProduct(product);

        if (result) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/seller-dashboard.jsp?success=Product%20Added"
            );

        } else {

            /*
             * If database insert fails, delete uploaded image
             */
            File uploadedFile =
                    new File(uploadDirectory, fileName);

            if (uploadedFile.exists()) {
                uploadedFile.delete();
            }

            response.sendRedirect(
                    request.getContextPath()
                    + "/add-product.jsp?error=Product%20Not%20Added"
            );
        }

    } catch (Exception e) {

        e.printStackTrace();

        response.sendRedirect(
                request.getContextPath()
                + "/add-product.jsp?error=Invalid%20Product%20Details"
        );
    }
}

}