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

        .logout {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .logout:hover {
            color: #e8a33d;
        }

        .container {
            width: 92%;
            max-width: 1100px;
            margin: 45px auto;
        }

        .welcome {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }

        .welcome h1 {
            margin-top: 0;
            color: #16233f;
        }

        .welcome p {
            color: #68738a;
            font-size: 16px;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 18px rgba(0,0,0,0.08);
        }

        .card h2 {
            color: #16233f;
            margin-top: 0;
        }

        .card p {
            color: #68738a;
        }

        .card a {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 25px;
            background: #162f63;
            color: white;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .card a:hover {
            background: #e8a33d;
            color: #16233f;
        }

        @media (max-width: 700px) {

            .cards {
                grid-template-columns: 1fr;
            }

            .navbar {
                padding: 15px;
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

    <a class="logout" href="login.jsp">
        Logout
    </a>

</div>


<div class="container">

    <div class="welcome">

        <h1>
            Seller Dashboard
        </h1>

        <p>
            Hello, <strong><%= user.getName() %></strong>
        </p>

        <p>
            Welcome to your SushmithaMart seller account.
        </p>

    </div>


    <div class="cards">

        <div class="card">

            <h2>Products</h2>

            <p>
                Add and manage your products.
            </p>

            <a href="seller-products.jsp">
                Manage Products
            </a>

        </div>


        <div class="card">

            <h2>Add Product</h2>

            <p>
                Add a new product to your store.
            </p>

            <a href="add-product.jsp">
                Add Product
            </a>

        </div>


        <div class="card">

            <h2>Orders</h2>

            <p>
                View orders received from buyers.
            </p>

            <a href="seller-orders.jsp">
                View Orders
            </a>

        </div>

    </div>

</div>

</body>
</html>