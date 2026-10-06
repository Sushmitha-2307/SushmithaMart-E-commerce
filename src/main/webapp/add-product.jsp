<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SushmithaMart - Add Product</title>

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
            max-width: 750px;
            margin: 40px auto;
        }

        .box {
            background: white;
            padding: 35px;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        h1 {
            margin-top: 0;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 16px;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input,
        textarea,
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccd2dc;
            border-radius: 7px;
            font-size: 15px;
            background: white;
        }

        textarea {
            min-height: 110px;
            resize: vertical;
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #e8a33d;
        }

        .image-box {
            border: 2px dashed #ccd2dc;
            padding: 20px;
            border-radius: 10px;
            background: #fafbfe;
        }

        .submit-btn {
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

        .submit-btn:hover {
            background: #16233f;
            color: white;
        }

        .back {
            display: block;
            text-align: center;
            margin-top: 18px;
            color: #16233f;
            text-decoration: none;
            font-weight: bold;
        }

        .error {
            background: #ffe4e4;
            color: #b00020;
            padding: 12px;
            border-radius: 7px;
            margin-bottom: 15px;
        }

        .success {
            background: #e4f8ea;
            color: #16833b;
            padding: 12px;
            border-radius: 7px;
            margin-bottom: 15px;
        }

        .preview {
            width: 180px;
            height: 180px;
            object-fit: contain;
            margin-top: 15px;
            display: none;
            background: white;
            border-radius: 8px;
        }

        @media (max-width: 700px) {

            .navbar {
                padding: 15px;
            }

            .nav-links {
                gap: 10px;
                font-size: 13px;
            }

            .box {
                padding: 22px;
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

    <div class="box">

        <h1>
            Add New Product
        </h1>


        <%
            String error = request.getParameter("error");
            String success = request.getParameter("success");

            if (error != null && !error.trim().isEmpty()) {
        %>

            <div class="error">
                <%= error.replace("%20", " ") %>
            </div>

        <%
            }

            if (success != null && !success.trim().isEmpty()) {
        %>

            <div class="success">
                Product added successfully.
            </div>

        <%
            }
        %>


        <!-- PRODUCT FORM -->

        <form action="add-product"
              method="post"
              enctype="multipart/form-data">


            <!-- PRODUCT NAME -->

            <label>
                Product Name
            </label>

            <input
                type="text"
                name="name"
                placeholder="Enter product name"
                required>


            <!-- CATEGORY -->

            <label>
                Category
            </label>

            <select
                name="category"
                required>

                <option value="">
                    Select Category
                </option>

                <option value="Electronics">
                    Electronics
                </option>

                <option value="Fashion">
                    Fashion
                </option>

                <option value="Footwear">
                    Footwear
                </option>

                <option value="Beauty & Personal Care">
                    Beauty & Personal Care
                </option>

                <option value="Makeup">
                    Makeup
                </option>

                <option value="Skincare">
                    Skincare
                </option>

                <option value="Hair Care">
                    Hair Care
                </option>

                <option value="Home">
                    Home
                </option>

                <option value="Kitchen">
                    Kitchen
                </option>

                <option value="Grocery">
                    Grocery
                </option>

                <option value="Books">
                    Books
                </option>

                <option value="Stationery">
                    Stationery
                </option>

                <option value="Toys">
                    Toys
                </option>

                <option value="Jewellery & Accessories">
                    Jewellery & Accessories
                </option>

                <option value="Bags & Luggage">
                    Bags & Luggage
                </option>

                <option value="Travel">
                    Travel
                </option>

                <option value="Sports & Fitness">
                    Sports & Fitness
                </option>

                <option value="Baby & Kids">
                    Baby & Kids
                </option>

                <option value="Health">
                    Health
                </option>

                <option value="Automotive">
                    Automotive
                </option>

                <option value="Pet Supplies">
                    Pet Supplies
                </option>

                <option value="Office Supplies">
                    Office Supplies
                </option>

                <option value="Garden & Outdoor">
                    Garden & Outdoor
                </option>

                <option value="Gifts & Collectibles">
                    Gifts & Collectibles
                </option>

                <option value="Other">
                    Other
                </option>

            </select>


            <!-- DESCRIPTION -->

            <label>
                Description
            </label>

            <textarea
                name="description"
                placeholder="Enter product description"
                required></textarea>


            <!-- PRICE -->

            <label>
                Price
            </label>

            <input
                type="number"
                name="price"
                placeholder="Enter price"
                min="1"
                step="0.01"
                required>


            <!-- QUANTITY / STOCK -->

            <label>
                Quantity
            </label>

            <!-- IMPORTANT:
                 AddProductServlet expects name="stock"
            -->

            <input
                type="number"
                name="stock"
                placeholder="Enter quantity"
                min="0"
                step="1"
                required>


            <!-- PRODUCT IMAGE -->

            <label>
                Product Image
            </label>

            <div class="image-box">

                <input
                    type="file"
                    name="image"
                    accept="image/jpeg,image/jpg,image/png,image/webp"
                    required
                    onchange="previewImage(event)">

                <img
                    id="imagePreview"
                    class="preview"
                    alt="Image Preview">

            </div>


            <!-- SUBMIT -->

            <button
                type="submit"
                class="submit-btn">

                Add Product

            </button>

        </form>


        <a href="seller-products" class="back">
            ← Back to My Products
        </a>

    </div>

</div>


<script>

function previewImage(event) {

    const file =
        event.target.files[0];

    const preview =
        document.getElementById("imagePreview");

    if (file) {

        preview.src =
            URL.createObjectURL(file);

        preview.style.display =
            "block";

    } else {

        preview.style.display =
            "none";
    }
}

</script>

</body>

</html>