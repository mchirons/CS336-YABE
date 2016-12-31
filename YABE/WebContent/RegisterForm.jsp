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
		<title>YABE Registration</title>
	</head>
	<body>
		<div class="header">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<h1><a href="HomePage.jsp" id="logo"><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span></a> Registration</h1>
						<a href ="LoginForm.jsp" id="back">Back</a>
					</div> 
				</div>
			</div>
		</div>
		<hr/>
		<div class="main">
			<div class="container">
				<form action="RegisterCheck.jsp" method="GET"> 
					<div class="form-group">
						<label>Email:</label><input class="form-control" type="email" name="email">
						<label>Username:</label><input class="form-control" type="text" name="username" />
						<label>Password:</label><input class="form-control" type="password" name="password" />
						<br/>
						<button type="submit" value="Submit" class="btn btn-primary">Submit</button>	
					</div>
				</form>	
			</div>
		</div>
	</body>
</html>