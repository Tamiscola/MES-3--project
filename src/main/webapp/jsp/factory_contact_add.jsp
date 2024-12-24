<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="taemin.DBManager" %>

<%
    String sup_name = request.getParameter("sup_name");
    String sup_phone = request.getParameter("sup_phone");
    String sup_address = request.getParameter("sup_address");
    String sup_email = request.getParameter("sup_email");

   

    if (sup_name != null && sup_phone != null && sup_address != null && sup_email != null) {
        Connection conn = null;
        PreparedStatement checkPstmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBManager.getDBConnection();

            
            String con_checkSql = "SELECT sup_name FROM supply_contact WHERE sup_name = ?";
            checkPstmt = conn.prepareStatement(con_checkSql);
            checkPstmt.setString(1, sup_name);
            rs = checkPstmt.executeQuery();

            if (rs.next()) {
            	%>
            	<script>
            	alert("중복")
            	</script>
            	<%
            } else {
                
                String con_insertSql = "INSERT INTO supply_contact(sup_no, sup_name, sup_phone, sup_address, sup_email) "
                                 + "VALUES (seq_supply_contact.NEXTVAL, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(con_insertSql);
                pstmt.setString(1, sup_name);
                pstmt.setString(2, sup_phone);
                pstmt.setString(3, sup_address);
                pstmt.setString(4, sup_email);
                pstmt.executeUpdate();

                %>
            	<script>
            	alert("완료")
            	location.href="project1_factory.jsp"
            	</script>
            	<%
            }
        } catch (SQLException se) {
            se.printStackTrace();
            
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
    <h1>연락처 등록</h1>
    <form id="form1" action="factory_sup_add.jsp" method="POST">
        <input type="text" name="sup_name" placeholder="공급업체 이름" required>
        <input type="text" name="sup_phone" placeholder="전화번호" required>
        <input type="text" name="sup_address" placeholder="주소" required>
        <input type="text" name="sup_email" placeholder="이메일" required>
        <button type="submit">등록</button>
    </form>
</body>
</html>