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
	
	try {
	    conn = DBManager.getDBConnection();
	    if (conn != null && !conn.isClosed()) {
	        System.out.println("Database connection successful!");
	        
	    } else {
	    	System.out.println("Failed to connect to the database.");
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
  <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Nautral Yak</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/project1.css">
</head>
<body>
  <div class = "container">
    <h1>Nautral Yak</h1>
    <div class="box">
    <br>
    <h1 id="main_text1">Nautral Yak</h1>
    <p>LOGIN</p>
    
    <form id="loginForm" method="post" action="project1_login.jsp">
	    <input type="text" id="id" name="id" autocomplete="on|off">
	    <br>
	    <input id="Id_checkbox_button" type="checkbox"><span style="margin: 2px;">아이디 저장</span>
	    <br>
	    <input type="password" name="password" id="password">
	    <br>
	    
	    <br>
	    <button id="login_button">로그인</button>
	    <br>
	</form>
    
    <p>아이디가 없으신가요?</p>
    <form id="register_id" method="post" action="project1_register.jsp">
    	<button id="join_membership_button" name="register">회원 가입</button>
    </form>
    <div  style="position: absolute; right: 10px; bottom: 0px;">전화번호 010-xxxx-xxxx <br>주소 수원시 장안구 서로구 xxx-xx  </div>
    </div>
  </div>
  
  <script>
  	document.addEventListener("DOMContentLoaded", function() {
  		const Id_checkbox_button = document.querySelector('#Id_checkbox_button');
  		const id = document.querySelector('#id');
  		const login_button = document.querySelector('#login_button');
  		
  		
  	})
  </script>
  
</body>
</html>

<%
	
%>
