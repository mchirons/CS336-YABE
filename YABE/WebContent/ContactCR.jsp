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
		String message = request.getParameter("message");
		String repUsername = request.getParameter("repusername");
		String username = request.getParameter("username");
		String subject = request.getParameter("subject");
		String type = request.getParameter("private");
		
		if (type == null){
			type ="q";
		}
			
		else if (type.equals("private")){
			type = "m";
		}
		
		if (!(message.length() == 0 && subject.length() == 0)){
			System.out.println("message: " +message + " repUsername: " + repUsername +  " username: " + username + " subject: " + subject);
			
			dao.messageCR(message, repUsername, username, subject, type);
			response.sendRedirect("UserPage.jsp");
		}
		else {
			response.sendRedirect("UserPage.jsp");
		}
		
		

	%>

	</body>
</html>