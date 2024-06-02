<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Products</title>
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
        .product-box {
            display: flex;
            flex-wrap: wrap;
        }
        .product {
            background-color: #f5f5f5;
            padding: 10px;
            margin: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 200px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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
        .product button {
            background-color: #febd69;
            border: none;
            padding: 10px;
            margin: 5px;
            cursor: pointer;
            border-radius: 5px;
        }
        .product button:hover {
            background-color: #e2a55f;
        }
    </style>
</head>
<body>
    <div class="header">
        <img src="https://upload.wikimedia.org/wikipedia/commons/a/a9/logo.svg" alt="">
        <h1>E-com</h1>
        <div class="search-bar">
            <form action="index.jsp" method="get">
                <input type="text" name="search" placeholder="Search for products...">
                <input type="submit" value="Search">
            </form>
        </div>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="sell.jsp">Sell</a>
            <a href="#">Order History</a>
            <div class="dropdown">
                <button class="dropbtn">Browse Categories</button>
                <div class="dropdown-content">
                    <a href="products.jsp?category_id=1">Health and Personal Care</a>
                    <a href="products.jsp?category_id=2">Electronics</a>
                    <a href="products.jsp?category_id=3">Indoor Plants</a>
                    <a href="products.jsp?category_id=4">Shoes</a>
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
        <div class="product-box">
            <%
                String categoryId = request.getParameter("category_id");
                Connection conn = null;
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");
                    String query = "SELECT * FROM Products WHERE category_id=?";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, Integer.parseInt(categoryId));
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
            %>
                        <div class="product">
                            <img src="product_image_url" alt="Product Image">
                            <h3><%= rs.getString("name") %></h3>
                            <p><%= rs.getString("description") %></p>
                            <p class="price">$<%= rs.getDouble("price") %></p>
                            <button onclick="location.href='buy.jsp?product_id=<%= rs.getInt("product_id") %>'">Buy Now</button>
                            <button onclick="location.href='addToCart.jsp?product_id=<%= rs.getInt("product_id") %>'">Add to Cart</button>
                        </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
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
</body>
</html>
