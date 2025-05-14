<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
  
  <script>
	function redirectToAuctionListPickUp(){
			 window.location.href = "auctionListPickUp.jsp";
	}
	function redirectToAuctionListSUV(){
		 window.location.href = "auctionListSUV.jsp";
	}
	function redirectToAuctionListSportsCar(){
		 window.location.href = "auctionListSportsCar.jsp";
	}
	function showLoginAlert(){
		alert("Please log in.");
	}
</script>
 
  
<% 
  String userIdLanding = (String) session.getAttribute("userid");
/* String category = ""; 
if (category != null) {
    session.setAttribute("category", category);
} */

String category = "";


%>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buyme Landing Page</title>
    <!-- ... -->
    <link rel="stylesheet" href="landingPage.css" />
  </head>
 
  <body>
     <%@ include file= "00-1-NavMenu.jsp"%>
     <div class="page-wrapper">
     <div class="content">
      	<p class="title">Welcome to BuyMe!</p>
      	<p class="sub-title">Find a Vehicle</p>
    </div>
     <div class="categorylisting">
     	<div class="pickup">
     		<%-- <h1 class="item-title" <% if (userId != null) { %> onClick= " handleClickPickUp()" <% } else { %> onClick="showLoginAlert()" <% } %>>Pickup Truck</h1> --%>
     		 
     		 <%-- <a class="item-title" href="<%= request.getContextPath() + "/item.jsp?auctionID=Pick Up" %>">More Details</a> --%>
     		 
     		 <h1 class="item-title" <% if (userId != null) { %> onClick= "redirectToAuctionListPickUp()" <% } else { %> onClick="showLoginAlert()" <% } %>>Pickup Truck</h1>
     		<img class= "carImage" src="Pickuptruck.jpg" alt="Pickup Truck">
     	</div>
     	<div class= "SUV">
     		<h1 class="item-title" <% if (userId != null) { %> onClick= "redirectToAuctionListSUV()" <% } else { %> onClick="showLoginAlert()" <% } %>>SUV</h1>
     		<img class="carImage" src="SUV.jpg" alt="SUV">
     	</div>
     	<div class= "Sports">
     		<h1 class="item-title" <% if (userId != null) { %> onClick="redirectToAuctionListSportsCar()" <% } else { %> onClick="showLoginAlert()" <% } %>>Sports Car</h1>
     		<img class="carImage" src="SportsCar.jpg" alt="SportsCar">
     	</div>
     </div>
    </div>
  </body>
</html>
