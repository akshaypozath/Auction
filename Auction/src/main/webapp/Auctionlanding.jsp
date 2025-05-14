<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <!-- ... -->
    <link rel="stylesheet" href="auction.css" />
  </head>
  
  <body>
    <%@ include file= "00-1-NavMenu.jsp"%>
    <div class="content">
      <p class="title">Welcome to the Auction!</p>
      <div class="auctionPageOptions">
      <button type="button" class="basic-btn">Create Auction</button>
      <button type="button" class="basic-btn">BID</button>
      <button type="button" class="basic-btn">List Winners</button>
 	</div>  
  
      
    </div>
    
  
  </body>
</html>
