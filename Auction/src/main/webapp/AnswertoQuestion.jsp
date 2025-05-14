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
				 SelectString = "SELECT a.QuestionID qid, a.Question, a.userid custid, a.date_question, "+
								"b.* FROM finalproject_schema.Question a " +
		 						"LEFT JOIN finalproject_schema.Answer b ON a.QuestionID = b.QuestionID WHERE Question LIKE '%"+squestion+"%'";
			 }
			 else{
				 SelectString = "SELECT a.QuestionID qid, a.Question, a.userid custid, a.date_question, "+
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
	
	
%>
  
  <body>
  
    <%@ include file= "00-1-NavMenu.jsp"%>
  <script>
    function goToAnswerQuestion(Question,qid) {
    	//out.print(RS.getString("auction_status"))
    	var url = 'CreateAnswer.jsp' + 
    				'?Question=' + encodeURIComponent(Question) + 
    				'&qid=' + encodeURIComponent(qid);
    	window.location.href = url;
    	
    }
    
    </script>
    
    <%
    	
    	
   
    	//String category = (String) session.getAttribute("selectedCategory");
  		/* String category = "";
		String getDataType = "All"; // All data, search, sort, search & Sort
		// String s_pname = "Nissan";
		String sort_field = "";
		String sort_order = ""; // DESCor ASC
		
		String s_pname = request.getParameter("spname");
		//String sort_field_html = request.getParameter("pname");
		//String selectedSortChoice = request.getParameter("sub_category");
		String sortoptions = request.getParameter("sub_category");
		if (sortoptions != null) {
            if (sortoptions.equals("pname")) {
            	sort_field = "pname";
            	sort_order= "ASC";
            	
            } else if (sortoptions.equals("ASC")) {
            	sort_order= "ASC";
            	sort_field= "startprice";
            	//sort_field = request.getParameter("sub_category");
            	
            } else if (sortoptions.equals("DESC")) {
            	sort_order= "DESC";
            	sort_field= "startprice";
            }
        } */
		
		//print.
		//System.out.println(sub_category);
		
		
		
		
		/* 
		String clickedButton = request.getParameter("clickedButton");
        if (clickedButton != null) {
            if (clickedButton.equals("Search Product")) {
            	getDataType = "Search";
            	
            } else if (clickedButton.equals("Sort")) {
            	getDataType = "Sort";
            	//sort_field = request.getParameter("sub_category");
            	
            } else if (clickedButton.equals("Search and Sort")) {
            	getDataType = "SearchandSort";
            }
        } */
  		
  		String SQLtext = "";
  		String userIdQA = (String) session.getAttribute("userid");
  		String s_question = "";
  		if(request.getParameter("squestion") != null){
  			s_question = request.getParameter("squestion");
  		}
		ResultSet RS = getQuestion(s_question);
		
		
		
    %>
    
  
    <div class="content-wrapper">
      <p class="title">Welcome to Question and Answer</p>
      <input type="text" name="aid" id="aid" value="<%= userIdQA %>" readonly>  
      	<form method="get" action="AnswertoQuestion.jsp">
    <table>
        <tr>    
            <td>Question Search</td><td><input type="text" name="squestion"></td>
        </tr>
    </table>
    <input type="submit" value="Search" name="clickedButton1">
</form>

      
      	<table border="1">
			<tr>
				<th>Question</th>
				<th>Question ID</th>
				<th>Customer ID</th>
				<th>Question Date</th>
				<th>Answer</th>
				<th>Customer Support ID</th>
				<th>Date Answered</th>
 			</tr>
 		 	<% 
 				 ///out.print(RS.next());
 		 	while(RS.next()){ %>
           	<TR>
    			<TD class ="status" onclick= "goToAnswerQuestion('<%=RS.getString("Question")%>','<%=RS.getInt("qid")%>')"> <%= RS.getString("Question") %></TD>
    			<TD> <%= RS.getInt("qid") %></TD>
    			<TD> <%= RS.getString("custid") %></TD>
    			<TD> <%= RS.getTimestamp("date_question") %></TD>
    			<TD> <%= RS.getString("Answer") %></TD>
    			<TD> <%= RS.getString("userid") %></TD>
    			<TD> <%= RS.getTimestamp("date_Answer") %></TD>
            </TR>
            <% } %>
      </table>
    </div>
    
  
  </body>
</html>
