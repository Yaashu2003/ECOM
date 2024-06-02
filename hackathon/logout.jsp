<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    session.invalidate(); // Invalidate the session
    response.sendRedirect("login.jsp"); // Redirect to login page
%>
l>