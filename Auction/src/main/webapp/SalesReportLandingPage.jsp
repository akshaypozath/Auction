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
  
  				<a href="SalesReport0.jsp" class = "earnings">Earnings Report for Auctions</a>
			    <a href="SalesReport1.jsp" class = "earnings">Earnings Report for Best Buyer</a>
			    <a href="SalesReport2.jsp" class = "earnings">Earnings Report for Best Selling Item</a>
			    <a href="SalesReport3.jsp" class = "earnings">Earnings Report by Sub Category</a>
    
  
  </body>
</html>
