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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/loginPage.css">
</head>
<body>
  <div id="main_concontainer">
    <h1 id="main_rogo">Nautral Yak</h1>
    <div class="box">
    <br>

    <p>로그인</p>
    
    <form id="loginForm" method="post" action="project1_login.jsp">
	    <input type="text" placeholder="아이디" id="id" name="id" autocomplete="on|off">
	    <br>
	    
	    <input type="password" name="password" id="password" placeholder="비밀번호">
	    <br>
	    <div id="Id_box">
	    	<input id="Id_save" type="checkbox"><label for="Id_save">아이디 저장</label>
	    </div>
	    <button id="login_button">로그인</button>
	    <br>
	</form>
    <strong>아이디가 없으신가요?</strong>
    <form id="register_id" method="post" action="project1_register.jsp">
    	<button id="join_membership_button" name="register">회원 가입</button>
    </form>
    
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






