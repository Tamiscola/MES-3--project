<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="taemin.DBManager" %>
<%
Connection conn = null;

try {
	conn = DBManager.getDBConnection();
	
	String supNo = request.getParameter("supNo");
	int supNumber = Integer.parseInt(supNo);
	
	String sup_sql = "DELETE FROM SUPPLY_CONTACT WHERE SUP_NO = ?";
	
	PreparedStatement pstmt = conn.prepareStatement(sup_sql);
	pstmt.setInt(1, supNumber);
	pstmt.executeUpdate();
	
	DBManager.dbClose(conn, pstmt, null);
} catch (SQLException se) {
	se.printStackTrace();
}


%>

<script>
	location.href = './project1_factory.jsp';
</script>