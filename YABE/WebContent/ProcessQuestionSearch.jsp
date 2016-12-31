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
			
			String a = "SELECT DISTINCT E1.Content, E2.Content FROM Email E1, Email E2, CustomerRep, Users WHERE ((E1.Type = 'q' AND RepID = E1.Receiver AND UserID = E1.Sender) AND (E2.Type = 'a' AND RepID = E2.Sender AND UserID = E2.Receiver)) AND  (LOWER(E1.Subject) LIKE '%" + search + "%' OR LOWER(E1.Content) LIKE '%" + search + "%');";
			
			System.out.println("query: " + a);
			PreparedStatement p = dbConnection.prepareStatement(a);
			ResultSet result = p.executeQuery();
			
			session.setAttribute("questionresults", result);
			response.sendRedirect("FAQPage.jsp");
			
		%>
	</body>
</html>