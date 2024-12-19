<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBManager" %>
<%@ page import="com.MainMaterial" %>

<%

Connection conn = null;
String userName = null;
String userId = (String)session.getAttribute("userId");



try{
	conn = DBManager.getDBConnection();
String nmsql = "SELECT name FROM login WHERE id = ?";
PreparedStatement nmpstmt = conn.prepareStatement(nmsql);
nmpstmt.setString(1, userId);

ResultSet rs1 = nmpstmt.executeQuery();
if(rs1.next()) {
	session.setAttribute("userName", rs1.getString("name"));
	
	
}
	rs1.close();
	nmpstmt.close();
	
} catch (Exception e) {
	e.printStackTrace();
}


if(userId == null) {
	%>
	<script>
	location.href="./project1.jsp"
	</script>
	<% 
}
	%>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Factory Page</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/factory_page.css">
  <style>
  
  body{                     /*전체적인 배경색깔*/
  background-color: #1C202A;
}
.leftbox {                /*왼쪽 박스*/
  text-align: center;     /* 글자 센터 */
  position: absolute;     /* 절대 위치 지정 */
  top: 80px;              /* 위에서부터 80px */
  left: 0;                /* 왼쪽 딱붙어서 진행 */
  width: 175px;           /* 가로 너비 200px */
  height: 100vh;          /* 세로는 꽉 채움 */
  background-color:  #1C202A;  /* 배경색 (옵션) */
  margin: 20px 0px 0px 0px;      /*위에 딱붙기 방지용*/
  /*border-right: 1px solid white;*/
}
.class_box{ /*왼쪽박스의 마진값 +띄우기값 확인용*/
  margin: 10px 0px 10px 0px;
  background-color: #1C202A;
  border: 2px solid #4d64af;
  color: white;
  font-size: 15px; 
  border-radius: 8%;
}
.big_headbox{         /*위쪽 큰박스*/
  position: absolute; /* 절대 위치 지정*/
  top: 0px;           /*위에 딱붙어 있기*/
  left: 0;            /*왼쪽에 딱붙어있기*/
  width: 100vw;       /*너비 가득 채우기*/
  height: 80px;       /*leftbox에서 떨어진만큼의 높이 설정(공백없이만들기 위해*/
  background-color: rgb(19, 21, 146);
}
.big_headbox_position{ /*위쪽 큰박스2*/
  display: flex;      /*flex 사용*/
  flex-direction: row;  /*왼쪽에서 오른쪽으로*/
  justify-content: space-between;  /*양쪽끝 고정 후 중앙에 띄움배치*/
  background-color: white;
  width: 100vw;
  height: 70px;
}
#head_box1{
  font-size: 40px;
  font-weight: bold;
  color: rgba(0, 0, );
}


#material_management_button{ /*왼쪽 자재관리 버튼*/
  width: 120px;     /*leftbox너비가 200px이라 꽉채우게 200px*/
  height: 30px;     /*적당한 높이로 값*/
  font-size: 10%;  /*폰트 크기*/
  font-weight:bold; /*폰트 두께*/
  letter-spacing: 0.1em;
}
#material_management_button:hover{
cursor: pointer;
}
#contact_management_button{ /*왼쪽 연락처관리 버튼*/
  width: 120px;     /*leftbox너비가 200px이라 꽉채우게 200px*/
  height: 35px;     /*적당한 높이로 값*/
  font-size: 10%;  /*폰트 크기*/
  font-weight:bold; /*폰트 두께*/
  letter-spacing: 0.1em;
}
#contact_management_button:hover{
  cursor: pointer;
}
/* 테이블을 표시할 공간 스타일 */
.content {
  margin: 200px 100px 100px 250px;  /* 위, 아래, 왼쪽, 오른쪽 100px 마진 */
  background-color: #f8f8f8;      /* 테이블 배경색 */
  padding: 20px;                    /* 테두리 내부 여백 */
  border: 1px solid #ccc;         /* 테두리 */
  box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* 테두리 그림자 */
}
#right_welcome{               /*오른쪽상단 어서오세요 글자*/
  margin: 0px 5px 0px 0px;
}
#logout_button{                /*오른쪽 상단 로그아웃 버튼*/
  position: absolute;          /*위치 절대 고정*/
  right: 5px;                  /*오른쪽에 딱 붙게 고정*/
  background-color: #38415f;
  width: 55px; 
  color: rgba(255, 255, 255, 0.8); 
  height: 25px;
  border-radius: 10%;
}
.button-container{            /*테이블안 버튼 컨테이너*/
  display: flex;              /*추가 수정 삭제 */
  justify-content: flex-end;  /*오른쪽끝으로 정렬*/
}
#add_button{                  /*추가 버튼*/    
  margin: 10px 10px 10px 10px;
  background-color: #38415f;
  border-radius: 10%;
  color: white;
  font-weight: bold;
}
#add_button:hover{
  cursor: pointer;
}
#edit_button{                 /*수정 버튼*/
  margin: 10px 10px 10px 10px;
  background-color: #38415f;
  border-radius: 10%;
  color: white;
  font-weight: bold;
}
#edit_button:hover{
  cursor: pointer;
}
#delete_button{               /*삭제 버튼*/
  margin: 10px 10px 10px 10px;
  background-color: #38415f;
  border-radius: 10%;
  color: rgb(138, 37, 37);
  font-weight: bold;
}
#delete_button:hover{
  cursor: pointer;
}


/* 테이블 스타일 */
table {
  width: 100%;
  border-collapse: collapse;
}

th, td {  /*선색상*/
  border: 1px solid #ddd; 
  padding: 10px;
  text-align: center;
}

th {            /*헤드*/
  background-color: #D1C9A4;
  font-weight: bold;
}

tr:nth-child(even) {
  background-color: #f9f9f9;
}
/* 스크롤바 스타일 숨기기 */
::-webkit-scrollbar {
  display: none;
}
.above-table-space{
  background-color: #1C202A;
  position: absolute;
  top: 100px;
  left: 200px;
  width: 100vw;
  height: 50px;
  border-bottom: 1px solid white;
  color: white;
}
  </style>
</head>
<body>
  <div class="big_headbox">
    <div class="big_headbox_position">
      <div id="head_box1">Natural Yak</div>
      <div id="right_welcome"><%= session.getAttribute("userName") %>님 어서오세요 <br>
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
  <div class="above-table-space">
    자재 관리 <!--여기에 버튼을 클릭하면 글자가 버튼누른 글자로 변하는 방식으로 변경-->
  </div>
  <div class="divider"></div>
  <!-- 중앙 공백 공간 -->
  <div id="content_area"></div>

<% 

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
    	  <td>
    	    <div class="button-container">
    	    <form action="project1_factory_material_add.jsp">
    	        <button id="add_button">추가</button>
    	        </form>
    	        <button id="edit_button">수정</button>
    	        <button id="delete_button">삭제</button>
    	    </div>
    	    </td>  
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
       	  <td >
    	    <div class="button-container">
    	        <button id="add_button">추가</button>
    	        <button id="edit_button">수정</button>
    	        <button id="delete_button">삭제</button>
    	    </div>
    	    </td>  
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