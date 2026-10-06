<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.sushmithamart.model.OrderItem" %>
<%@ page import="com.sushmithamart.model.User" %>
<%@ page import="com.sushmithamart.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SushmithaMart - Seller Orders</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #17233f;
            margin: 0;
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

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .nav-links a:hover {
            color: #e8a33d;
        }

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 35px auto;
        }

        .title {
            margin-bottom: 25px;
        }

        .empty {
            background: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            color: #666;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .order-card {
            background: white;
            padding: 22px;
            margin-bottom: 20px;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e0e0e0;
            padding-bottom: 12px;
            margin-bottom: 15px;
        }

        .order-id {
            font-size: 19px;
            font-weight: bold;
        }

        .status {
            padding: 7px 13px;
            border-radius: 20px;
            background: #eaf2ff;
            color: #162f63;
            font-size: 13px;
            font-weight: bold;
        }

        .product-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .details {
            color: #68738a;
            line-height: 1.8;
            margin-bottom: 10px;
        }

        .price {
            font-size: 16px;
            font-weight: bold;
            color: #162f63;
            margin-top: 10px;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #16233f;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .back-btn:hover {
            background: #e8a33d;
        }
    </style>
</head>

<body>

<div class="navbar">

    <div class="logo">
        Sushmitha<span>Mart</span>
    </div>

    <div class="nav-links">
        <a href="seller-dashboard.jsp">Dashboard</a>
        <a href="seller-products.jsp">Products</a>
        <a href="seller-orders.jsp">Orders</a>
    </div>

</div>

<div class="container">

    <h1 class="title">Seller Orders</h1>

    <%
        User loggedSeller = (User) session.getAttribute("user");

        if (loggedSeller == null) {
            response.sendRedirect("sellerLogin.jsp");
            return;
        }

        int sellerId = loggedSeller.getId();

        List<OrderItem> sellerOrderItems = new ArrayList<>();

        String sql =
            "SELECT oi.id, oi.order_id, oi.product_id, oi.quantity, oi.price, " +
            "COALESCE(oi.seller_id, p.seller_id) AS seller_id " +
            "FROM order_items oi " +
            "INNER JOIN products p ON oi.product_id = p.id " +
            "WHERE p.seller_id = ? AND oi.seller_id = ? " +
            "ORDER BY oi.id DESC";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, sellerId);
            ps.setInt(2, sellerId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    OrderItem item = new OrderItem();

                    item.setId(rs.getInt("id"));
                    item.setOrderId(rs.getInt("order_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    item.setSellerId(rs.getInt("seller_id"));

                    sellerOrderItems.add(item);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        if (sellerOrderItems.isEmpty()) {
    %>

        <div class="empty">
            No orders found for your products.
        </div>

    <%
        } else {

            for (OrderItem item : sellerOrderItems) {
    %>

        <div class="order-card">

            <div class="order-header">

                <div class="order-id">
                    Order ID: <%= item.getOrderId() %>
                </div>

                <div class="status">
                    Completed
                </div>

            </div>

            <div class="product-name">
                Product ID: <%= item.getProductId() %>
            </div>

            <div class="details">

                <strong>Quantity:</strong>
                <%= item.getQuantity() %>
                <br>

                <strong>Item Price:</strong>
                Rs<%= String.format("%.2f", item.getPrice()) %>

            </div>

            <div class="price">

                <strong>Total for item:</strong>
                Rs<%= String.format(
                    "%.2f",
                    item.getPrice() * item.getQuantity()
                ) %>

            </div>

        </div>

    <%
            }
        }
    %>

    <a href="seller-dashboard.jsp" class="back-btn">
        &larr; Back to Dashboard
    </a>

</div>

</body>
</html>