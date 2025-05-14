<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" href="login.css" />
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login Landing Page</title>
	</head>
	
	<body>
		<%@ include file= "00-1-NavMenu.jsp"%>
		<div class="logincontent">
		
			<% out.println("Login with UserName & Password"); %> 
			<!-- output the same thing, but using jsp programming -->
			
			
			<br>
				<form method="get" action="Login.jsp">
					<table>
						<tr>    
							<td>UserName</td><td><input type="text" name="userid"></td>
						</tr>
						<tr>
							<td>Password</td><td><input type="text" name="password"></td>
						</tr>
						
					</table>
					<input type="submit" value="Login">
				</form>
			<br>
		
		</div>
		
		

	</body>
</html>