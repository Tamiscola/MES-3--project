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
	
	
	String _sql = "SELECT * FROM (SELECT t.*, ROWNUM rnum FROM (SELECT * FROM ANNOUNCEMENT ORDER BY NO) t WHERE ROWNUM <= ?) WHERE rnum >= ?";
	
	PreparedStatement pstmt = conn.prepareStatement(_sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	pstmt.setInt(1, endRow);
	pstmt.setInt(2, startRow);
	
	ResultSet rs = pstmt.executeQuery();

	// 페이지 만들기용 변수들
	// Count total rows
    rs.last();
    int matRows = rs.getRow();	// retrieves the current row number, in this case, total number of rows in the ResultSet.
    rs.beforeFirst(); // Reset cursor to beginning of ResultSet
    
	int totalMatPages = 0;

	totalMatPages = (int) Math.ceilDiv(matRows, rowsPerPage);
  	System.out.println("matPages :" + totalMatPages);
	
%>
<table>
    <thead>
        <tr>
            <th>No</th>
            <th>작성자</th>
            <th>내용</th>
            <th>작성일자</th>
        </tr>
    </thead>
    <tbody>
        <%
        	while (rs.next() && (startRow <= endRow)) {%>
	        <tr>
	            <td><%= rs.getInt("NO") %></td>
	            <td><%= rs.getString("WRITER") %></td>
	            <td><%= rs.getString("CONTENT") %></td>
	            <td><%= rs.getDate("REG_DATE") %></td>
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