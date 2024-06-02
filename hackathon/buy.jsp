<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String productId = request.getParameter("product_id");
   // HttpSession session = request.getSession();
    String username = (String) session.getAttribute("username");

    Connection conn = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");

        // Get the user_id based on the username from the session
        int userId = -1;
        if (username != null) {
            String userQuery = "SELECT user_id FROM users1 WHERE username = ?";
            PreparedStatement userStmt = conn.prepareStatement(userQuery);
            userStmt.setString(1, username);
            ResultSet userRs = userStmt.executeQuery();
            if (userRs.next()) {
                userId = userRs.getInt("user_id");
            }
            userRs.close();
            userStmt.close();
        }

        if (userId != -1) {
            String query = "INSERT INTO Cart (user_id, product_id, quantity) VALUES (?, ?, 1)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, Integer.parseInt(productId));
            pstmt.executeUpdate();

            Integer cartCount = (Integer) session.getAttribute("cartCount");
            if (cartCount == null) {
                cartCount = 0;
            }
            cartCount++;
            session.setAttribute("cartCount", cartCount);

            response.sendRedirect("checkout.jsp");
        } else {
            response.sendRedirect("login.jsp");
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
