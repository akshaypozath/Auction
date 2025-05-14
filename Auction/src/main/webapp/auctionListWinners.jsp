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
  		
  		
		ResultSet RS = getBidWinner(0);
		
		
    %>
    
  
    <div class="content-wrapper">
      <p class="title">Welcome to Auction List Winners</p>

      	<table border="1">
			<tr>
				<th>Seller</th>
				<th>Sub Category</th>
				<th>Product</th>
				<th>List Date</th>
				<th>Expire Date</th>
				<th>Start Price</th>
				<th>Buyer</th>
				<th>Winning Amount</th>
				<th>Status</th>
				
 			</tr>
 		 	<% 
 				 ///out.print(RS.next());
 		 	while(RS.next()){ %>
           	<TR>
    			<TD> <%=RS.getString("seller") %></td>
    			<%-- <TD class ="status" onclick="if ('<%= RS.getString("auction_status") %>' === 'Open') goToBid('<%= RS.getInt("aid") %>', '<%= RS.getString("pname") %>',<%= RS.getFloat("startprice") %>);"> <%= RS.getString("auction_status") %></TD> --%>
    			<TD> <%= RS.getString("scname") %></TD>
                <TD> <%= RS.getString("pname") %></TD>
                <TD> <%= RS.getTimestamp("listdate") %></TD>
                <TD> <%= RS.getTimestamp("expdate") %></TD>
                <TD> <%= RS.getFloat("startprice") %></TD>
                <TD> <%= RS.getString("userid") %></TD>
                <TD> <%= RS.getFloat("bidamt") %></TD>
                <TD> <%= RS.getString("bid_status") %></TD>
            </TR>
            <% } %>
      </table>
    </div>
    
  
  </body>
</html>
