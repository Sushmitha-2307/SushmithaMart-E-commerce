<%@ page import="com.sushmithamart.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - Seller Dashboard</title>

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
            max-width: 1150px;
            margin: 40px auto;
        }

        .welcome {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .welcome h1 {
            margin: 0 0 10px;
        }

        .welcome p {
            color: #68738a;
            margin: 0;
        }

        .cards {
            display: grid;
            grid-template-columns:
                repeat(auto-fit, minmax(260px, 1fr));

            gap: 22px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            text-align: center;
        }

        .icon {
            font-size: 42px;
            margin-bottom: 15px;
        }

        .card h2 {
            margin: 0 0 10px;
        }

        .card p {
            color: #68738a;
            min-height: 45px;
        }

        .btn {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 22px;
            border-radius: 7px;

            background: #162f63;
            color: white;

            text-decoration: none;
            font-weight: bold;
        }

        .btn:hover {
            background: #e8a33d;
            color: #16233f;
        }

        .add-btn {
            background: #e8a33d;
            color: #16233f;
        }

        .add-btn:hover {
            background: #16233f;
            color: white;
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

        }

    </style>

</head>

<body>


<div class="navbar">

    <div class="logo">
        Sushmitha<span>Mart</span>
    </div>

    <div class="nav-links">

        <a href="seller-dashboard.jsp">
            Dashboard
        </a>

        <a href="seller-products">
            Products
        </a>

        <a href="seller-orders.jsp">
            Orders
        </a>

    </div>

</div>


<div class="container">


    <div class="welcome">

        <h1>
            Welcome, Seller!
        </h1>

        <p>
            Manage your products and seller orders from here.
        </p>

    </div>


    <div class="cards">


        <!-- PRODUCTS -->

        <div class="card">

            <div class="icon">
                📦
            </div>

            <h2>
                My Products
            </h2>

            <p>
                View and manage all your products.
            </p>

            <a href="seller-products"
               class="btn">

                View Products

            </a>

        </div>


        <!-- ADD PRODUCT -->

        <div class="card">

            <div class="icon">
                ➕
            </div>

            <h2>
                Add Product
            </h2>

            <p>
                Add a new product to your store.
            </p>

            <a href="add-product.jsp"
               class="btn add-btn">

                Add Product

            </a>

        </div>


        <!-- ORDERS -->

        <div class="card">

            <div class="icon">
                🛒
            </div>

            <h2>
                Seller Orders
            </h2>

            <p>
                View orders containing your products.
            </p>

            <a href="seller-orders.jsp"
               class="btn">

                View Orders

            </a>

        </div>


    </div>

</div>

</body>
</html>