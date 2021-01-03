<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.io.*" %>
	<%@ page import="java.sql.*" %>
	<%@ page import="java.lang.ClassNotFoundException" %>
	<%@  include file = "fun.jsp"%>
<% 

		if(null == session.getAttribute("name")){
			response.sendRedirect("login.jsp");
		
		}else{
			int id=Integer.valueOf(request.getParameter("id_trans"));
			cancel_trans(id);
 			response.sendRedirect("show_transactions.jsp");
			 
		}
%>
</body>
</html>