<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>





<script>
	// define all the other routing you need to do here!
	function redirectToHome() {
		// Redirect to the auction page
		window.location.href = "00-0-LandingPage.jsp";
	}
	
	function redirectToLogin() {
		// Redirect to the auction page
		window.location.href = "LoginForm.jsp";
	}
	function redirectToRegistration() {
		// Redirect to the auction page
		window.location.href = "Registration.jsp";
	}
	
	
	
	function redirectToAdmin() {
		// Redirect to the auction page
		window.location.href = 'AdminLanding.jsp';
	}
	function redirectToAuction() {
		// Redirect to the auction page
		window.location.href = 'Auctionlanding.jsp';
	}
	function redirectToSearch() {
		// Redirect to the auction page
		window.location.href = 'SearchLanding.jsp';
	}
	function redirectToLogOut(){
		window.location.href = 'Logout.jsp';
	}
	
		
</script>

<%
  String userId = (String) session.getAttribute("userid");	
%>


<link rel="stylesheet" href="NavMenu.css" />
<div class=navBar>
	 <button type="button" class="basic-btn" onclick="redirectToHome()">Home</button>
	 <% if (userId != null) { %>
	 <div class="dropdown">
		<button type="button" class="basic-btn">Auction</button>
			<div class="dropdown-options1">
			    <a href="CreateListing.jsp">Create Auction</a>
			    <a href="ListAlertforUser.jsp">Customer Alerts</a>
			    <a href="auctionListWinners.jsp">Winner List</a>
			    <a href="QuestionAndAnswer.jsp">Customer Q & A</a>
			</div>
	</div>
	<div class="dropdown">
		<button type="button" class="basic-btn">Admin</button>
			<div class="dropdown-options1">
			    <a href="Register_CustomerSupport.jsp">Create Customer Support</a>
			    <a href="SalesReportLandingPage.jsp" class = "earnings">Earnings Reports</a>
			    <a href="AnswertoQuestion.jsp">Customer Service: Q & A </a>
			</div>
	</div>
	<%}%>
	<% if (userId == null) { %>
	<button type="button" class="basic-btn" onclick="redirectToLogin()">Login</button>
	<%}%>
	<% if (userId != null) { %>
	<button type="button" class="basic-btn" onclick="redirectToLogOut()">Logout</button>
	<%}%>
	<button type="button" class="basic-btn" onclick="redirectToRegistration()">Registration</button>
	<% if (userId != null) { %>
	<div class="username-display">Welcome: <%=session.getAttribute("userid") %></div>
	<%}%>
</div>





<!--  
<div class="navBar">
      <button type="button" class="basic-btn"onclick= "redirectToHome()">Home</button>
      <button type="button" class="basic-btn" onclick="redirectToAuction()">Auction</button>
      <button type="button" class="basic-btn"onclick="redirectToSearch()">Search</button>
      <button type="button" class="basic-btn" onclick="redirectToAdmin()">Admin</button>
      <button type="button" class="basic-btn"onclick="redirectToLogin()">LogIn</button>
      <button type="button" class="basic-btn"onclick="redirectToRegistration()">Registration</button>
 </div>

-->
