<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Product Details</title>
    <style>
        /* Include styles from index.jsp here */
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
            margin-left: 20px;
        }
        .dropbtn {
            background-color: transparent;
            color: white;
            padding: 14px;
            font-size: 16px;
            border: none;
            cursor: pointer;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }
        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }
        .dropdown-content a:hover {background-color: #f1f1f1;}
        .dropdown:hover .dropdown-content {display: block;}
        .dropdown:hover .dropbtn {background-color: #232f3e;}
        .main-content {
            padding: 20px;
        }
        .product-details {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .product-details img {
            max-width: 100%;
            height: auto;
        }
        .product-details h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .product-details p {
            font-size: 16px;
            margin: 10px 0;
        }
        .product-details .price {
            font-size: 20px;
            color: #b12704;
            margin-top: 10px;
        }
        .product-details .buttons {
            display: flex;
            flex-direction: column;
        }
        .product-details .buttons button {
            background-color: #febd69;
            border: none;
            padding: 10px;
            margin: 5px 0;
            cursor: pointer;
            border-radius: 5px;
            width: 100%;
        }
        .product-details .buttons button:hover {
            background-color: #e2a55f;
        }
        .reviews {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .review {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        .review:last-child {
            border-bottom: none;
        }
        .review h4 {
            margin: 0 0 5px;
        }
        .review p {
            margin: 0;
        }
        .add-review {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .add-review textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
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
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int productId = Integer.parseInt(request.getParameter("product_id"));
            String username = (String) session.getAttribute("username");
            int userId = -1;
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");

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

                String query = "SELECT * FROM Products WHERE product_id = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, productId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
        %>
                    <div class="product-details">
                        <img src="<%= rs.getString("image_url") %>" alt="<%= rs.getString("name") %>">
                        <h2><%= rs.getString("name") %></h2>
                        <p><%= rs.getString("description") %></p>
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

        <div class="reviews">
            <h3>Reviews</h3>
            <%
                conn = null;
                pstmt = null;
                rs = null;
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");

                    String reviewQuery = "SELECT r.*, u.username FROM Reviews r JOIN users1 u ON r.user_id = u.user_id WHERE r.product_id = ?";
                    pstmt = conn.prepareStatement(reviewQuery);
                    pstmt.setInt(1, productId);
                    rs = pstmt.executeQuery();

                    boolean hasReviews = false;
                    while (rs.next()) {
                        hasReviews = true;
            %>
                        <div class="review">
                            <h4><%= rs.getString("username") %></h4>
                            <p>Rating: <%= rs.getInt("rating") %></p>
                            <p><%= rs.getString("review_text") %></p>
                        </div>
            <%
                    }
                    if (!hasReviews) {
            %>
                        <p>No reviews yet.</p>
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

        <div class="add-review">
            <h3>Post a Review</h3>
            <form action="postReview.jsp" method="post">
                <input type="hidden" name="product_id" value="<%= productId %>">
                <textarea name="review_text" required></textarea>
                <select name="rating">
                    <option value="1">1 - Poor</option>
                    <option value="2">2 - Fair</option>
                    <option value="3">3 - Good</option>
                    <option value="4">4 - Very Good</option>
                    <option value="5">5 - Excellent</option>
                </select>
                <button type="submit">Submit Review</button>
            </form>
        </div>
    </div>
</body>
</html>
