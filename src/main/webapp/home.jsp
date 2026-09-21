<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - Online Marketplace</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f5f7fb;
            color: #16233f;
        }

        /* NAVBAR */
        .navbar {
            background: #16233f;
            color: white;
            padding: 16px 6%;
            display: flex;
            align-items: center;
            gap: 35px;
        }

        .logo {
            font-size: 27px;
            font-weight: bold;
            white-space: nowrap;
        }

        .logo span {
            color: #e8a33d;
        }

        .search {
            flex: 1;
            display: flex;
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }

        .search input {
            flex: 1;
            border: none;
            outline: none;
            padding: 13px 16px;
            font-size: 14px;
        }

        .search button {
            border: none;
            background: #e8a33d;
            color: #16233f;
            padding: 0 22px;
            font-weight: bold;
            cursor: pointer;
        }

        .login {
            color: white;
            text-decoration: none;
            font-weight: bold;
            white-space: nowrap;
        }

        .register {
            background: #e8a33d;
            color: #16233f;
            padding: 10px 18px;
            border-radius: 7px;
            text-decoration: none;
            font-weight: bold;
            white-space: nowrap;
        }

        /* CATEGORY BAR */
        .categories {
            background: white;
            padding: 15px 6%;
            display: flex;
            justify-content: center;
            gap: 35px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }

        .categories a {
            text-decoration: none;
            color: #16233f;
            font-size: 14px;
            font-weight: bold;
        }

        .categories a:hover {
            color: #e8a33d;
        }

        /* HERO */
        .hero {
            width: 88%;
            margin: 35px auto;
            min-height: 390px;
            border-radius: 22px;
            background: linear-gradient(120deg, #16233f, #263f70);
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 60px 7%;
            overflow: hidden;
        }

        .hero-content {
            max-width: 560px;
        }

        .hero h1 {
            font-size: 48px;
            line-height: 1.15;
            margin-bottom: 20px;
        }

        .hero h1 span {
            color: #e8a33d;
        }

        .hero p {
            color: #d9dfeb;
            font-size: 18px;
            line-height: 1.6;
            margin-bottom: 28px;
        }

        .shop-btn {
            display: inline-block;
            background: #e8a33d;
            color: #16233f;
            padding: 14px 28px;
            border-radius: 9px;
            text-decoration: none;
            font-weight: bold;
        }

        .shop-btn:hover {
            background: white;
        }

        .hero-icon {
            font-size: 130px;
            opacity: 0.9;
        }

        /* SECTION */
        .section {
            width: 88%;
            margin: 45px auto;
        }

        .section-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
        }

        .section-title h2 {
            font-size: 26px;
        }

        .section-title span {
            color: #68738a;
            font-size: 14px;
        }

        /* CATEGORY CARDS */
        .category-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
        }

        .category-card {
            background: white;
            padding: 28px 20px;
            border-radius: 14px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            transition: 0.2s;
        }

        .category-card:hover {
            transform: translateY(-5px);
        }

        .category-icon {
            font-size: 40px;
            margin-bottom: 12px;
        }

        .category-card h3 {
            font-size: 16px;
        }

        /* FEATURES */
        .features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .feature {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.06);
        }

        .feature h3 {
            margin-bottom: 10px;
        }

        .feature p {
            color: #68738a;
            font-size: 14px;
            line-height: 1.5;
        }

        /* FOOTER */
        footer {
            margin-top: 60px;
            background: #16233f;
            color: white;
            text-align: center;
            padding: 28px;
        }

        footer span {
            color: #e8a33d;
        }

        @media (max-width: 800px) {

            .navbar {
                flex-wrap: wrap;
                gap: 15px;
            }

            .search {
                order: 3;
                flex-basis: 100%;
            }

            .hero {
                text-align: center;
                justify-content: center;
            }

            .hero-icon {
                display: none;
            }

            .hero h1 {
                font-size: 36px;
            }

            .category-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .features {
                grid-template-columns: 1fr;
            }

            .categories {
                overflow-x: auto;
                justify-content: flex-start;
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

    <div class="search">
        <input type="text" placeholder="Search for products...">
        <button>Search</button>
    </div>

    <a href="login.jsp" class="login">
        Login
    </a>

    <a href="register.jsp" class="register">
        Sign Up
    </a>

</div>


<!-- CATEGORY BAR -->
<div class="categories">

    <a href="login.jsp">All Categories</a>
    <a href="login.jsp">Electronics</a>
    <a href="login.jsp">Fashion</a>
    <a href="login.jsp">Home & Kitchen</a>
    <a href="login.jsp">Accessories</a>
    <a href="login.jsp">Daily Essentials</a>

</div>


<!-- HERO -->
<section class="hero">

    <div class="hero-content">

        <h1>
            Everything You Need,
            <span>All in One Place.</span>
        </h1>

        <p>
            Welcome to SushmithaMart — your online neighbourhood marketplace
            for everyday products, electronics, fashion, home essentials and more.
        </p>

        <a href="login.jsp" class="shop-btn">
            Start Shopping →
        </a>

    </div>

    <div class="hero-icon">
        🛍️
    </div>

</section>


<!-- CATEGORIES -->
<section class="section">

    <div class="section-title">
        <h2>Shop by Category</h2>
        <span>Explore our marketplace</span>
    </div>

    <div class="category-grid">

        <div class="category-card">
            <div class="category-icon">📱</div>
            <h3>Electronics</h3>
        </div>

        <div class="category-card">
            <div class="category-icon">👕</div>
            <h3>Fashion</h3>
        </div>

        <div class="category-card">
            <div class="category-icon">🍳</div>
            <h3>Home & Kitchen</h3>
        </div>

        <div class="category-card">
            <div class="category-icon">🎒</div>
            <h3>Accessories</h3>
        </div>

    </div>

</section>


<!-- FEATURES -->
<section class="section">

    <div class="section-title">
        <h2>Why SushmithaMart?</h2>
    </div>

    <div class="features">

        <div class="feature">
            <h3>🛒 Easy Shopping</h3>
            <p>
                Browse products and discover everything you need
                from different sellers in one marketplace.
            </p>
        </div>

        <div class="feature">
            <h3>🏪 Multiple Sellers</h3>
            <p>
                Sellers can add and manage their own products
                through their seller dashboard.
            </p>
        </div>

        <div class="feature">
            <h3>🔐 Secure Accounts</h3>
            <p>
                Separate Buyer, Seller and Admin accounts
                provide organized access to the marketplace.
            </p>
        </div>

    </div>

</section>


<!-- FOOTER -->
<footer>
    © 2026 <span>SushmithaMart</span> — Shop Smart. Live Better.
</footer>

</body>
</html>