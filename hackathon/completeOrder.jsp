<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Complete Order</title>
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
        <h2>Order Completion</h2>
        <div class="complete-order-message">
            <%
                String paymentMethod = request.getParameter("payment_method");
                String shippingAddress = (String) session.getAttribute("shipping_address");
                int userId = (Integer) session.getAttribute("user_id");
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                int orderId = -1;
                double totalAmount = 0.0;

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");

                    // Calculate total amount from the cart
                    String query = "SELECT SUM(p.price * c.quantity) AS total_amount FROM Products p JOIN Cart c ON p.product_id = c.product_id WHERE c.user_id = ?";
                    ps = conn.prepareStatement(query);
                    ps.setInt(1, userId);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        totalAmount = rs.getDouble("total_amount");
                    }
                    rs.close();
                    ps.close();

                    // Insert order into Orders table
                    query = "INSERT INTO Orders (user_id, status, total_amount) VALUES (?, 'Pending', ?)";
                    ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
                    ps.setInt(1, userId);
                    ps.setDouble(2, totalAmount);
                    ps.executeUpdate();
                    rs = ps.getGeneratedKeys();
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                    rs.close();
                    ps.close();

                    // Insert order details into OrderDetails table
                    query = "INSERT INTO OrderDetails (order_id, product_id, quantity, price) SELECT ?, product_id, quantity, price FROM Cart WHERE user_id = ?";
                    ps = conn.prepareStatement(query);
                    ps.setInt(1, orderId);
                    ps.setInt(2, userId);
                    ps.executeUpdate();
                    ps.close();

                    // Insert payment into Payments table
                    query = "INSERT INTO Payments (order_id, amount, payment_method) VALUES (?, ?, ?)";
                    ps = conn.prepareStatement(query);
                    ps.setInt(1, orderId);
                    ps.setDouble(2, totalAmount);
                    ps.setString(3, paymentMethod);
                    ps.executeUpdate();
                    ps.close();

                    // Insert shipping into Shipping table
                    query = "INSERT INTO Shipping (order_id, shipping_address, status) VALUES (?, ?, 'Processing')";
                    ps = conn.prepareStatement(query);
                    ps.setInt(1, orderId);
                    ps.setString(2, shippingAddress);
                    ps.executeUpdate();
                    ps.close();

                    // Clear the user's cart
                    query = "DELETE FROM Cart WHERE user_id = ?";
                    ps = conn.prepareStatement(query);
                    ps.setInt(1, userId);
                    ps.executeUpdate();
                    ps.close();

                    // Reset the cart count in the session
                    session.setAttribute("cartCount", 0);

                    out.println("<p>Order completed successfully!</p>");
                    out.println("<p>Your order ID is: " + orderId + "</p>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error completing order. Please try again later.</p>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </div>
    </div>
</body>
</html>
