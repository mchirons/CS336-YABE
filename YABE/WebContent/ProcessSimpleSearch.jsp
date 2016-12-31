<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Connection, java.sql.DriverManager, 
    java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	</head>
	<body>
		<%
			ApplicationDAO dao = new ApplicationDAO();
			Connection dbConnection = dao.getConnection();
			String search = request.getParameter("search").toString().toLowerCase();
			String type = request.getParameter("item").toString().toLowerCase();
			String sorting = request.getParameter("sorting").toString().toLowerCase();
			int year = 0;
			try {
				year = Integer.parseInt(search);
				System.out.println("year = " + year);
			} catch (NumberFormatException e) {
				
			}
			
			String a = null;
			if (search.length() == 0){
				System.out.println("search length is 0");
				if (type.equals("all")){
					a = "SELECT * FROM Vehicles ";
				}
				else {
					a = "SELECT * FROM Vehicles WHERE Type = '" + type + "' ";
				}
			}
			else if (type.equals("all")){
				a = "Select * from Vehicles where '" + search + "' LIKE CONCAT('%', Manufacturer, '%') OR '" + search + "' LIKE CONCAT('%', Model, '%') OR '"  + search +  "' LIKE CONCAT('%', Submodel, '%') OR (Year = " + year + ") ";
				System.out.println("all");
			}
			else {
				a = "Select * from Vehicles where Type = '" + type + "' AND '" + search + "' LIKE CONCAT('%', Manufacturer, '%') OR '" + search + "' LIKE CONCAT('%', Model, '%') OR '"  + search +  "' LIKE CONCAT('%', Submodel, '%') OR " + year + " = Year ";
				System.out.println("not all");
			}
			
			//Search for keyword, change 'order by'' term to sort (replace blah with variable)
			
			
			if (sorting.equals("featured") || sorting.equals("Category")){
				a = a + "ORDER BY VehicleID ASC;";
			} else if (sorting.equals("highest")){
				a = a + "ORDER BY CurrentBid DESC;";
			} else if (sorting.equals("newest")){
				a = a + "ORDER BY PostedTime DESC;";
			} else if (sorting.equals("oldest")){
				a = a + "ORDER BY PostedTime ASC;";
			} else if (sorting.equals("lowest")){
				a = a + "ORDER BY CurrentBid ASC;";
			} else if (sorting.equals("youngest")){
				a = a + "ORDER BY Year DESC;";
			} else if (sorting.equals("elderly")){
				a = a + "ORDER BY Year ASC;";
			}
			
			System.out.println("query: " + a);
			
			
			PreparedStatement p = dbConnection.prepareStatement(a);
			ResultSet result = p.executeQuery();
			
			session.setAttribute("searchresults", result);
			response.sendRedirect("HomePage.jsp");
			
		%>
	</body>
</html>