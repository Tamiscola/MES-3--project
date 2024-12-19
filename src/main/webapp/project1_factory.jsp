<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.DBManager" %>
<% 



Connection conn = DBManager.getDBConnection();
String userId = (String)session.getAttribute("userId");


if(userId == null) {
	%>
	<script>
	location.href="./project1.jsp"
	</script>
	<% 
}
	%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Factory Page</title>
  <link rel="stylesheet" href="./css/factory_page.css">
  <style>

  </style>
</head>
<body>
  <div class="big_headbox">
    <div class="big_headbox_position">
      <div id="head_box1">Nautral Yak</div>
      <div id="head_box3"><%= userId %>님 어서오세요 <br>
        <form id="Logout" action="./project1_logout.jsp" method="post">
        	<button type="submit">Logout</button>
        </form>
        
        
      </div>
    </div>
  </div>
  <div class="leftbox">
    <button type="button" class="class_box" id="material_management_button">자재 관리</button>
    <button class="class_box" id="contact_management_button">연락처 관리</button>
  </div>
  <!-- 중앙 공백 공간 -->
  <div id="content_area"></div>

  <script>
    // 자재 관리 버튼 클릭 이벤트
    document.getElementById('material_management_button').addEventListener('click', function() {
      const contentArea = document.getElementById('content_area');
      contentArea.className = 'content';
      contentArea.innerHTML = `
        <table>
          <thead>
            <tr>
              <th>품목</th>
              <th>수량</th>
              <th>단가</th>
              <th>합계</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>철판</td>
              <td>50</td>
              <td>1000</td>
              <td>50000</td>
            </tr>
            <tr>
              <td>볼트</td>
              <td>200</td>
              <td>50</td>
              <td>10000</td>
            </tr>
            <tr>
              <td>너트</td>
              <td>300</td>
              <td>30</td>
              <td>9000</td>
            </tr>
          </tbody>
        </table>
      `;
    });

    // 연락처 관리 버튼 클릭 이벤트
    document.getElementById('contact_management_button').addEventListener('click', function() {
      const contentArea = document.getElementById('content_area');
      contentArea.className = 'content';
      contentArea.innerHTML = `
        <table>
          <thead>
            <tr>
              <th>이름</th>
              <th>전화번호</th>
              <th>주소</th>
              <th>이메일</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>홍길동</td>
              <td>010-1234-5678</td>
              <td>서울시 강남구</td>
              <td>hong@test.com</td>
            </tr>
            <tr>
              <td>이순신</td>
              <td>010-9876-5432</td>
              <td>부산시 해운대구</td>
              <td>lee@test.com</td>
            </tr>
            <tr>
              <td>김철수</td>
              <td>010-5555-1234</td>
              <td>인천시 남동구</td>
              <td>kim@test.com</td>
            </tr>
          </tbody>
        </table>
      `;
    });
    
  
    
    
    
    
  </script>
</body>
</html>