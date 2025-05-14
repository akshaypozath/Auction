<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <!-- ... -->
    <link rel="stylesheet" href="bid.css" />
</head>
 
<body>
<%!
    /* // Function definition
    float getAID_MaxBidAmt(){
	
        float curr_max_bid = 0.0f;
        ResultSet RS = null;
        Connection con = null;
        float aid = 1;
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
                return curr_max_bid;
            }
        } catch (Exception ex) {
            //out.print(ex);
            //out.print("Select failed");
        	//return curr_max_bid;
        }
       
    } */
	
	/* String get_SQL(){
		
	    String SelectString = "" ;
	    ResultSet RS = null;
	    Connection con = null;
	    int aid = 1;
	    String userid = "user3";
	    
	    try{
	        // Get the database connection
	        ApplicationDB db = new ApplicationDB();    
	        con = db.getConnection();
	
	        // Create a SQL statement
	        Statement stmt = con.createStatement();
	        SelectString = "select * from autobid where aid = " + aid+" and userid != "
	        					+"`"+userid+"`";
	
	        PreparedStatement PS = con.prepareStatement(SelectString);
	        RS = PS.executeQuery();
	
	        if (RS.next()){
	            return SelectString;
	        }
	    } catch (Exception ex) {
	        //out.print(ex);
	        //out.print("Select failed");
	    	return SelectString;
	        
	    }
	    //return SelectString;
	}
	 */
	 
	 

		ResultSet getAuctionListData(String category,String getDataType,String spname,String sort_field,String sort_order){
			
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
							+"'"+category+"'";
				}else if (getDataType == "Search"){
					SelectString = "Select *," 
							+ "CASE WHEN expdate >= CURDATE() and issold = 0 THEN"+ "'Open'"
					        + "WHEN expdate < CURDATE() or issold = 1 THEN"+ "'Closed'"
					    	+ "END AS auction_status,"
					    	+ "CASE WHEN issold = 0 THEN"+ " 'Not sold' "
					    	+ "WHEN issold = 1 THEN"+ " 'Sold'"
					    	+ "END AS sold_status "
							+ "from auctions where scname = "
							+"'"+category+"'"+"AND pname LIKE '%"+spname+"%'";
					
				}else if (getDataType == "Sort"){
					SelectString = "Select *," 
							+ "CASE WHEN expdate >= CURDATE() and issold = 0 THEN"+ "'Open'"
					        + "WHEN expdate < CURDATE() or issold = 1 THEN"+ "'Closed'"
					    	+ "END AS auction_status,"
					    	+ "CASE WHEN issold = 0 THEN"+ " 'Not sold' "
					    	+ "WHEN issold = 1 THEN"+ " 'Sold'"
					    	+ "END AS sold_status "
							+ "from auctions where scname = "
							+"'"+category+"'"+" ORDER BY "+sort_field+" "+sort_order;
				
					
				}else if (getDataType == "SearchandSort"){
					SelectString = "Select *," 
							+ "CASE WHEN expdate >= CURDATE() and issold = 0 THEN"+ "'Open'"
					        + "WHEN expdate < CURDATE() or issold = 1 THEN"+ "'Closed'"
					    	+ "END AS auction_status,"
					    	+ "CASE WHEN issold = 0 THEN"+ " 'Not sold' "
					    	+ "WHEN issold = 1 THEN"+ " 'Sold'"
					    	+ "END AS sold_status "
							+ "from auctions where scname = "
							+"'"+category+"'"+"AND pname LIKE '%"+spname+"%'"
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
							+"'"+category+"'";
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
				 return RS ;
				
			}catch (Exception ex) {
	    		//RS.close();
	    		//con.close();
	        	/* out.println(ex);
	        	out.println("Select failed"); */
				return RS ;
	        	
			}
			//return SelectString ;
			
		}
		
	 
	 
	 
	String getBidWinner(int aid){
		 
		 String SelectString = "" ;
		 ResultSet RS = null;
		 Connection con = null;
		 
		 try{
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
		
		        if (RS.next()){
		            return SelectString;
		        }
			 
		 }catch (Exception ex) {
		        /* out.print(ex);
		        out.print("Select failed"); */
		    	return SelectString;
		        
		 }
		 
		 return SelectString;
	
	}
	
	
	String getBidHist(int aid){
		 
		 String SelectString = "" ;
		 ResultSet RS = null;
		 Connection con = null;
		 
		 try{
			 
			 	if (aid > 0){
			 		SelectString = "SELECT a.*, b.*, "+
    	       				"CASE "	+"WHEN b.bidamt >= subquery.max_bid_amount THEN 'winning' "
               						+"WHEN b.bidamt < subquery.max_bid_amount THEN 'losing' "+
          					"END AS bid_status, "+
          					"subquery.max_bid_amount "+
   					"FROM finalproject_schema.auctions a "+
   					"JOIN finalproject_schema.bids b ON a.aid = b.aid "+
   					"LEFT JOIN (SELECT aid, MAX(bidamt) AS max_bid_amount FROM finalproject_schema.bids "+
       								"GROUP BY aid) subquery ON a.aid = subquery.aid WHERE a.aid = "+aid;
			 		
			 	}else{
			 		SelectString = "SELECT a.*, b.*, "+
    	       				"CASE "	+"WHEN b.bidamt >= subquery.max_bid_amount THEN 'winning' "
               						+"WHEN b.bidamt < subquery.max_bid_amount THEN 'losing' "+
          					"END AS bid_status, "+
          					"subquery.max_bid_amount "+
   					"FROM finalproject_schema.auctions a "+
   					"JOIN finalproject_schema.bids b ON a.aid = b.aid "+
   					"LEFT JOIN (SELECT aid, MAX(bidamt) AS max_bid_amount FROM finalproject_schema.bids "+
       								"GROUP BY aid) subquery ON a.aid = subquery.aid";
			 		
			 	}
			 	
			 	
			 						
			 	PreparedStatement PS = con.prepareStatement(SelectString);
		        RS = PS.executeQuery();
		
		        if (RS.next()){
		            return SelectString;
		        }
			 
		 }catch (Exception ex) {
		        /* out.print(ex);
		        out.print("Select failed"); */
		    	return SelectString;
		        
		 }
		 
		 return SelectString;
	
	}
	
	String Insert_Alert(String userid, String pname, String notification, int aid){
		
		String SelectString = "Insert Success" ;
		ResultSet RS = null;
	    Connection con = null;
	    Statement stmt = null;
		
		String insertStatement = "";
		
		LocalDateTime currentTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String alert_date = currentTime.format(formatter);
	    
	    
	    
		
		try{
			ApplicationDB db = new ApplicationDB();    
	        con = db.getConnection();
	      	//Create a SQL statement
			stmt = con.createStatement();
	      	
			insertStatement = String.format("INSERT INTO `finalproject_schema`.`userAlerts`"
								+" ( `userid`, `pname`, `notification`, `alert date`, `aid`)" 
					+" VALUES ('"+ userid
							+ "','" + pname + "','" + notification +
							"','"+ alert_date +
							"','" + aid + "'"+")");
	      	
			//out.println(insertStatement);
	        stmt.executeUpdate(insertStatement);
	        
		    //return bid_no;
		    RS.close();
			con.close();
	        return insertStatement;
			
		}catch (Exception ex) {
	        /* out.print(ex);
	        out.print("Select failed"); */
			return insertStatement;
	        
	 }
	}
String Insert_Question(String userid, String question){
		
		String SelectString = "Insert Success" ;
		ResultSet RS = null;
	    Connection con = null;
	    Statement stmt = null;
		
		String insertStatement = "";
		
		LocalDateTime currentTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String date_question = currentTime.format(formatter);
        int answer_id = 0; 
	    
	    
	    
		
		try{
			ApplicationDB db = new ApplicationDB();    
	        con = db.getConnection();
	      	//Create a SQL statement
			stmt = con.createStatement();
	      	
			insertStatement = String.format("INSERT INTO `finalproject_schema`.`Question`"
								+" ( `Question`, `userid`, `date_question`)" 
					+" VALUES ('"+ question
							+ "','" + userid + "','" + date_question +
							"'"+")");
	      	
			//out.println(insertStatement);
	        stmt.executeUpdate(insertStatement);
	        
		    //return bid_no;
		    RS.close();
			con.close();
	        return insertStatement;
			
		}catch (Exception ex) {
	        /* out.print(ex);
	        out.print("Select failed"); */
			return insertStatement;
	        
	 }
	}

String getQuestion(String squestion){
	 
	 String SelectString = "" ;
	 ResultSet RS = null;
	 Connection con = null;
	 
	 try{
		 if(squestion != ""){
			 SelectString = "SELECT a.*, b.* FROM finalproject_schema.Question " +
	 					"JOIN finalproject_schema.Answers b ON a.QuestionID = b.QuestionID WHERE Question LIKE '%"+squestion+"%'";
		 }
		 else{
			 SelectString = "SELECT a.*, b.* FROM finalproject_schema.Question " +
	 					"JOIN finalproject_schema.Answers b ON a.QuestionID = b.QuestionID ";
		 }
		 PreparedStatement PS = con.prepareStatement(SelectString);
	     RS = PS.executeQuery();
	
	        if (RS.next()){
	            return SelectString;
	        }
		 
	 }catch (Exception ex) {
	        /* out.print(ex);
	        out.print("Select failed"); */
	    	return SelectString;
	        
	 }
	 
	 return SelectString;

}

String getEarnRptForAuction(int rpt){
	

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
			 
			 PreparedStatement PS = con.prepareStatement(SelectString);
		     RS = PS.executeQuery();
		     return SelectString;
		 
	 }catch (Exception ex) {
	    	return SelectString;
	 }
	
}


	
%>

<%
    // Call the function and print the result
    //float curr_max = getAID_MaxBidAmt();
	//String SQLText = get_SQL();
	
	int aid = 1;
	
    //out.println("Bid winners All" + getBidWinner(0));
    //out.println("Bid winner for aid" + getBidWinner(aid));
    //out.println("Bid History All" + getBidHist(0));
    //out.println("Bid History for aid" + getBidHist(1));
   // out.println("Bid History for aid" + getEarnRptForAuction(3));
    String category = "Sports Car";
    String getDataType = "All";
    String spname = "";
    String sort_field = "";
    String sort_order = "";
    
    out.println("Bid History for aid" + getAuctionListData(category,getDataType,spname,sort_field,sort_order));
   
    
    		
    		//out.println("Insert SQL" + Insert_Question("user1","What is your return policy?"));
    		 
    //String InsertStmt = Insert_Alert("user1", "Nissan", "Higher Bidd Has been placed", aid);
    //out.println("Insert Alert"+InsertStmt);
    
    
%>
    
<!-- ... -->
</body>
	<
<!-- ... -->
</html>
