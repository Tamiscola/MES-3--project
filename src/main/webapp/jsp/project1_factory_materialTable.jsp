<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="taemin.DBManager" %>

<%
Connection conn = null;
try {
    conn = DBManager.getDBConnection();
    String sql = "SELECT * FROM MAIN_MATERIAL";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();
    ResultSetMetaData rsmd = rs.getMetaData();
    int n_cols = rsmd.getColumnCount();
%>
<table>
    <thead>
        <tr>
            <% for (int j = 1; j <= n_cols; j++) { %>
                <th><%= rsmd.getColumnName(j) %></th>
            <% } %>
        </tr>
    </thead>
    <tbody>
        <% while (rs.next()) { %>
            <tr>
                <% for (int j = 1; j <= n_cols; j++) { 
                    String columnTypeName = rsmd.getColumnTypeName(j);
                %>
                    <td>
                        <% 
                        if (columnTypeName.equals("VARCHAR2")) { 
                            out.print(rs.getString(j));
                        } else if (columnTypeName.equals("NUMBER")) {
                            out.print(rs.getInt(j));
                        } 
                        %>
                    </td>
                <% } %>
            </tr>
        <% } %>
    </tbody>
</table>
<%
} catch (SQLException se) {
    se.printStackTrace();
} finally {
    if (conn != null) {
        try {
            conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
}
%>