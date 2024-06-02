<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Remove from Cart</title>
    <style>
        /* Include your styles from index.jsp here */
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
        .complete-order-message {
            background-color: white;
            padding: 20px;
            margin: 10px 0;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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
        <h2>Removing Item from Cart</h2>
        <div class="complete-order-message">
            <%
                Integer userId = (Integer) session.getAttribute("user_id");
                String productId = request.getParameter("product_id");
                Integer cartCount = (Integer) session.getAttribute("cartCount");

                if (userId == null || productId == null || cartCount == null) {
                    out.println("<p>Error: Missing required parameters. Please try again later.</p>");
                } else {
                    Connection conn = null;
                    PreparedStatement ps = null;

                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");

                        // Remove the item from the cart
                        String query = "DELETE FROM Cart WHERE user_id = ? AND product_id = ?";
                        ps = conn.prepareStatement(query);
                        ps.setInt(1, userId);
                        ps.setInt(2, Integer.parseInt(productId));
                        ps.executeUpdate();
                        ps.close();

                        // Update the cart count in the session
                        cartCount--;
                        session.setAttribute("cartCount", cartCount);

                        out.println("<p>Item removed from cart successfully!</p>");
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error removing item from cart. Please try again later.</p>");
                    } finally {
                        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
            %>
            <p><a href="cart.jsp">Go back to cart</a></p>
        </div>
    </div>
</body>
</html>
