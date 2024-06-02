<%@ include file="allCss1.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>EBOOK: Login</title>
    <link href="allcomponents/login.css" rel="stylesheet" type="text/css">
</head>
<body style="background: url('img/backgroundreg.jpg'); background-repeat: no-repeat; background-size: cover;">

<div class="back-img"></div>
<div class="box">
    <span class="borderLine"></span>

    <c:if test="${not empty failedMsg}">
        <h5 class="text-center text-danger">${failedMsg}</h5>
        <c:remove var="failedMsg" scope="session"/>
    </c:if>

    <form method="post" action="login.jsp">
        <h2>LOGIN PAGE</h2>
        <div class="inputBox">
            <input type="text" required="required" name="name"/>
            <span>UserName</span>
            <i></i>
        </div>

        <div class="inputBox">
            <input type="password" required="required" name="password"/>
            <span>Password</span>
            <i></i>
        </div>

        <button type="submit" style="background-color: #b3afaf" class="btn btn btn-primary">Submit</button>
        <h4 align="center" style="color: #b3afaf"><a href="register.jsp">or Create Account</a></h4>
    </form>
</div>

<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String username = request.getParameter("name");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    //HttpSession session = request.getSession();  Ensure session is retrieved correctly

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");

        String sql = "SELECT user_id FROM users1 WHERE username = ? AND password = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        rs = ps.executeQuery();

        if (rs.next()) {
            int userId = rs.getInt("user_id");
            session.setAttribute("username", username);
            session.setAttribute("user_id", userId);
            System.out.println("User logged in: " + username + ", User ID: " + userId); // Debug statement
            response.sendRedirect("index.jsp");
        } else {
            session.setAttribute("failedMsg", "Invalid username or password. Please try again.");
            System.out.println("Login failed for user: " + username); // Debug statement
            response.sendRedirect("login.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("failedMsg", "An error occurred. Please try again.");
        response.sendRedirect("login.jsp");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
}
%>

</body>
</html>
