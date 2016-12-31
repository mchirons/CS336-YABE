<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Connection, java.sql.DriverManager, 
    java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/FAQPage.css" rel="stylesheet" type="text/css"/>
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
						<h1><a href="HomePage.jsp" id="logo"><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span></a> FAQ Page</h1>
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
		
		<div class="search">
			<div class="container">
				<form class="form-inline" method="GET" action="ProcessQuestionSearch.jsp">
					<div class="form-group">
						<input type="text" class="form-control" id="search" name="search" placeholder="Browse questions ..."/>
						<button type="submit" class="btn btn-primary">Search</button>
					</div>
				</form>
			</div>
		</div>
		
		<div class="main">
			<div class="container">
			<% 
				Connection dbConnection = dao.getConnection();
					String selectString = null;
					ResultSet results = null;
					PreparedStatement p = null;
					if (session.getAttribute("questionresults") != null){
						results = (ResultSet)session.getAttribute("questionresults");
						System.out.println("there are search results");
					}
					else {
						selectString = "SELECT DISTINCT E1.Content, E2.Content FROM Email E1, Email E2, CustomerRep, Users WHERE (E1.Type = 'q' AND RepID = E1.Receiver AND UserID = E1.Sender) AND (E2.Type = 'a' AND RepID = E2.Sender AND UserID = E2.Receiver);";
						p = dbConnection.prepareStatement(selectString);
						results = p.executeQuery();
						System.out.println("there are no search results");
					}
			        while(results.next())
			        {
			            %>
			                <div class="row">
			                	<p>
								<div class="col-md-12">
									<h5>
										Question: <%= results.getString("E1.Content")%>
									</h5>
									<p>Answer: <%=results.getString("E2.Content")%>	
								</div>
							</div>
							<hr/>
			            <% 
			        }
    			%>
			</div>
			<%session.removeAttribute("questionresults"); %>
		</div>

</body>
</html>