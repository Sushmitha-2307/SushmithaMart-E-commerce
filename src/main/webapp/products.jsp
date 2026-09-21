<%@ page import="java.util.List" %>
<%@ page import="com.sushmithamart.model.Product" %>
<%@ page import="com.sushmithamart.service.ProductService" %>

<%
    ProductService productService = new ProductService();
    List<Product> products = productService.getAllProducts();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>SushmithaMart - Products</title>

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
    padding: 15px 30px;
    display: flex;
    align-items: center;
    gap: 25px;
    position: sticky;
    top: 0;
    z-index: 100;
}

.logo {
    font-size: 25px;
    font-weight: bold;
    white-space: nowrap;
}

.logo span {
    color: #e8a33d;
}

.search {
    flex: 1;
    max-width: 600px;
}

.search input {
    width: 100%;
    padding: 13px 18px;
    border: none;
    border-radius: 8px;
    outline: none;
    font-size: 15px;
}

.links {
    display: flex;
    gap: 18px;
    white-space: nowrap;
}

.links a {
    color: white;
    text-decoration: none;
    font-weight: bold;
    font-size: 14px;
}

.links a:hover {
    color: #e8a33d;
}

.container {
    padding: 30px;
    max-width: 1600px;
    margin: auto;
}

h1 {
    margin: 0;
    font-size: 30px;
}

.subtitle {
    color: #68738a;
    margin-top: 8px;
    margin-bottom: 28px;
}

.grid {
    display: grid;
    grid-template-columns: repeat(5, minmax(0, 1fr));
    gap: 20px;
}

.card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    border: 1px solid #e3e7ee;
    box-shadow: 0 3px 12px rgba(0,0,0,0.08);
    transition: 0.2s;
    display: flex;
    flex-direction: column;
    min-width: 0;
}

.card:hover {
    transform: translateY(-3px);
    box-shadow: 0 7px 20px rgba(0,0,0,0.12);
}

.image-area {
    width: 100%;
    height: 210px;
    background: white;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.product-image {
    width: 100%;
    height: 100%;
    object-fit: contain;
    padding: 15px;
    display: block;
}

.info {
    padding: 14px;
    display: flex;
    flex-direction: column;
    flex: 1;
}

.name {
    font-size: 16px;
    font-weight: bold;
    color: #17233f;
    margin-bottom: 8px;
    min-height: 38px;
}

.description {
    color: #68738a;
    font-size: 13px;
    line-height: 1.4;
    min-height: 38px;
}

.price {
    font-size: 20px;
    font-weight: bold;
    color: #17233f;
    margin-top: 12px;
}

.stock {
    color: #16833b;
    font-size: 13px;
    font-weight: bold;
    margin-top: 6px;
}

.cart-form {
    margin: 0 14px 15px;
}

.cart-button {
    width: 100%;
    border: none;
    border-radius: 7px;
    padding: 11px;
    background: #162f63;
    color: white;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;
}

.cart-button:hover {
    background: #e8a33d;
    color: #16233f;
}

@media (max-width: 1200px) {
    .grid {
        grid-template-columns: repeat(4, 1fr);
    }
}

@media (max-width: 950px) {
    .grid {
        grid-template-columns: repeat(3, 1fr);
    }

    .navbar {
        flex-wrap: wrap;
    }

    .search {
        order: 3;
        max-width: 100%;
        flex-basis: 100%;
    }
}

@media (max-width: 650px) {
    .grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 12px;
    }

    .container {
        padding: 15px;
    }

    .image-area {
        height: 160px;
    }

    .links {
        gap: 10px;
    }

    .logo {
        font-size: 20px;
    }
}

</style>

<script>

function searchProducts() {

    const text =
        document.getElementById("searchBox")
        .value
        .toLowerCase()
        .trim();

    const cards =
        document.querySelectorAll(".card");

    cards.forEach(function(card) {

        const name =
            card.dataset.name.toLowerCase();

        if (name.includes(text)) {
            card.style.display = "";
        } else {
            card.style.display = "none";
        }

    });
}


/* IMAGE SELECTOR */

function getProductImage(name) {

    name = name.toLowerCase();


   if (name.includes("bluetooth speaker"))
    return "https://cdn.phototourl.com/member/2026-09-19-0daac560-e198-4678-917c-87428ff62501.jpg";

    if (name.includes("laptop bag"))
    return "https://cdn.phototourl.com/member/2026-09-19-8e8fb42b-8a9d-4361-9619-ef6027b75bae.jpg";

    if (name.includes("mouse"))
        return "https://images.unsplash.com/photo-1527814050087-3793815479db?auto=format&fit=crop&w=600&q=80";

    if (name.includes("mobile phone stand"))
    return "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mobile%20holder.jpg";

    if (name.includes("camera") || name.includes("web camera"))
        return "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=600&q=80";

   if (name.includes("power bank"))
    return "https://cdn.phototourl.com/member/2026-09-19-624af99a-c4ed-48fd-b9f4-780fdd1ee4bc.jpg";

    if (name.includes("aux cable"))
    return "https://cdn.miswag.me/images/images/a1167503-5fcb-4b76-86e8-e71a5024b994.jpg";

    if (name.includes("adapter"))
    return "https://cdn.phototourl.com/free/2026-09-20-51d857fc-a89e-4684-bf44-3f41b80d3b04.jpg";

    if (name.includes("microphone"))
        return "https://images.unsplash.com/photo-1590602847861-f357a9332bbc?auto=format&fit=crop&w=600&q=80";

    if (name.includes("mini tripod"))
    return "https://spiritofa.shop/cdn/shop/files/305670669803.jpg?v=1777312879";

    if (name.includes("phone holder"))
    return "https://commons.wikimedia.org/wiki/Special:Redirect/file/A_phone_holder.jpg";

    if (name.includes("smart watch"))
    return "https://cdn.phototourl.com/member/2026-09-19-26c44986-ed44-4601-9217-94283d09caeb.jpg";

   if (name.includes("usb c hub"))
    return "https://cdn.phototourl.com/member/2026-09-20-adeea089-eec9-46fc-a26f-d6a69b9b2f13.jpg";

    if (name.includes("gel pen"))
    return "https://images-r.meesho.com/images/products/1042063930/rpwp8_512.webp";

  if (name.includes("wooden pencil"))
    return "https://upload.wikimedia.org/wikipedia/commons/5/54/Yellow_HB_pencils.jpg";

    if (name.includes("small notes"))
    return "https://cdn.phototourl.com/free/2026-09-20-09355d7d-ba3d-41be-8124-af4badee1ced.jpg";

   if (name.includes("paper clip"))
    return "https://cdn.phototourl.com/free/2026-09-20-a9b790aa-7d3b-4dad-851c-e1657b64a312.jpg";

    if (name.includes("highlighter set"))
    return "https://cdn.phototourl.com/member/2026-09-20-0a8650ec-5815-424e-90c8-b52b3048742b.jpg";

    if (name.includes("kids pen set"))
    return "https://cdn.phototourl.com/member/2026-09-20-e35f6240-4be0-490d-95fb-6f512a345d91.jpg";

    if (name.includes("book stand"))
    return "https://www.highfashionhome.com/cdn/shop/files/STAND-BOOK-3030-Book-WEB.jpg?v=1749508618";

    if (name.includes("spiral notes"))
    return "https://cdn.phototourl.com/member/2026-09-20-08e59419-bb92-46e6-a774-4b284c8543ce.jpg";

    if (name.includes("cello tape"))
    return "https://cdn.phototourl.com/member/2026-09-20-cfb45126-202d-4383-92d1-c17f35a476fa.jpg";

    if (name.includes("study table"))
    return "https://cdn.phototourl.com/member/2026-09-20-d7072f6e-d500-472f-a0b3-80a3218e3579.jpg";

    if (name.includes("passport holder"))
    return "https://cdn.phototourl.com/member/2026-09-20-9b97429c-7f54-4fdd-bfaf-92dc89e02ddd.jpg";

    if (name.includes("stick glue"))
    return "https://asset.sastasundar.com/incom/images/product/Fevi-Stik-The-Original-Glue-Stick-1623752009-10087412-1.jpg";

    if (name.includes("study light"))
    return "https://cdn.phototourl.com/free/2026-09-20-2797d369-c2f5-48f1-8bf6-0dbab5c975d8.jpg";

    if (name.includes("pen stand"))
    return "https://cdn.phototourl.com/member/2026-09-20-31f41dc2-6432-457f-9371-f6559e88e926.jpg";

    if (name.includes("umbrella"))
    return "https://cdn.shopify.com/s/files/1/0908/4003/9706/files/g1900027-bk-sku.jpg";

    if (name.includes("travel pillow"))
    return "https://commons.wikimedia.org/wiki/Special:Redirect/file/Travel_Pillow.jpg";

    if (name.includes("laundry bag"))
    return "https://cdn.phototourl.com/member/2026-09-20-adb4f99f-a1ff-4f3b-a395-bc05a893b3f2.jpg";

    if (name.includes("cosmetic pouch"))
    return "https://cdn.phototourl.com/free/2026-09-20-ea92da2d-ff41-492e-9e5f-b99903c11c2c.jpg";

    if (name.includes("cosmetic drawer"))
    return "https://cdn.phototourl.com/member/2026-09-20-af13906e-5341-4211-9670-c13728de2e1a.jpg";

    if (name.includes("coffee cup"))
    return "https://upload.wikimedia.org/wikipedia/commons/e/e8/Coffee_cup_%281%29.jpg";

   if (name.includes("electric kettle"))
    return "https://cdn.phototourl.com/member/2026-09-19-3aba405d-d888-4e62-965b-3cd2ffe92b47.jpg";

   if (name.includes("vegetable peeler"))
    return "https://cdn.phototourl.com/member/2026-09-20-145aaa8f-d460-457d-8cbf-b57b55288ce1.jpg";

    if (name.includes("vegetable cutter"))
    return "https://cdn.phototourl.com/member/2026-09-20-d860372f-0c94-46af-8390-f0ffe8664d43.jpg";

        if (name.includes("vegetable chopper"))
    return "https://commons.wikimedia.org/wiki/Special:Redirect/file/Zyliss%20vegetable%20chopper.jpg";

    if (name.includes("kitchen tongs"))
    return "https://cdn.phototourl.com/member/2026-09-20-839506ab-4530-4ed9-865d-709b92bb9ab1.jpg";

   if (name.includes("kitchen measuring cup"))
    return "https://cdn.phototourl.com/member/2026-09-20-99dac625-22f6-432b-bb5c-1592a7e4f685.jpg";

if (name.includes("grocery container"))
    return "https://cdn.phototourl.com/free/2026-09-20-16251955-abbc-4635-929c-04be4cde1024.jpg";

    if (name.includes("kitchen drawer"))
    return "https://cdn.phototourl.com/member/2026-09-20-79ce58a8-c8a6-4286-a819-28d5009844b6.jpg";

    if (name.includes("cooking apron"))
    return "https://cdn.phototourl.com/member/2026-09-20-9b06e3e7-6b4e-4789-a001-7241509411b2.jpg";

    if (name.includes("stapler"))
    return "https://cdn.phototourl.com/free/2026-09-20-3798cc10-9af1-45cf-91a4-07fbcbed80f2.jpg";

    if (name.includes("shoe stand"))
    return "https://cdn.phototourl.com/free/2026-09-20-898e265b-de79-4bc4-b06b-0e99730b184f.jpg";

    if (name.includes("phone holder"))
    return "https://www.comnito.com/cdn/shop/files/03_a3d63e40-d17f-4fa0-9b27-6df7fd4730de.jpg?v=1784205949&width=375";

    if (name.includes("slipper"))
    return "https://cdn.phototourl.com/member/2026-09-19-2dff9701-ca5d-4842-b8d6-1ffe88a86d9d.jpg";

    if (name.includes("keychain stand"))
    return "https://cdn.phototourl.com/member/2026-09-20-d4d41241-ed56-412a-a710-1b8a30eb2a6a.jpg";

    if (name.includes("keychain light"))
    return "https://cdn.phototourl.com/member/2026-09-20-1eacd727-bb79-40fb-afd5-0634332290ce.jpg";

    if (name.includes("motion sensor led light"))
    return "https://cdn.phototourl.com/member/2026-09-20-5551bd85-947f-4b61-a6fe-6e38fa5506ec.jpg";

    if (name.includes("night led light"))
    return "https://cdn.phototourl.com/member/2026-09-20-d3ec29a0-1132-4564-8214-3412bea27b41.jpg";

    if (name.includes("door stopper"))
    return "https://cdn.phototourl.com/free/2026-09-20-7253be25-0f66-46ce-a698-26b4816756a9.jpg";

    if (name.includes("comb set"))
    return "https://cdn.phototourl.com/member/2026-09-20-f5860e8a-c126-4a25-ac56-4cc928bc7f32.jpg";

    if (name.includes("sunglasses case"))
    return "https://cdn.phototourl.com/member/2026-09-21-25f19c2f-7fe1-436a-9e21-f185ce7d7c4e.jpg";

    if (name.includes("measuring tape"))
    return "https://cdn.phototourl.com/member/2026-09-20-e94fd966-f2f7-4e09-87a8-062d4b2f9c1a.jpg";

    if (name.includes("face towel"))
    return "https://cdn.phototourl.com/member/2026-09-20-4482557f-4aca-4b12-858e-6114edbea68c.jpg";

    if (name.includes("stainless steel bottle"))
    return "https://cdn.phototourl.com/member/2026-09-21-5ec92f20-c87c-41b2-a754-9619bf2d1592.jpg";

    if (name.includes("joystick"))
    return "https://cdn.phototourl.com/member/2026-09-21-1e6ff225-aa02-4d3a-a375-af475144329f.jpg";

    if (name.includes("clock"))
    return "https://cdn.phototourl.com/member/2026-09-21-11bbd51d-847a-4e41-bfcc-eea4d9960a61.jpg";

    if (name.includes("leather wallet"))
    return "https://cdn.phototourl.com/member/2026-09-21-f822023a-b20e-47dc-afa6-2104ab6b9c78.jpg";


    /* DEFAULT */

    return "https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80";
}

</script>

</head>

<body>

<div class="navbar">

    <div class="logo">
        Sushmitha<span>Mart</span>
    </div>

    <div class="search">

        <input
            id="searchBox"
            type="text"
            placeholder="Search for products..."
            onkeyup="searchProducts()">

    </div>

    <div class="links">

        <a href="index.jsp">Home</a>
        <a href="products.jsp">Products</a>
        <a href="cart">Cart</a>
        <a href="orders.jsp">Orders</a>
        <a href="checkout.jsp">Checkout</a>
        <a href="login.jsp">Logout</a>

    </div>

</div>


<div class="container">

    <h1>All Products</h1>

    <p class="subtitle">
        Explore our products and add your favourites to cart.
    </p>

    <div class="grid">

<%
    if (products != null && !products.isEmpty()) {

        for (Product p : products) {
%>

        <div
            class="card"
            data-name="<%= p.getName() %>">

            <div class="image-area">

                <img
                    class="product-image"
                    src=""
                    alt="<%= p.getName() %>"
                    data-product-name="<%= p.getName() %>">

            </div>


            <div class="info">

                <div class="name">
                    <%= p.getName() %>
                </div>

                <div class="description">

<%
    if (
        p.getDescription() != null &&
        !p.getDescription().trim().isEmpty()
    ) {
%>

                    <%= p.getDescription() %>

<%
    } else {
%>

                    Quality product from SushmithaMart.

<%
    }
%>

                </div>

                <div class="price">
                    &#8377;<%= String.format("%.0f", p.getPrice()) %>
                </div>

                <div class="stock">
                    Available: <%= p.getQuantity() %>
                </div>

            </div>


            <form
                class="cart-form"
                action="cart"
                method="post">

                <input
                    type="hidden"
                    name="productId"
                    value="<%= p.getId() %>">

                <input
                    type="hidden"
                    name="quantity"
                    value="1">

                <input
                    type="hidden"
                    name="action"
                    value="add">

                <button
                    class="cart-button"
                    type="submit">

                    Add to Cart

                </button>

            </form>

        </div>

<%
        }

    } else {
%>

        <p>No products available.</p>

<%
    }
%>

    </div>

</div>


<script>

/*
 * Apply image to every product
 */

document
.querySelectorAll(".product-image")
.forEach(function(image) {

    const productName =
        image.getAttribute("data-product-name");

    image.src =
        getProductImage(productName);

});

</script>

</body>
</html>