<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, javax.servlet.http.HttpSession" %>
<%@ page import="java.lang.ClassNotFoundException" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>EBOOK: Index</title>
<%@ include file="allCss1.jsp" %>
<link href="Signup_reg.css" rel="stylesheet" type="text/css">
<script>
function validateForm() {
    var password = document.forms["registerForm"]["Password"].value;
    var confirmPassword = document.forms["registerForm"]["ConPassword"].value;
    if (password !== confirmPassword) {
        alert("Passwords do not match.");
        return false;
    }
    return true;
}
</script>
</head>
<body style="background: url('backgroundreg.jpg'); background-repeat: no-repeat; background-size: cover;">

<div class="back-img"></div>
<div class="box">
    <span class="borderLine"></span>
    <form name="registerForm" method="post" action="register.jsp" onsubmit="return validateForm()">
        <h2>Create New Profile</h2>
        <c:if test="${not empty succMSG}">
            <p class="text-center text-success">${succMSG}</p>
            <c:remove var="succMSG" />
        </c:if>
        <c:if test="${not empty failedMSG}">
            <p class="text-center text-danger">${failedMSG}</p>
            <c:remove var="failedMSG" />
        </c:if>
        <div class="inputBox">
            <input type="text" required="required" name="userName" />
            <span>UserName</span>
            <i></i>
            <i></i>
        </div>
        <div class="inputBox">
            <input type="text" required="required" name="Phno" />
            <span>Phno</span>
            <i></i>
            <i></i>
        </div>
        <div class="inputBox">
            <input type="email" required="required" name="Email" />
            <span>Email ID</span>
            <i></i>
        </div>
        <div class="inputBox">
            <input type="password" required="required" name="Password" />
            <span>Password</span>
            <i></i>
        </div>
        <div class="inputBox">
            <input type="password" required="required" name="ConPassword" />
            <span>Confirm Password</span>
            <i></i>
        </div>
        <div class="links">
            <input type="reset" value="Reset" />
            <input type="submit" value="Register">
        </div>
    </form>
</div>

<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String userName = request.getParameter("userName");
    String phno = request.getParameter("Phno");
    String email = request.getParameter("Email");
    String password = request.getParameter("Password");
    String confirmPassword = request.getParameter("ConPassword");

    if (password.equals(confirmPassword)) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "system", "system");
            String sql = "INSERT INTO users1 (username, password, email) VALUES (?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, userName);
            ps.setString(2, password);
            ps.setString(3, email);

            int result = ps.executeUpdate();
            if (result > 0) {
                request.getSession().setAttribute("succMSG", "Account successfully created. Please login.");
                response.sendRedirect("login.jsp");
            } else {
                request.getSession().setAttribute("failedMSG", "Registration failed. Please try again.");
                response.sendRedirect("register.jsp");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.getSession().setAttribute("failedMSG", "An error occurred. Please try again.");
            response.sendRedirect("register.jsp");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        request.getSession().setAttribute("failedMSG", "Passwords do not match.");
        response.sendRedirect("register.jsp");
    }
}
%>

</body>
</html>
