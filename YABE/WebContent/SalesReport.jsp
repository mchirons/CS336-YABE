<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<<link href="css/HomePage.css" rel="stylesheet" type="text/css"/>
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
		
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SalesReport</title>
</head>
<body>
		<div class="header">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h1><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span> </h1>
					</div>
					<div class="col-md-6">
						<ul>
							<li>Hello <strong>Administrator</strong>!</li>
							<li><a href="AdminPage.jsp">Back</a>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<hr/>
		</br></br>	
		
		<div class="feature">
			<div class="container">
				
				<%
					ApplicationDAO dao = new ApplicationDAO();
					Connection dbConnection = dao.getConnection();
					String a = "SELECT sum(CurrentBid) from Vehicles where Winner is not null ;";
					PreparedStatement preparedStatement = dbConnection.prepareStatement(a);
					ResultSet rs = preparedStatement.executeQuery(a);
					String b1 = "SELECT PostTitle,CurrentBid from Vehicles where Winner is not null ;";
			        PreparedStatement preparedStatement2 = dbConnection.prepareStatement(b1);
			        ResultSet rs2 = preparedStatement2.executeQuery(b1);
			        String b2 = "SELECT Type,sum(CurrentBid) from Vehicles where Winner is not null group by Type;";
			        PreparedStatement preparedStatement3 = dbConnection.prepareStatement(b2);
			        ResultSet rs3 = preparedStatement3.executeQuery(b2);
			        String b3 = "select Username,sum(CurrentBid) from Vehicles v, Users u where u.Userid=v.Postedby and v.Winner is not null group by Postedby;";
			        PreparedStatement preparedStatement4 = dbConnection.prepareStatement(b3);
			        ResultSet rs4 = preparedStatement4.executeQuery(b3);
			        String c = "SELECT PostTitle,count(*) from Bids b, Vehicles v where v.VehicleID = b.PlacedOn  group by PlacedOn;";
			        PreparedStatement preparedStatement5 = dbConnection.prepareStatement(c);
			        ResultSet rs5 = preparedStatement5.executeQuery(c);
			        String d = "SELECT Username,count(*) from Users u, Bids b where u.UserID= b.PlacedBy group by PlacedBy;";
			        PreparedStatement preparedStatement6 = dbConnection.prepareStatement(d);
			        ResultSet rs6 = preparedStatement6.executeQuery(d);
			       %>
			        
			        	</div>
		</div>
				<br>
				<div class="main">
					<div class="container">
					<ul class="nav nav-tabs" role="tablist">
  				<li class="nav-item">
   				 <a class="nav-link active" data-toggle="tab" href="#1" role="tab">Total Earnings</a>
  				</li>
  				<li class="nav-item">
    			<a class="nav-link" data-toggle="tab" href="#2" role="tab">Earnings per item </a>
  				</li>
  				<li class="nav-item">
    			<a class="nav-link" data-toggle="tab" href="#3" role="tab">Earnings per item type</a>
  				</li>
  				<li class="nav-item">
    			<a class="nav-link" data-toggle="tab" href="#4" role="tab">Earnings per user</a>
  				</li>
  				<li class="nav-item">
    			<a class="nav-link" data-toggle="tab" href="#5" role="tab">Best-selling item</a>
  				</li>
  				<li class="nav-item">
    			<a class="nav-link" data-toggle="tab" href="#6" role="tab">Best buyer</a>
  				</li>
					</ul>

				<div class="tab-content">
  				<div class="tab-pane active" id="1" role="tabpanel"> <%
			        while(rs.next())
			        {if(rs.getString(1)!= null){
			            %>
								<div class="col-md-9">
									<p>Total Earnings: <%=rs.getString(1)%></p>
								</div>
							
			            <%	}	            
			        }
			        %> </div>
  				<div class="tab-pane" id="2" role="tabpanel"><%
			        while(rs2.next())
			        {if(rs2.getString(1)!= null){
			            %>
								<div class="col-md-9">
									<p><%=rs2.getString(1)%>:$<%=rs2.getString(2) %></p>
								</div>
							
			            <%		}            
			        }
			        %></div>
  				<div class="tab-pane" id="3" role="tabpanel"><%
			        while(rs3.next())
			        {if(rs3.getString(1)!= null){
			            %>
								<div class="col-md-9">
									<p><%=rs3.getString(1)%>:$<%=rs3.getString(2)%></p>
								</div>
							
			            <%	}	            
			        }
			        %></div>
  				<div class="tab-pane" id="4" role="tabpanel"><%
			        while(rs4.next())
			        {if(rs4.getString(1)!= null){
			            %>
								<div class="col-md-9">
									<p><%=rs4.getString(1)%>:$<%=rs4.getString(2)%></p>
								</div>
							
			            <%		      }      
			        }
			        %></div>
  				<div class="tab-pane" id="5" role="tabpanel"><%
			        while(rs5.next())
			        {
			            %>
								<div class="col-md-9">
									<p>Best-selling item: <%=rs5.getString(1)%></p>
								</div>
							
			            <%		            
			        }
			        %></div>
  				<div class="tab-pane" id="6" role="tabpanel"><%
			        while(rs6.next())
			        {
			            %>
								<div class="col-md-9">
									<p>Best Buyer: <%=rs6.getString(1)%></p>
								</div>	
			            <%            
			        }
			        %></div>
			    </div>
					
					</div>
				</div>
			     
		
		
</body>
</html>