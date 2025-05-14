<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<style>
        .regContent {
            display: grid; 
            justify-content: center;
        }
    </style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
    document.getElementById('expiredate').addEventListener('change', updateDateTime);
    document.getElementById('expiretime').addEventListener('input', updateDateTime);

    function updateDateTime() {
        var selectedDate = document.getElementById('expiredate').value;
        var selectedTime = document.getElementById('expiretime').value;
        var formattedDateTime = selectedDate + ' ' + selectedTime + ':00.0';
        
        document.getElementById('formatteddatetime').value = formattedDateTime;
    }
</script>
<body>
<%@ include file= "00-1-NavMenu.jsp"%>
<div class="regContent">
			
			<p class="title">Create A Listing!</p>
			<br>
				<form method="get" action="sqlCreateListing.jsp">
					<table>
						<tr>    
							<td>Sub Category</td> 
							<td>
                				<select name="sub_category">
                    				<option value="Pick Up">Pick Up</option>
                    				<option value="SUV">SUV</option>
                    				<option value="Sports Car">Sports Car</option>
                    			</select>
           					</td>
						</tr>
						<tr>
							<td>Product Name</td><td><input type="text" name="pname"></td>
						</tr>
						
						<tr>    
							<td>Start Price</td><td><input type="text" name="startprice"></td>
						</tr>
						<tr>    
							<td>Minimum Sell Price</td><td><input type="text" name="minprice"></td>
						</tr>
						<tr>    
							<td>Expire Date and Time</td>
								<td>
								    <input type="datetime-local" name="expiredatetime" id="expiredatetime">
								</td>
						</tr>
					
						
						
					</table>
					<input type="submit" value="Create">
					
				
				</form>
				
			<br>
		
			
		</div>
</body>
</html>