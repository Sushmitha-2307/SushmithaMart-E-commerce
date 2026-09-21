<%@ page import="com.sushmithamart.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.sushmithamart.service.CartService" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    CartService cartService = new CartService();

    List<Map<String, Object>> cartItems =
            cartService.getCartItems(user.getId());

    double totalAmount = 0;
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - Checkout</title>

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
            max-width: 850px;
            margin: 45px auto;
        }

        .checkout-box {
            background: white;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        h1 {
            margin-top: 0;
            color: #16233f;
        }

        .subtitle {
            color: #68738a;
            margin-bottom: 30px;
        }

        .section {
            margin-bottom: 25px;
        }

        .section h2 {
            font-size: 20px;
            margin-bottom: 15px;
        }

        .input-box {
            margin-bottom: 15px;
        }

        .input-box label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }

        .input-box input,
        .input-box textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccd2dc;
            border-radius: 7px;
            font-size: 14px;
        }

        .input-box textarea {
            min-height: 90px;
            resize: vertical;
        }

        .summary {
            background: #f5f7fb;
            padding: 20px;
            border-radius: 10px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #dfe3ea;
        }

        .summary-item:last-child {
            border-bottom: none;
        }

        .item-name {
            font-weight: bold;
        }

        .item-details {
            color: #68738a;
            font-size: 14px;
            margin-top: 4px;
        }

        .payment {
            display: flex;
            justify-content: space-between;
            margin-top: 18px;
            padding-top: 15px;
            border-top: 1px solid #dfe3ea;
        }

        .total {
            display: flex;
            justify-content: space-between;
            margin-top: 18px;
            padding-top: 18px;
            border-top: 2px solid #16233f;
            font-size: 22px;
            font-weight: bold;
            color: #16233f;
        }

        .place-order {
            width: 100%;
            margin-top: 25px;
            padding: 14px;
            border: none;
            border-radius: 8px;
            background: #e8a33d;
            color: #16233f;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .place-order:hover {
            background: #16233f;
            color: white;
        }

        .empty {
            text-align: center;
            padding: 30px;
            color: #68738a;
        }

    </style>

</head>

<body>

<div class="navbar">

    <div class="logo">
        Sushmitha<span>Mart</span>
    </div>

    <a href="cart" class="back">
        Back to Cart
    </a>

</div>


<div class="container">

    <div class="checkout-box">

        <h1>Checkout</h1>

        <p class="subtitle">
            Complete your details to place your order.
        </p>


        <form action="order" method="post">

            <input
                type="hidden"
                name="userId"
                value="<%= user.getId() %>">


            <div class="section">

                <h2>Delivery Details</h2>

                <div class="input-box">

                    <label>Full Name</label>

                    <input
                        type="text"
                        name="name"
                        value="<%= user.getName() %>"
                        placeholder="Enter your full name"
                        required>

                </div>


                <div class="input-box">

                    <label>Phone Number</label>

                    <input
                        type="tel"
                        name="phone"
                        placeholder="Enter your phone number"
                        required>

                </div>


                <div class="input-box">

                    <label>Delivery Address</label>

                    <textarea
                        name="address"
                        placeholder="Enter your complete delivery address"
                        required></textarea>

                </div>

            </div>


            <div class="section">

                <h2>Order Summary</h2>

                <div class="summary">

<%
    if (cartItems != null && !cartItems.isEmpty()) {

        for (Map<String, Object> item : cartItems) {

            String itemName =
                    String.valueOf(item.get("name"));

            int quantity =
                    ((Number) item.get("quantity")).intValue();

            double price =
                    ((Number) item.get("price")).doubleValue();

            double itemTotal = price * quantity;

            totalAmount += itemTotal;
%>

                    <div class="summary-item">

                        <div>
                            <div class="item-name">
                                <%= itemName %>
                            </div>

                            <div class="item-details">
                                Quantity: <%= quantity %>
                                × ₹<%= String.format("%.2f", price) %>
                            </div>
                        </div>

                        <div>
                            ₹<%= String.format("%.2f", itemTotal) %>
                        </div>

                    </div>

<%
        }

    } else {
%>

                    <div class="empty">
                        Your cart is empty.
                    </div>

<%
    }
%>

                    <div class="payment">

                        <strong>Payment</strong>

                        <span>Cash on Delivery</span>

                    </div>


                    <div class="total">

                        <span>Total</span>

                        <span>
                            ₹<%= String.format("%.2f", totalAmount) %>
                        </span>

                    </div>

                </div>

            </div>


            <input
                type="hidden"
                name="totalAmount"
                value="<%= totalAmount %>">


            <button
                type="submit"
                class="place-order">

                Place Order

            </button>

        </form>

    </div>

</div>

</body>
</html>