<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
	<body>
		<%
		String userId = (String) session.getAttribute("userid");
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			//out.print("ApplicationDB Successful");
			Connection con = db.getConnection();
			//out.print("getConnection Successful");
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			//Get parameters from the HTML form at the HelloWorld.jsp
			// String aid = request.getParameter("aid");
			String pname = request.getParameter("pname");
			String startpricestr = request.getParameter("startprice");
			Float startprice=Float.parseFloat(startpricestr);
			String minpricestr = request.getParameter("minprice");
			Float minprice=Float.parseFloat(minpricestr);
			String expiredatetime = request.getParameter("expiredatetime");
			String sub_category = request.getParameter("sub_category");
			
			
			
			LocalDateTime currentTime = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String listdate = currentTime.format(formatter);
			
			int isbiddable= 1;
			int issold=0;
			int is_removed= 0;
			
			
			
			
			
			// const dob1 = new Date(dob);
			
			//out.print(newUser);
			//out.print(newPwd);
		
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String rsIsTrue = "false";
			//String Selectstr = "SELECT * FROM users where userid=? and password=?";
			//String insertStatement = String.format("INSERT INTO `finalproject_schema`.`users` (`fname`, `lname`, `dob`, `email`, `userid`, `password`, `role`)" 
			//		+"VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s');", fname,lname,2023-01-02,email,userid,password);
			
			
			String insertStatement = String.format("INSERT INTO `finalproject_schema`.`auctions` (`isbiddable`, `issold`, `startprice`, `minsell`, `pname`, `scname`, `userid`, `is_removed`, `listdate`, `expdate`)" 
					+" VALUES ('" + isbiddable+ "','" + issold
							+ "','" + startprice + "','" + minprice +
							"','" + pname + "','"+ sub_category+"','"+ userId+"','"+ is_removed+"','"+ listdate+"','"+ expiredatetime+"')");
			
			
			out.println(insertStatement);
			stmt.executeUpdate(insertStatement);
			
	
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			response.sendRedirect("00-0-LandingPage.jsp");
			con.close();
	
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("Insert failed");
		}
	%>
	</body>
</html>