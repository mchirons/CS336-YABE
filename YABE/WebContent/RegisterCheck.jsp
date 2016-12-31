<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body>
			<%
				ApplicationDAO dao = new ApplicationDAO();
				String email = request.getParameter("email");
				String username = request.getParameter("username");
				String password = request.getParameter("password");
		
				boolean isValidRegistration = dao.checkRegistration(email, username, password);
		
				if (isValidRegistration){
					session.setAttribute("connected", "true");
					session.setAttribute("login", username);
					response.sendRedirect("HomePage.jsp");
				}
				else{
					response.sendRedirect("RegisterFailure.jsp");
				}
			%>
	</body>
</html>