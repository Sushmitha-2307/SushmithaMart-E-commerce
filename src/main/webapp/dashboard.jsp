<%@ page import="com.sushmithamart.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userName = user.getName();

    String firstLetter = "";

    if (userName != null && !userName.trim().isEmpty()) {
        firstLetter = userName.trim().substring(0, 1).toUpperCase();
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - Home</title>

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

        /* NAVBAR */

        .navbar {
            background: #16233f;
            color: white;
            padding: 14px 30px;
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

        .nav-right {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .nav-link:hover {
            color: #e8a33d;
        }

        /* PROFILE */

        .profile-container {
            position: relative;
        }

        .profile-button {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            border: none;
            background: #e8a33d;
            color: #16233f;
            font-size: 19px;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .profile-button:hover {
            background: white;
        }

        .profile-menu {
            display: none;
            position: absolute;
            right: 0;
            top: 52px;
            width: 190px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.18);
            overflow: hidden;
            z-index: 1000;
        }

        .profile-menu.show {
            display: block;
        }

        .profile-name {
            padding: 15px;
            font-weight: bold;
            color: #16233f;
            border-bottom: 1px solid #eeeeee;
        }

        .profile-menu a {
            display: block;
            padding: 13px 15px;
            text-decoration: none;
            color: #17233f;
            font-weight: 500;
        }

        .profile-menu a:hover {
            background: #f5f7fb;
            color: #e8a33d;
        }

        /* MAIN */

        .container {
            max-width: 1100px;
            margin: 45px auto;
            padding: 20px;
        }

        .welcome {
            background: white;
            padding: 35px;
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

        /* CARDS */

        .buttons {
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
            margin-top: 0;
            color: #16233f;
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

        /* MOBILE */

        @media (max-width: 700px) {

            .navbar {
                padding: 12px 15px;
            }

            .logo {
                font-size: 21px;
            }

            .nav-right {
                gap: 12px;
            }

            .nav-link {
                font-size: 14px;
            }

            .buttons {
                grid-template-columns: 1fr;
            }

            .container {
                margin: 25px auto;
                padding: 15px;
            }

            .welcome {
                padding: 25px;
            }

        }

    </style>

</head>

<body>

    <!-- NAVBAR -->

    <div class="navbar">

        <div class="logo">
            Sushmitha<span>Mart</span>
        </div>

        <div class="nav-right">

            <a class="nav-link" href="products.jsp">
                Products
            </a>

            <a class="nav-link" href="cart">
                Cart
            </a>

            <a class="nav-link" href="orders.jsp">
                Orders
            </a>

            <!-- PROFILE -->

            <div class="profile-container">

                <button
                    class="profile-button"
                    type="button"
                    onclick="toggleProfile()">

                    <%= firstLetter %>

                </button>

                <div
                    class="profile-menu"
                    id="profileMenu">

                    <div class="profile-name">
                        <%= userName %>
                    </div>

                    <a href="#">
                        Language
                    </a>

                    <a href="login.jsp">
                        Logout
                    </a>

                </div>

            </div>

        </div>

    </div>


    <!-- MAIN CONTENT -->

    <div class="container">

        <div class="welcome">

            <h1>
                Welcome to SushmithaMart
            </h1>

            <p>
                Hello, <strong><%= userName %></strong>
            </p>

            <p>
                Explore products, manage your cart and view your orders.
            </p>

        </div>


        <!-- NORMAL SHOPPING OPTIONS -->

        <div class="buttons">

            <div class="card">

                <h2>
                    Products
                </h2>

                <p>
                    Browse all available products.
                </p>

                <a href="products.jsp">
                    View Products
                </a>

            </div>


            <div class="card">

                <h2>
                    Cart
                </h2>

                <p>
                    View your shopping cart.
                </p>

                <a href="cart">
                    View Cart
                </a>

            </div>


            <div class="card">

                <h2>
                    Orders
                </h2>

                <p>
                    View your previous orders.
                </p>

                <a href="orders.jsp">
                    View Orders
                </a>

            </div>

        </div>

    </div>


    <script>

        function toggleProfile() {

            const menu = document.getElementById("profileMenu");

            menu.classList.toggle("show");
        }


        document.addEventListener("click", function(event) {

            const profileContainer =
                document.querySelector(".profile-container");

            const profileMenu =
                document.getElementById("profileMenu");

            if (!profileContainer.contains(event.target)) {

                profileMenu.classList.remove("show");

            }

        });

    </script>

</body>
</html>