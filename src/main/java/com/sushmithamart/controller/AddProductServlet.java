package com.sushmithamart.controller;

import com.sushmithamart.dao.ProductDAO;
import com.sushmithamart.model.Product;
import com.sushmithamart.model.User;

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
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet("/add-product")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class AddProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAO();

    private String getUploadDirectory() {
        String configuredPath = System.getenv("PRODUCT_UPLOAD_DIR");

        if (configuredPath != null && !configuredPath.trim().isEmpty()) {
            return configuredPath.trim();
        }

        String railwayPath = "/app/uploads/products";

        if (System.getProperty("os.name").toLowerCase().contains("win")) {
            return "C:" + File.separator
                    + "sushmithamart" + File.separator
                    + "uploads" + File.separator
                    + "products";
        }

        return railwayPath;
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user.getRole() == null ||
                !"SELLER".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            return;
        }

        File imageFile = null;

        try {
            request.setCharacterEncoding("UTF-8");

            String name = request.getParameter("name");
            String category = request.getParameter("category");
            String description = request.getParameter("description");
            String priceText = request.getParameter("price");
            String quantityText = request.getParameter("stock");

            if (name == null || name.trim().isEmpty()
                    || category == null || category.trim().isEmpty()
                    || priceText == null || priceText.trim().isEmpty()
                    || quantityText == null || quantityText.trim().isEmpty()) {
                showError(response, "Please fill all required product details.");
                return;
            }

            double price;
            int quantity;

            try {
                price = Double.parseDouble(priceText.trim());
                quantity = Integer.parseInt(quantityText.trim());
            } catch (NumberFormatException e) {
                showError(response, "Please enter a valid price and stock quantity.");
                return;
            }

            if (!Double.isFinite(price) || price < 0) {
                showError(response, "Please enter a valid non-negative price.");
                return;
            }

            if (quantity < 0) {
                showError(response, "Stock quantity cannot be negative.");
                return;
            }

            Part imagePart = request.getPart("image");

            if (imagePart == null || imagePart.getSize() == 0) {
                showError(response, "Please select a product image.");
                return;
            }

            String originalFilename = imagePart.getSubmittedFileName();

            if (originalFilename == null || originalFilename.trim().isEmpty()) {
                showError(response, "Invalid image file.");
                return;
            }

            String extension = "";
            int dotIndex = originalFilename.lastIndexOf('.');

            if (dotIndex > 0) {
                extension = originalFilename.substring(dotIndex).toLowerCase();
            }

            if (!extension.equals(".jpg")
                    && !extension.equals(".jpeg")
                    && !extension.equals(".png")
                    && !extension.equals(".webp")) {
                showError(response, "Only JPG, JPEG, PNG and WEBP images are allowed.");
                return;
            }

            String filename = UUID.randomUUID() + extension;

            Path uploadPath = Paths.get(getUploadDirectory()).toAbsolutePath().normalize();

            Files.createDirectories(uploadPath);

            imageFile = uploadPath.resolve(filename).toFile();

            imagePart.write(imageFile.getAbsolutePath());

            String imagePath = "images/products/" + filename;

            Product product = new Product();
            product.setName(name.trim());
            product.setCategory(category.trim());
            product.setDescription(description == null ? "" : description.trim());
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setSellerId(user.getId());
            product.setImage(imagePath);

            boolean result = productDAO.addProduct(product);

            if (result) {
                response.sendRedirect(
                        request.getContextPath() + "/seller-products?success=true");
                return;
            }

            if (imageFile.exists()) {
                Files.deleteIfExists(imageFile.toPath());
            }

            showError(response, "Database insert failed. Product was not added.");

        } catch (Exception e) {
            e.printStackTrace();

            if (imageFile != null && imageFile.exists()) {
                try {
                    Files.deleteIfExists(imageFile.toPath());
                } catch (IOException ignored) {
                    // Preserve the original error.
                }
            }

            showError(response, "Product could not be added. Please check the server logs.");
        }
    }

    private void showError(HttpServletResponse response, String message)
            throws IOException {

        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><meta charset='UTF-8'>");
        out.println("<title>SushmithaMart - Product Error</title></head><body>");
        out.println("<h2>Product Could Not Be Added</h2>");
        out.println("<p>" + escapeHtml(message) + "</p>");
        out.println("<a href='add-product.jsp'>Go Back</a>");
        out.println("</body></html>");
    }

    private String escapeHtml(String text) {
        if (text == null) {
            return "";
        }

        return text.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}