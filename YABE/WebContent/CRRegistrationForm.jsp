<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="css/HomePage.css" rel="stylesheet" type="text/css"/>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>New Customer Representative </title>
	</head>
	<body>
		
		<h1><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span> </h1>
		<hr/>
		<h2>create new customer representative</h2>
			<form action="CRRegistrationCheck.jsp" method="GET">
				Username: <input type="text" name="username"><br /><br />
				Password: <input type="password" name="password"><br /><br />
				Name:<input type="text" name="name"><br /><br />
				Email:<input type="text" name="email"><br /><br />
				<br />
				<br />
				<div>
					<input type="submit" value="Submit" class="button" />
					<br />
					<br />	
					<div class="button">
						<a href="AdminPage.jsp">Back</a>
					</div>
				</div>
			</form>
		</div>
		
	</body>
</html>