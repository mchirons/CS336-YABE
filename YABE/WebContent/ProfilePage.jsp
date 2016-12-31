<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Connection, java.sql.DriverManager, 
    java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link href="css/UserPage.css" rel="stylesheet" type="text/css"/>
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
		<title>Insert title here</title>
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
		
		<div class="header">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h1><a href="HomePage.jsp" id="logo"><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span></a> Profile Page</h1>
					</div>
					<div class="col-md-6">
						<ul>
							<li>Hello <strong><%= session.getAttribute("login")%></strong>!</li>
							<li><a href="FAQPage.jsp">FAQ    </a></li>
							<li><a href="#">My yaBe</a></li>
							<li><a href="Logout.jsp">Logout</a>
						</ul>
					</div>  
				</div>
			</div>
		</div>
		<hr/>
		
		<% 
			String profilename = request.getParameter("profilename");
		%>
		
		<div class="main">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<h3><%=profilename%>'s Profile</h3>
							<h4>Auction History</h4>
						<table class="table">
			                	<thead>
				                	<tr>
				                		<th></th>
				                		<th>Auction Title</th>
				                		<th>Role</th>
				                	</tr>
				                </thead>
				                <tbody>
								<%	
									Connection dbConnection = dao.getConnection();
									String selectString ="SELECT DISTINCT PostTitle, VehicleID FROM Vehicles, Users WHERE Username = '" + profilename + "' AND UserID = PostedBy;";
									PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
									ResultSet result = preparedStatement.executeQuery();
									while (result.next()){
										%>
											<tr>
						                	<th scope="row"></th>
						                	<%String auctionURL = "AuctionPage.jsp?VehicleID=" + result.getString("VehicleID");%>
						                	<td><a href=<%=auctionURL%>><%= result.getString("PostTitle")%></a></td>
						                	<%
			
						                		String role = "Seller";
						   
						                	%>
						                	<td><%=role%></td>
						                	</tr>
					                	<% 
									}
									
									selectString ="SELECT DISTINCT PostTitle, VehicleID FROM Vehicles, Users, Bids WHERE Username = '" + profilename + "' AND UserID = PlacedBy AND PlacedOn = VehicleID;";
									preparedStatement = dbConnection.prepareStatement(selectString);
									result = preparedStatement.executeQuery();
									
									while (result.next()){
										%>
											<tr>
						                	<th scope="row"></th>
						                	<%String auctionURL = "AuctionPage.jsp?VehicleID=" + result.getString("VehicleID");%>
						                	<td><a href=<%=auctionURL%>><%= result.getString("PostTitle")%></a></td>
						                	<%
						                		String role = "Bidder";
						   
						                	%>
						                	<td><%=role%></td>
						                	</tr>
					                	<% 
									}
								%>
						</table>
					</div>
				</div>
			</div>
		</div>
		
	</body>
</html>