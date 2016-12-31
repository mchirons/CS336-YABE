<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Connection, java.sql.DriverManager, 
    java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
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
		<script type="text/javascript">
         
          	   function getConfirmation(){
               var retVal = confirm("Are you sure you want to delete your account?");
               if( retVal == true ){
            	   window.location.href = 'DeleteAccount.jsp';
                  return true;
               }
               else{
                  return false;
               }
            }
      </script>
		
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>YABE UserPage</title>
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
						<h1><a href="HomePage.jsp" id="logo"><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span></a> User Page</h1>
					</div>
					<div class="col-md-6">
						<ul>
							<li><a href="FAQPage.jsp">FAQ    </a></li>
							<li>Hello <strong><%= session.getAttribute("login")%></strong>!</li>
							<li><a href="#">My yaBe</a></li>
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
				    <a class="nav-link active" data-toggle="tab" href="#manage" role="tab">Manage Account</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" data-toggle="tab" href="#history" role="tab">Bid History</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" data-toggle="tab" href="#messages" role="tab">Messages</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" data-toggle="tab" href="#support" role="tab">Customer Support</a>
				  </li>
				</ul>
				
				<!-- Tab panes -->
				<div class="tab-content">
				  <div class="tab-pane active" id="manage" role="tabpanel">
				  	<div class="container">
				  		<form>
         					<input class ="btn btn-primary" type="button" value="Delete Account" onclick="getConfirmation();" />
     					 </form>
				  	</div>
				  </div>
				  <div class="tab-pane" id="history" role="tabpane2">
						<div class="container">
							<table class="table">
			                	<thead>
				                	<tr>
				                		<th></th>
				                		<th>Auction Title</th>
				                		<th>Amount</th>
				                		<th>Placed On</th>
				                		<th>Seller</th>
				                	</tr>
				                </thead>
				                <tbody>
								<%
									String username = session.getAttribute("login").toString();
									String selectString = 	"SELECT U1.Username, U2.Username, V.PostTitle, B.Amount, B.PostTime, V.VehicleID " +
															"FROM Users U1, Users U2, Vehicles V, Bids B " + 
															"WHERE U1.Username= '" + username + "' AND U1.UserID = B.PlacedBy " +
															"AND B.PlacedOn = V.VehicleID AND U2.UserID = V.PostedBy;";
									Connection dbConnection = dao.getConnection();
									PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
									ResultSet result = preparedStatement.executeQuery();
							        while(result.next())
							        {
							            %>
							                <tr>
							                	<th scope="row"></th>
							                	<%
							                		String VehicleID = result.getString(6);
							                		String seller = result.getString(2);
							                		String auctionURL = "AuctionPage.jsp?VehicleID=" + VehicleID;
							                		String sellerURL = "ProfilePage.jsp?profilename=" + seller;
							                	%>
							                	<td><a href=<%=auctionURL %>><%= result.getString(3)%></a></td>
							                	<td><%= result.getString(4)%></td>
							                	<td><%= result.getString(5)%></td>
							                	<td><a href=<%=sellerURL%>><%=seller%></td>
							                </tr>
							            <% 
							        }
	    						%>				
    							</tbody>
    						</table>
						</div>
				  </div>
				  <div class="tab-pane" id="messages" role="tabpane3">
				  	<div class="container">
							<table class="table">
			                	<thead>
				                	<tr>
				                		<th></th>
				                		<th>From</th>
				                		<th>To</th>
				                		<th>Subject</th>
				                		<th>Contents</th>
				                		<th>Sent</th>
				                	</tr>
				                </thead>
				                <tbody>
				                <%
									String selectString2 = "SELECT Sender, Receiver, Subject, Content, Date_Time " +
									"FROM Email, Users U " +
									"WHERE U.Username = '" + username + "' AND (U.UserID = Sender OR U.UserID = Receiver) ORDER BY Date_Time DESC;";
									PreparedStatement preparedStatement2 = dbConnection.prepareStatement(selectString2);
									ResultSet result2 = preparedStatement2.executeQuery();
									
				                	
				                	//selectString = "SELECT Username FROM Users WHERE UserID = " + SenderID + ";";
				                	
							        while(result2.next())
							        {
							            %>
							            	<% 	
							            	String SenderID = result2.getString(1);
											String ReceiverID = result2.getString(2);
											String Subject = result2.getString(3);
											String Content = result2.getString(4);
						                	String Date_Time = result2.getString(5);
						                	
						                	String sender = null;
						                	String receiver = null;
							            		selectString = "SELECT  Username, RepID FROM CustomerRep WHERE RepID = " + SenderID + ";";
							            		preparedStatement = dbConnection.prepareStatement(selectString);
							            		result = preparedStatement.executeQuery();
							            		if (result.next()){
							            			sender = result.getString(1);
							            			selectString = "SELECT  Username FROM Users WHERE UserID = " + ReceiverID + ";";
								            		preparedStatement = dbConnection.prepareStatement(selectString);
								            		result = preparedStatement.executeQuery();
								            		result.next();
								            		receiver = result.getString(1);
							            		}
							            		else {
							            			selectString = "SELECT  Username FROM Users WHERE UserID = " + SenderID + ";";
								            		preparedStatement = dbConnection.prepareStatement(selectString);
								            		result = preparedStatement.executeQuery();
								            		result.next();
								            		sender = result.getString(1);
								            		if (sender.equals("YABE")){
								            			receiver = username;
								            		}
								            		else {
								            			selectString = "SELECT  Username FROM CustomerRep WHERE RepID = " + ReceiverID + ";";
									            		preparedStatement = dbConnection.prepareStatement(selectString);
									            		result = preparedStatement.executeQuery();
									            		result.next();
									            		receiver = result.getString(1);
								            		}
								            		
								            		
							            		}
							            	%>
							                <tr>
							                	<th scope="row"></th>
							                	<td><%= sender%></td>
							                	<td><%= receiver%></td>
							                	<td><%= Subject%></td>
							                	<td><%= Content%></td>
							                	<td><%= Date_Time%></td>
							                </tr>
							            <% 
							        }
	    						%>
	    						</tbody>
    						</table>				
				  		</div>
				  	</div>
				  <div class="tab-pane" id="support" role="tabpane4">
				  		<div class="container">
				  			<div class="row">
				  				<div class="col-md-6">
				  					<h3>Contact Customer Representative</h3>
				  					<form action="ContactCR.jsp" method="GET">
				  					<p>If you wish to respond to a Customer Rep please enter their Username found in the message</p>
				  						<div class="form-group">
				  							<label>Subject</label><input type="text" class="form-control" id="subject" name="subject"/>
				  						</div>
				  						<div class="form-group">
				  							<label>Rep Username</label><input type="text" class="form-control" id="repusername" name="repusername" />
				  							<input type="hidden" id="username" name="username" value="<%= username%>" />
				  						</div>
				  						<div class="form-group">
				  							<label>Body</label><textarea class="form-control" id="message" name="message" rows="4"></textarea>
				  						</div>
				  						<div class="checkbox">
				  							<label>
				  								<input type="checkbox" name="private" id="private" value="private"> Private Message
				  							</label>
				  						</div>
				  						<button type="submit" class="btn btn-primary">Submit</button>
				  					</form>
				  				</div>
				  			</div>
				  			<div class="row">
				  				<div class="col-md-6">
				  					<form action="SetAlert.jsp">
				  						<h3>Set an Item Alert</h3>
				  					</form>
				  				</div>
				  			</div>
				  		</div>
				  </div>
			</div>
		</div>
	</body>
</html>