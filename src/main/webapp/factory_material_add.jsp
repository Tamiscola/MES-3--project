<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBManager" %>

<%
    String color = request.getParameter("color");
	Integer quantity = null;    
	String material = request.getParameter("material");
	Integer defection = null;    
	String waterproof = request.getParameter("waterproof");
    String windproof = request.getParameter("windproof");
    String supply_company = request.getParameter("supply_company");

    
    

    try {
        quantity = Integer.parseInt(request.getParameter("quantity"));
        defection = Integer.parseInt(request.getParameter("defection"));
    } catch (NumberFormatException e) {
    	e.printStackTrace();
        
    }

    if (color != null && material != null && waterproof != null && windproof != null && supply_company != null && quantity != null && defection != null) {
        Connection conn = null;
        PreparedStatement checkPstmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBManager.getDBConnection();

            
            String mat_checkSql = "SELECT material FROM main_material WHERE material = ?";
            checkPstmt = conn.prepareStatement(mat_checkSql);
            checkPstmt.setString(1, material);
            rs = checkPstmt.executeQuery();

            if (rs.next()) {
                %>
                <script>
                    alert("중복");
                </script>
                <%
            } else {
                
                String mat_insertSql = "INSERT INTO main_material(no, color, quantity, material, defection, waterproof, windproof, supply_company) "
                                 + "VALUES (seq_main_material.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(mat_insertSql);
                pstmt.setString(1, color);
                pstmt.setInt(2, quantity);
                pstmt.setString(3, material);
                pstmt.setInt(4, defection);
                pstmt.setString(5, waterproof);
                pstmt.setString(6, windproof);
                pstmt.setString(7, supply_company);
                pstmt.executeUpdate();

                %>
                <script>
                    alert("완료");
                    location.href = "project1_factory.jsp";
                </script>
                <%
            }
        } catch (SQLException se) {
            se.printStackTrace();
            out.println("Error: " + se.getMessage());
        } finally {
            DBManager.dbClose(conn, checkPstmt, rs);
            DBManager.dbClose(null, pstmt, null);
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>등록</title>
</head>
<body>
    <h1>자재 등록</h1>
    <form id="form1" action="factory_material_add.jsp" method="POST">
        <input type="text" name="color" placeholder="color" required>
        <input type="number" name="quantity" placeholder="quantity" required>
        <input type="text" name="material" placeholder="material" required>
        <input type="number" name="defection" placeholder="defection" required>
        <input type="text" name="waterproof" placeholder="waterproof" required>
        <input type="text" name="windproof" placeholder="windproof" required>
        <input type="text" name="supply_company" placeholder="supply_company" required>
        <button type="submit">등록</button>
    </form>
</body>
</html>
