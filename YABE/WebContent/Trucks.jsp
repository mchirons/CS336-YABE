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
		<link href="style.css" rel="stylesheet" type="text/css"/>
		<link href="assets/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
		
		<script src="assets/js/jquery-1.7.1.min.js"></script> 
 
		<script src="assets/js/jquery.validate.js"></script> 
		 
		<script src="script.js"></script> 
		<script>
		            addEventListener('load', prettyPrint, false);
		            $(document).ready(function(){
		            $('pre').addClass('prettyprint linenums');
		                  });
		            </script> 
		
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Trucks</title>
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
						<h1><a href="HomePage.jsp" id="logo"><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span></a> Truck Details</h1>
					</div>
					<div class="col-md-6">
						<ul>
							<li>Hello <strong><%= session.getAttribute("login")%></strong>!</li>
							<li><a href="#">My yaBe</a></li>
							<li><a href="Logout.jsp">Logout</a>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<hr/>
		<div class ="container">
		<form action="InsertTrucks.jsp" method="GET" id="trucks-form">
			<div class="form-group row">
 		 <label for="example-text-input" class="col-xs-2 col-form-label">Bid Title</label>
  			<div class="col-xs-10">
    			<input class="form-control" type="text" placeholder="e.g. Fancy truck" name="bidtitle" id="bidtitle">
 				 </div>
			</div>
			<div class="form-group row">
  				<label for="example-datetime-local-input" class="col-xs-2 col-form-label">Bid close time</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="datetime-local" value="2016-08-06 00:00:00" name="closetime" id="closetime">
  				</div>
			</div>
			<div class="form-group row">
  				<label for="example-color-input" class="col-xs-2 col-form-label">Color</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="text" placeholder="Type the color of your truck" name="color" id="color">
  				</div>
			</div>
			<div class="form-group row">
  				<label for="example-number-input" class="col-xs-2 col-form-label">Horsepower</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="number" placeholder="e.g. 350" name="horsepower" id="horsepower">
  				</div>
			</div>
			<div class="form-group row">
  				<label for="example-number-input" class="col-xs-2 col-form-label">Mileage</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="number" placeholder="e.g. 50000" name="mileage" id="mileage">
  				</div>
			</div>
			<div class="form-group row">
  				<label for="example-number-input" class="col-xs-2 col-form-label">Mpg</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="number" placeholder="e.g. 13" name="mpg" id="mpg">
  				</div>
			</div>
			<div class="form-group row">
 		 		<label for="example-text-input" class="col-xs-2 col-form-label">Manufacturer</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="text" placeholder="Freightliner\Kenworth\Volvo\Peterbilt:...." name="manufacturer" id="manufacturer">
 				 </div>
			</div>
			<div class="form-group row">
 		 		<label for="example-text-input" class="col-xs-2 col-form-label">Model</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="text" placeholder="Type truck Model" name="model" id="model">
 				 </div>
			</div>
			<div class="form-group row">
  				<label for="example-month-input" class="col-xs-2 col-form-label">year</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="number" placeholder="Type year of the truck" name="year" id="year">
  				</div>
			</div>
			<div class="form-group row">
  				<label for="example-number-input" class="col-xs-2 col-form-label">Doors</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="number" placeholder="Type how many doors the truck have" name="door" id="door">
  				</div>
			</div>
			<div class="form-group row">
  				<label for="example-number-input" class="col-xs-2 col-form-label">Seats</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="number" placeholder="Type how many seats the truck have" name="seats" id="seats">
  				</div>
			</div>
			<div class="form-group row">
  				<label for="example-number-input" class="col-xs-2 col-form-label">Height</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="number" placeholder="Type how tall the truck is" name="height" id="height">
  				</div>
			</div>
			<div class="form-group row">
  				<label for="example-number-input" class="col-xs-2 col-form-label">TowCapacity</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="number" placeholder="Type truck's towcapacity" name="towcapacity" id="towcapacity">
  				</div>
			</div>
			<div class="form-group row">
  				<label for="example-number-input" class="col-xs-2 col-form-label">Clearance</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="number" placeholder="Type truck's clearance" name="clearance" id="clearance">
  				</div>
			</div>
			<div class="form-group row">
  				<label for="example-number-input" class="col-xs-2 col-form-label">Picture</label>
  				<div class="col-xs-10">
    			<input class="form-control" type="text" placeholder="Paste a url" name="picture" id="picture">
  				</div>
			</div>
			<div>
				<p style="text-align:center;"><input type="submit" value="Submit" class="button" /></p>
			</div>
			</form>
</div>
		</body>
</html>