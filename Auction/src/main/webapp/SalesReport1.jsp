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
	
  		String setSearchParm(){
	   		String dataType = "Search"; 
	  		return dataType;
    	}
	   String setSortParm(){
	  		String dataType = "Sort"; 
	 		return dataType;
		}
		String setSearchSortParm(){
		  	String dataType = "SearchandSort"; 
		 	return dataType;
		}
    
    
    
    %>
  <%!
	
  ResultSet getBidWinner(int aid){
		 
		 String SelectString = "" ;
		 ResultSet RS = null;
		 Connection con = null;
		 
		 try{
			 ApplicationDB db = new ApplicationDB();    
		     con = db.getConnection();
		
		        // Create a SQL statement
		     Statement stmt = con.createStatement();
			 if (aid >0){
			 		SelectString ="SELECT a.userid seller, a.scname, a.pname, a.listdate, a.expdate, a.startprice, b.*, "
	 						+"CASE "+ "WHEN b.bidamt >= a.minsell THEN "+"'winner' "
									+ "WHEN b.bidamt < a.minsell THEN "+ "'loser' "+
							"END AS bid_status "+
					"FROM finalproject_schema.auctions a "+
					"JOIN ("+
							"SELECT aid, MAX(bidamt) AS max_bid_amount "+
							"FROM finalproject_schema.bids "+
							"GROUP BY aid"+") max_bids ON a.aid = max_bids.aid "+
					"JOIN finalproject_schema.bids b ON a.aid = b.aid "
							+"AND b.bidamt = max_bids.max_bid_amount "+
					"WHERE a.expdate < NOW()"+" AND "+
							"a.aid = "+ aid;
			 		
			 	}else {
			 		SelectString ="SELECT a.userid seller, a.scname, a.pname, a.listdate, a.expdate, a.startprice, b.*, "
	 						+"CASE "+ "WHEN b.bidamt >= a.minsell THEN "+"'winner' "
									+ "WHEN b.bidamt < a.minsell THEN "+ "'loser' "+
							"END AS bid_status "+
					"FROM finalproject_schema.auctions a "+
					"JOIN ("+
							"SELECT aid, MAX(bidamt) AS max_bid_amount "+
							"FROM finalproject_schema.bids "+
							"GROUP BY aid"+") max_bids ON a.aid = max_bids.aid "+
					"JOIN finalproject_schema.bids b ON a.aid = b.aid "
							+"AND b.bidamt = max_bids.max_bid_amount "+
					"WHERE a.expdate < NOW()";
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
  
  ResultSet getEarnRptForAuction(int rpt){
		

		 String SelectString = "" ;
		 ResultSet RS = null;
		 Connection con = null;
		 
		 if(rpt == 0){ // Earn report for all aution
			 SelectString = "SELECT a.userid AS seller, a.scname, a.pname, a.listdate, a.expdate, a.startprice, b.*, "
					    			+"CASE WHEN b.bidamt >= a.minsell THEN 'winner' "+ 
				        					"WHEN b.bidamt < a.minsell THEN 'loser' "+
				   					 "END AS bid_status, "+
				        					"(b.bidamt - a.minsell) AS earn, b.userid AS buyer "+
								"FROM finalproject_schema.auctions a "+
							"JOIN "+
				    			"(SELECT aid, MAX(bidamt) AS max_bid_amount FROM finalproject_schema.bids GROUP BY aid) max_bids "+
				    		"ON a.aid = max_bids.aid "+
							"JOIN "+
				    				"finalproject_schema.bids b ON a.aid = b.aid AND b.bidamt = max_bids.max_bid_amount "+
							"WHERE a.expdate < NOW()";
		 }
		 if (rpt == 1){ //Get buest buyer
			 SelectString = "SELECT best_buyer.buyer AS best_buyer_id, SUM(best_buyer.earn) AS total_earnings FROM "+  
				 		"( SELECT a.userid AS seller, a.scname, a.pname, a.listdate, a.expdate, a.startprice, b.*, "+ 
		 				"CASE WHEN b.bidamt >= a.minsell THEN 'winner' "+
	 						"WHEN b.bidamt < a.minsell THEN 'loser' "+
		 				"END AS bid_status, "+
	 						"(b.bidamt - a.minsell) AS earn, b.userid AS buyer " +
		 				"FROM finalproject_schema.auctions a "+
	 			"JOIN (SELECT aid, MAX(bidamt) AS max_bid_amount FROM finalproject_schema.bids "+
		 				"GROUP BY aid) max_bids ON a.aid = max_bids.aid "+
	 		"JOIN finalproject_schema.bids b ON a.aid = b.aid AND b.bidamt = max_bids.max_bid_amount "+
		 "WHERE a.expdate < NOW() ) AS best_buyer GROUP BY best_buyer.buyer ORDER BY total_earnings DESC LIMIT 1";
			  
			 
		 }
		 if(rpt == 2){ //get best selling item
			 SelectString = "SELECT a.pname AS best_selling_item, "+
									    "SUM(CASE WHEN b.bidamt >= a.minsell THEN b.bidamt - a.minsell ELSE 0 "+ 
									    "END) AS total_earnings "+
						  "FROM finalproject_schema.auctions a "+
						  "JOIN "+
						   		"(SELECT aid, MAX(bidamt) AS max_bid_amount FROM finalproject_schema.bids GROUP BY aid) max_bids "+
						    		"ON a.aid = max_bids.aid "+
							"JOIN finalproject_schema.bids b ON a.aid = b.aid AND b.bidamt = max_bids.max_bid_amount "+ 
						"WHERE a.expdate < NOW() GROUP BY a.pname ORDER BY total_earnings DESC LIMIT 1";
		 }
		 if(rpt == 3){ //get earning by scname, pname and seller
			 				
			 SelectString = "SELECT a.scname, a.pname, a.userid AS seller, "+
			    					"SUM(CASE WHEN b.bidamt >= a.minsell THEN b.bidamt - a.minsell ELSE 0 "+
			    					"END) AS total_earnings "+
									"FROM finalproject_schema.auctions a "+
							"JOIN (SELECT aid, MAX(bidamt) AS max_bid_amount FROM finalproject_schema.bids "+
									"GROUP BY aid) max_bids ON a.aid = max_bids.aid "+
							"JOIN finalproject_schema.bids b "+
								"ON a.aid = b.aid AND b.bidamt = max_bids.max_bid_amount "+
							"WHERE a.expdate < NOW() GROUP BY a.scname, a.pname, a.userid ORDER BY total_earnings DESC";
		 }
		 try{
			 
			 	ApplicationDB db = new ApplicationDB();    
		     	con = db.getConnection();
		
		        // Create a SQL statement
		     	Statement stmt = con.createStatement();
				 
				 PreparedStatement PS = con.prepareStatement(SelectString);
			     RS = PS.executeQuery();
			     return RS;
			 
		 }catch (Exception ex) {
		    	return RS;
		 }
		
	}
	
%>
  
  <body>
  
    <%@ include file= "00-1-NavMenu.jsp"%>
    <script>
    function goToBid(aid,pname,startprice) {
    	//out.print(RS.getString("auction_status"))
    	var url = 'Bid.jsp' + 
    				'?aid=' + encodeURIComponent(aid) + 
    				'&pname=' + encodeURIComponent(pname) + 
    				'&startprice=' + encodeURIComponent(startprice);
    	window.location.href = url;
    	
    }
    
    </script>
    
    <%
   
    	//String category = (String) session.getAttribute("selectedCategory");
  		String category = "";
		String getDataType = "All"; // All data, search, sort, search & Sort
		//String s_pname = "Nissan";
		String sort_field = "";
		String sort_order = ""; // DESCor ASC
		String s_pname = request.getParameter("spname");
		
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
        }
		
	
		
		
		String clickedButton = request.getParameter("clickedButton");
        if (clickedButton != null) {
            if (clickedButton.equals("Search Product")) {
            	getDataType = "Search";
            	
            } else if (clickedButton.equals("Sort")) {
            	getDataType = "Sort";
            } else if (clickedButton.equals("Search and Sort")) {
            	getDataType = "SearchandSort";
            }
        }
  		
  		String SQLtext = "";
  		
  		
		
		ResultSet RS1 = getEarnRptForAuction(1);
		
		
		
    %>
    
  
    <div class="content-wrapper">
      <p class="title">Welcome to Reports Page</p>
      <p class="sub-title">Get Best Buyer based on Earnings</p>
      	<table border="1">
			<tr>
				<th>Best Buyer</th>
				<th>Total Earnings</th>
				
 			</tr>
 		 	<% 
 				 ///out.print(RS.next());
 		 	while(RS1.next()){ %>
           	<TR>
    			<TD> <%=RS1.getString("best_buyer_id") %></td>
    			<TD> <%= RS1.getFloat("total_earnings") %></TD>
            </TR>
            <% } %>
      </table>
    </div>
    
  
  </body>
</html>
