<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Connection, java.sql.DriverManager, 
    java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.util.Date, java.sql.Timestamp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link href="css/HomePage.css" rel="stylesheet" type="text/css"/>
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" 
		integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		
		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" 
		integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
		
		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" 
		integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
		
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
		<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
		
		<title>YABE Auction Page</title>
	</head>
	<body>
		<%
			response.setHeader("Cache-Control","no-cache");
			response.setHeader("Cache-Control","no-store");
			response.setDateHeader("Expires", 0);
			response.setHeader("Pragma","no-cache");
			if (session.getAttribute("connected") == null	|| !((String) session.getAttribute("connected"))
                .equals("true")) {
    			String redirectURL = "LoginForm.jsp";
    			response.sendRedirect(redirectURL);
			}
			ApplicationDAO dao = new ApplicationDAO();
			dao.updateAuctions();
		%>
		
		<%
			String VehicleID = null;
			if (request.getParameter("VehicleID") == null){
				VehicleID = session.getAttribute("VehicleID").toString();
			}
			else {
				VehicleID =  request.getParameter("VehicleID");
			}
			//Gets attributes from Vehicle
			
			String selectString;
			Connection dbConnection = dao.getConnection();
			selectString = "select Type from Vehicles where VehicleID = " + VehicleID + ";";

			PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
			ResultSet result = preparedStatement.executeQuery();
			result.next();
			String type = result.getString("Type");
			if (type.equals("car"))
				selectString = "SELECT * FROM Vehicles v JOIN Cars c ON v.VehicleID=c.CarID WHERE VehicleID = '" + VehicleID + "';";
			else if (type.equals("trk"))
				selectString =  "SELECT * FROM Vehicles v JOIN Trucks t ON v.VehicleID=t.TruckID WHERE VehicleID = '" + VehicleID + "';";
			else if (type.equals("mtr"))
				selectString =  "SELECT * FROM Vehicles v JOIN Motorcycles m ON v.VehicleID=m.MotorcycleID WHERE VehicleID = '" + VehicleID + "';";
				
			preparedStatement = dbConnection.prepareStatement(selectString);
			result = preparedStatement.executeQuery();
			result.next();
			
			//Gets max bid on Vehicle
			String selectString2 = "SELECT MAX(Amount) MaxBid, Username, Email " + 
					"FROM Bids, Vehicles, Users " +
					"WHERE VehicleID = " + VehicleID + " AND VehicleID = PlacedOn AND PostedBy = UserID;";
			PreparedStatement preparedStatement2 = dbConnection.prepareStatement(selectString2);
			ResultSet result2 = preparedStatement2.executeQuery();
			result2.next();
			
			String username = session.getAttribute("login").toString();
			String seller = result2.getString("Username");
			
		%>
		
		<div class="header">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h1><a href="HomePage.jsp" id="logo"><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span></a> Auction Page</h1>
					</div>
					<div class="col-md-6">
						<ul>
							<li><a href="FAQPage.jsp">FAQ    </a></li>
							<li>Hello <strong><%= session.getAttribute("login")%></strong>!</li>
							<li><a href="UserPage.jsp">My yaBe</a></li>
							<li><a href="Logout.jsp">Logout</a>
						</ul>
					</div>  
				</div>
			</div>
		</div>
		<hr/>
		<%
			String maxAmount = result2.getString("MaxBid");
			if (maxAmount == null){
					maxAmount = "0";
			}
			String cDate = null;
			Timestamp timestamp = result.getTimestamp("CloseTime");
			Date closeDate = timestamp;
			Date currentDate = new Date();
			if (currentDate.after(closeDate)){
				cDate = "Auction Closed";
			}
			else {
				cDate = timestamp.toString();
			}
		%>
		<div class="main">
			<div class="container">
				<div class="row">
					<div class="col-md-4">
						<img src=<%= result.getString("Img") %> class="thumbnail img-responsive" class="img-responsive"/>
					</div>
					<div class="col-md-4">
						<h4><strong><%=result.getString("PostTitle")%></strong></h4>
						<p>Best Offer: $<%=maxAmount%></p>
						<p>Close Time: <%=cDate%>
						<%
							if (!cDate.equals("Auction Closed") && !username.equals(seller))
							{
								%>
									<form action= "ProcessBid.jsp">
										<div class="form-group row">
									  		<div class="col-xs-10">
									    		<input class="form-control" type="number" step="0.01" name="amount">
									    		<input type="hidden" name="maxAmount" value=<%=maxAmount%>>
									    		<input type="hidden" name="VehicleID" value=<%=VehicleID%>>
									    		<button type="submit" class="btn btn-primary" id="makeoffer">Make Offer</button>
									  		</div>
										</div>
									</form>
								<% 
							}
						%>
							
						
					</div>
					<div class="col-md-4">
						<h5><strong>Seller Information</strong></h5>
						<%String profileURL = "ProfilePage.jsp?profilename=" + seller; %>
						<p><a href=<%=profileURL%>><%=seller%></a></p>
						<p><%=result2.getString("Email") %></p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
					<% 		
							String t = null;
							if (type.equals("car")){
								t = "Car";
							} else if (type.equals("trk")){
								t = "Truck";
							} else {
								t = "Motorcycle";
							}
					%>
						
						<h4>Item Specifics</h4>
						<p>Type: <%= t %>
						<p>Color: <%=result.getString("Color")%></p>
						<p>HorsePower: <%=result.getString("HorsePower")%></p>
						<p>Mileage: <%=result.getString("Mileage")%></p>
						<p>Mpg: <%=result.getString("Mpg")%></p>
						<p>Manufacturer: <%=result.getString("Manufacturer")%></p>
						<p>Model: <%=result.getString("Model")%></p>
						<p>Year: <%=result.getString("Year")%></p>
						<%
							if (type.equals("car")){
								%>
									<p>Doors: <%= result.getString("Doors")%></p>
									<p>Seats: <%= result.getString("Seats")%></p>
								<%
							}else if (type.equals("trk")){
								%>
									<p>Doors: <%= result.getString("Doors")%></p>
								 	<p>Seats: <%= result.getString("Seats")%></p>
								 	<p>Height: <%= result.getString("Height")%></p>
								 	<p>Tow Capacity: <%= result.getString("TowCapacity")%></p>
								 	<p>Clearance: <%= result.getString("Clearance")%></p>
								<%
							} else {
								%>
									<p>HandleBarType: <%= result.getString("HandlebarType")%></p>
								 	<p>SeatType: <%= result.getString("SeatType")%></p>
								<%
							}
						%>	
					</div>
				</div>
				<div class="tab-content">
					<ul class="nav nav-tabs" role="tablist">
				  	<li class="nav-item">
				    	<a class="nav-link active" data-toggle="tab" href="#bidhistory" role="tab">Bid History</a>
				  	</li>
				 	 <li class="nav-item">
				    	<a class="nav-link" data-toggle="tab" href="#similarauctions" role="tab">Similar Auctions</a>
				 	 </li>
				 </ul>
			  	<div class="tab-pane active" id="bidhistory" role="tabpanel">
			  		<div class="container">
			  			<table class="table">
		                	<thead>
			                	<tr>
			                		<th></th>
			                		<th>Bidder</th>
			                		<th>Amount</th>
			                		<th>Time</th>
			                	</tr>
			                </thead>
			                <tbody>
							<%
								selectString ="SELECT Username, Amount, PostTime FROM Bids, Users, Vehicles WHERE VehicleID = " + VehicleID + " AND VehicleID = PlacedOn AND PlacedBy = UserID ORDER BY PostTime DESC;";
								preparedStatement = dbConnection.prepareStatement(selectString);
								result = preparedStatement.executeQuery();
								while (result.next()){
									%>
										<tr>
					                	<th scope="row"></th>
					                	<%
					                		String buyer = result.getString("Username");
					                		profileURL = "ProfilePage.jsp?profilename=" + buyer;
					                	%>
					                	<td><a href=<%= profileURL%>><%=buyer%></a></td>
					                	<td><%= result.getString("Amount")%></td>
					                	<td><%= result.getString("PostTime")%></td>
					                	</tr>
				                	<% 
								}
							%>
							</tbody>
						</table>
			  		</div>
			 	 </div>
			 	<div class="tab-pane" id="similarauctions" role="tabpane2">
			 		<div class="container">
			 			<table class="table">
		                	<thead>
			                	<tr>
			                		<th></th>
			                		<th>Auction Title</th>
			                	</tr>
			                </thead>
			                <tbody>
							<%
								
								selectString ="SELECT DISTINCT V1.PostTitle, V1.VehicleID FROM Vehicles V1, Vehicles V2 WHERE V2.VehicleID = '" + VehicleID + "' AND V1.Type = V2.Type AND V1.VehicleID <> V2.VehicleID AND (V1.PostedTime BETWEEN DATE_SUB(NOW(), INTERVAL 30 DAY) AND NOW());";
								preparedStatement = dbConnection.prepareStatement(selectString);
								result = preparedStatement.executeQuery();
								while (result.next()){
									%>
										<tr>
					                	<th scope="row"></th>
					                	<%
					                		String vID = result.getString("V1.VehicleID");
					                		String auctionURL = "AuctionPage.jsp?VehicleID=" + vID;
					                	%>
					                	<td><a href=<%=auctionURL%>><%=result.getString("V1.PostTitle")%></a></td>
					                	</tr>
				                	<% 
								}
							%>
							</tbody>
						</table>
			 		</div>
			 	</div>
				</div>
			</div>
		</div>
	</body>
</html>