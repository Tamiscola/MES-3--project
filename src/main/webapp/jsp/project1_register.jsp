<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="taemin.DBManager" %>
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
<style>
    /* 전체 페이지 스타일 */
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background: linear-gradient(135deg, #7F8C8D , #2C3E50 );
      color: #ffffff;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    /* 메인 컨테이너 */
    #new_main_concontainer {
      background-color: rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(255, 255, 255, 0.3);
      border-radius: 15px;
      padding: 20px;
      width: 40vw;
      max-width: 400px;
      text-align: center;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
    }
    #new_Id_checkbox_button{
      margin: 30px 0px 30px 0px;
    }
    #new_name_button{
      margin: 20px 0px 20px 0px;
    }
    /* 제목 스타일 */
    #new_main_rogo {
      font-size: 2rem;
      margin-bottom: 20px;
      font-weight: bold;
      color: #ffffff;
    }

    /* 입력 필드 스타일 */
    input[type="text"], input[type="password"] {
      width: calc(100% - 20px);
      padding: 10px;
      margin-bottom: 15px;
      border: none;
      border-radius: 5px;
      outline: none;
      font-size: 1rem;
    }

    /* 버튼 스타일 */
    button {
      width: calc(100% - 20px);
      padding: 10px;
      margin-top: 10px;
      background-color: #2C3E50 ;
      border: none;
      border-radius: 5px;
      color: #ffffff;
      font-size: 1rem;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    

    #pw1{
      margin: 20px auto;
    }
    button:hover {
      background-color: rgba(33, 61, 38, 0.671) ;
    }
    #name{
      margin: 20px auto;
    }
    /* 체크박스 스타일 */
    #Id_box {
      display: flex;
      align-items: center;
      justify-content: start;
      margin-bottom: 10px;
    }

    #Id_save {
      margin-right: 10px;
    }

    /* 폰트 강조 */
    strong {
      font-weight: bold;
      color: #ecf0f1;
    }
</style>
<body>
    <div id="new_main_concontainer">
    <h1 id="new_main_rogo">Natural Yak</h1>
    <strong>회원가입</strong>
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