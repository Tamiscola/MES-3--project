<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBManager" %>
<%
Connection conn = null;

try {
	conn = DBManager.getDBConnection();
	
	String matNo = request.getParameter("matNo");
	int matNumber = Integer.parseInt(matNo);
	
	String mat_sql = "DELETE FROM MAIN_MATERIAL WHERE NO = ?";
	
	PreparedStatement pstmt = conn.prepareStatement(mat_sql);
	pstmt.setInt(1, matNumber);
	pstmt.executeUpdate();
	
	DBManager.dbClose(conn, pstmt, null);
} catch (SQLException se) {
	se.printStackTrace();
}


%>

<script>
	location.href = './project1_factory.jsp';
</script>