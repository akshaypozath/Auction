<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
 
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
    	ResultSet RS = null;
    	Connection con = null;
    	
    	
	    try {
	    	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			//out.print("ApplicationDB Successful");
			con = db.getConnection();
			//out.print("getConnection Successful");
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			//Get parameters from the HTML form at the HelloWorld.jsp
			String category = request.getParameter("data");
			//out.print(category);
			
			//if( category == "SUV"){
				//
				//String SelectString = "Select * from auctions where scname =";
			//}
			
			String SelectString = "Select *," 
					+ "CASE WHEN expdate >= CURDATE() and issold = 0 THEN"+ "'Open'"
			        + "WHEN expdate < CURDATE() or issold = 1 THEN"+ "'Closed'"
			    	+ "END AS auction_status,"
			    	+ "CASE WHEN issold = 0 THEN"+ " 'Not sold' "
			    	+ "WHEN issold = 1 THEN"+ " 'Sold'"
			    	+ "END AS sold_status "
					+ "from auctions where scname = "
					+"'"+category+"'";
			//out.print(SelectString);
			
			PreparedStatement PS = con.prepareStatement(SelectString);
			//PS.setString(1,category);
			
			RS = PS.executeQuery();
			//out.print(RS);
			/* 
			String rsIsTrue = "false";
			
			while (RS.next()) {
				
				rsIsTrue = "true";
				
			} 
			 */
			
			// out.print(rsIsTrue);
		} 	
		catch (Exception ex) {
			out.print(ex);
			out.print("Select failed");
		}
		
    %>
    <div class="content-wrapper">
      <p class="title">Welcome to Auction List</p>
      
      	<form method="get" action="---------">
			<table>
				<tr>    
					<td>Product Name Search</td><td><input type="text" name="spname"></td>
				</tr>
			</table>
			<input type="submit" value="Search Product">
		</form>
      	<form method="get" action="sqlCreateListing.jsp">
			<table>
				<tr>    
					<td>SortAuction</td> 
					<td>
                		<select name="sub_category">
                    		<option value="pname">Product Name</option>
                    		<option value="price">Price</option>
                    	</select>
           			</td>
				</tr>
			</table>
			<input type="submit" value="Create">
					
		</form>
      
      	<table border="1">
			<tr>
				<th>Auction ID</th>
				<th>Auction Status</th>
				<th>Sold Status</th>
				<th>Start Price</th>
				<th>Product Name</th>
				<th>Sub Category Name</th>
				<th>User ID</th>
				<th>List Date</th>
				<th>Expire Date</th>
 			</tr>
 		 	<% 
 				 ///out.print(RS.next());
 		 	while(RS.next()){ %>
           	<TR>
    			<TD> <%=RS.getString("aid") %></td>
    			<TD class ="status" onclick="if ('<%= RS.getString("auction_status") %>' === 'Open') goToBid('<%= RS.getInt("aid") %>', '<%= RS.getString("pname") %>',<%= RS.getFloat("startprice") %>);"> <%= RS.getString("auction_status") %></TD>
    			<TD> <%= RS.getString("sold_status") %></TD>
                <TD> <%= RS.getFloat("startprice") %></TD>
                <TD> <%= RS.getString("pname") %></TD>
                <TD> <%= RS.getString("scname") %></TD>
                <TD> <%= RS.getString("userid") %></TD>
                <TD> <%= RS.getTimestamp("listdate") %></TD>
                <TD> <%= RS.getTimestamp("expdate") %></TD>
            </TR>
            <% } %>
      </table>
      
  
      
    </div>
    
  
  </body>
</html>
