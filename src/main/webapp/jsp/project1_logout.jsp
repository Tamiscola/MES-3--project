<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="taemin.DBManager" %>

<script>
alert("로그아웃 되었습니다.")
</script>
<% 
session.invalidate();
%>
<script>
location.href="project1.jsp"
</script>