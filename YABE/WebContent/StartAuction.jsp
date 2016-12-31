<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>StartAuction</title>
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
		%>
		
		<div class="header">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h1><a href="HomePage.jsp" id="logo"><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span></a> Choose vehicle type</h1>
					</div>
					<div class="col-md-6">
						<ul>
							<li>Hello <strong><%= session.getAttribute("login")%></strong>!</li>
							<li><a href="UserPage.jsp">My yaBe</a></li>
							<li><a href="Logout.jsp">Logout</a>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<hr/>
		</br></br>
				<div class ="container">
				<div><p style = "font-size:170%;">Select a Category</p></div>
				</br></br>
				<div>   <a href="Cars.jsp" class="btn btn-secondary btn-lg active" role="button" aria-pressed="true">Cars></a>
						<a href="Trucks.jsp" class="btn btn-secondary btn-lg active" role="button" aria-pressed="true">Trucks></a>
						<a href="Motorcycles.jsp" class="btn btn-secondary btn-lg active" role="button" aria-pressed="true">Motorcycles></a></div>
				</div>		
</body>
</html>