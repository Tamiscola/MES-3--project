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
	String matNo = request.getParameter("matNo");
	int matNoNum = Integer.parseInt(matNo);
	
	
	
	String sup_sql = "UPDATE MAIN_MATERIAL SET " 
			+ "COLOR = ?, QUANTITY = ?, MATERIAL = ?, DEFECTION = ?, WATERPROOF = ?, WINDPROOF = ?, SUPPLY_COMPANY = ? "
			+ "WHERE NO = ?";
	
	PreparedStatement pstmt = conn.prepareStatement(sup_sql);
	pstmt.setString(1, cells[0]);
	pstmt.setInt(2, Integer.parseInt(cells[1]));
	pstmt.setString(3, cells[2]);
	pstmt.setInt(4, Integer.parseInt(cells[3]));
	pstmt.setString(5, cells[4]);
	pstmt.setString(6, cells[5]);
	pstmt.setString(7, cells[6]);
	pstmt.setInt(8, matNoNum);
	
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