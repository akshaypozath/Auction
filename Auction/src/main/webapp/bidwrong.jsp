<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
  <head>
  <script>
  function validateManualBid() {
      var manualBidInput = document.getElementById("bid_amt").value;
      var autoIncrementInput = document.getElementById("increment").value;
      var autoBidLimitInput = document.getElementById("bid_limit").value;
      var curr_max_bid_amt = document.getElementById("curr_max_bid_amt").value;
      
      
      
      /* 
      if (manualBidInput < curr_max_bid_amt ){
		  alert("Bid amount has to be greater than current max bid."); 
		  return false; 
	  } */
      
	 /*  if(manualBidInput !== "") && ((autoIncrementInput !== "" || autoBidLimitInput !== ""))){
		  
		  if (manualBidInput < curr_max_bid_amt ){
    		  //alert("Bid amount has to be greater than current max bid."); 
    		  alert("Manual Bid should not have Auto Bid information and bid amount has to be greater than current max bid."); 
    		  return false; 
    	  }
		  
	  }  */
	  

      if (manualBidInput === "" || (autoIncrementInput !== "" || autoBidLimitInput !== "")) {
    	  alert("Manual Bid should not have Auto Bid information.");
          return false;
      }
      else{
    	  if (manualBidInput < curr_max_bid_amt ){
    		  alert("Bid amount has to be greater than current max bid."); 
    		  return false; 
    	  }
    	  
      }
      
      
      return true;
  }
  
 function validateAutoBid(){
	  var autoIncrementInput = document.getElementById("increment").value;
      var autoBidLimitInput = document.getElementById("bid_limit").value;
      var manualBidInput = document.getElementById("bid_amt").value;
      var curr_max_bid_amt = document.getElementById("curr_max_bid_amt").value;

      if (autoIncrementInput === "" || autoBidLimitInput === "" || manualBidInput === "") {
          alert("Please fill in all fields the 3 fields for Automatic Bid to process.");
          return false; 
      }
      /* if (manualBidInput < curr_max_bid_amt ){
		  alert("Bid amount has to be greater than current max bid."); 
		  return false; 
	  } */
	  else{
		  if (manualBidInput < curr_max_bid_amt ){
    		  alert("Bid amount has to be greater than current max bid."); 
    		  return false; 
    	  } 
	  }
      
      
      return true;
  }
  
 </script>
  <!-- function createManualBid(){
		
	/*
		if bid_amt != 0 and increment = 0 and bid_limit = 0 {
			call insert bid function to create bid with Bid type = manual
			Review all autobids to check 
		}
		
	*/
	
	  
  }
  
  funuction InsertBid(){
	  /* 
	  	Insert Bid Table with session user id
	  */
	  
  }
  
  function InsertAutoBid(){
	  /*  
	  	Insert AutoBid Table with session user id
	  */
  }
  
  
  function createAutoBid(){
	  /*
		if bid_amt != 0 {
			
			if increment !=0 and bid_limit !=0{
				call insert_auto_inc function
			}
			call insert bid function to create bid with Bid type = auto
			
		}
		
		
	*/
	  
  } -->
 
    <!-- ... -->
    <link rel="stylesheet" href="bid.css" />
  </head>
 
 <!-- getting max bid amount java function -->
 <%!
    
	float getAID_MaxBidAmt(int aid){
	    float curr_max_bid = 0;
	    ResultSet RS = null;
	    Connection con = null;
	    
	    
    	try{
	        // Get the database connection
	        ApplicationDB db = new ApplicationDB();    
	        con = db.getConnection();
	
	        // Create a SQL statement
	        Statement stmt = con.createStatement();
	        String SelectString = "select MAX(bidamt) maxbidamt from bids where aid = " + aid;
	
	        PreparedStatement PS = con.prepareStatement(SelectString);
	        RS = PS.executeQuery();
	
	        if (RS.next()){
	            curr_max_bid = RS.getFloat("maxbidamt");
	            
	        }
	    } catch (Exception ex) {
	        	/* out.println(ex);
	        	out.println("Select failed"); */
	        	
    	}
    	return curr_max_bid;
	}
    %>
 
 
  <body>
     <%@ include file= "00-1-NavMenu.jsp"%>
   	<% 
   	String aid = request.getParameter("aid");
 	String pname = request.getParameter("pname");
	Float startprice = Float.parseFloat(request.getParameter("startprice"));
 	Float current_max_bid = getAID_MaxBidAmt(Integer.parseInt(aid));
 	%>
 	<div class = "bid-content">
 	<div class = "bid-information">
 		
 		
 		<td>Auction ID: </td>
        <input type="text" name="aid" id="aid" value="<%= aid %>" readonly>
        
 		<td>Product Name: </td>
        <input type="text" name="pname" id="panme" value="<%= pname %>" readonly>
 		
 		<td>Starting Price: </td>
        <input type="text" name="startprice" id="startprice" value=" <%= String.format("%.2f", startprice) %>" readonly>
 		
 		<td>Current Max Bid Amount: </td>
        <input type="text" name="curr_max_bid_amt" id="curr_max_bid_amt" value="<%= current_max_bid %>" readonly>
 		 
 	</div>
 	<div class = "border"></div>
    <div class="bids">
    <p class="bid-title">Let's Bid!</p>
    <div class="manual-bid">
        <form id="manualBidForm" action="CreateBid.jsp?aid=<%= aid %>" method="POST">
            <table>
            
                <tr>
                    <td>Bid</td>
                    <td><input type="number" step="0.01" name="bid_amt" id="bid_amt"></td>
                </tr>
                
                
                <tr>
                    <td>Increment</td>
                    <td><input type="number" step="0.01" name="increment" id="increment"></td>
                </tr>
                
                <tr>
                    <td>Bid Limit</td>
                    <td><input type="number" step="0.01" name="bid_limit" id="bid_limit"></td>
                </tr>
                
                
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Make Bid" onclick="return validateManualBid()">
                    </td>
                    <!--  
                    <td colspan="2">
                        <input type="submit" value="Set Automatic Bid" onclick="return validateAutoBid()">
                    </td>
                    -->
                </tr>
            </table>
        </form>
    </div>

<!--  
    <div class="auto-bid">
        Similar structure for auto-bid form 
        <form id="autoBidForm" action="CreateBid.jsp?aid=" method="POST">
            <table>
            
                <tr>
                    <td>Increment</td>
                    <td><input type="number" step="0.01" name="increment" id="increment"></td>
                </tr>
                
                <tr>
                    <td>Bid Limit</td>
                    <td><input type="number" step="0.01" name="bid_limit" id="bid_limit"></td>
                </tr>
                
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Set Automatic Bid" onclick="return validateAutoBid()">
                    </td>
                </tr>
            </table>
        </form>
    </div>
    -->
</div>
    <div class = "border"></div>
    </div>
     	
    
  </body>
</html>
