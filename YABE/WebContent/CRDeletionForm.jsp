<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href="css/HomePage.css" rel="stylesheet" type="text/css"/>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Delete Customer Representative </title>
	</head>
	<body>
		
		<h1><span id="y">Y</span><span id="a">A</span><span id="b">B</span><span id="e">E</span> </h1>
		<hr/>
		<h2>delete existing customer representative</h2>
		<%
					ApplicationDAO dao = new ApplicationDAO();
					String selectString = "SELECT * FROM CustomerRep LIMIT 50;";
					Connection dbConnection = dao.getConnection();
					PreparedStatement preparedStatement = dbConnection.prepareStatement(selectString);
					ResultSet result = preparedStatement.executeQuery();
			        while(result.next())
			        {
			            %>
			            <form action="CRDeletion.jsp" method="GET">
			            <%
			            	String username = result.getString("Username"); 
			            	String repID = result.getString("RepID");
			            %>
			            <p> CustomerRepID: &nbsp<%=repID%></p>
			            <p> Username: &nbsp<%=username%></p>
						  <input type="hidden" value=<%= username%> name="username">		
							<div>
								<input type="submit" value="Delete account" class="button" />
							</div>
							</form>
							<br>
			            <% 
			        }
    			%>
		
	</body>
</html>