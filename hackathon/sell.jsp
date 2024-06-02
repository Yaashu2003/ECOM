<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Sell Product</title>
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
        .form-container {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        .form-container h2 {
            margin-top: 0;
        }
        .form-container form {
            display: flex;
            flex-direction: column;
        }
        .form-container label {
            margin-bottom: 10px;
            font-weight: bold;
        }
        .form-container input, .form-container textarea, .form-container select {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        .form-container input[type="submit"] {
            background-color: #232f3e;
            color: white;
            border: none;
            cursor: pointer;
        }
        .form-container input[type="submit"]:hover {
            background-color: #1a242f;
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
            <a href="#">Cart</a>
            <a href="logout.jsp">Logout</a>
            <c:if test="${not empty sessionScope.username}">
                <span class="username">Welcome, ${sessionScope.username}</span>
            </c:if>
        </div>
    </div>

    <div class="main-content">
        <div class="form-container">
            <h2>List a New Product</h2>
            <form action="sell.jsp" method="post">
                <label for="name">Product Name:</label>
                <input type="text" id="name" name="name" required>
                
                <label for="category">Category:</label>
                <select id="category" name="category" required>
                    <!-- Add options dynamically from the database -->
                    <option value="1">Electronics</option>
                    <option value="2">Books</option>
                    <option value="3">Indoor Plants</option>
                    <option value="4">Beauty Picks</option>
                    <option value="5">Shoes</option>
                </select>

                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="5" required></textarea>

                <label for="price">Price:</label>
                <input type="number" id="price" name="price" step="0.01" required>

                <label for="quantity">Stock Quantity:</label>
                <input type="number" id="quantity" name="quantity" required>
                
                <label for="img">img URL</label>
                <input type="text" id="img" name="img" required>

                <input type="submit" value="List Product">
            </form>
            <%
                // Handle form submission
                String name = request.getParameter("name");
                String category = request.getParameter("category");
                String description = request.getParameter("description");
                String price = request.getParameter("price");
                String quantity = request.getParameter("quantity");
                String image_url = request.getParameter("img");

                if(name != null && category != null && description != null && price != null && quantity != null) {
                    Connection conn = null;
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");
                        String query = "INSERT INTO Products (category_id, name, description, price, stock_quantity, image_url) VALUES (?, ?, ?, ?, ?,?)";
                        PreparedStatement pstmt = conn.prepareStatement(query);
                        pstmt.setInt(1, Integer.parseInt(category));
                        pstmt.setString(2, name);
                        pstmt.setString(3, description);
                        pstmt.setDouble(4, Double.parseDouble(price));
                        pstmt.setInt(5, Integer.parseInt(quantity));
                        pstmt.setString(6, image_url);
                        pstmt.executeUpdate();
                        out.println("Product listed successfully!");
                    } catch(Exception e) {
                        e.printStackTrace();
                        out.println("Failed to list product: " + e.getMessage());
                    } finally {
                        if(conn != null) {
                            try {
                                conn.close();
                            } catch(SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
