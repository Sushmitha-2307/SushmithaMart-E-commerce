<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    List<Map<String, Object>> cartItems =
            (List<Map<String, Object>>) request.getAttribute("cartItems");

    double total = 0;
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - Cart</title>

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
            max-width: 1100px;
            margin: 35px auto;
        }

        .cart-box {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .cart-title {
            margin-top: 0;
            margin-bottom: 25px;
            font-size: 28px;
        }

        .item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            padding: 20px 0;
            border-bottom: 1px solid #e3e7ee;
        }

        .item-info {
            flex: 1;
        }

        .item h3 {
            margin: 0 0 8px;
            font-size: 18px;
        }

        .price {
            color: #162f63;
            font-size: 17px;
            font-weight: bold;
        }

        .quantity {
            width: 65px;
            padding: 9px;
            border: 1px solid #ccd2dc;
            border-radius: 6px;
        }

        button {
            padding: 9px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .update {
            background: #162f63;
            color: white;
        }

        .update:hover {
            background: #e8a33d;
            color: #16233f;
        }

        .remove {
            background: #d9363e;
            color: white;
        }

        .remove:hover {
            background: #b52b32;
        }

        .total {
            text-align: right;
            font-size: 24px;
            font-weight: bold;
            margin-top: 25px;
        }

        .empty {
            text-align: center;
            padding: 60px 20px;
            color: #68738a;
            font-size: 20px;
        }

        .empty a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 22px;
            background: #162f63;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .empty a:hover {
            background: #e8a33d;
            color: #16233f;
        }

        .checkout-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 25px;
        }

        .checkout {
            display: block;
            width: 220px;
            padding: 13px;
            text-align: center;
            background: #e8a33d;
            color: #16233f;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .checkout:hover {
            background: #16233f;
            color: white;
        }

        .continue-shopping {
            background: #162f63;
            color: white;
        }

        .continue-shopping:hover {
            background: #e8a33d;
            color: #16233f;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 15px;
            }

            .nav-links {
                gap: 10px;
                font-size: 13px;
            }

            .container {
                width: 95%;
            }

            .cart-box {
                padding: 20px;
            }

            .item {
                flex-direction: column;
                align-items: flex-start;
            }

            .item form {
                width: 100%;
            }

            .quantity {
                margin-right: 5px;
            }

            .checkout-actions {
                flex-direction: column;
            }

            .checkout {
                width: 100%;
            }
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

    <div class="cart-box">

        <h1 class="cart-title">
            My Shopping Cart
        </h1>

<%
    if (cartItems == null || cartItems.isEmpty()) {
%>

        <div class="empty">

            <div>Your cart is empty</div>

            <a href="products.jsp">
                Continue Shopping
            </a>

        </div>

<%
    } else {

        for (Map<String, Object> item : cartItems) {

            int productId =
                    ((Number) item.get("productId")).intValue();

            int quantity =
                    ((Number) item.get("quantity")).intValue();

            String name =
                    String.valueOf(item.get("name"));

            double price =
                    ((Number) item.get("price")).doubleValue();

            double itemTotal =
                    price * quantity;

            total += itemTotal;
%>

        <div class="item">

            <div class="item-info">

                <h3>
                    <%= name %>
                </h3>

                <div class="price">
                    ₹<%= String.format("%.2f", price) %>
                </div>

            </div>


            <form action="cart" method="post">

                <input
                    type="hidden"
                    name="productId"
                    value="<%= productId %>">

                <input
                    type="number"
                    name="quantity"
                    value="<%= quantity %>"
                    min="1"
                    class="quantity">

                <button
                    type="submit"
                    name="action"
                    value="update"
                    class="update">
                    Update
                </button>

                <button
                    type="submit"
                    name="action"
                    value="remove"
                    class="remove">
                    Remove
                </button>

            </form>

        </div>

<%
        }
%>

        <div class="total">
            Total: ₹<%= String.format("%.2f", total) %>
        </div>

        <div class="checkout-actions">

            <a href="products.jsp"
               class="checkout continue-shopping">
                Continue Shopping
            </a>

            <a href="checkout.jsp"
               class="checkout">
                Proceed to Checkout
            </a>

        </div>

<%
    }
%>

    </div>

</div>

</body>
</html>