<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.sushmithamart.model.User" %>

<%
User user = (User) session.getAttribute("user");

if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

if (!"SELLER".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect("dashboard.jsp");
    return;
}

%>

<!DOCTYPE html><html>
<head><meta charset="UTF-8">
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

    .back {
        color: white;
        text-decoration: none;
        font-weight: bold;
    }

    .back:hover {
        color: #e8a33d;
    }

    .container {
        width: 92%;
        max-width: 700px;
        margin: 45px auto;
    }

    .box {
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

    .input-box {
        margin-bottom: 18px;
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
        outline: none;
    }

    .input-box input:focus,
    .input-box textarea:focus {
        border-color: #162f63;
    }

    .input-box textarea {
        min-height: 100px;
        resize: vertical;
    }

    .image-input {
        padding: 10px;
        background: #f8f9fc;
        cursor: pointer;
    }

    .image-note {
        display: block;
        margin-top: 6px;
        color: #68738a;
        font-size: 12px;
    }

    .add-btn {
        width: 100%;
        padding: 14px;
        border: none;
        border-radius: 8px;
        background: #e8a33d;
        color: #16233f;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
    }

    .add-btn:hover {
        background: #16233f;
        color: white;
    }

</style>

</head><body><div class="navbar"><div class="logo">
    Sushmitha<span>Mart</span>
</div>

<a href="seller-dashboard.jsp" class="back">
    Back to Dashboard
</a>

</div><div class="container"><div class="box">

    <h1>Add Product</h1>

    <p class="subtitle">
        Add a new product to your SushmithaMart store.
    </p>


    <form action="add-product"
          method="post"
          enctype="multipart/form-data">

        <div class="input-box">

            <label>Product Name</label>

            <input
                type="text"
                name="name"
                placeholder="Enter product name"
                required>

        </div>


        <div class="input-box">

            <label>Category</label>

            <input
                type="text"
                name="category"
                placeholder="Example: Electronics"
                required>

        </div>


        <div class="input-box">

            <label>Price</label>

            <input
                type="number"
                name="price"
                step="0.01"
                min="0"
                placeholder="Enter price"
                required>

        </div>


        <div class="input-box">

            <label>Stock Quantity</label>

            <input
                type="number"
                name="stock"
                min="0"
                placeholder="Enter stock quantity"
                required>

        </div>


        <div class="input-box">

            <label>Description</label>

            <textarea
                name="description"
                placeholder="Enter product description"
                required></textarea>

        </div>


        <div class="input-box">

            <label>Product Image</label>

            <input
                type="file"
                name="image"
                class="image-input"
                accept="image/*"
                required>

            <span class="image-note">
                Select a product image from your device.
            </span>

        </div>


        <button type="submit" class="add-btn">
            Add Product
        </button>

    </form>

</div>

</div></body>
</html>