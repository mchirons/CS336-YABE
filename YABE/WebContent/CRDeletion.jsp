<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title></title>
		</head>
	<body>
	<%
		ApplicationDAO dao = new ApplicationDAO();
		String username = request.getParameter("username");
	
	    boolean isValidID = dao.CRdeletion(username);
	   response.sendRedirect("AdminPage.jsp");

	%>

	</body>
</html>