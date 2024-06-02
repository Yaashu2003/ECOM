<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*" %>

<%
    int productId = Integer.parseInt(request.getParameter("product_id"));
    String reviewText = request.getParameter("review_text");
    int rating = Integer.parseInt(request.getParameter("rating"));

    Integer userIdObject = (Integer) session.getAttribute("user_id");
    int userId = userIdObject != null ? userIdObject : -1;

    if (userId == -1) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");

        String query = "INSERT INTO Reviews (product_id, user_id, rating, review_text) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, productId);
        pstmt.setInt(2, userId);
        pstmt.setInt(3, rating);
        pstmt.setString(4, reviewText);
        pstmt.executeUpdate();

        response.sendRedirect("productDetails.jsp?product_id=" + productId);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
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
