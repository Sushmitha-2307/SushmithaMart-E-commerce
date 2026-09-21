<%@ page import="com.sushmithamart.model.User" %>
<%@ page import="com.sushmithamart.util.DBConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
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
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - Seller Orders</title>

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
        }

        .header p {
            color: #68738a;
        }

        .order {
            background: white;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.08);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e1e5eb;
        }

        .order-id {
            font-weight: bold;
            font-size: 18px;
        }

        .status {
            color: #16233f;
            font-weight: bold;
        }

        .item {
            padding: 12px 0;
            border-bottom: 1px solid #eef0f4;
        }

        .item:last-child {
            border-bottom: none;
        }

        .item-name {
            font-weight: bold;
        }

        .item-details {
            color: #68738a;
            margin-top: 5px;
        }

        .empty {
            background: white;
            padding: 45px;
            text-align: center;
            border-radius: 15px;
            box-shadow: 0 5px 18px rgba(0,0,0,0.08);
        }

        .total {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #dfe3ea;
            font-size: 19px;
            font-weight: bold;
            text-align: right;
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

        <h1>Seller Orders</h1>

        <p>
            Orders containing your products
        </p>

    </div>


<%
    boolean hasOrders = false;

    String sql =
        "SELECT o.id AS order_id, " +
        "o.total_amount, o.status, " +
        "p.name AS product_name, " +
        "oi.quantity, oi.price " +
        "FROM orders o " +
        "JOIN order_items oi ON o.id = oi.order_id " +
        "JOIN products p ON oi.product_id = p.id " +
        "WHERE p.seller_id = ? " +
        "ORDER BY o.id DESC";

    try (
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)
    ) {

        ps.setInt(1, user.getId());

        ResultSet rs = ps.executeQuery();

        int currentOrderId = -1;

        while (rs.next()) {

            hasOrders = true;

            int orderId = rs.getInt("order_id");

            if (orderId != currentOrderId) {

                if (currentOrderId != -1) {
%>
                    <div class="total">
                        Order Total: ₹<%= rs.getDouble("total_amount") %>
                    </div>

                    </div>
<%
                }

                currentOrderId = orderId;
%>

                <div class="order">

                    <div class="order-header">

                        <div class="order-id">
                            Order #<%= orderId %>
                        </div>

                        <div class="status">
                            <%= rs.getString("status") %>
                        </div>

                    </div>

<%
            }
%>

                    <div class="item">

                        <div class="item-name">
                            <%= rs.getString("product_name") %>
                        </div>

                        <div class="item-details">
                            Quantity: <%= rs.getInt("quantity") %>
                            &nbsp; | &nbsp;
                            Price: ₹<%= rs.getDouble("price") %>
                        </div>

                    </div>

<%
        }

        if (currentOrderId != -1) {
%>

                </div>

<%
        }

        if (!hasOrders) {
%>

            <div class="empty">

                <h2>No Orders Yet</h2>

                <p>
                    You have not received any orders for your products.
                </p>

            </div>

<%
        }

    } catch (Exception e) {

        e.printStackTrace();
%>

        <div class="empty">

            <h2>Unable to Load Orders</h2>

            <p>
                Please try again later.
            </p>

        </div>

<%
    }
%>

</div>

</body>

</html>