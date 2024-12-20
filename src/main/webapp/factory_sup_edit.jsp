<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBManager" %>
<%
Connection conn = null;
boolean isSuccess = false;
try {
	conn = DBManager.getDBConnection();
	
	String cellsJoined = request.getParameter("cells");
	String[] cells = cellsJoined.split(",");
	String supNo = request.getParameter("supNo");
	int supNoNum = Integer.parseInt(supNo);
	
	
	
	String sup_sql = "UPDATE SUPPLY_CONTACT SET " 
			+ "SUP_NAME = ?, SUP_PHONE = ?, SUP_ADDRESS = ?, SUP_EMAIL = ? "
			+ "WHERE SUP_NO = ?";
	
	PreparedStatement pstmt = conn.prepareStatement(sup_sql);
	pstmt.setString(1, cells[0]);
	pstmt.setString(2, cells[1]);
	pstmt.setString(3, cells[2]);
	pstmt.setString(4, cells[3]);
	pstmt.setInt(5, supNoNum);
	
	pstmt.executeUpdate();
	
	DBManager.dbClose(conn, pstmt, null);
	isSuccess = true;
} catch (SQLException se) {
	se.printStackTrace();
}

%>
<%
	if (isSuccess) {
%>
<script>
	alert("수정되었습니다.")
	location.href = './project1_factory.jsp';
</script>
<% }
else {
%>
<script>
	alert('수정에 실패하였습니다.');
	location.href = './project1_factory.jsp';
</script>
<% } %>