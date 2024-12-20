<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.DBManager" %>

<%
    Connection conn = null;
	PreparedStatement pstmt = null;
   
    try {
        conn = DBManager.getDBConnection();

        String color = request.getParameter("color");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String material = request.getParameter("material");
        int defection = Integer.parseInt(request.getParameter("defection"));
        String waterproof = request.getParameter("waterproof");
        String windproof = request.getParameter("windproof");
        String supply_company = request.getParameter("supply_company");

        String sql = "INSERT INTO main_material(no, color, quantity, material, defection, waterproof, windproof, supply_company) "
                   + "VALUES (seq_main_material.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, color);
        pstmt.setInt(2, quantity);
        pstmt.setString(3, material);
        pstmt.setInt(4, defection);
        pstmt.setString(5, waterproof);
        pstmt.setString(6, windproof);
        pstmt.setString(7, supply_company);

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
    	%>
    	<script>
    	alert("등록")
    	</script>
    	<%
        } else {
        	%>
        	<script>
        	alert("실패")
        	</script>
        	<%
        }

    } catch (Exception e) {
        
        e.printStackTrace();
    } finally {
        
        DBManager.dbClose(conn, pstmt, null);
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
    
    
    <form id="form1" action="project1_factory_material_add.jsp" method="POST">
        <input type="text" name="color" placeholder="Color" required>
        <input type="number" name="quantity" placeholder="Quantity" required>
        <input type="text" name="material" placeholder="Material" required>
        <input type="number" name="defection" placeholder="Defection" required>
        <input type="text" name="waterproof" placeholder="Waterproof" required>
        <input type="text" name="windproof" placeholder="Windproof" required>
        <input type="text" name="supply_company" placeholder="Supply Company" required>
        <button type="submit">등록</button>
    </form>

    
</body>
</html>
