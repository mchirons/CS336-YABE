<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Connection, java.sql.DriverManager, 
    java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.util.Date, java.sql.Timestamp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="css/CRPage.css" rel="stylesheet" type="text/css"/>
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

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
    			String redirectURL = "CRLoginPage.jsp";
    			response.sendRedirect(redirectURL);
			}
			ApplicationDAO dao = new ApplicationDAO();
			dao.updateAuctions();
			String username = session.getAttribute("login").toString();
		%>
	
	<div class="header">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h1><a href="HomePage.jsp" id="logo"><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span></a> Customer Rep Page</h1>
					</div>
					<div class="col-md-6">
						<ul>
							<li>Hello <strong><%= session.getAttribute("login")%></strong>!</li>
							<li><a href="Logout.jsp">Logout</a>
						</ul>
					</div>  
				</div>
			</div>
		</div>
		<hr/>
		
		<div class="main">
			<div class="container">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
				  <li class="nav-item">
				    <a class="nav-link active" data-toggle="tab" href="#messages" role="tab">Messages</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link active" data-toggle="tab" href="#questions" role="tab">Questions</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" data-toggle="tab" href="#edit" role="tab">Edit</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" data-toggle="tab" href="#delete" role="tab">Delete</a>
				  </li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="messages" role="tabpanel">
				  		<div class="container">
				  			<div class="row">
				  				<div class="col-md-12">
				  					<h3>Reply to Message</h3>
				  					<form action="CRReply.jsp" method="GET">
				  						<div class="form-group">
				  							<label>Subject</label><input type="text" class="form-control" id="subject" name="subject"/>
				  						</div>
				  						<div class="form-group">
				  							<label>Customer Username</label><input type="text" class="form-control" id="username" name="username" />
				  							<input type="hidden" id="repusername" name="repusername" value="<%= username%>" />
				  						</div>
				  						<div class="form-group">
				  							<label>Body</label><textarea class="form-control" id="message" name="message" rows="4"></textarea>
				  						</div>
				  						<button type="submit" class="btn btn-primary">Submit</button>
				  					</form>
				  				</div>
				  			</div>
				  			<div class="row">
				  				<div class="col-md-12">
				  					<h4>Messages</h4>
				  					<table class="table">
					                	<thead>
						                	<tr>
						                		<th></th>
						                		<th>From</th>
						                		<th>Subject</th>
						                		<th>Contents</th>
						                		<th>Sent</th>
						                	</tr>
						                </thead>
						                <tbody>
						                <%
						                	Connection dbConnection = dao.getConnection();
						                	String selectString = "SELECT * FROM Email, CustomerRep WHERE Receiver = RepID AND Username = '" + username + "' AND Type = 'm';";
						                	PreparedStatement p = dbConnection.prepareStatement(selectString);
						                	ResultSet result = p.executeQuery();
						           			while (result.next()){
						           				
						          				%>
						          					<tr>
						          						<%
						          							String sender = null;
						          							String senderID = result.getString("Sender");
						          							String s = "SELECT Username FROM Users WHERE UserID = " + senderID + ";";
						          							p = dbConnection.prepareStatement(s);
						          							ResultSet r = p.executeQuery();
						          							r.next();
						          							sender = r.getString(1); 
						          						%>
						          						<td></td>
						          						<td><%= sender%></td>
						          						<td><%= result.getString("Subject")%></td>
						          						<td><%= result.getString("Content")%></td>
						          						<td><%= result.getString("Date_Time")%></td>
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
				  	<div class="tab-pane" id="questions" role="tabpanel">
				  		<div class="container">
				  			<div class="row">
				  				<div class="col-md-12">
				  					<h3>Answer Question</h3>
				  					<form action="CRAnswer.jsp" method="GET">
				  						<div class="form-group">
				  							<label>Subject</label><input type="text" class="form-control" id="subject" name="subject"/>
				  						</div>
				  						<div class="form-group">
				  							<label>Customer Username</label><input type="text" class="form-control" id="username" name="username" />
				  							<input type="hidden" id="repusername" name="repusername" value="<%= username%>" />
				  						</div>
				  						<div class="form-group">
				  							<label>Body</label><textarea class="form-control" id="message" name="message" rows="4"></textarea>
				  						</div>
				  						<button type="submit" class="btn btn-primary">Submit</button>
				  					</form>
			  					</div>
				  			</div>
				  			<div class="row">
				  				<div class="col-md-12">
				  					<h4>Questions</h4>
				  					<table class="table">
					                	<thead>
						                	<tr>
						                		<th></th>
						                		<th>From</th>
						                		<th>Subject</th>
						                		<th>Contents</th>
						                		<th>Sent</th>
						                	</tr>
						                </thead>
						                <tbody>
						                <%
						             
						                	selectString = "SELECT * FROM Email, CustomerRep WHERE Receiver = RepID AND Username = '" + username + "' AND Type = 'q';";
						                	p = dbConnection.prepareStatement(selectString);
						                	result = p.executeQuery();
						           			while (result.next()){
						           				
						          				%>
						          					<tr>
						          						<%
						          							String senderID = result.getString("Sender");
						          							selectString = "SELECT Username FROM Users WHERE UserID = " + senderID + ";";
						          							p = dbConnection.prepareStatement(selectString);
						          							ResultSet r = p.executeQuery();
						          							r.next();
						          							String sender = r.getString(1);
						          						%>
						          						<td></td>
						          						<td><%= sender%></td>
						          						<td><%= result.getString("Subject")%></td>
						          						<td><%= result.getString("Content")%></td>
						          						<td><%= result.getString("Date_Time")%></td>
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
						<div class="tab-pane" id="edit" role="tabpanel">
					  		<div class="container">
					  			<div class="row">
					  				<div class="col-md-6">
					  					<form action="CREditUser.jsp" method="GET">
					  						<div class="form-group">
					  							<label>Old Username: </label><input type="text" class="form-control" id="oldusername" name="oldusername"/>
					  						</div>
					  						<div class="form-group">
					  							<label>New Username</label><input type="text" class="form-control" id="newusername" name="newusername" />
					  							<input type="hidden" id="username" name="username" value="<%= username%>" />
					  						</div>
					  						<div class="form-group">
					  							<label>New Password</label><input type="text" class="form-control" id="newpassword" name="newpassword" rows="4"></input>
					  						</div>
					  						<button type="submit" class="btn btn-primary">Submit</button>
					  					</form>
					  				</div>
					  			</div>
				  			
				  			</div>
					  	</div>
					  	<div class="tab-pane" id="delete" role="tabpanel">
					  		<div class="container">
					  			<div class="row">
					  				<div class="col-md-6">
					  					<form action="CRDeleteAuction.jsp" method="GET">
					  						<div class="form-group">
					  							<label>VehicleID: </label><input type="text" class="form-control" id="vehicleid" name="vehicleid"/>
					  						</div>
					  						<button type="submit" class="btn btn-primary">Delete</button>
					  					</form>
					  				</div>
					  				<div class="col-md-6">
					  					<form action="CRDeleteBid.jsp" method="GET">
					  						<div class="form-group">
					  							<label>BidID: </label><input type="text" class="form-control" id="bidid" name="bidid"/>
					  						</div>
					  						<button type="submit" class="btn btn-primary">Delete</button>
					  					</form>
					  				</div>
					  			</div>
				  			
				  			</div>
					  	</div>
					</div>
				</div>			
			</div>
		
</body>
</html>