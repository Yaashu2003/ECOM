<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Homepage</title>
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
        .nav-links .username {
            margin-left: 20px; /* Add margin to the username span */
        }
        /* Dropdown Button */
        .dropbtn {
            background-color: transparent;
            color: white;
            padding: 14px;
            font-size: 16px;
            border: none;
            cursor: pointer;
        }
        /* Dropdown Content (Hidden by Default) */
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }
        /* Links inside the dropdown */
        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }
        /* Change color of dropdown links on hover */
        .dropdown-content a:hover {background-color: #f1f1f1;}
        /* Show the dropdown menu on hover */
        .dropdown:hover .dropdown-content {display: block;}
        /* Change the background color of the dropdown button when the dropdown content is shown */
        .dropdown:hover .dropbtn {background-color: #232f3e;}

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
            height: 380px; /* Adjusted height to fit buttons */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
            flex: 0 0 auto;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
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
        .product .buttons {
            display: flex;
            flex-direction: column;
        }
        .product .buttons button {
            background-color: #febd69;
            border: none;
            padding: 10px;
            margin: 5px 0;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
        }
        .product .buttons button:hover {
            background-color: #e2a55f;
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
        
        <h1>E-com</h1>
        <div class="search-bar">
            <form action="searchResults.jsp" method="get">
                <input type="text" name="search" placeholder="Search for products...">
                <input type="submit" value="Search">
            </form>
        </div>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="sell.jsp">Sell</a>
            <a href="orderHistory.jsp">Order History</a>
            <div class="dropdown">
                <button class="dropbtn">Browse Categories</button>
                <div class="dropdown-content">
                    <a href="products.jsp?category_id=4">Health and Personal Care</a>
                    <a href="products.jsp?category_id=1">Electronics</a>
                    <a href="products.jsp?category_id=3">Indoor Plants</a>
                    <a href="products.jsp?category_id=2">Books</a>
                    <a href="products.jsp?category_id=5">Shoes</a>
                </div>
            </div>
            <a href="cart.jsp">Cart (<span id="cart-count">${sessionScope.cartCount}</span>)</a>
            <a href="logout.jsp">Logout</a>
            <c:if test="${not empty sessionScope.username}">
                <span class="username">Welcome, ${sessionScope.username}</span>
            </c:if>
        </div>
    </div>

    <div class="main-content">
        <!-- Carousel Section -->
        <div class="carousel">
            <img src="carousel-image.jpg" alt="Carousel Image">
        </div>
        
        <!-- Welcome message -->
        <c:choose>
            <c:when test="${not empty sessionScope.username}">
                <h2>Welcome, ${sessionScope.username}</h2>
            </c:when>
            <c:otherwise>
                <h2>Welcome, please login</h2>
            </c:otherwise>
        </c:choose>

        <!-- Section 1: Featured Products -->
        <div class="section">
            <h2>Featured Products</h2>
            <div class="product-box">
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    String username = (String) session.getAttribute("username");
                    int userId = -1;
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");

                        // Get the user_id based on the username from the session
                        if (username != null) {
                            String userQuery = "SELECT user_id FROM users1 WHERE username = ?";
                            PreparedStatement userStmt = conn.prepareStatement(userQuery);
                            userStmt.setString(1, username);
                            ResultSet userRs = userStmt.executeQuery();
                            if (userRs.next()) {
                                userId = userRs.getInt("user_id");
                                session.setAttribute("user_id", userId);
                            }
                            userRs.close();
                            userStmt.close();
                        }

                        String query = "SELECT * FROM (SELECT * FROM Products WHERE rownum <= 7) ORDER BY product_id";
                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                %>
                            <div class="product" onclick="location.href='productDetails.jsp?product_id=<%= rs.getInt("product_id") %>'">
                                <img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("name") %>">
                                <h3><%= rs.getString("name") %></h3>
                                <p class="price">$<%= rs.getDouble("price") %></p>
                                <div class="buttons">
                                    <button onclick="location.href='buy.jsp?product_id=<%= rs.getInt("product_id") %>&user_id=<%= userId %>'">Buy Now</button>
                                    <button onclick="location.href='addToCart.jsp?product_id=<%= rs.getInt("product_id") %>&user_id=<%= userId %>'">Add to Cart</button>
                                </div>
                            </div>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) {
                            try {
                                rs.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (pstmt != null) {
                            try {
                                pstmt.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </div>
        </div>

        <!-- Section 2: Best Sellers -->
        <div class="section">
            <h2>Best Sellers</h2>
            <div class="product-box">
                <%
                    conn = null;
                    pstmt = null;
                    rs = null;
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");

                        // Get the user_id based on the username from the session
                        if (username != null) {
                            String userQuery = "SELECT user_id FROM users1 WHERE username = ?";
                            PreparedStatement userStmt = conn.prepareStatement(userQuery);
                            userStmt.setString(1, username);
                            ResultSet userRs = userStmt.executeQuery();
                            if (userRs.next()) {
                                userId = userRs.getInt("user_id");
                                session.setAttribute("user_id", userId);
                            }
                            userRs.close();
                            userStmt.close();
                        }

                        String query = "SELECT * FROM (SELECT * FROM Products ORDER BY product_id DESC) WHERE rownum <= 7 ORDER BY product_id ASC";
                        pstmt = conn.prepareStatement(query);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                %>
                            <div class="product" onclick="location.href='productDetails.jsp?product_id=<%= rs.getInt("product_id") %>'">
                                <img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("name") %>">
                                <h3><%= rs.getString("name") %></h3>
                                <p class="price">$<%= rs.getDouble("price") %></p>
                                <div class="buttons">
                                    <button onclick="location.href='buy.jsp?product_id=<%= rs.getInt("product_id") %>&user_id=<%= userId %>'">Buy Now</button>
                                    <button onclick="location.href='addToCart.jsp?product_id=<%= rs.getInt("product_id") %>&user_id=<%= userId %>'">Add to Cart</button>
                                </div>
                            </div>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) {
                            try {
                                rs.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (pstmt != null) {
                            try {
                                pstmt.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </div>
        </div>

        <!-- Additional Sections -->
          <div class="flex-container">
        <a href="products.jsp?category_id=4">     <div class="flex-box">
                <img src="img/healthcare.jpg" alt="Health & Personal Care">
                <h3>Health & Personal Care</h3>
                
            </div></a>
         <a href="products.jsp?category_id=3">  <div class="flex-box" >
                <img src="img/buety.jfif" alt="Beauty Picks">
                <h3>Beauty Picks</h3>
                
            </div></a>
           <a href="products.jsp?category_id=1">    <div class="flex-box">
                <img src="img/electronics.webp" alt="Electronics">
                <h3>Electronics</h3>
                
            </div></a>
        </div>
    </div>
</body>
</html>
