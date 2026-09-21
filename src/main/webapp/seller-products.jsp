<%@ page import="com.sushmithamart.model.User" %>
<%@ page import="com.sushmithamart.model.Product" %>
<%@ page import="com.sushmithamart.dao.ProductDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if (!"SELLER".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    ProductDAO productDAO = new ProductDAO();
    List<Product> allProducts = productDAO.getAllProducts();

    List<Product> sellerProducts = new java.util.ArrayList<>();

    for (Product product : allProducts) {
        if (product.getSellerId() == user.getId()) {
            sellerProducts.add(product);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - Manage Products</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #17233f;
        }

        .navbar {
            background: #16233f;
            color: white;
            padding: 16px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 25px;
            font-weight: bold;
        }

        .logo span {
            color: #e8a33d;
        }

        .back {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .back:hover {
            color: #e8a33d;
        }

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 45px auto;
        }

        .header {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0 0 10px;
            color: #16233f;
        }

        .header p {
            color: #68738a;
            margin: 0;
        }

        .products {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .product {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.08);
        }

        .product h2 {
            margin-top: 0;
            color: #16233f;
        }

        .product p {
            color: #68738a;
            line-height: 1.5;
        }

        .price {
            font-size: 20px;
            font-weight: bold;
            color: #16233f;
        }

        .stock {
            color: #68738a;
            margin-top: 8px;
        }

        .empty {
            background: white;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 18px rgba(0,0,0,0.08);
        }

        .add-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 22px;
            background: #e8a33d;
            color: #16233f;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        @media (max-width: 700px) {
            .products {
                grid-template-columns: 1fr;
            }

            .navbar {
                padding: 15px;
            }
        }

    </style>

</head>

<body>

<div class="navbar">

    <div class="logo">
        Sushmitha<span>Mart</span>
    </div>

    <a href="seller-dashboard.jsp" class="back">
        Back to Dashboard
    </a>

</div>


<div class="container">

    <div class="header">

        <h1>Manage Products</h1>

        <p>
            Products added by
            <strong><%= user.getName() %></strong>
        </p>

    </div>


    <% if (sellerProducts.isEmpty()) { %>

        <div class="empty">

            <h2>No Products Yet</h2>

            <p>
                You have not added any products yet.
            </p>

            <a href="add-product.jsp" class="add-btn">
                Add Product
            </a>

        </div>

    <% } else { %>

        <div class="products">

            <% for (Product product : sellerProducts) { %>

                <div class="product">

                    <h2>
                        <%= product.getName() %>
                    </h2>

                    <p>
                        <%= product.getDescription() %>
                    </p>

                    <div class="price">
                        ₹<%= product.getPrice() %>
                    </div>

                    <div class="stock">
                        Stock: <%= product.getQuantity() %>
                    </div>

                </div>

            <% } %>

        </div>

    <% } %>

</div>

</body>
</html>