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
	
	String getAuctionListData(String category,String getDataType,String spname,String sort_field,String sort_order){
		
		ResultSet RS = null;
		Connection con = null;
		String SelectString = "";
		
		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			//out.print("ApplicationDB Successful");
			con = db.getConnection();
			//out.print("getConnection Successful");
	
			//Create a SQL statement
			Statement stmt = con.createStatement();
	
			//Get parameters from the HTML form at the HelloWorld.jsp
			//String category = request.getParameter("data"); 
			
			//out.print(category);
			
			//if( category == "SUV"){
				//
				//String SelectString = "Select * from auctions where scname =";
			//}
			
			if (getDataType == "All"){
				SelectString = "Select *," 
						+ "CASE WHEN expdate >= CURDATE() and issold = 0 THEN"+ "'Open'"
				        + "WHEN expdate < CURDATE() or issold = 1 THEN"+ "'Closed'"
				    	+ "END AS auction_status,"
				    	+ "CASE WHEN issold = 0 THEN"+ " 'Not sold' "
				    	+ "WHEN issold = 1 THEN"+ " 'Sold'"
				    	+ "END AS sold_status "
						+ "from auctions where scname = "
						+"'"+"Pick Up"+"'";
			}else if (getDataType == "Search"){
				SelectString = "Select *," 
						+ "CASE WHEN expdate >= CURDATE() and issold = 0 THEN"+ "'Open'"
				        + "WHEN expdate < CURDATE() or issold = 1 THEN"+ "'Closed'"
				    	+ "END AS auction_status,"
				    	+ "CASE WHEN issold = 0 THEN"+ " 'Not sold' "
				    	+ "WHEN issold = 1 THEN"+ " 'Sold'"
				    	+ "END AS sold_status "
						+ "from auctions where scname = "
						+"'"+"Pick Up"+"'"+"AND pname LIKE '%"+spname+"%'";
				
			}else if (getDataType == "Sort"){
				SelectString = "Select *," 
						+ "CASE WHEN expdate >= CURDATE() and issold = 0 THEN"+ "'Open'"
				        + "WHEN expdate < CURDATE() or issold = 1 THEN"+ "'Closed'"
				    	+ "END AS auction_status,"
				    	+ "CASE WHEN issold = 0 THEN"+ " 'Not sold' "
				    	+ "WHEN issold = 1 THEN"+ " 'Sold'"
				    	+ "END AS sold_status "
						+ "from auctions where scname = "
						+"'"+"Pick Up"+"'"+" ORDER BY "+sort_field+" "+sort_order;
			
				
			}else if (getDataType == "SearchandSort"){
				SelectString = "Select *," 
						+ "CASE WHEN expdate >= CURDATE() and issold = 0 THEN"+ "'Open'"
				        + "WHEN expdate < CURDATE() or issold = 1 THEN"+ "'Closed'"
				    	+ "END AS auction_status,"
				    	+ "CASE WHEN issold = 0 THEN"+ " 'Not sold' "
				    	+ "WHEN issold = 1 THEN"+ " 'Sold'"
				    	+ "END AS sold_status "
						+ "from auctions where scname = "
						+"'"+"Pick Up"+"'"+"AND pname LIKE '%"+spname+"%'"
						+" ORDER BY "+sort_field+" "+sort_order;
				
			}else {
				SelectString = "Select *," 
						+ "CASE WHEN expdate >= CURDATE() and issold = 0 THEN"+ "'Open'"
				        + "WHEN expdate < CURDATE() or issold = 1 THEN"+ "'Closed'"
				    	+ "END AS auction_status,"
				    	+ "CASE WHEN issold = 0 THEN"+ " 'Not sold' "
				    	+ "WHEN issold = 1 THEN"+ " 'Sold'"
				    	+ "END AS sold_status "
						+ "from auctions where scname = "
						+"'"+"Pick Up"+"'";
			}
			
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
			 return SelectString ;
			
		}catch (Exception ex) {
    		//RS.close();
    		//con.close();
        	/* out.println(ex);
        	out.println("Select failed"); */
			return SelectString ;
        	
		}
		//return SelectString ;
		
	}

%>

  <BODY>
    <H1>Creating a Method</H1>
    

    <%
    	int aid = 1;
  
  
		String category = "SUV";
		String getDataType = "All"; // All data, search, sort, search & Sort
		String s_pname = "Nis";
		String sort_field = "startprice";
		String sort_order = "DESC"; // DESC or ASC
	
  		
  		String SQLtext = "";
  		
  		
		SQLtext = getAuctionListData(category,getDataType,s_pname,sort_field,sort_order);
    %>
    
    
    <p class="aid">SQL1Text # <%=SQLtext%></p>
   
     
     
  </BODY>
</HTML>