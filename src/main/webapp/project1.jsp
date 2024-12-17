<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="taemin.jsp.DBManager" %>

<% 
	Connection conn = null;
	
	try {
	    conn = DBManager.getDBConnection();
	    if(conn != null && !conn.isClosed()) {
	        out.println("<p>Database connection successful!</p>");
	    } else {
	        out.println("<p>Failed to connect to the database.</p>");
	    }
	} catch(Exception e) {
	    out.println("<p>Error: " + e.getMessage() + "</p>");
	} finally {
	    if(conn != null) {
	        DBManager.dbClose(conn, null, null);
	    }
	}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	hello	
</body>
</html>