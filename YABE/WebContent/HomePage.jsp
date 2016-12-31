<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="com.cs336.pkg.*, java.sql.Connection, java.sql.DriverManager, 
    java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
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
		
		<script type="text/javascript">
		$(document).ready(function() {
    		$('dropdown-toggle').dropdown()
			});
		</script>
		
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>YABE Homepage</title>
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
						<h1><a href="HomePage.jsp" id="logo"><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span></a> HomePage</h1>
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
		
		<div class="auction">
			<div class="container">
				<a href="StartAuction.jsp" class="btn btn-primary">
					Start Auction
				</a>
			</div>
		</div>
		
		<div class="search">
			<div class="container">
				<form class="form-inline" method="GET" action="ProcessSimpleSearch.jsp">
					<div class="form-group">
						<input type="text" class="form-control" id="search" name="search" placeholder="Browse current auctions..."/>
						<select class="form-control" name="item">
						  <option selected value="all">All</option>
						  <option value="car">Cars</option>
						  <option value="trk">Trucks</option>
						  <option value="mtr">Motorcycles</option>
						</select>
						<select class="form-control" name="sorting" name="sorting">
					  	  <option  value="featured">Featured items</option>
						  <option  value="highest">Price: highest first</option>
						  <option  value="lowest">Price: lowest first</option>
						  <option  value="newest">Time: newly listed</option>
						  <option  value="oldest">Time: ending soonest</option>
						  <option  value="youngest">Year: newest first</option>
						  <option  value="elderly">Year: oldest first</option>
						</select>
						<button type="submit" class="btn btn-primary">Search</button>
					</div>
				</form>
			</div>
		</div>
		
		<!-- Creates auctions items list -->
		<div class="feature">
			<div class="container">
				<%	
					Connection dbConnection = dao.getConnection();
					String selectString = null;
					ResultSet results = null;
					PreparedStatement p = null;
					if (session.getAttribute("searchresults") != null){
						results = (ResultSet)session.getAttribute("searchresults");
						System.out.println("there are search results");
					}
					else {
						selectString = "SELECT * FROM Vehicles LIMIT 50;";
						p = dbConnection.prepareStatement(selectString);
						results = p.executeQuery();
						System.out.println("there are no search results");
					}
			        while(results.next())
			        {
			            %>
			                <div class="row">
			                	<p>
								<div class="col-md-5">
									<%String img = results.getString("Img"); %>
									<img src =<%= img%> class="thumbnail img-responsive"/>
									<p>Close Time: <%=results.getString("CloseTime")%>	
								</div>
								<div class="col-md-7">
									<%
										String VehicleID = results.getString(1); 
										String url = "AuctionPage.jsp?VehicleID=" + VehicleID;
									%>
									<h3><a href=<%=url %>><%=results.getString(5)%></a></h3>
									<%
										String type = results.getString("Type");
										if (type.equals("car")){
											type = "Car";
										} else if (type.equals("trk")){
											type = "Truck";
										} else {
											type = "Motorcycle";
										}
									%>
									<p>Type: <%= type %>
									<p>Make: <%=results.getString("Manufacturer")%></p>
									<p>Model: <%=results.getString("Model")%></p>
									<p>Year: <%=results.getString("Year")%></p>
									<p>Max bid: $<%= results.getString("CurrentBid") %> </p>
								</div>
							</div>
			            <% 
			        }
    			%>
			</div>
			<%session.removeAttribute("searchresults"); %>
		</div>
</body>
</html>