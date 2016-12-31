<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		
		<link href="css/LoginRegister.css" rel="stylesheet" type="text/css"/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
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
		
		<title>Login Error</title>
	</head>
	
	<body>
		<div class="header">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<h1><a href="HomePage.jsp" id="logo"><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span></a> Error</h1>
					</div> 
				</div>
			</div>
		</div>
		<div class="main">
			<div class="container">
				<h3>Invalid Username and Password. Please try again.</h3>
				<form method="get" action="LoginForm.jsp">
	    			<button type="submit" class="btn btn-primary">Back</button>
				</form>
			</div>
		</div>
		
	</body>
</html>