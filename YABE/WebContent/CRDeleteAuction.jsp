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
			String vehicleID = request.getParameter("vehicleid");
			;
			
			if (vehicleID.length() == 0){
				response.sendRedirect("CRPage.jsp");
			}
			dao.deleteAuction(vehicleID);
			response.sendRedirect("CRPage.jsp");
			
		%>
	</body>
</html>