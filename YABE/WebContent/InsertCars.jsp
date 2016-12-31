<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
			<%
				ApplicationDAO dao = new ApplicationDAO();
				String username = session.getAttribute("login").toString();
				String selectString = "SELECT UserID FROM Users WHERE Username = '" + username + "'";
				Connection dbConnection = dao.getConnection();
				PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
				ResultSet result = preparedStatement.executeQuery();
				result.next();
				String userID = result.getString(1);
				String bidtitle = request.getParameter("bidtitle");
				String closetime = request.getParameter("closetime");
				String color = request.getParameter("color");
				String horsepower = request.getParameter("horsepower");
				String mileage = request.getParameter("mileage");
				String mpg = request.getParameter("mpg");
				String manufacturer = request.getParameter("manufacturer");
				String model = request.getParameter("model");
				String year = request.getParameter("year");
				String door = request.getParameter("door");
				String seat = request.getParameter("seats");
				String img = request.getParameter("picture");
				
				
				boolean InsertCars = dao.InsertCars(userID,bidtitle,closetime,color,horsepower,mileage,mpg,manufacturer,model,year,door,seat,img);
		
				if (InsertCars)
					response.sendRedirect("HomePage.jsp");
				else
				{
					response.sendRedirect("AuctionFailure.jsp");
				}
				
			
			%>
	</body>
</html>