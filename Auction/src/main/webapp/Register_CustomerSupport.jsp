<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" href="registration.css" />
	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login Landing Page</title>
	</head>
	
	<body>
	<%@ include file= "00-1-NavMenu.jsp"%>

		<%
			/* String userid = (String) session.getAttribute("userid");
			String userrole = (String) session.getAttribute("userrole");
			if (userrole != "admin"){
				response.sendRedirect("00-0-LandingPage.jsp");
			} */
		%>
		
		<div class="regContent">
			
			<% out.println("Input all of your Information."); %> 
			<!-- output the same thing, but using  jsp programming -->
			
			<br>
				<form method="get" action="create_customerSupportRep.jsp">
					<table>
						<tr>    
							<td>UserId</td><td><input type="text" name="userid"></td>
						</tr>
						
						<tr>
							<td>Password</td><td><input type="text" name="password"></td>
						</tr>
						
						<tr>    
							<td>First name</td><td><input type="text" name="fname"></td>
						</tr>
						
						<tr>    
							<td>Last Name</td><td><input type="text" name="lname"></td>
						</tr>
						
						<tr>    
							<td>Email</td><td><input type="text" name="email"></td>
						</tr>
						 
						
						<tr>    
							<td>Date Of Birth</td><td><input type="date" name="dob"></td>
						</tr>
					
						
						
					</table>
					<input type="submit" value="Submit">
					
				
				</form>
				
			<br>
		
			
		</div>
		
	</body>
</html>