<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.sushmithamart.model.Product" %>
<%@ page import="com.sushmithamart.dao.ProductDAO" %>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

String contextPath = request.getContextPath();

ProductDAO productDAO = new ProductDAO();
List<Product> products = productDAO.getAllProducts();

String userName = "Login / Sign Up";

boolean buyerLoggedIn =
        session.getAttribute("user") != null;

String profileLetter = "";

if (buyerLoggedIn) {

    try {

        Object userObj =
                session.getAttribute("user");

        java.lang.reflect.Method m =
                userObj.getClass().getMethod("getName");

        Object nameObj =
                m.invoke(userObj);

        if (nameObj != null &&
            !nameObj.toString().trim().isEmpty()) {

            userName =
                    nameObj.toString().trim();

            profileLetter =
                    userName.substring(0, 1).toUpperCase();

        }

    } catch (Exception e) {

        userName = "My Account";
        profileLetter = "U";
    }
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>SushmithaMart - Shop • Save • Smile</title>

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, Helvetica, sans-serif;
    background: #f7f8fc;
    color: #222;
}

a {
    text-decoration: none;
    color: inherit;
}

button {
    font-family: inherit;
}

/* ================= HEADER ================= */

.top-header {
    background: #ffffff;
    border-bottom: 1px solid #eeeeee;
    position: sticky;
    top: 0;
    z-index: 1000;
}

.header-main {
    max-width: 1400px;
    margin: auto;
    min-height: 78px;
    padding: 12px 25px;
    display: flex;
    align-items: center;
    gap: 25px;
}

.brand-area {
    display: flex;
    align-items: center;
    gap: 10px;
    min-width: 220px;
}

.brand-s-logo {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    background: linear-gradient(135deg, #ff4d6d, #7b2ff7);
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    font-weight: bold;
}

.brand-name {
    font-size: 22px;
    font-weight: 800;
    color: #222;
}

.brand-tagline {
    font-size: 9px;
    color: #777;
    letter-spacing: 1.5px;
    margin-top: 2px;
}

.search-area {
    flex: 1;
    display: flex;
    max-width: 650px;
}

.search-area input {
    flex: 1;
    height: 43px;
    border: 1px solid #ddd;
    border-right: 0;
    border-radius: 8px 0 0 8px;
    padding: 0 15px;
    outline: none;
}

.search-area button {
    width: 50px;
    border: 0;
    border-radius: 0 8px 8px 0;
    background: #6c3df4;
    color: white;
    cursor: pointer;
}

.header-actions {
    display: flex;
    align-items: center;
    gap: 18px;
}

.header-action {
    position: relative;
    display: flex;
    align-items: center;
    gap: 7px;
    cursor: pointer;
    color: #333;
    font-size: 14px;
}

.header-action i {
    font-size: 18px;
}

.header-action:hover {
    color: #6c3df4;
}

.cart-count {
    position: absolute;
    top: -12px;
    left: 11px;
    min-width: 17px;
    height: 17px;
    border-radius: 50%;
    background: #ff3b30;
    color: white;
    font-size: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0 4px;
}

/* ================= PROFILE ================= */

.profile-wrapper {
    position: relative;
}

.profile-button {
    display: flex;
    align-items: center;
    gap: 8px;
    border: 0;
    background: transparent;
    cursor: pointer;
}

.profile-circle {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    background: #6c3df4;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
}

.profile-name {
    max-width: 100px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.profile-menu {
    position: absolute;
    right: 0;
    top: 48px;
    width: 190px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 8px 30px rgba(0,0,0,.15);
    padding: 8px;
    display: none;
    z-index: 2000;
}

.profile-menu.show {
    display: block;
}

.profile-menu-item {
    width: 100%;
    padding: 11px 12px;
    border-radius: 7px;
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;
    color: #333;
}

.profile-menu-item:hover {
    background: #f4f1ff;
    color: #6c3df4;
}

.language-box {
    position: relative;
}

.language-list {
    display: none;
    margin-top: 5px;
    margin-left: 5px;
    border-top: 1px solid #eee;
    padding-top: 5px;
}

.language-list.show {
    display: block;
}

.language-option {
    padding: 8px 10px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
}

.language-option:hover {
    background: #f3f0ff;
}

/* ================= NAVIGATION ================= */

.main-nav {
    border-top: 1px solid #f1f1f1;
    background: white;
}

.nav-inner {
    max-width: 1400px;
    margin: auto;
    padding: 0 25px;
    display: flex;
    align-items: center;
    gap: 28px;
    min-height: 48px;
    overflow-x: auto;
}

.nav-link {
    white-space: nowrap;
    font-size: 14px;
    color: #444;
    cursor: pointer;
}

.nav-link:hover,
.nav-link.active {
    color: #6c3df4;
}

/* ================= HERO ================= */

.hero {
    max-width: 1400px;
    margin: 25px auto;
    padding: 55px 45px;
    border-radius: 18px;
    background: linear-gradient(135deg, #eee7ff, #ffffff);
    display: flex;
    align-items: center;
    justify-content: space-between;
    overflow: hidden;
}

.hero-content h1 {
    margin: 0 0 10px;
    font-size: 45px;
    color: #29213f;
}

.hero-content h1 span {
    color: #6c3df4;
}

.hero-content p {
    font-size: 17px;
    color: #666;
    line-height: 1.6;
}

.hero-content p span {
    color: #777;
}

.shop-btn {
    margin-top: 15px;
    display: inline-flex;
    align-items: center;
    gap: 9px;
    background: #6c3df4;
    color: white;
    padding: 13px 22px;
    border-radius: 8px;
    font-weight: bold;
}

.hero-visual {
    width: 300px;
    height: 220px;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
}

.big-cart {
    font-size: 120px;
    color: #6c3df4;
}

.bag-s {
    position: absolute;
    right: 20px;
    bottom: 25px;
    width: 65px;
    height: 65px;
    background: #ff4d6d;
    color: white;
    border-radius: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 32px;
    font-weight: bold;
}

/* ================= PROMO ================= */

.promo-section {
    max-width: 1400px;
    margin: 25px auto;
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
}

.promo-card {
    background: white;
    border-radius: 14px;
    padding: 25px;
    position: relative;
    border: 1px solid #eee;
    overflow: hidden;
}

.promo-card h3 {
    margin: 0 0 7px;
}

.promo-card p {
    color: #777;
}

.promo-card a {
    color: #6c3df4;
    font-weight: bold;
}

.promo-icon {
    position: absolute;
    right: 30px;
    bottom: 20px;
    font-size: 55px;
    color: #ddd;
}

/* ================= CATEGORIES ================= */

.section {
    max-width: 1400px;
    margin: 35px auto;
    padding: 0 5px;
}

.category-grid {
    display: grid;
    grid-template-columns: repeat(8, 1fr);
    gap: 15px;
}

.category-card {
    background: white;
    border-radius: 12px;
    padding: 17px 8px;
    text-align: center;
    border: 1px solid #eee;
    cursor: pointer;
}

.category-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0,0,0,.08);
}

.category-icon {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    margin: auto;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
}

.cat-blue {
    background: #e8f1ff;
    color: #2878ff;
}

.cat-pink {
    background: #ffe9f0;
    color: #ff4d88;
}

.cat-green {
    background: #e8f8ee;
    color: #24a148;
}

.cat-purple {
    background: #f0eaff;
    color: #7b2ff7;
}

.cat-orange {
    background: #fff0df;
    color: #f28c28;
}

.cat-cyan {
    background: #e6fbff;
    color: #00a5c8;
}

.category-name {
    margin-top: 10px;
    font-size: 13px;
}

/* ================= PRODUCTS ================= */

.products-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 18px;
}

.products-header h2 {
    margin: 0;
}

.filter-button {
    border: 1px solid #ddd;
    background: white;
    border-radius: 8px;
    padding: 10px 14px;
    cursor: pointer;
}

.filter-button:hover {
    border-color: #6c3df4;
    color: #6c3df4;
}

.filter-icon {
    width: 17px;
    height: 17px;
    display: inline-block;
    vertical-align: middle;
    margin-right: 5px;
}

.filter-panel {
    display: none;
    background: white;
    border: 1px solid #eee;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 20px;
}

.filter-panel.show {
    display: block;
}

.filter-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}

.filter-group label {
    display: block;
    font-weight: bold;
    margin-bottom: 7px;
}

.filter-group select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 7px;
    background: white;
}

.clear-filter {
    margin-top: 18px;
    border: 0;
    background: #eee;
    padding: 10px 16px;
    border-radius: 7px;
    cursor: pointer;
}

.view-all {
    color: #6c3df4;
    font-weight: bold;
}

.product-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 18px;
}

.product-card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    border: 1px solid #eee;
    transition: .2s;
}

.product-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0,0,0,.08);
}

.product-image-wrap {
    width: 100%;
    height: 190px;
    background: #f6f6f6;
    overflow: hidden;
}

.product-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.product-info {
    padding: 15px;
}

.product-name {
    font-weight: bold;
    min-height: 40px;
}

.product-category {
    font-size: 12px;
    color: #888;
    margin: 7px 0;
}

.product-price {
    font-size: 18px;
    font-weight: bold;
    color: #6c3df4;
    margin-bottom: 12px;
}

.add-cart-btn {
    width: 100%;
    border: 0;
    background: #6c3df4;
    color: white;
    padding: 10px;
    border-radius: 7px;
    cursor: pointer;
    font-weight: bold;
}

.add-cart-btn:hover {
    background: #5729d4;
}

.add-cart-btn:disabled {
    opacity: .7;
    cursor: wait;
}

/* ================= FEATURES ================= */

.features {
    max-width: 1400px;
    margin: 45px auto;
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
}

.feature-card {
    background: white;
    border: 1px solid #eee;
    border-radius: 12px;
    padding: 25px;
    text-align: center;
}

.feature-card > i {
    font-size: 28px;
    color: #6c3df4;
}

.feature-card h4 {
    margin-bottom: 5px;
}

.feature-card p {
    color: #777;
    font-size: 13px;
}

/* ================= FOOTER ================= */

footer {
    background: #201a30;
    color: white;
    padding: 45px 25px 20px;
    margin-top: 50px;
}

.footer-grid {
    max-width: 1400px;
    margin: auto;
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1fr;
    gap: 40px;
}

.footer-brand h2 {
    margin-top: 0;
}

.footer-brand p {
    color: #bbb;
    line-height: 1.7;
}

.footer-column h3 {
    margin-top: 0;
}

.footer-column a {
    display: block;
    color: #bbb;
    margin: 10px 0;
    font-size: 14px;
}

.footer-column a:hover {
    color: white;
}

.footer-contact {
    color: #bbb;
    margin: 10px 0;
    font-size: 14px;
}

.copyright {
    max-width: 1400px;
    margin: 30px auto 0;
    padding-top: 20px;
    border-top: 1px solid #3b354a;
    color: #aaa;
    text-align: center;
}

/* ================= RESPONSIVE ================= */

@media (max-width: 1100px) {

    .product-grid {
        grid-template-columns: repeat(4, 1fr);
    }

    .category-grid {
        grid-template-columns: repeat(4, 1fr);
    }

    .features {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 800px) {

    .header-main {
        flex-wrap: wrap;
    }

    .brand-area {
        min-width: auto;
    }

    .search-area {
        order: 3;
        flex-basis: 100%;
        max-width: none;
    }

    .header-actions {
        margin-left: auto;
    }

    .hero {
        padding: 35px 25px;
    }

    .hero-content h1 {
        font-size: 34px;
    }

    .hero-visual {
        display: none;
    }

    .promo-section {
        grid-template-columns: 1fr;
    }

    .product-grid {
        grid-template-columns: repeat(2, 1fr);
    }

    .filter-grid {
        grid-template-columns: 1fr;
    }

    .footer-grid {
        grid-template-columns: 1fr 1fr;
    }
}

@media (max-width: 550px) {

    .header-actions {
        gap: 10px;
    }

    .header-action span {
        display: none;
    }

    .profile-name {
        display: none;
    }

    .category-grid {
        grid-template-columns: repeat(2, 1fr);
    }

    .features {
        grid-template-columns: 1fr;
    }

    .footer-grid {
        grid-template-columns: 1fr;
    }

    .product-grid {
        grid-template-columns: 1fr 1fr;
        gap: 10px;
    }

    .product-image-wrap {
        height: 150px;
    }
}

</style>

</head>

<body>

<!-- ================= HEADER ================= -->

<header class="top-header">

    <div class="header-main">

        <a href="<%= contextPath %>/home.jsp"
           class="brand-area">

            <div class="brand-s-logo">
                S
            </div>

            <div>

                <div class="brand-name">
                    SushmithaMart
                </div>

                <div class="brand-tagline">
                    RETAIL &amp; E-COMMERCE
                </div>

            </div>

        </a>


        <form class="search-area"
              method="get"
              action="<%= contextPath %>/products.jsp">

            <input
                type="text"
                name="search"
                placeholder="Search for products, brands and more...">

            <button type="submit">

                <i class="fa-solid fa-magnifying-glass"></i>

            </button>

        </form>


        <div class="header-actions">

<%
if (buyerLoggedIn) {
%>

            <!-- PROFILE -->

            <div class="profile-wrapper">

                <button
                    type="button"
                    class="profile-button"
                    onclick="toggleProfileMenu()">

                    <div class="profile-circle">
                        <%= profileLetter %>
                    </div>

                    <span class="profile-name">
                        <%= userName %>
                    </span>

                    <i class="fa-solid fa-chevron-down"></i>

                </button>


                <div
                    id="profileMenu"
                    class="profile-menu">

                    <!-- LANGUAGE -->

                    <div class="language-box">

                        <div
                            class="profile-menu-item"
                            onclick="toggleLanguage()">

                            <i class="fa-solid fa-language"></i>

                            <span>
                                Language
                            </span>

                            <span style="margin-left:auto;">
                                ›
                            </span>

                        </div>


                        <div
                            id="languageList"
                            class="language-list">

                            <div
                                class="language-option"
                                onclick="selectLanguage('English')">

                                English

                            </div>


                            <div
                                class="language-option"
                                onclick="selectLanguage('Tamil')">

                                தமிழ்

                            </div>

                        </div>

                    </div>


                    <!-- LOGOUT -->

                    <div
                        class="profile-menu-item"
                        onclick="confirmLogout()">

                        <i class="fa-solid fa-right-from-bracket"></i>

                        <span>
                            Logout
                        </span>

                    </div>

                </div>

            </div>

<%
} else {
%>

            <!-- LOGIN -->

            <a
                href="<%= contextPath %>/login.jsp"
                class="header-action">

                <i class="fa-regular fa-user"></i>

                <span>
                    Login / Sign Up
                </span>

            </a>

<%
}
%>


            <!-- CART -->

            <a
                href="<%= contextPath %>/cart"
                class="header-action">

                <i class="fa-solid fa-cart-shopping"></i>

                <span>
                    Cart
                </span>

            </a>


            <!-- ORDERS -->

            <a
                href="<%= contextPath %>/orders.jsp"
                class="header-action">

                <i class="fa-regular fa-clipboard"></i>

                <span>
                    Orders
                </span>

            </a>

        </div>

    </div>


    <!-- NAVIGATION -->

    <nav class="main-nav">

        <div class="nav-inner">

            <a
                class="nav-link active"
                href="<%= contextPath %>/home.jsp">

                <i class="fa-solid fa-house"></i>
                Home

            </a>


            <a
                class="nav-link"
                href="<%= contextPath %>/products.jsp">

                All Products

            </a>


            <a
                class="nav-link"
                href="<%= contextPath %>/products.jsp?category=Electronics">

                Electronics
                <i class="fa-solid fa-chevron-down"></i>

            </a>


            <a
                class="nav-link"
                href="<%= contextPath %>/products.jsp?category=Fashion">

                Fashion
                <i class="fa-solid fa-chevron-down"></i>

            </a>


            <a
                class="nav-link"
                href="<%= contextPath %>/products.jsp?category=Home%20%26%20Living">

                Home &amp; Living
                <i class="fa-solid fa-chevron-down"></i>

            </a>


            <a
                class="nav-link"
                href="<%= contextPath %>/products.jsp?category=Beauty">

                Beauty
                <i class="fa-solid fa-chevron-down"></i>

            </a>


            <a
                class="nav-link"
                href="<%= contextPath %>/products.jsp?category=Sports">

                Sports
                <i class="fa-solid fa-chevron-down"></i>

            </a>


            <a
                class="nav-link"
                href="<%= contextPath %>/products.jsp?category=Books">

                Books
                <i class="fa-solid fa-chevron-down"></i>

            </a>


            <a
                class="nav-link"
                href="<%= contextPath %>/products.jsp?category=Accessories">

                Accessories
                <i class="fa-solid fa-chevron-down"></i>

            </a>

        </div>

    </nav>

</header>


<!-- ================= HERO ================= -->

<section class="hero">

    <div class="hero-content">

        <h1>
            Welcome to
            <br>
            <span>SushmithaMart</span>
        </h1>

        <p>
            Shop
            <span>•</span>
            Save
            <span>•</span>
            Smile
        </p>

        <p>
            Your one-stop destination for
            <br>
            <strong>
                the best products &amp; amazing deals!
            </strong>
        </p>

        <a
            href="<%= contextPath %>/products.jsp"
            class="shop-btn">

            Shop Now

            <i class="fa-solid fa-arrow-right"></i>

        </a>

    </div>


    <div class="hero-visual">

        <i class="fa-solid fa-cart-shopping big-cart"></i>

        <div class="bag-s">
            <span>S</span>
        </div>

    </div>

</section>


<!-- ================= PROMO ================= -->

<section class="promo-section">

    <div class="promo-card">

        <h3>
            Big Deals
        </h3>

        <p>
            Up to 50% OFF
        </p>

        <a href="<%= contextPath %>/products.jsp">

            Shop Now
            <i class="fa-solid fa-arrow-right"></i>

        </a>

        <i class="fa-solid fa-headphones promo-icon"></i>

    </div>


    <div class="promo-card">

        <h3>
            Special Offers
        </h3>

        <p>
            Best Prices
        </p>

        <a href="<%= contextPath %>/products.jsp">

            Shop Now
            <i class="fa-solid fa-arrow-right"></i>

        </a>

        <i class="fa-solid fa-bag-shopping promo-icon"></i>

    </div>

</section>


<!-- ================= CATEGORIES ================= -->

<section class="section">

    <div class="category-grid">

        <a
            href="<%= contextPath %>/products.jsp?category=Electronics"
            class="category-card">

            <div class="category-icon cat-blue">
                <i class="fa-solid fa-mobile-screen"></i>
            </div>

            <div class="category-name">
                Electronics
            </div>

        </a>


        <a
            href="<%= contextPath %>/products.jsp?category=Fashion"
            class="category-card">

            <div class="category-icon cat-pink">
                <i class="fa-solid fa-shirt"></i>
            </div>

            <div class="category-name">
                Fashion
            </div>

        </a>


        <a
            href="<%= contextPath %>/products.jsp?category=Home%20%26%20Living"
            class="category-card">

            <div class="category-icon cat-green">
                <i class="fa-solid fa-couch"></i>
            </div>

            <div class="category-name">
                Home &amp; Living
            </div>

        </a>


        <a
            href="<%= contextPath %>/products.jsp?category=Beauty"
            class="category-card">

            <div class="category-icon cat-purple">
                <i class="fa-solid fa-wand-magic-sparkles"></i>
            </div>

            <div class="category-name">
                Beauty
            </div>

        </a>


        <a
            href="<%= contextPath %>/products.jsp?category=Sports"
            class="category-card">

            <div class="category-icon cat-orange">
                <i class="fa-solid fa-basketball"></i>
            </div>

            <div class="category-name">
                Sports
            </div>

        </a>


        <a
            href="<%= contextPath %>/products.jsp?category=Books"
            class="category-card">

            <div class="category-icon cat-cyan">
                <i class="fa-solid fa-book-open"></i>
            </div>

            <div class="category-name">
                Books
            </div>

        </a>


        <a
            href="<%= contextPath %>/products.jsp?category=Accessories"
            class="category-card">

            <div class="category-icon cat-blue">
                <i class="fa-solid fa-bag-shopping"></i>
            </div>

            <div class="category-name">
                Accessories
            </div>

        </a>


        <a
            href="<%= contextPath %>/products.jsp"
            class="category-card">

            <div class="category-icon cat-pink">
                <i class="fa-solid fa-border-all"></i>
            </div>

            <div class="category-name">
                All Products
            </div>

        </a>

    </div>

</section>


<!-- ================= PRODUCTS ================= -->

<section class="section">

    <div class="products-header">

        <h2>
            Latest Products
        </h2>

        <div>

            <button
                type="button"
                class="filter-button"
                onclick="toggleFilter()">

                <svg
                    class="filter-icon"
                    viewBox="0 0 24 24"
                    aria-hidden="true">

                    <path
                        d="M3 5h18l-7 8v5l-4 2v-7L3 5z"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linejoin="round"/>

                </svg>

                Filter

            </button>

        </div>

    </div>


    <!-- FILTER -->

    <div
        id="filterPanel"
        class="filter-panel">

        <h3>
            Filter Products
        </h3>


        <div class="filter-grid">

            <div class="filter-group">

                <label>
                    Category
                </label>

                <select id="categoryFilter">

                    <option value="all">
                        All Categories
                    </option>

                    <option value="Electronics">
                        Electronics
                    </option>

                    <option value="Fashion">
                        Fashion
                    </option>

                    <option value="Home & Living">
                        Home &amp; Living
                    </option>

                    <option value="Beauty">
                        Beauty
                    </option>

                    <option value="Sports">
                        Sports
                    </option>

                    <option value="Books">
                        Books
                    </option>

                    <option value="Accessories">
                        Accessories
                    </option>

                </select>

            </div>


            <div class="filter-group">

                <label>
                    Price
                </label>

                <select id="priceFilter">

                    <option value="all">
                        All Prices
                    </option>

                    <option value="under500">
                        Under &#8377;500
                    </option>

                    <option value="500to1000">
                        &#8377;500 - &#8377;1,000
                    </option>

                    <option value="1000to2000">
                        &#8377;1,000 - &#8377;2,000
                    </option>

                    <option value="above2000">
                        Above &#8377;2,000
                    </option>

                </select>

            </div>


            <div class="filter-group">

                <label>
                    Sort By
                </label>

                <select id="sortFilter">

                    <option value="default">
                        Recommended
                    </option>

                    <option value="low">
                        Price: Low to High
                    </option>

                    <option value="high">
                        Price: High to Low
                    </option>

                    <option value="name">
                        Name: A to Z
                    </option>

                </select>

            </div>

        </div>


        <button
            type="button"
            class="clear-filter"
            onclick="clearFilters()">

            Clear Filter

        </button>

    </div>


    <div
        style="display:flex;justify-content:flex-end;margin-bottom:15px;">

        <a
            href="<%= contextPath %>/products.jsp"
            class="view-all">

            View All

            <i class="fa-solid fa-arrow-right"></i>

        </a>

    </div>


    <!-- PRODUCT GRID -->

    <div
        id="productGrid"
        class="product-grid">

<%
int count = 0;

if (products != null) {

    for (Product p : products) {

        if (count >= 10) {
            break;
        }

        count++;

        String name =
                p.getName() == null
                ? ""
                : p.getName();

        String lowerName =
                name.toLowerCase();

        String category =
                p.getCategory() == null
                ? "Products"
                : p.getCategory();

        String image =
                p.getImage() == null
                ? ""
                : p.getImage();

        String encodedImage =
                URLEncoder.encode(
                    image,
                    "UTF-8"
                );

        String productImage =
                contextPath
                + "/images/default-product.jpg";


        if (!image.trim().isEmpty()) {

            if (
                image.startsWith("http://")
                ||
                image.startsWith("https://")
            ) {

                productImage = image;

            } else {

                productImage =
                    contextPath
                    + "/product-image?file="
                    + encodedImage;
            }
        }


        String mappedImage = null;


        /* ================= ELECTRONICS ================= */

        if (lowerName.contains("bluetooth speaker")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-19-0daac560-e198-4678-917c-87428ff62501.jpg";

        } else if (lowerName.contains("laptop bag")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-19-8e8fb42b-8a9d-4361-9619-ef6027b75bae.jpg";

        } else if (lowerName.contains("mouse")) {

            mappedImage =
                "https://images.unsplash.com/photo-1527814050087-3793815479db?auto=format&fit=crop&w=600&q=80";

        } else if (lowerName.contains("mobile phone stand")) {

            mappedImage =
                "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mobile%20holder.jpg";

        } else if (
            lowerName.contains("camera")
            ||
            lowerName.contains("web camera")
        ) {

            mappedImage =
                "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=600&q=80";

        } else if (lowerName.contains("power bank")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-19-624af99a-c4ed-48fd-b9f4-780fdd1ee4bc.jpg";

        } else if (lowerName.contains("aux cable")) {

            mappedImage =
                "https://cdn.miswag.me/images/images/a1167503-5fcb-4b76-86e8-e71a5024b994.jpg";

        } else if (lowerName.contains("adapter")) {

            mappedImage =
                "https://cdn.phototourl.com/free/2026-09-20-51d857fc-a89e-4684-bf44-3f41b80d3b04.jpg";

        } else if (lowerName.contains("microphone")) {

            mappedImage =
                "https://images.unsplash.com/photo-1590602847861-f357a9332bbc?auto=format&fit=crop&w=600&q=80";

        } else if (lowerName.contains("mini tripod")) {

            mappedImage =
                "https://spiritofa.shop/cdn/shop/files/305670669803.jpg?v=1777312879";

        } else if (lowerName.contains("phone holder")) {

            mappedImage =
                "https://commons.wikimedia.org/wiki/Special:Redirect/file/A_phone_holder.jpg";

        } else if (lowerName.contains("smart watch")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-19-26c44986-ed44-4601-9217-94283d09caeb.jpg";

        } else if (lowerName.contains("usb c hub")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-adeea089-eec9-46fc-a26f-d6a69b9b2f13.jpg";


        /* ================= STATIONERY ================= */

        } else if (lowerName.contains("gel pen")) {

            mappedImage =
                "https://images-r.meesho.com/images/products/1042063930/rpwp8_512.webp";

        } else if (
            lowerName.contains("sketch pen")
            ||
            lowerName.contains("sketch pens")
        ) {

            mappedImage =
                "https://images.unsplash.com/photo-1517842645767-c639042777db?auto=format&fit=crop&w=700&q=80";

        } else if (lowerName.contains("wooden pencil")) {

            mappedImage =
                "https://upload.wikimedia.org/wikipedia/commons/5/54/Yellow_HB_pencils.jpg";

        } else if (lowerName.contains("small notes")) {

            mappedImage =
                "https://cdn.phototourl.com/free/2026-09-20-09355d7d-ba3d-41be-8124-af4badee1ced.jpg";

        } else if (lowerName.contains("paper clip")) {

            mappedImage =
                "https://cdn.phototourl.com/free/2026-09-20-a9b790aa-7d3b-4dad-851c-e1657b64a312.jpg";

        } else if (lowerName.contains("highlighter set")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-0a8650ec-5815-424e-90c8-b52b3048742b.jpg";

        } else if (lowerName.contains("kids pen set")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-e35f6240-4be0-490d-95fb-6f512a345d91.jpg";

        } else if (lowerName.contains("book stand")) {

            mappedImage =
                "https://www.highfashionhome.com/cdn/shop/files/STAND-BOOK-3030-Book-WEB.jpg?v=1749508618";

        } else if (lowerName.contains("spiral notes")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-08e59419-bb92-46e6-a774-4b284c8543ce.jpg";

        } else if (lowerName.contains("cello tape")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-cfb45126-202d-4383-92d1-c17f35a476fa.jpg";


        /* ================= HOME ================= */

        } else if (lowerName.contains("study table")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-d7072f6e-d500-472f-a0b3-80a3218e3579.jpg";

        } else if (lowerName.contains("study light")) {

            mappedImage =
                "https://cdn.phototourl.com/free/2026-09-20-2797d369-c2f5-48f1-8bf6-0dbab5c975d8.jpg";

        } else if (lowerName.contains("pen stand")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-31f41dc2-6432-457f-9371-f6559e88e926.jpg";

        } else if (
            lowerName.contains("lighter")
            ||
            lowerName.contains("gas lighter")
            ||
            lowerName.contains("kitchen lighter")
        ) {

            mappedImage =
                "https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=700&q=80";

        } else if (lowerName.contains("coffee cup")) {

            mappedImage =
                "https://upload.wikimedia.org/wikipedia/commons/e/e8/Coffee_cup_%281%29.jpg";

        } else if (lowerName.contains("electric kettle")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-19-3aba405d-d888-4e62-965b-3cd2ffe92b47.jpg";

        } else if (lowerName.contains("vegetable peeler")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-145aaa8f-d460-457d-8cbf-b57b55288ce1.jpg";

        } else if (lowerName.contains("vegetable cutter")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-d860372f-0c94-46af-8390-f0ffe8664d43.jpg";

        } else if (lowerName.contains("vegetable chopper")) {

            mappedImage =
                "https://commons.wikimedia.org/wiki/Special:Redirect/file/Zyliss%20vegetable%20chopper.jpg";

        } else if (lowerName.contains("kitchen tongs")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-839506ab-4530-4ed9-865d-709b92bb9ab1.jpg";

        } else if (lowerName.contains("kitchen measuring cup")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-99dac625-22f6-432b-bb5c-1592a7e4f685.jpg";

        } else if (lowerName.contains("grocery container")) {

            mappedImage =
                "https://cdn.phototourl.com/free/2026-09-20-16251955-abbc-4635-929c-04be4cde1024.jpg";

        } else if (lowerName.contains("kitchen drawer")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-79ce58a8-c8a6-4286-a819-28d5009844b6.jpg";

        } else if (lowerName.contains("cooking apron")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-9b06e3e7-6b4e-4789-a001-7241509411b2.jpg";

        } else if (lowerName.contains("stapler")) {

            mappedImage =
                "https://cdn.phototourl.com/free/2026-09-20-3798cc10-9af1-45cf-91a4-07fbcbed80f2.jpg";

        } else if (lowerName.contains("shoe stand")) {

            mappedImage =
                "https://cdn.phototourl.com/free/2026-09-20-898e265b-de79-4bc4-b06b-0e99730b184f.jpg";

        } else if (lowerName.contains("slipper")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-19-2dff9701-ca5d-4842-b8d6-1ffe88a86d9d.jpg";

        } else if (lowerName.contains("keychain stand")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-d4d41241-ed56-412a-a710-1b8a30eb2a6a.jpg";

        } else if (lowerName.contains("keychain light")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-1eacd727-bb79-40fb-afd5-0634332290ce.jpg";

        } else if (lowerName.contains("motion sensor led light")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-5551bd85-947f-4b61-a6fe-6e38fa5506ec.jpg";

        } else if (lowerName.contains("night led light")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-d3ec29a0-1132-4564-8214-3412bea27b41.jpg";

        } else if (lowerName.contains("door stopper")) {

            mappedImage =
                "https://cdn.phototourl.com/free/2026-09-20-7253be25-0f66-46ce-a698-26b4816756a9.jpg";

        } else if (lowerName.contains("comb set")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-f5860e8a-c126-4a25-ac56-4cc928bc7f32.jpg";

        } else if (lowerName.contains("sunglasses case")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-21-25f19c2f-7fe1-436a-9e21-f185ce7d7c4e.jpg";

        } else if (lowerName.contains("measuring tape")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-e94fd966-f2f7-4e09-87a8-062d4b2f9c1a.jpg";

        } else if (lowerName.contains("face towel")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-4482557f-4aca-4b12-858e-6114edbea68c.jpg";

        } else if (lowerName.contains("stainless steel bottle")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-21-5ec92f20-c87c-41b2-a754-9619bf2d1592.jpg";

        } else if (lowerName.contains("joystick")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-21-1e6ff225-aa02-4d3a-a375-af475144329f.jpg";

        } else if (lowerName.contains("clock")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-21-11bbd51d-847a-4e41-bfcc-eea4d9960a61.jpg";

        } else if (lowerName.contains("leather wallet")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-21-f822023a-b20e-47dc-afa6-2104ab6b9c78.jpg";

        } else if (lowerName.contains("passport holder")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-9b97429c-7f54-4fdd-bfaf-92dc89e02ddd.jpg";

        } else if (lowerName.contains("stick glue")) {

            mappedImage =
                "https://asset.sastasundar.com/incom/images/product/Fevi-Stik-The-Original-Glue-Stick-1623752009-10087412-1.jpg";

        } else if (lowerName.contains("umbrella")) {

            mappedImage =
                "https://cdn.shopify.com/s/files/1/0908/4003/9706/files/g1900027-bk-sku.jpg";

        } else if (lowerName.contains("travel pillow")) {

            mappedImage =
                "https://commons.wikimedia.org/wiki/Special:Redirect/file/Travel_Pillow.jpg";

        } else if (lowerName.contains("laundry bag")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-adb4f99f-a1ff-4f3b-a395-bc05a893b3f2.jpg";

        } else if (lowerName.contains("cosmetic pouch")) {

            mappedImage =
                "https://cdn.phototourl.com/free/2026-09-20-ea92da2d-ff41-492e-9e5f-b99903c11c2c.jpg";

        } else if (lowerName.contains("cosmetic drawer")) {

            mappedImage =
                "https://cdn.phototourl.com/member/2026-09-20-af13906e-5341-4211-9670-c13728de2e1a.jpg";
        }


        if (
            image.trim().isEmpty()
            &&
            mappedImage != null
        ) {

            productImage =
                    mappedImage;
        }


        String fallback =
                mappedImage != null
                ? mappedImage
                : contextPath
                    + "/images/default-product.jpg";

%>

        <div
            class="product-card"
            data-name="<%= name.toLowerCase() %>"
            data-category="<%= category %>"
            data-price="<%= p.getPrice() %>">

            <div class="product-image-wrap">

                <img
                    src="<%= productImage %>"
                    alt="<%= name %>"
                    class="product-image"
                    data-fallback="<%= fallback %>"
                    data-fallback-used="false"
                    onerror="handleProductImageError(this);">

            </div>


            <div class="product-info">

                <div class="product-name">
                    <%= name %>
                </div>

                <div class="product-category">
                    <%= category %>
                </div>

                <div class="product-price">

                    &#8377;<%= String.format(
                        "%.0f",
                        p.getPrice()
                    ) %>

                </div>


                <button
                    class="add-cart-btn"
                    type="button"
                    onclick="addToCart('<%= p.getId() %>', this)">

                    <i class="fa-solid fa-cart-shopping"></i>

                    &nbsp;

                    Add to Cart

                </button>

            </div>

        </div>

<%
    }
}
%>

    </div>

</section>


<!-- ================= FEATURES ================= -->

<section class="features">

    <div class="feature-card">

        <i class="fa-solid fa-truck-fast"></i>

        <h4>
            Fast Delivery
        </h4>

        <p>
            Quick &amp; Reliable Delivery
        </p>

    </div>


    <div class="feature-card">

        <i class="fa-solid fa-shield-halved"></i>

        <h4>
            Secure Payment
        </h4>

        <p>
            100% Secure Transactions
        </p>

    </div>


    <div class="feature-card">

        <i class="fa-solid fa-headset"></i>

        <h4>
            24/7 Support
        </h4>

        <p>
            We're Always Here
        </p>

    </div>


    <div class="feature-card">

        <i class="fa-solid fa-star"></i>

        <h4>
            Quality Products
        </h4>

        <p>
            Trusted Products
        </p>

    </div>

</section>


<!-- ================= FOOTER ================= -->

<footer>

    <div class="footer-grid">

        <div class="footer-brand">

            <h2>
                SushmithaMart
            </h2>

            <p>
                Your trusted destination for
                quality products, great prices
                and a better shopping experience.

                <br><br>

                Shop • Save • Smile
            </p>

        </div>


        <div class="footer-column">

            <h3>
                Quick Links
            </h3>

            <a href="<%= contextPath %>/home.jsp">
                Home
            </a>

            <a href="<%= contextPath %>/products.jsp">
                All Products
            </a>

            <a href="<%= contextPath %>/cart">
                Cart
            </a>

        </div>


        <div class="footer-column">

            <h3>
                Customer Service
            </h3>

            <a href="#">
                Help Center
            </a>

            <a href="#">
                Shipping
            </a>

            <a href="#">
                Returns
            </a>

            <a href="#">
                Contact Us
            </a>

        </div>


        <div class="footer-column">

            <h3>
                Get In Touch
            </h3>

            <div class="footer-contact">
                support@sushmithamart.com
            </div>

            <div class="footer-contact">
                Customer Support
            </div>

            <div class="footer-contact">
                Instagram
            </div>

            <div class="footer-contact">
                Facebook
            </div>

        </div>

    </div>


    <div class="copyright">

        © 2026 SushmithaMart.
        All Rights Reserved.

        <br>

        Shop • Save • Smile

    </div>

</footer>


<!-- ================= JAVASCRIPT ================= -->

<script>

/* =====================================================
   PROFILE MENU
===================================================== */

function toggleProfileMenu() {

    var menu =
        document.getElementById("profileMenu");

    if (!menu) {
        return;
    }

    menu.classList.toggle("show");
}


/* =====================================================
   LANGUAGE
===================================================== */

function toggleLanguage() {

    var languageList =
        document.getElementById("languageList");

    if (!languageList) {
        return;
    }

    languageList.classList.toggle("show");
}


function selectLanguage(language) {

    var languageList =
        document.getElementById("languageList");

    if (languageList) {
        languageList.classList.remove("show");
    }

    if (language === "Tamil") {

        alert("தமிழ் மொழி தேர்வு செய்யப்பட்டது");

    } else {

        alert("English language selected");
    }
}


/* =====================================================
   LOGOUT
===================================================== */

function confirmLogout() {

    var result =
        confirm("Are you sure you want to logout?");

    if (!result) {
        return;
    }

    window.location.href =
        "<%= contextPath %>/logout";
}


/* =====================================================
   ADD TO CART
   IMPORTANT:
   CartServlet mapping = /cart
   CartServlet add operation = POST
===================================================== */

function addToCart(productId, button) {

    if (!productId) {

        alert("Product ID not found.");

        return;
    }


    if (
        button &&
        button.dataset.adding === "true"
    ) {

        return;
    }


    if (button) {

        button.dataset.adding = "true";

        button.disabled = true;

        button.innerHTML =
            '<i class="fa-solid fa-spinner fa-spin"></i> Adding...';
    }


    var form =
        document.createElement("form");

    form.method = "POST";

    form.action =
        "<%= contextPath %>/cart";


    var actionInput =
        document.createElement("input");

    actionInput.type = "hidden";

    actionInput.name = "action";

    actionInput.value = "add";


    var productInput =
        document.createElement("input");

    productInput.type = "hidden";

    productInput.name = "productId";

    productInput.value = productId;


    var quantityInput =
        document.createElement("input");

    quantityInput.type = "hidden";

    quantityInput.name = "quantity";

    quantityInput.value = "1";


    form.appendChild(actionInput);

    form.appendChild(productInput);

    form.appendChild(quantityInput);


    document.body.appendChild(form);


    form.submit();
}


/* =====================================================
   CART COUNT
===================================================== */

function setCartCount(count) {

    var cartCount =
        document.getElementById("cartCount");

    if (!cartCount) {
        return;
    }

    cartCount.textContent = count;
}


function getCartCount() {

    var count = 0;

    try {

        count =
            parseInt(
                localStorage.getItem(
                    "sushmithaMartCartCount"
                )
            );

        if (isNaN(count)) {
            count = 0;
        }

    } catch (e) {

        count = 0;
    }

    return count;
}


function loadCartCount() {

    setCartCount(
        getCartCount()
    );
}


/* =====================================================
   IMAGE FALLBACK
===================================================== */

function handleProductImageError(imageElement) {

    if (!imageElement) {
        return;
    }


    var alreadyUsed =
        imageElement.getAttribute(
            "data-fallback-used"
        );


    if (alreadyUsed === "true") {
        return;
    }


    var fallback =
        imageElement.getAttribute(
            "data-fallback"
        );


    if (
        fallback &&
        imageElement.src !== fallback
    ) {

        imageElement.setAttribute(
            "data-fallback-used",
            "true"
        );

        imageElement.src =
            fallback;

    } else {

        imageElement.setAttribute(
            "data-fallback-used",
            "true"
        );

        imageElement.src =
            "<%= contextPath %>/images/default-product.jpg";
    }
}


/* =====================================================
   FILTER
===================================================== */

function toggleFilter() {

    var panel =
        document.getElementById("filterPanel");

    if (!panel) {
        return;
    }

    panel.classList.toggle("show");
}


function clearFilters() {

    var category =
        document.getElementById("categoryFilter");

    var price =
        document.getElementById("priceFilter");

    var sort =
        document.getElementById("sortFilter");


    if (category) {
        category.value = "all";
    }

    if (price) {
        price.value = "all";
    }

    if (sort) {
        sort.value = "default";
    }


    filterProducts();
}


function filterProducts() {

    var category =
        document.getElementById("categoryFilter").value;

    var price =
        document.getElementById("priceFilter").value;

    var sort =
        document.getElementById("sortFilter").value;


    var grid =
        document.getElementById("productGrid");


    if (!grid) {
        return;
    }


    var cards =
        Array.from(
            grid.querySelectorAll(".product-card")
        );


    cards.forEach(function(card) {

        var cardCategory =
            card.getAttribute(
                "data-category"
            ) || "";


        var cardPrice =
            parseFloat(
                card.getAttribute(
                    "data-price"
                )
            ) || 0;


        var categoryMatch =
            category === "all" ||
            cardCategory.toLowerCase() ===
            category.toLowerCase();


        var priceMatch = true;


        if (price === "under500") {

            priceMatch =
                cardPrice < 500;

        } else if (price === "500to1000") {

            priceMatch =
                cardPrice >= 500 &&
                cardPrice <= 1000;

        } else if (price === "1000to2000") {

            priceMatch =
                cardPrice > 1000 &&
                cardPrice <= 2000;

        } else if (price === "above2000") {

            priceMatch =
                cardPrice > 2000;
        }


        card.style.display =
            categoryMatch && priceMatch
            ? ""
            : "none";
    });


    if (sort !== "default") {

        cards.sort(function(a, b) {

            if (sort === "low") {

                return (
                    parseFloat(
                        a.getAttribute("data-price")
                    ) -
                    parseFloat(
                        b.getAttribute("data-price")
                    )
                );

            }


            if (sort === "high") {

                return (
                    parseFloat(
                        b.getAttribute("data-price")
                    ) -
                    parseFloat(
                        a.getAttribute("data-price")
                    )
                );

            }


            if (sort === "name") {

                return (
                    a.getAttribute("data-name") || ""
                ).localeCompare(
                    b.getAttribute("data-name") || ""
                );
            }


            return 0;
        });


        cards.forEach(function(card) {

            grid.appendChild(card);

        });
    }
}


/* =====================================================
   EVENTS
===================================================== */

document.addEventListener(
    "DOMContentLoaded",
    function() {

        loadCartCount();


        var categoryFilter =
            document.getElementById(
                "categoryFilter"
            );

        var priceFilter =
            document.getElementById(
                "priceFilter"
            );

        var sortFilter =
            document.getElementById(
                "sortFilter"
            );


        if (categoryFilter) {

            categoryFilter.addEventListener(
                "change",
                filterProducts
            );
        }


        if (priceFilter) {

            priceFilter.addEventListener(
                "change",
                filterProducts
            );
        }


        if (sortFilter) {

            sortFilter.addEventListener(
                "change",
                filterProducts
            );
        }
    }
);


/* =====================================================
   CLOSE PROFILE WHEN CLICKING OUTSIDE
===================================================== */

document.addEventListener(
    "click",
    function(event) {

        var wrapper =
            document.querySelector(
                ".profile-wrapper"
            );

        var menu =
            document.getElementById(
                "profileMenu"
            );


        if (
            wrapper &&
            menu &&
            !wrapper.contains(event.target)
        ) {

            menu.classList.remove("show");
        }
    }
);

</script>

</body>

</html>