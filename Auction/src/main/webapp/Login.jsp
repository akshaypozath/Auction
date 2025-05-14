<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
	<body>
		<%
		try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			//out.print("ApplicationDB Successful");
			Connection con = db.getConnection();
			//out.print("getConnection Successful");
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			//Get parameters from the HTML form at the HelloWorld.jsp
			String newUser = request.getParameter("userid");
			String newPwd = request.getParameter("password");
			
			//out.print(newUser);
			//out.print(newPwd);
		
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String rsIsTrue = "false";
			String Selectstr = "SELECT * FROM users where userid=? and password=?";
			//String Selectstr = "SELECT * FROM userInfo where username='user1' and password='password1'";
			//out.print(Selectstr);
			//Run the query against the database.
			PreparedStatement ps = con.prepareStatement(Selectstr);
			ps.setString(1,newUser);
			ps.setString(2,newPwd);
			
			ResultSet result = ps.executeQuery();
			
			String userrole = "";
			
			while (result.next()) {
				
				rsIsTrue = "true";
				userrole = result.getString("role");
				
			}
	
			if (rsIsTrue == "true"){
				
				//window.location.assign("LoginForm.jsp");
				session.setAttribute("userid",newUser);
				session.setAttribute("userrole",userrole);
				response.sendRedirect("00-0-LandingPage.jsp");
				
				//window.location.href = "LoginForm.jsp";
				//location.href = "http://stackoverflow.com";
				//out.print("Login Successful");%>
				
				<%
				// JavaScript
				
				
			}
			else{
				//out.print("Login Failure: Username or password wrong");
				response.sendRedirect("unsuccesful.jsp");
			}
				
	
	
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			
			ps.close();
			result.close();
			con.close();
	
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("Select failed");
		}
	%>
	</body>
</html>