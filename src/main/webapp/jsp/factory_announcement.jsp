<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="taemin.DBManager" %>

<%
    Connection conn = null;
	PreparedStatement pstmt = null;
   
    try {
        
       

    } catch (Exception e) {
        
        e.printStackTrace();
    } finally {
        
        DBManager.dbClose(conn, pstmt, null);
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>등록</title>
</head>
<body>
    
    
    <div>
    <h1>공지사항</h1>
    	
    
    </div>
<script>



</script>
    
</body>
</html>
