<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.DBManager" %>
<% 
    
    String id = request.getParameter("id");
    String pw1 = request.getParameter("pw1");
    String pw2 = request.getParameter("pw2");
    String name = request.getParameter("name");
    

    if (id != null && pw1 != null && name != null) {
        
        Connection conn = DBManager.getDBConnection();
        
    
        String checkSql = "SELECT id FROM login WHERE id = ?";
        try {
            PreparedStatement checkPstmt = conn.prepareStatement(checkSql);
            checkPstmt.setString(1, id);
            ResultSet rs = checkPstmt.executeQuery();
            
            if (rs.next()) {
    	%>
    	<script>
    	alert("중복")
    	</script>
    	<%
                
            } else {
            	if(!pw1.equals(pw2)) {
            		%>
                	<script>
                	alert("비밀번호 불일치")
                	</script>
                	<%
            		
            	} else {
    
                String insertSql = "INSERT INTO login(no, id, pw, name, reg_date)"
                                   + "VALUES (seq_login.NEXTVAL, ?, ?, ?, sysdate)";
                
                PreparedStatement pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, id);
                pstmt.setString(2, pw1);
                pstmt.setString(3, name);
                
                pstmt.executeUpdate();
                DBManager.dbClose(conn, pstmt, null);
                %>
                <script>
                
                alert("가입완료");
                location.href="project1.jsp"
                </script>
                <%
            	}
            }
            
            DBManager.dbClose(conn, checkPstmt, rs);
        } catch (Exception e) {
            e.printStackTrace();
            
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
</head>
<body>
    <h1>회원가입</h1>
    
    <form id="form1" action="project1_register.jsp" method="POST">
        <input type="text" id="id" name="id" placeholder="아이디" required>
        <input type="password" id="pw1" name="pw1" placeholder="비밀번호" required>
        <input type="password" id="pw2" name="pw2" placeholder="비밀번호확인" required>
        <input type="text" id="name" name="name" placeholder="이름" required>
        <button type="submit">가입</button>
   	</form>
    
    <script>
    	
    </script>
    
</body>
</html>
