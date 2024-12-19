<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="taemin.DBManager" %>
<%@ page import="taemin.MainMaterial" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Factory Page</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/factory_page.css">
  <style>
  </style>
</head>
<body>
  <div class="big_headbox">
    <div class="big_headbox_position">
      <div id="head_box1">Natural Yak</div>
      <div id="right_welcome">''어서오세요 <br>
        <button id= logout_button>Logout</button>
      </div>
    </div>
  </div>
  <div class="leftbox">
    <button type="button" class="class_box" id="material_management_button">자재 관리</button>
    <button class="class_box" id="contact_management_button">연락처 관리</button>
  </div>
  <div class="above-table-space">
    자재 관리 <!--여기에 버튼을 클릭하면 글자가 버튼누른 글자로 변하는 방식으로 변경-->
  </div>
  <div class="divider"></div>
  <!-- 중앙 공백 공간 -->
  <div id="content_area"></div>

<% 
Connection conn = null;
try {
	conn = DBManager.getDBConnection();
	
	String sql = "SELECT * FROM MAIN_MATERIAL";

    PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery(sql);
	ResultSetMetaData rsmd = rs.getMetaData();
	
	int n_cols = rsmd.getColumnCount();
%>
 <script>
 let col_names = [];
 <% 
 for (int j = 1; j <= n_cols; j++) {
 %>
 	col_names.push("<%= rsmd.getColumnName(j) %>");
 <%
 }
 %>
 console.log(col_names);
 
document.addEventListener('DOMContentLoaded', function() {
    // 자재 관리 버튼 클릭 이벤트
    document.getElementById('material_management_button').addEventListener('click', function() {
      const contentArea = document.getElementById('content_area');
      contentArea.innerHTML = `
      	<table>
      		<thead>
      			<tr></tr>
      		</thead>
      		<tbody></tbody>
      	</table>
      `;
      let tr = document.querySelector('thead tr');
      const tbody = document.querySelector('tbody');
      
      
      for (let i = 0; i < col_names.length; i++) {
    	  let th = document.createElement('th');
    	  th.appendChild(document.createTextNode(col_names[i]));
    	  tr.appendChild(th);
      }
      
      let tbody_tr;
      let tbody_td;
      
      <% while (rs.next()) { 
      		MainMaterial mm = new MainMaterial();
      		mm.setNo(rs.getInt("NO"));
      		mm.setColor(rs.getString("COLOR"));
      		mm.setQuantity(rs.getInt("QUANTITY"));
      		mm.setMaterial(rs.getString("MATERIAL"));
      		mm.setDefection(rs.getString("DEFECTION"));
      		mm.setWaterProof(rs.getString("WATERPROOF"));
      		mm.setWindProof(rs.getString("WINDPROOF"));
      		mm.setSupplyCompany(rs.getString("SUPPLY_COMPANY"));
      		%>
      		
      		tbody_tr = document.createElement('tr');
			
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= mm.getNo()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= mm.getColor()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= mm.getQuantity()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= mm.getMaterial()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= mm.getDefection()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= mm.getWaterProof()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= mm.getWindProof()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= mm.getSupplyCompany()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		tbody.appendChild(tbody_tr);
      		
	  <%}
	  rs.close();%>
	  
	  

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
})
  </script>
  <%
		} catch (SQLException se) {
			se.printStackTrace();
		}
  %>
</body>
</html>