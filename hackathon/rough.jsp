<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title> </title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .header {
            background-color: #232f3e;
            color: white;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .header img {
            height: 50px;
        }
        .header h1 {
            margin: 0;
            margin-left: 20px;
        }
        .search-bar {
            flex-grow: 1;
            margin-left: 20px;
            display: flex;
            align-items: center;
        }
        .search-bar input[type="text"] {
            width: 80%;
            padding: 10px;
            border: none;
            border-radius: 5px;
        }
        .search-bar input[type="submit"] {
            padding: 10px;
            background-color: #febd69;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .nav-links {
            display: flex;
            align-items: center;
        }
        .nav-links a {
            color: white;
            margin-left: 20px;
            text-decoration: none;
        }
        .main-content {
            padding: 20px;
        }
        .carousel {
            background-color: #f5f5f5;
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
        }
        .carousel img {
            max-width: 100%;
            height: auto;
        }
        .section {
            background-color: white;
            padding: 20px;
            margin: 10px 0;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .section h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .product-box {
            display: flex;
            flex-wrap: nowrap;
            overflow-x: auto;
        }
        .product {
            background-color: #f5f5f5;
            padding: 10px;
            margin: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 200px;
            height: 300px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
            flex: 0 0 auto;
        }
        .product img {
            max-width: 100%;
            height: auto;
        }
        .product h3 {
            font-size: 18px;
            color: #333;
        }
        .product p {
            font-size: 16px;
            color: #888;
        }
        .product .price {
            font-size: 20px;
            color: #b12704;
            margin-top: 10px;
        }
        .flex-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 20px;
        }
        .flex-box {
            width: 400px;
            height: 500px;
            background-color: white;
            font-size: 25px;
            text-align: center;
            line-height: 1.2; /* Adjusted for better alignment */
            border-radius: 20px;
            margin: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .flex-box img {
            width: 100%;
            height: 300px;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
        }
        .flex-box h3 {
            margin: 10px 0;
            padding: 0 10px;
            font-size: 18px;
        }
        .flex-box h6 {
            margin: 10px 0;
        }
        .flex-box h6 a {
            text-decoration: none;
            color: #007185;
            font-size: 16px;
        }
        .footer {
            background-color: #232f3e;
            color: white;
            text-align: center;
            padding: 20px;
            position: absolute;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>

<body>


    <div class="header">
        <img src="https://upload.wikimedia.org/wikipedia/commons/a/a9/E-com_logo.svg" alt="E-Com">
        <h1></h1>
        <div class="search-bar">
            <form action="index.jsp" method="get">
                <input type="text" name="search" placeholder="Search for products...">
                <input type="submit" value="Search">
            </form>
        </div>
        <div class="nav-links">
            <a href="#">Home</a>
            <a href="#">Sell</a>
            <a href="#">Order History</a>
            <a href="#">Browse Category</a>
            <a href="#">Cart</a>
            <a href="#">Logout</a>
            </c:if>
        </div>
    </div>

    <div class="main-content">
        <!-- Carousel Section -->
        <div class="carousel">
            <img src="https://assets-global.website-files.com/605826c62e8de87de744596e/6304972b0f458d536743e9d9_reebok.jpg" alt="Carousel Image">
        </div>
        
        <!-- Welcome message -->
        <c:choose>
            <c:when test="${not empty sessionScope.username}">
                <h2>Welcome, user!!</h2>
            </c:when>
            <c:otherwise>
                <h2>Please,login</h2>
            </c:otherwise>
        </c:choose>
      
        
        <!-- Section 1: Featured Products -->
        <div class="section">
            <h2>Featured Products</h2>
            <div class="product-box">
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9" alt="Featured Product 1">
                    <h3>Smartphone</h3>
                    <p class="price">$19.99</p>
                </div>
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1517430816045-df4b7de011b1" alt="Featured Product 2">
                    <h3>Laptop</h3>
                    <p class="price">$29.99</p>
                </div>
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1496181133206-80ce9b88a853" alt="Featured Product 3">
                    <h3>  Tablet</h3>
                    <p class="price">$39.99</p>
                </div>
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1512499617640-c2f9994bc3f9" alt="Featured Product 4">
                    <h3Smartwatch</h3>
                    <p class="price">$49.99</p>
                </div>
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1497294815431-9365093b7331" alt="Featured Product 5">
                    <h3>Headphones</h3>
                    <p class="price">$59.99</p>
                </div>
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1592194996308-ded6d1b8b690" alt="Featured Product 6">
                    <h3>Bluetooth Speaker</h3>
                    <p class="price">$69.99</p>
                </div>
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1568440722974-ebd69c8e3c91" alt="Featured Product 7">
                    <h3>Gaming Console</h3>
                    <p class="price">$79.99</p>
                </div>
                <div class="product">
                    <img src="img/featured8.jpg" alt="Featured Product 8">
                    <h3>Featured Product 8</h3>
                    <p class="price">$89.99</p>
                </div>
            </div>
        </div>

        <!-- Section 2: Best Sellers -->
        <div class="section">
            <h2>Best Sellers</h2>
            <div class="product-box">
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1541807084-5c52b6c6d459
" alt="Best Seller 1">
                    <h3>External Hard Drive</h3>
                    <p class="price">$59.99</p>
                </div>
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1517336714731-489689fd1ca8
" alt="Best Seller 2">
                    <h3>4K Monitor</h3>
                    <p class="price">$69.99</p>
                </div>
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1518770660439-4636190af475" alt="Best Seller 3">
                    <h3>Action Camera</h3>
                    <p class="price">$79.99</p>
                </div>
                <div class="product">
                    <img src="img/bestseller4.jpg" alt="Best Seller 4">
                    <h3>Best Seller 4</h3>
                    <p class="price">$89.99</p>
                </div>
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1514894781622-e51e9f73a360" alt="Best Seller 5">
                    <h3>Self-help</h3>
                    <p class="price">$99.99</p>
                </div>
                <div class="product">
                    <img src="https://images.unsplash.com/photo-1501004318641-b39e6451bec6
" alt="Best Seller 6">
                    <h3>Ficus</h3>
                    <p class="price">$109.99</p>
                </div>
                <div class="product">
                    <img src="img/bestseller7.jpg" alt="Best Seller 7">
                    <h3>Best Seller 7</h3>
                    <p class="price">$119.99</p>
                </div>
                <div class="product">
                    <img src="img/bestseller8.jpg" alt="Best Seller 8">
                    <h3>Best Seller 8</h3>
                    <p class="price">$129.99</p>
                </div>
            </div>
        </div>

        <!-- Additional Sections -->
        <div class="flex-container">
            <div class="flex-box">
                <img src="" alt="Health & Personal Care">
                <h3>Health & Personal Care</h3>
                <h6><a href="#">Shop More</a></h6>
            </div>
            <div class="flex-box">
                <img src="img/buety.jfif" alt="Beauty Picks">
                <h3>Beauty Picks</h3>
                <h6><a href="#">Shop More</a></h6>
            </div>
            <div class="flex-box">
                <img src="img/electronics.webp" alt="Electronics">
                <h3>Electronics</h3>
                <h6><a href="#">Shop More</a></h6>
            </div>
        </div>
    </div>
</body>
</html>
