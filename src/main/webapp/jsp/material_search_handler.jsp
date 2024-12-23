<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="taemin.DBManager" %>
<%@ page import="taemin.MainMaterial" %>
<%@ page import="taemin.SupplyContact" %>


<%
Connection conn = null;

try {
	conn = DBManager.getDBConnection();
	
	String searchInput = request.getParameter("searchWord");
	System.out.println("searchInput :" + searchInput);

	
	String searchMatSql = "SELECT * FROM MAIN_MATERIAL WHERE "
  			+ "COLOR LIKE ? OR "
			+ "MATERIAL LIKE ? OR "
			+ "SUPPLY_COMPANY LIKE ?";
	
    PreparedStatement searchPstmt = conn.prepareStatement(searchMatSql);
      
    if (searchInput == null || searchInput.equals("undefined")) {
  	    System.out.println("검색어가 올바르게 입력되지 않았습니다.");
  	} else {
  		System.out.println("검색어를 올바르게 받았습니다.");
  	}
      searchPstmt.setString(1, "%" + searchInput + "%");
      searchPstmt.setString(2, "%" + searchInput + "%");
      searchPstmt.setString(3, "%" + searchInput + "%");
  	
  	  ResultSet searchRs = searchPstmt.executeQuery();
  	  
  	%>
<table>
    <thead>
        <tr>
            <th>No</th>
            <th>Color</th>
            <th>Quantity</th>
            <th>Material</th>
            <th>Defection</th>
            <th>Waterproof</th>
            <th>Windproof</th>
            <th>Supply Company</th>
        </tr>
    </thead>
    <tbody>
        <% while (searchRs.next()) { %>
        <tr>
            <td><%= searchRs.getInt("NO") %></td>
            <td><%= searchRs.getString("COLOR") %></td>
            <td><%= searchRs.getInt("QUANTITY") %></td>
            <td><%= searchRs.getString("MATERIAL") %></td>
            <td><%= searchRs.getString("DEFECTION") %></td>
            <td><%= searchRs.getString("WATERPROOF") %></td>
            <td><%= searchRs.getString("WINDPROOF") %></td>
            <td><%= searchRs.getString("SUPPLY_COMPANY") %></td>
        </tr>
        <% } %> <!-- End of while loop -->
    </tbody>
</table>
</script>
<% 
	DBManager.dbClose(conn, searchPstmt, searchRs);
} catch(SQLException se) {
	se.printStackTrace();
}

%>