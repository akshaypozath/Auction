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
   
   <div class="search">
      <p class="title">Search</p>
      <div class="searchOptions">
      <button type="button" class="basic-btn">Status of Bidding</button>
      <button type="button" class="basic-btn">Categories</button>
      <button type="button" class="basic-btn">History Of Bids</button>
      <button type="button" class="basic-btn">List of Auctions</button>
      <button type="button" class="basic-btn">Ask a Question</button>
      
    </div>
    </div>
  </body>
</html>
