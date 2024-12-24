<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="taemin.DBManager" %>
<%@ page import="taemin.MainMaterial" %>
<%@ page import="taemin.SupplyContact" %>

<%
Connection conn = null;
	
try{
	conn = DBManager.getDBConnection();
	
	String pageNo = request.getParameter("page");
	
	if (pageNo == null || pageNo.isEmpty()) {
	    pageNo = "1"; // Default to first page if no parameter is provided
	}
	
	int pageNumber = Integer.parseInt(pageNo);
	int rowsPerPage = 10;
	int startRow = (pageNumber - 1) * rowsPerPage + 1; // Calculate starting row
	System.out.println("startRow :" + startRow);
    int endRow = pageNumber * rowsPerPage; // Calculate ending row
    System.out.println("endRow :" + endRow);
	
	
	String sup_sql = "SELECT * FROM (SELECT t.*, ROWNUM rnum FROM (SELECT * FROM SUPPLY_CONTACT ORDER BY SUP_NO) t WHERE ROWNUM <= ?) WHERE rnum >= ?";
	
	PreparedStatement pstmt = conn.prepareStatement(sup_sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	pstmt.setInt(1, endRow);
	pstmt.setInt(2, startRow);
	
	ResultSet rs = pstmt.executeQuery();

	// 페이지 만들기용 변수들
	// Count total rows
    rs.last();
    int supRows = rs.getRow();	// retrieves the current row number, in this case, total number of rows in the ResultSet.
    rs.beforeFirst(); // Reset cursor to beginning of ResultSet
    
	int totalMatPages = 0;

	totalMatPages = (int) Math.ceilDiv(supRows, rowsPerPage);
  	System.out.println("matPages :" + totalMatPages);
	
%>
<table>
    <thead>
        <tr>
            <th>SUP_NO</th>
            <th>SUP_NAME</th>
            <th>SUP_PHONE</th>
            <th>SUP_ADDRESS</th>
            <th>SUP_EMAIL</th>
        </tr>
    </thead>
    <tbody>
        <%
        	while (rs.next() && (startRow <= endRow)) {%>
	        <tr>
	            <td><%= rs.getInt("SUP_NO") %></td>
	            <td><%= rs.getString("SUP_NAME") %></td>
	            <td><%= rs.getString("SUP_PHONE") %></td>
	            <td><%= rs.getString("SUP_ADDRESS") %></td>
	            <td><%= rs.getString("SUP_EMAIL") %></td>
	        </tr>
	        <%
	        }			
	        %> 
    </tbody>
</table>
<script>
</script>
<%
	
	DBManager.dbClose(conn, pstmt, rs);
} catch (SQLException se) {
	se.printStackTrace();
}

%>