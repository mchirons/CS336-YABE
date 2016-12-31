<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
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
<style>
p.ex1 {
    margin-left: 7cm;
}
</style>

<title>AdminPage</title>
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
							<li><a href="LoginForm.jsp">Back</a>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<hr/>
		<br/><br/>
				<div class ="container">
			
			<form action="RegisterCheck.jsp" method="GET">
				<div>   <a href="CRRegistrationForm.jsp" class="btn btn-secondary btn-lg active" role="button" aria-pressed="true">Create new Customer Representative></a>
				        <a href="CRDeletionForm.jsp" class="btn btn-secondary btn-lg active" role="button" aria-pressed="true">Delete existing Customer Representative></a>
				        <p class="ex1"><a href="SalesReport.jsp" class="btn btn-secondary btn-lg active" role="button" aria-pressed="true">Generate Sales Report</a></p>
				</div>		
				
			</form>
		</div>	
		
		
</body>
</html>