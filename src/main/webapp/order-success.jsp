<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Order Successful - SushmithaMart</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #17233f;
        }

        .success-box {
            width: 90%;
            max-width: 520px;
            background: white;
            padding: 45px;
            text-align: center;
            border-radius: 18px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.10);
        }

        .success-icon {
            font-size: 60px;
            margin-bottom: 15px;
        }

        h1 {
            margin: 0 0 12px;
            color: #16233f;
        }

        p {
            color: #68738a;
            font-size: 16px;
            margin-bottom: 28px;
        }

        .btn {
            display: inline-block;
            padding: 13px 25px;
            margin: 5px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
        }

        .products {
            background: #16233f;
            color: white;
        }

        .orders {
            background: #e8a33d;
            color: #16233f;
        }

        .btn:hover {
            opacity: 0.85;
        }
    </style>
</head>

<body>

<div class="success-box">

    <div class="success-icon">✓</div>

    <h1>Order Placed Successfully!</h1>

    <p>
        Thank you for shopping with SushmithaMart.
        Your order has been placed successfully.
    </p>

    <a href="products.jsp" class="btn products">
        Continue Shopping
    </a>

    <a href="orders.jsp" class="btn orders">
        View Orders
    </a>

</div>

</body>
</html>