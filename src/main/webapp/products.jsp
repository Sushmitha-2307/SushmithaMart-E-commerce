<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.sushmithamart.model.Product" %>
<%@ page import="com.sushmithamart.service.ProductService" %>

<%
    ProductService productService = new ProductService();

    List<Product> allProducts =
            productService.getAllProducts();

    List<Product> products =
            new ArrayList<Product>();

    String selectedCategory =
            request.getParameter("category");

    String searchText =
            request.getParameter("search");

    if (selectedCategory != null) {
        selectedCategory =
                selectedCategory.trim();
    }

    if (searchText != null) {
        searchText =
                searchText.trim().toLowerCase();
    }

    /*
     * CATEGORY + SEARCH FILTER
     */

    if (allProducts != null) {

        for (Product product : allProducts) {

            boolean categoryMatch = true;
            boolean searchMatch = true;

            /*
             * CATEGORY CHECK
             */

            if (selectedCategory != null
                    && !selectedCategory.isEmpty()
                    && !selectedCategory.equalsIgnoreCase("all")) {

                String productCategory =
                        product.getCategory();

                if (productCategory == null) {
                    productCategory = "";
                }

                categoryMatch =
                        productCategory
                                .trim()
                                .equalsIgnoreCase(
                                        selectedCategory
                                );
            }

            /*
             * SEARCH CHECK
             */

            if (searchText != null
                    && !searchText.isEmpty()) {

                String productName =
                        product.getName();

                String productDescription =
                        product.getDescription();

                String productCategory =
                        product.getCategory();

                if (productName == null) {
                    productName = "";
                }

                if (productDescription == null) {
                    productDescription = "";
                }

                if (productCategory == null) {
                    productCategory = "";
                }

                String searchableText =
                        productName + " "
                        + productDescription + " "
                        + productCategory;

                searchMatch =
                        searchableText
                                .toLowerCase()
                                .contains(searchText);
            }

            /*
             * ADD ONLY WHEN BOTH MATCH
             */

            if (categoryMatch && searchMatch) {

                products.add(product);
            }
        }
    }

    /*
     * GROUP FILTERED PRODUCTS BY CATEGORY
     */

    Map<String, List<Product>> categoryProducts =
            new LinkedHashMap<String, List<Product>>();

    if (products != null) {

        for (Product product : products) {

            String category =
                    product.getCategory();

            if (category == null
                    || category.trim().isEmpty()) {

                category = "Other";

            } else {

                category =
                        category.trim();
            }

            if (!categoryProducts.containsKey(category)) {

                categoryProducts.put(
                        category,
                        new ArrayList<Product>()
                );
            }

            categoryProducts
                    .get(category)
                    .add(product);
        }
    }
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

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


/* =========================
   NAVBAR
   ========================= */

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


/* =========================
   CONTAINER
   ========================= */

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


/* =========================
   FILTER BUTTON
   ========================= */

.filter-bar {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 25px;
}

.filter-button {
    background: white;
    color: #16233f;
    border: 1px solid #d9dee7;
    border-radius: 8px;
    padding: 10px 18px;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;

    display: flex;
    align-items: center;
    gap: 8px;

    box-shadow: 0 2px 7px rgba(0,0,0,0.06);
}

.filter-button:hover {
    background: #162f63;
    color: white;
    border-color: #162f63;
}

.filter-icon {
    width: 17px;
    height: 17px;
    display: block;
    flex-shrink: 0;
}


/* =========================
   FILTER BOX
   ========================= */

.filter-box {
    display: none;

    background: white;

    border: 1px solid #e0e4eb;

    border-radius: 12px;

    padding: 20px;

    margin-bottom: 25px;

    box-shadow:
        0 3px 12px rgba(0,0,0,0.07);
}

.filter-box.show {
    display: block;
}

.filter-title {
    font-size: 19px;
    font-weight: bold;
    color: #16233f;
    margin-bottom: 18px;
}

.filter-options {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 14px;
}

.filter-label {
    font-size: 14px;
    font-weight: bold;
    color: #17233f;
}


/* =========================
   PRICE / SORT
   ========================= */

.filter-select {
    padding: 9px 32px 9px 12px;

    border: 1px solid #d5dae3;

    border-radius: 7px;

    outline: none;

    font-size: 14px;

    color: #17233f;

    background: white;

    cursor: pointer;
}

.filter-select:focus {
    border-color: #162f63;
}


/* =========================
   FILTER ACTION BUTTONS
   ========================= */

.apply-filter {
    padding: 9px 18px;

    border: none;

    border-radius: 7px;

    background: #162f63;

    color: white;

    font-weight: bold;

    cursor: pointer;
}

.apply-filter:hover {
    background: #e8a33d;
    color: #16233f;
}

.clear-filter {
    padding: 9px 18px;

    border: 1px solid #d5dae3;

    border-radius: 7px;

    background: white;

    color: #16233f;

    font-weight: bold;

    cursor: pointer;
}

.clear-filter:hover {
    background: #f0f2f6;
}


/* =========================
   CATEGORY
   ========================= */

.category-section {
    margin-bottom: 40px;
}

.category-title {
    font-size: 24px;
    font-weight: bold;
    color: #16233f;

    margin: 0 0 18px 0;

    padding-bottom: 10px;

    border-bottom: 2px solid #e8a33d;
}


/* =========================
   PRODUCT GRID
   ========================= */

.grid {
    display: grid;

    grid-template-columns:
        repeat(5, minmax(0, 1fr));

    gap: 20px;
}


/* =========================
   PRODUCT CARD
   ========================= */

.card {
    background: white;

    border-radius: 12px;

    overflow: hidden;

    border: 1px solid #e3e7ee;

    box-shadow:
        0 3px 12px rgba(0,0,0,0.08);

    transition: 0.2s;

    display: flex;

    flex-direction: column;

    min-width: 0;
}

.card:hover {
    transform: translateY(-3px);

    box-shadow:
        0 7px 20px rgba(0,0,0,0.12);
}


/* =========================
   IMAGE
   ========================= */

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


/* =========================
   PRODUCT INFO
   ========================= */

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


/* =========================
   CART
   ========================= */

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


/* =========================
   RESPONSIVE
   ========================= */

@media (max-width: 1200px) {

    .grid {
        grid-template-columns:
            repeat(4, 1fr);
    }

}


@media (max-width: 950px) {

    .grid {
        grid-template-columns:
            repeat(3, 1fr);
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
        grid-template-columns:
            repeat(2, 1fr);

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

    .category-title {
        font-size: 20px;
    }

    .filter-options {
        flex-direction: column;

        align-items: stretch;
    }

    .filter-select,
    .apply-filter,
    .clear-filter {
        width: 100%;
    }

}

</style>


<script>

/* =========================
   SEARCH
   ========================= */

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
            card.dataset.name
                .toLowerCase();

        if (
            text === ""
            ||
            name.includes(text)
        ) {

            card.style.display = "";

        } else {

            card.style.display = "none";
        }

    });

}


/* =========================
   OPEN / CLOSE FILTER
   ========================= */

function toggleFilter() {

    const filterBox =
        document.getElementById("filterBox");

    filterBox.classList.toggle("show");

}


/* =========================
   APPLY FILTER
   ========================= */

function applyProductFilter() {

    const priceFilter =
        document.getElementById(
            "priceFilter"
        ).value;

    const sortFilter =
        document.getElementById(
            "sortFilter"
        ).value;

    const cards =
        Array.from(
            document.querySelectorAll(".card")
        );


    /*
     * PRICE FILTER
     */

    cards.forEach(function(card) {

        const price =
            parseFloat(
                card.getAttribute(
                    "data-price"
                )
            );

        let show = true;


        if (
            priceFilter ===
            "under500"
        ) {

            show =
                price < 500;

        }

        else if (
            priceFilter ===
            "500to1000"
        ) {

            show =
                price >= 500
                &&
                price <= 1000;

        }

        else if (
            priceFilter ===
            "1000to2000"
        ) {

            show =
                price > 1000
                &&
                price <= 2000;

        }

        else if (
            priceFilter ===
            "above2000"
        ) {

            show =
                price > 2000;

        }


        card.style.display =
            show ? "" : "none";

    });


    /*
     * SORT
     */

    const grids =
        document.querySelectorAll(".grid");


    grids.forEach(function(grid) {

        const gridCards =
            Array.from(
                grid.querySelectorAll(".card")
            );


        if (
            sortFilter ===
            "low"
        ) {

            gridCards.sort(
                function(a, b) {

                    return (
                        parseFloat(
                            a.getAttribute(
                                "data-price"
                            )
                        )
                        -
                        parseFloat(
                            b.getAttribute(
                                "data-price"
                            )
                        )
                    );

                }
            );

        }


        else if (
            sortFilter ===
            "high"
        ) {

            gridCards.sort(
                function(a, b) {

                    return (
                        parseFloat(
                            b.getAttribute(
                                "data-price"
                            )
                        )
                        -
                        parseFloat(
                            a.getAttribute(
                                "data-price"
                            )
                        )
                    );

                }
            );

        }


        else if (
            sortFilter ===
            "name"
        ) {

            gridCards.sort(
                function(a, b) {

                    return (
                        a.dataset.name
                            .toLowerCase()
                            .localeCompare(
                                b.dataset.name
                                    .toLowerCase()
                            )
                    );

                }
            );

        }


        gridCards.forEach(
            function(card) {

                grid.appendChild(card);

            }
        );

    });

}


/* =========================
   CLEAR FILTER
   ========================= */

function clearProductFilter() {

    document.getElementById(
        "priceFilter"
    ).value = "all";


    document.getElementById(
        "sortFilter"
    ).value = "relevance";


    const cards =
        document.querySelectorAll(".card");


    cards.forEach(
        function(card) {

            card.style.display = "";

        }
    );

}


/* =========================
   PRODUCT IMAGE MAPPING
   ========================= */

function getProductImage(name) {

    name = name.toLowerCase().trim();


    if (name.includes("bluetooth speaker"))
        return "https://cdn.phototourl.com/member/2026-09-19-0daac560-e198-4678-917c-87428ff62501.jpg";


    if (name.includes("laptop bag"))
        return "https://cdn.phototourl.com/member/2026-09-19-8e8fb42b-8a9d-4361-9619-ef6027b75bae.jpg";


    if (name.includes("mouse"))
        return "https://images.unsplash.com/photo-1527814050087-3793815479db?auto=format&fit=crop&w=600&q=80";


    if (name.includes("mobile phone stand"))
        return "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mobile%20holder.jpg";


    if (
        name.includes("camera")
        ||
        name.includes("web camera")
    )
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


    if (
        name.includes("paper clip")
        ||
        name.includes("paper clips")
        ||
        name === "clips"
    )
        return "https://cdn.phototourl.com/free/2026-09-20-a9b790aa-7d3b-4dad-851c-e1657b64a312.jpg";


    if (name.includes("highlighter"))
        return "https://cdn.phototourl.com/member/2026-09-20-0a8650ec-5815-424e-90c8-b52b3048742b.jpg";


    if (
        name.includes("kids pen set")
        ||
        name.includes("pen set")
    )
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


    if (
        name.includes("comb set")
        ||
        name.includes("combo set")
    )
        return "https://cdn.phototourl.com/member/2026-09-20-f5860e8a-c126-4a25-ac56-4cc928bc7f32.jpg";


    if (name.includes("sunglasses"))
        return "https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=600&q=80";


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


    /*
     * FINAL FALLBACK
     *
     * Uses product name so products without
     * a specific mapping don't show the
     * smartwatch image.
     */

    return "https://loremflickr.com/600/600/"
        + encodeURIComponent(
            name.replace(/\s+/g, ",")
        )
        + "?lock=1";
}


/* =========================
   IMAGE FALLBACK
   ========================= */

function useMappedImage(image) {

    const productName =
        image.getAttribute(
            "data-product-name"
        );

    const fallbackUsed =
        image.getAttribute(
            "data-fallback-used"
        );


    if (fallbackUsed === "yes") {
        return;
    }


    image.setAttribute(
        "data-fallback-used",
        "yes"
    );


    const mappedImage =
        getProductImage(productName);


    image.onerror = function() {

        image.onerror = null;

        image.src =
            "https://loremflickr.com/600/600/"
            + encodeURIComponent(
                productName
                    .toLowerCase()
                    .trim()
                    .replace(/\s+/g, ",")
            )
            + "?lock=2";

    };


    image.src = mappedImage;
}

</script>

</head>


<body>


<!-- =========================
     NAVBAR
     ========================= -->

<div class="navbar">

    <div class="logo">
        Sushmitha<span>Mart</span>
    </div>


    <div class="search">

        <input
            id="searchBox"
            type="text"
            placeholder="Search for products..."
            value="<%= searchText != null ? searchText : "" %>"
            onkeyup="searchProducts()">

    </div>


    <div class="links">

        <a href="index.jsp">
            Home
        </a>


        <a href="products.jsp?category=all">
            Products
        </a>


        <a href="cart">
            Cart
        </a>


        <a href="orders.jsp">
            Orders
        </a>


        <a href="checkout.jsp">
            Checkout
        </a>


        <a href="login.jsp">
            Logout
        </a>

    </div>

</div>


<!-- =========================
     MAIN
     ========================= -->

<div class="container">


<%

    if (selectedCategory != null
            && !selectedCategory.isEmpty()
            && !selectedCategory.equalsIgnoreCase("all")) {

%>


    <h1>
        <%= selectedCategory %>
    </h1>


    <p class="subtitle">

        Products from
        <%= selectedCategory %>
        category.

    </p>


<%

    }

    else if (searchText != null
            && !searchText.isEmpty()) {

%>


    <h1>
        Search Results
    </h1>


    <p class="subtitle">

        Results for:
        <strong>
            <%= searchText %>
        </strong>

    </p>


<%

    }

    else {

%>


    <h1>
        All Products
    </h1>


    <p class="subtitle">

        Explore our products and add your favourites to cart.

    </p>


<%

    }

%>


<!-- =========================
     FILTER BUTTON
     ========================= -->

<div class="filter-bar">

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


<!-- =========================
     FILTER PANEL
     ========================= -->

<div
    id="filterBox"
    class="filter-box">


    <div class="filter-title">

        Filter Products

    </div>


    <div class="filter-options">


        <span class="filter-label">
            Price
        </span>


        <select
            id="priceFilter"
            class="filter-select">


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


        <span class="filter-label">
            Sort
        </span>


        <select
            id="sortFilter"
            class="filter-select">


            <option value="relevance">
                Relevance
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


        <button
            type="button"
            class="apply-filter"
            onclick="applyProductFilter()">

            Apply

        </button>


        <button
            type="button"
            class="clear-filter"
            onclick="clearProductFilter()">

            Clear

        </button>


    </div>

</div>


<!-- =========================
     PRODUCTS
     ========================= -->

<%

    if (categoryProducts != null
            && !categoryProducts.isEmpty()) {


        for (
            Map.Entry<String, List<Product>> entry :
            categoryProducts.entrySet()
        ) {


            String categoryName =
                    entry.getKey();


            List<Product> categoryList =
                    entry.getValue();

%>


    <div class="category-section">


        <h2 class="category-title">

            <%= categoryName %>

        </h2>


        <div class="grid">


<%

            for (Product p : categoryList) {


                String sellerImage =
                        p.getImage();


                if (sellerImage == null) {

                    sellerImage = "";

                }


                sellerImage =
                        sellerImage.trim();


                String imageUrl;


                /*
                 * IMAGE CODE
                 */

                if (sellerImage.isEmpty()) {


                    imageUrl =
                        request.getContextPath()
                        + "/images/default-product.jpg";


                }


                else if (
                    sellerImage.startsWith(
                        "http://"
                    )
                    ||
                    sellerImage.startsWith(
                        "https://"
                    )
                ) {


                    imageUrl =
                        sellerImage;


                }


                else {


                    String fileName =
                            sellerImage;


                    int slashIndex =
                            fileName.lastIndexOf('/');


                    if (slashIndex >= 0) {


                        fileName =
                                fileName.substring(
                                    slashIndex + 1
                                );

                    }


                    imageUrl =
                        request.getContextPath()
                        + "/product-image?file="
                        + URLEncoder.encode(
                            fileName,
                            "UTF-8"
                        );

                }

%>


        <div
            class="card"
            data-name="<%= p.getName() %>"
            data-price="<%= p.getPrice() %>">


            <div class="image-area">


                <img
                    class="product-image"

                    src="<%= imageUrl %>"

                    alt="<%= p.getName() %>"

                    data-product-name="<%= p.getName() %>"

                    data-seller-image="<%= sellerImage %>"

                    data-fallback-used="no"

                    onerror="useMappedImage(this)">


            </div>


            <div class="info">


                <div class="name">

                    <%= p.getName() %>

                </div>


                <div class="description">


<%

                if (
                    p.getDescription() != null
                    &&
                    !p.getDescription()
                        .trim()
                        .isEmpty()
                ) {

%>


                    <%= p.getDescription() %>


<%

                }

                else {

%>


                    Quality product from SushmithaMart.


<%

                }

%>


                </div>


                <div class="price">

                    &#8377;<%= String.format(
                        "%.0f",
                        p.getPrice()
                    ) %>

                </div>


                <div class="stock">

                    Available:
                    <%= p.getQuantity() %>

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

%>


        </div>

    </div>


<%

        }

    }

    else {

%>


    <p>
        No products found.
    </p>


<%

    }

%>


</div>


</body>

</html>