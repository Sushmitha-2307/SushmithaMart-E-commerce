package com.sushmithamart.controller;

import com.sushmithamart.model.Product;
import com.sushmithamart.model.User;
import com.sushmithamart.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/seller-products")
public class SellerProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductService productService;

    @Override
    public void init() {
        productService = new ProductService();
    }

    // ==========================================
    // GET
    // ==========================================
    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        int sellerId = user.getId();

        List<Product> products =
                productService.getProductsBySeller(sellerId);

        request.setAttribute("products", products);

        request.getRequestDispatcher("seller-products.jsp")
               .forward(request, response);
    }


    // ==========================================
    // POST
    // ==========================================
    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        int sellerId = user.getId();

        String action = request.getParameter("action");

        try {

            // ==================================
            // ADD PRODUCT
            // ==================================
            if ("add".equals(action)) {

                String name =
                        request.getParameter("name");

                String description =
                        request.getParameter("description");

                String priceParam =
                        request.getParameter("price");

                String quantityParam =
                        request.getParameter("quantity");

                String image =
                        request.getParameter("image");


                double price =
                        Double.parseDouble(priceParam);

                int quantity =
                        Integer.parseInt(quantityParam);


                Product product = new Product();

                product.setName(name);
                product.setDescription(description);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setSellerId(sellerId);
                product.setImage(image);


                boolean success =
                        productService.addProduct(product);


                if (success) {
                    response.sendRedirect("seller-products");
                } else {
                    response.sendRedirect("add-product.jsp?error=1");
                }

                return;
            }


            // ==================================
            // DELETE PRODUCT
            // ==================================
            if ("delete".equals(action)) {

                String productIdParam =
                        request.getParameter("productId");

                int productId =
                        Integer.parseInt(productIdParam);


                productService.deleteProduct(
                        productId,
                        sellerId
                );


                response.sendRedirect("seller-products");

                return;
            }


            // ==================================
            // UPDATE PRODUCT
            // ==================================
            if ("update".equals(action)) {

                String productIdParam =
                        request.getParameter("productId");

                String name =
                        request.getParameter("name");

                String description =
                        request.getParameter("description");

                String priceParam =
                        request.getParameter("price");

                String quantityParam =
                        request.getParameter("quantity");

                String image =
                        request.getParameter("image");


                int productId =
                        Integer.parseInt(productIdParam);

                double price =
                        Double.parseDouble(priceParam);

                int quantity =
                        Integer.parseInt(quantityParam);


                Product product = new Product();

                product.setId(productId);
                product.setName(name);
                product.setDescription(description);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setSellerId(sellerId);
                product.setImage(image);


                productService.updateProduct(product);


                response.sendRedirect("seller-products");

                return;
            }


            response.sendRedirect("seller-products");

        } catch (NumberFormatException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "seller-products?error=invalid"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "seller-products?error=server"
            );
        }
    }
}