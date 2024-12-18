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
		
		String sql = "";
		
		
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	} catch (SQLException se) {
		se.printStackTrace();
	}

%>