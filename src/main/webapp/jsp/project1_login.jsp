<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="taemin.DBManager" %>
<% 
	Connection conn = null;
	String inputId = request.getParameter("id"); // Get ID from request
	String inputPw = request.getParameter("password"); // Get password from request
	boolean loginSuccessful = false; // To track login status
	
	try {
	    conn = DBManager.getDBConnection();
	    if (conn != null && !conn.isClosed()) {
	        out.println("<p>Database connection successful!</p>");
	    } else {
	        out.println("<p>Failed to connect to the database.</p>");
	    }
	    
	
	    String sql = "SELECT ID, PW FROM LOGIN WHERE ID = ? AND PW = ?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, inputId);
	    pstmt.setString(2, inputPw);
	
	    ResultSet rs = pstmt.executeQuery(); // Execute query
	    
	    loginSuccessful = rs.next(); // This will be true if there's at least one match
	    
	    if (loginSuccessful == true) {
	    	session.setAttribute("userId", inputId);
	    	%><script> location.href = './project1_factory.jsp'</script> <% 
	    } 
	    else {
	    	%><script> alert('Wrong Id or Password')</script> <%
	    }
	    
	} catch (SQLException se) {
	    se.printStackTrace();
	    out.println("<p>Error: " + se.getMessage() + "</p>");
	} finally {
	    if (conn != null) {
	        DBManager.dbClose(conn, null, null);
	    }
	}
%>

<script>
	location.href = './project1.jsp';
</script>