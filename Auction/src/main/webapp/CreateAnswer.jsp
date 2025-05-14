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
  
  
  <body>
  
    <%@ include file= "00-1-NavMenu.jsp"%>
  <!-- <script>
    function goToAnswerQuestion(Question,qid) {
    	//out.print(RS.getString("auction_status"))
    	var url = 'CreateAnswer.jsp' + 
    				'?Question=' + encodeURIComponent(Question) + 
    				'&qid=' + encodeURIComponent(qid);
    	window.location.href = url;
    	
    }
    
    </script> -->
    
    <%
	
	String Question = request.getParameter("Question");
    int qid = Integer.parseInt(request.getParameter("qid"));
	
	
%>
  		
    
  
    <div class="content-wrapper">
	      <%-- <p class="title">Answering Questions</p>
	      <input type="text" name="Question" id="Question" value="<%= Question %>" readonly>
	      <input type="text" name="qid" id="qid" value="<%= qid %>" readonly>    
	      <form method="get" action="InsertAnswer.jsp?qid=<%= qid %>" >
	    <table>
	        <tr> 
	        	 
	            <td>Please enter your answer to the question.</td><td><input type="text" name="answer"></td>
	        </tr>
	    </table>
	    <input type="submit" value="Submit Answer" name="clickedButton1">
		</form> --%>
		
		<form method="get" action="InsertAnswer.jsp?qid=<%= qid %>" >
		    <p class="title">Answering Questions</p>
		    <input type="text" name="Question" id="Question" value="<%= Question %>" readonly>
		    <input type="text" name="qid" id="qid" value="<%= qid %>" readonly>    
		
		    <table>
		        <tr> 
		            <td>Please enter your answer to the question.</td><td><input type="text" name="answer"></td>
		        </tr>
		    </table>
		
		    <input type="submit" value="Submit Answer" name="clickedButton1">
		</form>
		
		
    </div>
    
  
  </body>
</html>
