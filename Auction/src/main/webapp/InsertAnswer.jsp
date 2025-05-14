<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
  <HEAD>
    <TITLE>Creating a Method</TITLE>
  </HEAD>
  

<%!
/* String Insert_Question(String userid, String question){
	
	String SelectString = "Insert Success" ;
	ResultSet RS = null;
    Connection con = null;
    Statement stmt = null;
	
	String insertStatement = "";
	
	LocalDateTime currentTime = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    String date_question = currentTime.format(formatter);
    int answer_id = 0; 
    
    
    
	
	try{
		ApplicationDB db = new ApplicationDB();    
        con = db.getConnection();
      	//Create a SQL statement
		stmt = con.createStatement();
      	
		insertStatement = String.format("INSERT INTO `finalproject_schema`.`Question`"
							+" ( `Question`, `userid`, `date_question`)" 
				+" VALUES ('"+ question
						+ "','" + userid + "','" + date_question +
						"'"+")");
      	
		//out.println(insertStatement);
        stmt.executeUpdate(insertStatement);
        
	    //return bid_no;
	    RS.close();
		con.close();
        return insertStatement;
		
	}catch (Exception ex) {
        /* out.print(ex);
        out.print("Select failed"); 
		return insertStatement;
        
 }
}
 */
String Insert_Answer(String Answer, String userid, int QuestionID){
	
	String SelectString = "Insert Success" ;
	ResultSet RS = null;
    Connection con = null;
    Statement stmt = null;
	
	String insertStatement = "";
	
	LocalDateTime currentTime = LocalDateTime.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    String date_answer = currentTime.format(formatter);
    //int answer_id = 0; 
    
    
    
	
	try{
		ApplicationDB db = new ApplicationDB();    
        con = db.getConnection();
      	//Create a SQL statement
		stmt = con.createStatement();
      	
		insertStatement = String.format("INSERT INTO `finalproject_schema`.`Answer`"
							+" ( `Answer`, `userid`, `date_Answer`, `QuestionID` )" 
				+" VALUES ('"+ Answer
						+ "','" + userid + "','" + date_answer + "','"+ QuestionID+"')");
      	
		//out.println(insertStatement);
        stmt.executeUpdate(insertStatement);
        
	    //return bid_no;
	    RS.close();
		con.close();
        return insertStatement;
		
	}catch (Exception ex) {
        /* out.print(ex);
        out.print("Select failed"); */
		return insertStatement;
        
 }
}

	
%>

  <BODY>
    
    

    <%
    String userId = (String) session.getAttribute("userid");
  	String Answer = request.getParameter("answer");
  	int QuestionID = 0;
  	QuestionID = Integer.parseInt(request.getParameter("qid"));
  	Insert_Answer(Answer,userId,QuestionID);
   	//Insert_Question(userId, question);
   	response.sendRedirect("AnswertoQuestion.jsp");
    %>
    
     
     
  </BODY>
</HTML>