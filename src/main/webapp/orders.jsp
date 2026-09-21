<%@ page import="com.sushmithamart.model.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.sushmithamart.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = user.getId();
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - My Orders</title>

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
            max-width: 1000px;
            margin: 40px auto;
        }

        .title {
            margin-bottom: 25px;
        }

        .order-card {
            background: white;
            padding: 25px;
            margin-bottom: 18px;
            border-radius: 14px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.08);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e3e7ee;
            padding-bottom: 15px;
            margin-bottom: 15px;
        }

        .order-id {
            font-weight: bold;
            color: #16233f;
        }

        .status {
            background: #e8a33d;
            color: #16233f;
            padding: 7px 12px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 13px;
        }

        .amount {
            font-size: 20px;
            font-weight: bold;
            margin-top: 12px;
        }

        .empty {
            background: white;
            padding: 50px;
            text-align: center;
            border-radius: 14px;
            color: #68738a;
        }

        .shop-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 22px;
            background: #16233f;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .shop-btn:hover {
            background: #e8a33d;
            color: #16233f;
        }

    </style>

</head>

<body>

<div class="navbar">

    <div class="logo">
        Sushmitha<span>Mart</span>
    </div>

    <div class="nav-links">
        <a href="products.jsp">Products</a>
        <a href="cart">Cart</a>
        <a href="orders.jsp">Orders</a>
    </div>

</div>


<div class="container">

    <h1 class="title">My Orders</h1>

<%
    boolean hasOrders = false;

    String sql =
        "SELECT id, total_amount, status " +
        "FROM orders " +
        "WHERE user_id = ? " +
        "ORDER BY id DESC";

    try (
        Connection connection = DBConnection.getConnection();
        PreparedStatement statement = connection.prepareStatement(sql)
    ) {

        statement.setInt(1, userId);

        try (ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {

                hasOrders = true;

                int orderId = rs.getInt("id");
                double totalAmount = rs.getDouble("total_amount");
                String status = rs.getString("status");
%>

    <div class="order-card">

        <div class="order-header">

            <div class="order-id">
                Order #<%= orderId %>
            </div>

            <div class="status">
                <%= status %>
            </div>

        </div>

        <div>
            Order Total
        </div>

        <div class="amount">
            ₹<%= String.format("%.2f", totalAmount) %>
        </div>

    </div>

<%
            }
        }

    } catch (Exception e) {
%>

    <div class="empty">
        Unable to load your orders.
    </div>

<%
        e.printStackTrace();
    }

    if (!hasOrders) {
%>

    <div class="empty">

        <h2>No Orders Yet</h2>

        <p>
            You haven't placed any orders yet.
        </p>

        <a href="products.jsp" class="shop-btn">
            Start Shopping
        </a>

    </div>

<%
    }
%>

</div>

</body>
</html>