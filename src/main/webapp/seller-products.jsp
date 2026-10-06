<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.sushmithamart.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    List<Product> products =
            (List<Product>) request.getAttribute("products");

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - My Products</title>

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
            max-width: 1200px;
            margin: 35px auto;
        }

        .top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .top h1 {
            margin: 0;
        }

        .add-btn {
            background: #e8a33d;
            color: #16233f;
            padding: 12px 20px;
            border-radius: 7px;
            text-decoration: none;
            font-weight: bold;
        }

        .add-btn:hover {
            background: #16233f;
            color: white;
        }

        .products {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 22px;
        }

        .card {
            background: white;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .image-container {
            width: 100%;
            height: 230px;
            background: #eef1f6;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        .product-image {
            width: 100%;
            height: 100%;
            object-fit: contain;
            background: white;
        }

        .content {
            padding: 20px;
        }

        .content h2 {
            margin: 0 0 10px;
            font-size: 20px;
        }

        .category {
            display: inline-block;
            background: #eef2ff;
            color: #16233f;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .description {
            color: #68738a;
            min-height: 45px;
        }

        .price {
            color: #162f63;
            font-size: 20px;
            font-weight: bold;
            margin: 12px 0;
        }

        .quantity {
            color: #555;
            margin-bottom: 15px;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .delete-btn {
            background: #d9363e;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .delete-btn:hover {
            background: #b52b32;
        }

        .empty {
            background: white;
            padding: 60px 20px;
            text-align: center;
            border-radius: 14px;
            color: #68738a;
            font-size: 20px;
        }

        .no-image {
            color: #888;
            font-size: 14px;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 15px;
            }

            .nav-links {
                gap: 10px;
                font-size: 13px;
            }

            .top {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
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

    <div class="top">

        <h1>
            My Products
        </h1>

        <a href="add-product.jsp" class="add-btn">
            + Add Product
        </a>

    </div>


<%

    if (products == null || products.isEmpty()) {

%>

    <div class="empty">

        <div>
            No products added yet.
        </div>

        <br>

        <a href="add-product.jsp" class="add-btn">
            Add Your First Product
        </a>

    </div>

<%

    } else {

%>


    <div class="products">

<%

        for (Product product : products) {

            String image = product.getImage();

%>

        <div class="card">

            <div class="image-container">

<%

            if (image != null &&
                !image.trim().isEmpty()) {

                String imageUrl;

                /*
                 * Cloudinary / external URL என்றால்
                 * அதை direct-ஆ use பண்ணும்.
                 */
                if (image.startsWith("http://") ||
                    image.startsWith("https://")) {

                    imageUrl = image;

                } else {

                    /*
                     * Database-ல்:
                     * images/products/filename.jpg
                     *
                     * இதில் filename மட்டும் எடுத்துக்கொண்டு
                     * ProductImageServlet-க்கு அனுப்புகிறோம்.
                     */

                    String fileName = image;

                    int slashIndex =
                            fileName.lastIndexOf('/');

                    if (slashIndex >= 0) {
                        fileName =
                                fileName.substring(
                                        slashIndex + 1
                                );
                    }

                    imageUrl =
                            contextPath
                            + "/product-image?file="
                            + URLEncoder.encode(
                                    fileName,
                                    "UTF-8"
                              );
                }

%>

                <img
                    src="<%= imageUrl %>"
                    class="product-image"
                    alt="<%= product.getName() %>"
                    onerror="showNoImage(this)"
                >

<%

            } else {

%>

                <div class="no-image">
                    No Image Available
                </div>

<%

            }

%>

            </div>


            <div class="content">

                <h2>
                    <%= product.getName() %>
                </h2>


<%

                String category =
                        product.getCategory();

                if (category != null &&
                    !category.trim().isEmpty()) {

%>

                <div class="category">
                    <%= category %>
                </div>

<%

                }

%>


                <div class="description">

                    <%= product.getDescription() %>

                </div>


                <div class="price">

                    ₹<%= String.format(
                            "%.2f",
                            product.getPrice()
                    ) %>

                </div>


                <div class="quantity">

                    Stock:
                    <strong>
                        <%= product.getQuantity() %>
                    </strong>

                </div>


                <div class="actions">

                    <form
                        action="seller-products"
                        method="post"
                        onsubmit="return confirm('Delete this product?');">

                        <input
                            type="hidden"
                            name="action"
                            value="delete">

                        <input
                            type="hidden"
                            name="productId"
                            value="<%= product.getId() %>">

                        <button
                            type="submit"
                            class="delete-btn">

                            Delete

                        </button>

                    </form>

                </div>

            </div>

        </div>

<%

        }

%>

    </div>

<%

    }

%>

</div>


<script>

function showNoImage(image) {

    image.style.display = "none";

    const container = image.parentElement;

    container.innerHTML =
        '<div class="no-image">No Image Available</div>';
}

</script>


</body>
</html>