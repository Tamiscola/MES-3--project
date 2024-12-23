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

	
	String searchSupSql = "SELECT * FROM SUPPLY_CONTACT WHERE "
  			+ "SUP_NAME LIKE ? OR "
			+ "SUP_PHONE LIKE ? OR "
			+ "SUP_ADDRESS LIKE ? OR "
			+ "SUP_EMAIL LIKE ?";
	
    PreparedStatement searchPstmt = conn.prepareStatement(searchSupSql);
      
    if (searchInput == null || searchInput.equals("undefined")) {
  	    System.out.println("검색어가 올바르게 입력되지 않았습니다.");
  	} else {
  		System.out.println("검색어를 올바르게 받았습니다.");
  	}
      searchPstmt.setString(1, "%" + searchInput + "%");
      searchPstmt.setString(2, "%" + searchInput + "%");
      searchPstmt.setString(3, "%" + searchInput + "%");
      searchPstmt.setString(4, "%" + searchInput + "%");
  	
  	  ResultSet searchRs = searchPstmt.executeQuery();
  	  
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
        <% while (searchRs.next()) { %>
        <tr>
            <td><%= searchRs.getInt("SUP_NO") %></td>
            <td><%= searchRs.getString("SUP_NAME") %></td>
            <td><%= searchRs.getString("SUP_PHONE") %></td>
            <td><%= searchRs.getString("SUP_ADDRESS") %></td>
            <td><%= searchRs.getString("SUP_EMAIL") %></td>
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