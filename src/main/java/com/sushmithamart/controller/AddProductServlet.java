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

    /*
     * Product images will be stored here.
     */
    private static final String UPLOAD_DIR =
            "C:" + File.separator +
            "sushmithamart" + File.separator +
            "uploads" + File.separator +
            "products";


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Get the existing login session.
         */
        HttpSession session = request.getSession(false);

        /*
         * IMPORTANT FIX:
         *
         * LoginServlet stores the logged-in user as:
         *
         * session.setAttribute("user", user);
         *
         * Therefore we must check "user", NOT "name".
         */
        if (session == null || session.getAttribute("user") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }


        /*
         * Get logged-in user.
         */
        User user = (User) session.getAttribute("user");


        /*
         * Only SELLER can add products.
         */
        if (user == null ||
            user.getRole() == null ||
            !"SELLER".equalsIgnoreCase(user.getRole())) {

            response.sendRedirect(
                    request.getContextPath() + "/dashboard.jsp"
            );

            return;
        }


        try {

            /*
             * Read product details.
             */
            String name =
                    request.getParameter("name");

            String category =
                    request.getParameter("category");

            String description =
                    request.getParameter("description");

            String priceText =
                    request.getParameter("price");

            String quantityText =
                    request.getParameter("stock");


            /*
             * Validate required fields.
             */
            if (name == null ||
                name.trim().isEmpty() ||

                category == null ||
                category.trim().isEmpty() ||

                priceText == null ||
                priceText.trim().isEmpty() ||

                quantityText == null ||
                quantityText.trim().isEmpty()) {

                showError(
                        response,
                        "Please fill all required product details."
                );

                return;
            }


            /*
             * Convert price and stock.
             */
            double price;
            int quantity;

            try {

                price =
                        Double.parseDouble(
                                priceText.trim()
                        );

                quantity =
                        Integer.parseInt(
                                quantityText.trim()
                        );

            } catch (NumberFormatException e) {

                showError(
                        response,
                        "Please enter a valid price and stock quantity."
                );

                return;
            }


            /*
             * Validate price and quantity.
             */
            if (price < 0) {

                showError(
                        response,
                        "Price cannot be negative."
                );

                return;
            }


            if (quantity < 0) {

                showError(
                        response,
                        "Stock quantity cannot be negative."
                );

                return;
            }


            /*
             * Get uploaded image.
             */
            Part imagePart =
                    request.getPart("image");


            if (imagePart == null ||
                imagePart.getSize() == 0) {

                showError(
                        response,
                        "Please select a product image."
                );

                return;
            }


            /*
             * Get original image filename.
             */
            String originalFilename =
                    imagePart.getSubmittedFileName();


            if (originalFilename == null ||
                originalFilename.trim().isEmpty()) {

                showError(
                        response,
                        "Invalid image file."
                );

                return;
            }


            /*
             * Get file extension.
             */
            String extension = "";

            int dotIndex =
                    originalFilename.lastIndexOf('.');


            if (dotIndex > 0) {

                extension =
                        originalFilename
                                .substring(dotIndex)
                                .toLowerCase();
            }


            /*
             * Allow only common image types.
             */
            if (!extension.equals(".jpg") &&
                !extension.equals(".jpeg") &&
                !extension.equals(".png") &&
                !extension.equals(".webp")) {

                showError(
                        response,
                        "Only JPG, JPEG, PNG and WEBP images are allowed."
                );

                return;
            }


            /*
             * Create a unique filename.
             *
             * This prevents two products from
             * overwriting each other's images.
             */
            String filename =
                    UUID.randomUUID().toString()
                    + extension;


            /*
             * Create upload directory if it
             * does not already exist.
             */
            File uploadDirectory =
                    new File(UPLOAD_DIR);


            if (!uploadDirectory.exists()) {

                boolean created =
                        uploadDirectory.mkdirs();


                if (!created &&
                    !uploadDirectory.exists()) {

                    showError(
                            response,
                            "Could not create product image folder."
                    );

                    return;
                }
            }


            /*
             * Save image permanently in the
             * configured product image folder.
             */
            File imageFile =
                    new File(
                            uploadDirectory,
                            filename
                    );


            imagePart.write(
                    imageFile.getAbsolutePath()
            );


            /*
             * Store the image path in database.
             */
            String imagePath =
                    "images/products/" + filename;


            /*
             * Create Product object.
             */
            Product product =
                    new Product();


            product.setName(
                    name.trim()
            );


            product.setCategory(
                    category.trim()
            );


            product.setDescription(
                    description == null
                            ? ""
                            : description.trim()
            );


            product.setPrice(
                    price
            );


            product.setQuantity(
                    quantity
            );


            product.setSellerId(
                    user.getId()
            );


            product.setImage(
                    imagePath
            );


            /*
             * Save product into database.
             */
            boolean result =
                    productDAO.addProduct(product);


            if (result) {

                /*
                 * Product successfully added.
                 *
                 * Go to seller products page.
                 */
                response.sendRedirect(
                        request.getContextPath()
                        + "/seller-products?success=true"
                );

                return;

            } else {

                /*
                 * Database insert failed.
                 *
                 * Delete the uploaded image so
                 * unused files are not left behind.
                 */
                if (imageFile.exists()) {

                    imageFile.delete();
                }


                showError(
                        response,
                        "Database insert failed. Product was not added."
                );

                return;
            }


        } catch (Exception e) {

            e.printStackTrace();

            showError(
                    response,
                    "Product error: " + e.getMessage()
            );
        }
    }


    /*
     * Display error message.
     */
    private void showError(
            HttpServletResponse response,
            String message)
            throws IOException {

        response.setContentType(
                "text/html;charset=UTF-8"
        );


        PrintWriter out =
                response.getWriter();


        out.println(
                "<!DOCTYPE html>"
        );

        out.println(
                "<html>"
        );

        out.println(
                "<head>"
        );

        out.println(
                "<meta charset='UTF-8'>"
        );

        out.println(
                "<title>SushmithaMart - Product Error</title>"
        );

        out.println(
                "</head>"
        );

        out.println(
                "<body>"
        );


        out.println(
                "<h2>Product Could Not Be Added</h2>"
        );


        out.println(
                "<p>" + escapeHtml(message) + "</p>"
        );


        out.println(
                "<a href='" +
                response.encodeURL("add-product.jsp") +
                "'>Go Back</a>"
        );


        out.println(
                "</body>"
        );

        out.println(
                "</html>"
        );
    }


    /*
     * Basic HTML escaping for error messages.
     */
    private String escapeHtml(String text) {

        if (text == null) {
            return "";
        }

        return text
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}