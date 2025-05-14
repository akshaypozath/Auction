<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<html>
  <head>

    <!-- ... -->
    <link rel="stylesheet" href="auction.css" />
    <style>
        .content-wrapper {
            display: grid; 
            justify-content: center;
        }
    </style>
  </head>
  <%!
	
  ResultSet getQuestion(String squestion){
		 
		 String SelectString = "" ;
		 ResultSet RS = null;
		 Connection con = null;
		 Statement stmt = null;
		 
		 
		 try{
			 ApplicationDB db = new ApplicationDB();    
		     con = db.getConnection();
		     //Create a SQL statement
			stmt = con.createStatement();
			if(squestion != ""){
				 SelectString = "SELECT a.Question, a.userid custid, a.date_question, "+
								"b.* FROM finalproject_schema.Question a " +
		 						"LEFT JOIN finalproject_schema.Answer b ON a.QuestionID = b.QuestionID WHERE Question LIKE '%"+squestion+"%'";
			 }
			 else{
				 SelectString = "SELECT a.Question, a.userid custid, a.date_question, "+
									"b.* FROM finalproject_schema.Question a " +
		 							"LEFT JOIN finalproject_schema.Answer b ON a.QuestionID = b.QuestionID ";
			 }
			 PreparedStatement PS = con.prepareStatement(SelectString);
		     RS = PS.executeQuery();
		
		       return RS;
			 
		 }catch (Exception ex) {
		        /* out.print(ex);
		        out.print("Select failed"); */
		    	return RS;
		        
		 }
		 
	}
  
  ResultSet getAlerts(String userid, String spname){
		 
		 String SelectString = "" ;
		 ResultSet RS = null;
		 Connection con = null;
		 Statement stmt = null;
		 
		 
		 try{
			 ApplicationDB db = new ApplicationDB();    
		     con = db.getConnection();
		     //Create a SQL statement
			stmt = con.createStatement();
		     
			if(spname != ""){
				 SelectString = "SELECT * FROM userAlerts "+
										" WHERE pname LIKE '%"+spname+"%' AND userid = '"+userid+"'";
			 }
			 else{
				 SelectString = "SELECT * FROM userAlerts "+
										" WHERE userid = '"+userid+"'";
			 }
			 PreparedStatement PS = con.prepareStatement(SelectString);
		     RS = PS.executeQuery();
		
		       return RS;
			 
		 }catch (Exception ex) {
		        /* out.print(ex);
		        out.print("Select failed"); */
		    	return RS;
		        
		 }
		 
	}
	
	
%>
  
  <body>
  
    <%@ include file= "00-1-NavMenu.jsp"%>
  
    
    <%
    	
    	
   
  		String SQLtext = "";
  		String userid = (String) session.getAttribute("userid");
  		String spname = "";
  		if(request.getParameter("spname") != null){
  			spname = request.getParameter("spname");
  		}
		ResultSet RS = getAlerts(userid,spname);
		
		
		
    %>
    
  
    <div class="content-wrapper">
      <p class="title">Review Alerts for the user</p>
      <input type="text" name="aid" id="aid" value="<%= userid %>" readonly>  
      <form method="get" action="ListAlertforUser.jsp">
		    <table>
		        <tr>    
		            <td>Product Search</td><td><input type="text" name="spname"></td>
		        </tr>
		    </table>
    		<input type="submit" value="Search" name="clickedButton1">
	 </form>

      
     <table border="1">
			<tr>
				<th>Alert User</th>
				<th>Product Name</th>
				<th>Alert Description</th>
				<th>Alert Date</th>
 			</tr>
 		 	<% 
 				 ///out.print(RS.next());
 		 	while(RS.next()){ %>
           	<TR>
    			<TD> <%= RS.getString("userid") %></td>
    			<TD> <%= RS.getString("pname") %></TD>
    			<TD> <%= RS.getString("notification") %></TD>
    			<TD> <%= RS.getTimestamp("alert date") %></TD>
    			
            </TR>
            <% } %>
      </table>
    </div>
    
  
  </body>
</html>
