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
   
   
	float getAID_MaxBidAmt(float aid){
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
	        RS.close();
	    	con.close();
	        
	    } catch (Exception ex) {
	    		//RS.close();
	    		//con.close();
	        	/* out.println(ex);
	        	out.println("Select failed"); */
	        	
    	}
    	
    	
    	return curr_max_bid;
	}

/* 
	int getBid_IsWin(int aid, float curr_bid){
		
	} */
	
	
	int getBidNo(){
		
		ResultSet RS = null;
	    Connection con = null;
	    Statement stmt = null;
	    int bidno = 0;
	    int is_removed =0;
	    int bid_no = 0;
	    try{
	    	// Get the database connection
	        ApplicationDB db = new ApplicationDB();    
	        con = db.getConnection();
	      	//Create a SQL statement
			stmt = con.createStatement();
	      	
			RS = stmt.executeQuery("SELECT MAX(bid_no) bid_no from bids;");
		    /* RS.next();
		    bid_no = RS.getInt("bid_no"); */
		    if (RS.next()) {
		        bid_no = RS.getInt("bid_no");
		        System.out.println("Last inserted bid number: " + bid_no);
		        RS.close();
		    	con.close();
		        return bid_no;
		    } else {
		    	RS.close();
		    	con.close();
		        System.out.println("No records found.");
		        return bid_no;
		    }
	      	
	    }catch (Exception ex) {
        	/* out.println(ex);
        	out.println("Select failed"); */
        	//RS.close();
        	//con.close();
	    	return bid_no;
        	
		}
		
	}

	String placeBid(int aid, float curr_max_bid, float curr_bid,float bid_inc,float autobid_ulimit,String curr_bidder, String bidtype,  
			int iswin){
	    
		ResultSet RS = null;
	    Connection con = null;
	    Statement stmt = null;
	    int bidno = 0;
	    int is_removed =0;
	    int bid_no = 0;
	    
	    LocalDateTime currentTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String biddate = currentTime.format(formatter);
	    
	    
	    String insertStatement = "";
	    
	    
	    if (curr_bid > curr_max_bid){
		    // Insert $curr_bid as current bid, for $currentBidder
		    try{
		    	// Get the database connection
		        ApplicationDB db = new ApplicationDB();    
		        con = db.getConnection();
		      	//Create a SQL statement
				stmt = con.createStatement();
		      	/* 
		        insertStatement = String.format("INSERT INTO `finalproject_schema`.`bids` (`date`, `iswin`, `bidamt`, `userid`, `is_removed`, `aid`, `bidtype`)" 
						+" VALUES ('"+ biddate
								+ "','" + iswin + "','" + curr_bid +
								"','" + curr_bidder + "','"+ is_removed+"','"+ aid+"','"
								+bidtype+"')");  */
		        

		        insertStatement = String.format("INSERT INTO `finalproject_schema`.`bids` (`date`, `bidamt`, `iswin`, `userid`, `aid`, `is_removed`, `bidtype`)" 
						+" VALUES ('"+ biddate
								+ "','" + curr_bid  + "','" + iswin +
								"','" + curr_bidder + "','"+ aid+"','"+ is_removed+"','"
								+bidtype+"')"); 
		        
		        
				
				/* insertStatement = "INSERT INTO `finalproject_schema`.`bids` (`date`, `iswin`, `bidamt`, `userid`, `is_removed`, `aid`, `bidtype`) VALUES(NOW(),?,?,?,?)";
				PreparedStatement ps = con.prepareStatement(insertStatement);
				ps.setInt(2,iswin);
				ps.setFloat(3,curr_bid);
				ps.setString(4,curr_bidder);
				ps.setInt(5,is_removed);
				ps.setInt(6,aid);
				ps.setString(7,bidtype); */
				
		        //out.println(insertStatement);
		        stmt.executeUpdate(insertStatement);
		        
			    //return bid_no;
			    RS.close();
    			con.close();
		        return insertStatement;
		    	
		    } catch (Exception ex) {
	        	/* out.println(ex);
	        	out.println("Select failed"); */
	        	//RS.close();
    			//con.close();
		    	return insertStatement;
	        	
    		}
		    
		}
		else{
		    // Not valid condition
			return insertStatement;
		}
	    
	   
	    
		
	}
	
	String placeAutoBid(int aid,float curr_bid,float bid_inc,float autobid_ulimit,String curr_bidder,int bid_no){
		ResultSet ab_RS = null;
		
		ResultSet RS = null;
	    Connection con = null;
	    Statement stmt = null;
	    int bidno = 0;
	    int is_removed =0;
	    
	    LocalDateTime currentTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String biddate = currentTime.format(formatter);
	    
	    
	    String insertStatement = "";
		
		
		if ( autobid_ulimit != 0 && bid_inc != 0 && curr_bid != 0 ){
			try{
				// Get the database connection
		        ApplicationDB db = new ApplicationDB();    
		        con = db.getConnection();
		      	//Create a SQL statement
				stmt = con.createStatement();
		      	/* 
				insertStatement = String.format("INSERT INTO `finalproject_schema`.`auto_bid` (`date`, `autobid_ulimit`, `bidamt`, `bid_inc`, `aid`, `userid`, `bid_no`)" 
						+" VALUES ('"+ biddate
								+ "','" + autobid_ulimit + "','" + curr_bid +
								"','" + bid_inc + "','"+ aid+"','"+ curr_bidder+"','"
								+bid_no+"')");  */
				
				insertStatement = String.format("INSERT INTO `finalproject_schema`.`autobid` (`autobid_ulimit`,`bid_inc`, `autobid_amt`, `aid`, `userid`,`autobiddate`, `bid_no`)" 
						+" VALUES ('"+ autobid_ulimit
								+ "','" + bid_inc + "','" + curr_bid +
								"','" + aid + "','"+ curr_bidder+"','"+ biddate+"','"
								+bid_no+"')"); 
				
				
				stmt.executeUpdate(insertStatement);
				RS.close();
    			con.close();
				return insertStatement;
		      	
			}catch (Exception ex) {
	        	/* out.println(ex);
	        	out.println("Select failed"); */
	        	//RS.close();
    			//con.close();
		    	return insertStatement;
	        	
    		}
			
			
		}else{
			return insertStatement;
		}
	    
	}
	
	String placeAutoBidsForAutoBids(int aid,float curr_max_bid,float curr_bid,String curr_bidder){
		
		ResultSet RS = null;
		ResultSet RS1 = null;
		Connection con = null;
		Connection con1 = null;
	    Statement stmt = null;
	    Statement stmt1 = null;
	    
	    String SelectString = "";
	    String insertStatement = "";
		
		/*
			Read all auto bids 
			For Every auto bids perform the following {
				if curr_max_bid+ autobid.bid_inc <= autobid.autobid_ulimit{
					Autobid_amount = curr_max_bid+ autobid.bid_inc
					placeBid()
				}
				curr_max_bid = getAID_MaxBidAmt(aid);
			}
		*/
		
		
		
		try{
			// Get the database connection
	        ApplicationDB db = new ApplicationDB();    
	        con = db.getConnection();
	      	//Create a SQL statement
			stmt = con.createStatement();
	      	
			//SelectString = "select * from auto_bid where aid = " + aid;
			
			SelectString = "select * from autobid where aid = " + aid+" and userid != "+"'"+curr_bidder+"'";
			
			PreparedStatement PS = con.prepareStatement(SelectString);
	        RS = PS.executeQuery();
	        stmt1 = con.createStatement();
	        
	        float autobid_amount = 0;
	        float bid_inc =0;
	  		float autobid_ulimit =0;
	  		
	  		String bidtype = "Auto";
	  		int iswin = 0;
	  		String auto_bidder = "";
	  		float auto_bidinc = 0;
	  		
	        
			while (RS.next()) {
				
				curr_max_bid = getAID_MaxBidAmt(aid);
				auto_bidinc = RS.getFloat("bid_inc");
				autobid_amount = curr_max_bid + auto_bidinc;
				autobid_ulimit = RS.getFloat("autobid_ulimit");
				auto_bidder = RS.getString("userid");
				
				
				if (autobid_amount <= autobid_ulimit){
					
					placeBid(aid,curr_max_bid,autobid_amount,bid_inc,autobid_ulimit,auto_bidder, bidtype,iswin);
					Create_HighBid_Alert(aid,autobid_amount,auto_bidder);
					Create_HighAutoBid_Alert(aid,curr_bid, curr_bidder);
					
				}
				
				
			}
			
			RS.close();
			con.close();
			
			return SelectString;
	      	
			
			
		}catch (Exception ex) {
        	/* out.println(ex);
        	out.println("Select failed"); */
	    	return SelectString;
        	
		}
		
	    
	}
	String Create_HighBid_Alert(int aid, float curr_bid,String curr_bidder){
		

		ResultSet RS = null;
		ResultSet RS1 = null;
		Connection con = null;
		Connection con1 = null;
	    Statement stmt = null;
	    Statement stmt1 = null;
	    
	    String SelectString = "";
	    String insertStatement = "";
	    String notification = "New High Bid Placed";
	    
	    try{
	    	// Get the database connection
	        ApplicationDB db = new ApplicationDB();    
	        con = db.getConnection();
	      	//Create a SQL statement
			stmt = con.createStatement();
	      	
			//SelectString = "select * from bid where aid = " + aid and not current bidder
			SelectString = "select b.*, a.userid seller, a.pname from bids b JOIN auctions a ON a.aid = b.aid  where b.aid = " 
							+ aid+" and b.userid != "+"'"+curr_bidder+"'";
			
			PreparedStatement PS = con.prepareStatement(SelectString);
	        RS = PS.executeQuery();
	        stmt1 = con.createStatement();
	        
	        while (RS.next()) {
	        	String insertString = Insert_Alert(RS.getString("userid"),RS.getString("pname"),notification, aid);
	        }
	        
	        return SelectString;
	    	
	    }catch (Exception ex) {
	    	return SelectString;
	    }
		
		
	}
	
	
	String Create_HighAutoBid_Alert(int aid, float curr_bid,String curr_bidder){
		

		ResultSet RS = null;
		ResultSet RS1 = null;
		Connection con = null;
		Connection con1 = null;
	    Statement stmt = null;
	    Statement stmt1 = null;
	    
	    String SelectString = "";
	    String insertStatement = "";
	    String notification = "New Higher Bid place greater than Auto Upper Limit";
	    
	    try{
	    	// Get the database connection
	        ApplicationDB db = new ApplicationDB();    
	        con = db.getConnection();
	      	//Create a SQL statement
			stmt = con.createStatement();
	      	
			//SelectString = "select * from autobid where aid = " + aid and not current bidder
			SelectString = "select b.*, a.userid seller, a.pname from autobid b JOIN auctions a ON a.aid = b.aid  where b.aid = " 
							+ aid+" and b.userid != "+"'"+curr_bidder+"'";
			
			PreparedStatement PS = con.prepareStatement(SelectString);
	        RS = PS.executeQuery();
	        stmt1 = con.createStatement();
	        float autobid_ulimit = 0;
	        
	        while (RS.next()) {
	        	
	        	autobid_ulimit = Float.parseFloat(RS.getString("autobid_ulimit"));
	        	
	        	if (curr_bid > autobid_ulimit){
	        		
	        		String insertString = Insert_Alert(RS.getString("userid"),RS.getString("pname"),notification, aid);
	        		
	        	}
	        	
	        	
	        }
	        
	        return SelectString;
	    	
	    }catch (Exception ex) {
	    	return SelectString;
	    }
		
		
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
%>

  <BODY>
    <H1>Bid Successfully Placed</H1>
    

    <%
   		
    	
    
    
    
    	int aid = 1;
  	
  		aid = Integer.parseInt(request.getParameter("aid"));
  		
  		
  		float curr_max_bid = getAID_MaxBidAmt(aid); /* 40200 */
  		
  		float curr_bid = 0;
  		if (request.getParameter("bid_amt") != null){
  			curr_bid = Float.parseFloat(request.getParameter("bid_amt"));
  		}
  		
  		
  		float auto_bid_amt = 0;
  		if (request.getParameter("bid_amt1") != null){
  			auto_bid_amt = Float.parseFloat(request.getParameter("bid_amt1"));
  		}
  		
  		
  		float bid_inc = 0;
  		String sbid_inc = request.getParameter("increment");
  		if (request.getParameter("increment") != null){
  			bid_inc = Float.parseFloat(request.getParameter("increment"));
  		}
  		
  		
  		float autobid_ulimit =0;
  		if (request.getParameter("bid_limit") != null){
  			autobid_ulimit = Float.parseFloat(request.getParameter("bid_limit"));
  		}
  		
  		
  		
  		/* String curr_bidder = "user2";
  		
  		curr_bidder = session.getAttribute("userid"); */
  		
  		String curr_bidder = (String) session.getAttribute("userid");
  		
  		String bidtype = "Manual";
  		if (bid_inc != 0 && autobid_ulimit  !=0 && auto_bid_amt !=0){
  			bidtype = "Auto";
  			curr_bid = auto_bid_amt;
  		}
  		
  		int iswin = 0;
  		int bid_no = 0;
  		
  		String SQLtext1 = "";
  		String SQLtext2 = "";
  		String SQLtext3 = "";
  		String CreateAlert_SQL = "";
  		String CreateAlert_SQL2 = "";
  		
		SQLtext1 = placeBid(aid,curr_max_bid,curr_bid,bid_inc,autobid_ulimit,curr_bidder, bidtype,iswin);
		CreateAlert_SQL = Create_HighBid_Alert(aid,curr_bid,curr_bidder);
		CreateAlert_SQL2 = Create_HighAutoBid_Alert(aid,curr_bid, curr_bidder);
		
		bid_no = getBidNo();
		
  		curr_max_bid = getAID_MaxBidAmt(aid); /* 42250 */
  		
  		if (bidtype == "Auto"){
  			SQLtext2 = placeAutoBid(aid, curr_bid, bid_inc, autobid_ulimit,curr_bidder,bid_no);
  		}
  		
  		SQLtext3 = placeAutoBidsForAutoBids(aid,curr_max_bid,curr_bid,curr_bidder);
  		 
  		
    	//out.println("Current Max Bid: " + getAID_MaxBidAmt(aid));
    	response.sendRedirect("00-0-LandingPage.jsp");
    %>
    
     
     
  </BODY>
</HTML>