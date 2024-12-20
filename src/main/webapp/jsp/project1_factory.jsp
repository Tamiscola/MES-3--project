<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="taemin.DBManager" %>
<%@ page import="taemin.MainMaterial" %>
<%@ page import="taemin.SupplyContact" %>

<%

String userId = (String)session.getAttribute("userId");
if(userId == null) {
	%>
	<script>
	location.href="./project1.jsp"
	</script>
	<% 
}
	%>
%>

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
      <div id="head_box">Natural Yak</div>
      <div id="right_welcome"><%= userId %>님 어서오세요 <br>
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
Connection conn = null;
try {
	conn = DBManager.getDBConnection();
	
	String mat_sql = "SELECT * FROM MAIN_MATERIAL";
	String sup_sql = "SELECT * FROM SUPPLY_CONTACT";

    PreparedStatement pstmt = conn.prepareStatement(mat_sql);
    PreparedStatement pstmt2 = conn.prepareStatement(sup_sql);
    
	ResultSet rs = pstmt.executeQuery(mat_sql);
	ResultSet rs2 = pstmt2.executeQuery(sup_sql);
	
	ResultSetMetaData rsmd = rs.getMetaData();
	ResultSetMetaData rsmd2 = rs2.getMetaData();
	
	int n_cols = rsmd.getColumnCount();
	int n_cols2 = rsmd2.getColumnCount();
%>
 <script>
 // 주재료, 공급업체 테이블 칼럼 이름 불러오기
 let mat_col_names = [];
 let sup_col_names = [];
 <% 
 for (int j = 1; j <= n_cols; j++) {
 %>
 	mat_col_names.push("<%= rsmd.getColumnName(j) %>");
 <%
 }
 %>

 <% 
 for (int k = 1; k <= n_cols2; k++) {
 %>
 	sup_col_names.push("<%= rsmd2.getColumnName(k) %>");
 <%
 }
 %>
 console.log("Material Columns:", mat_col_names);
 console.log("Supply Columns:", sup_col_names);
 
document.addEventListener('DOMContentLoaded', function() {
    // 자재 관리 버튼 클릭 이벤트
    document.getElementById('material_management_button').addEventListener('click', function() {
      const contentArea = document.getElementById('content_area');
      // 테이블 생성
      contentArea.innerHTML = `
    	  <td>
    	    <div class="button-container">
    	        <button id="add_button">추가</button>
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
      
      const deleteButton = document.getElementById('delete_button');
      const addButton = document.getElementById('add_button');
      const editButton = document.getElementById('edit_button');
      
      //자재 DB 불러오기
      let tr = document.querySelector('thead tr');
      const tbody = document.querySelector('tbody');
      
      
      for (let i = 0; i < mat_col_names.length; i++) {
    	  let th = document.createElement('th');
    	  th.appendChild(document.createTextNode(mat_col_names[i]));
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
	  %>
	  let selectedRows = [];
	  
	  //행 선택 동작
	  document.querySelectorAll('tr').forEach(row => {
		  row.addEventListener("click", function(event) {
			  // 단일행 선택 동작
			 if (selectedRows.includes(this)) {
				// Deselect the row
				selectedRows = selectedRows.filter(r => r != this);
				this.style.backgroundColor = "";
			 }  else {
				// Select the row 
				selectedRows.forEach(r => r.style.backgroundColor = "");
				selectedRows = [this];
				this.style.backgroundColor = "royalblue";
			 }
		  });
	  });
	  
	  // 행 버튼 동작
	  // 삭제 버튼
	  
	  deleteButton.addEventListener("click", function(){
		 if (selectedRows.length == 0) {	// 선택한 행이 없을 시
			 alert("항목을 선택해주세요.");
		 } else {
			 if (confirm("정말 삭제하시겠습니까?")) {
				 for (i = 0; i < selectedRows.length; i++) {	// 모든 선택된 행
					 const matNo = selectedRows[i].children[0].textContent;
					 selectedRows[i].remove();
					 console.log("Deleting material with NO:", matNo);	
					 
				 	 location.href = `./factory_material_delete.jsp?matNo=` + matNo;
				 }
				 selectedRows = [];	// 선택된 행들 집합 리셋
			 }
		 }
	  });
	  
	  // 추가 버튼
	  
	  //수정 버튼
	  
	  editButton.addEventListener("click", function(){
			 if (selectedRows.length == 0) {	// 선택한 행이 없을 시
				 alert("항목을 선택해주세요.");
			 	 console.log("No selected row");
			 } else {
				 console.log("row selected");
				 if (confirm("수정하시겠습니까?")) {
					 let e_selectedRows = selectedRows;
					 console.log("e_selectedRows", e_selectedRows);
					 
					 const cells = [];
					 const matNo = e_selectedRows[0].children[0].textContent;
					 
					 for (i = 1; i < e_selectedRows[0].children.length; i++) {  // NO 칼럼을 제외한 모든 <td> 셀 조회
						const cell = e_selectedRows[0].children[i];
					 	const originalValue = cell.textContent; 
					 	
					 	// input 필드 만들기
					 	const input = document.createElement("input");
					 	input.type = "text";
					 	input.value = originalValue;
					 	
					 	// <td> content 를 input값으로 교체
					 	cell.textContent = "";
					 	cell.appendChild(input);
					 	
					    // Add event listener to save on Enter key press
					 	input.addEventListener("keyup", function(event){ 
					 		if (event.key === "Enter") {	// Enter 눌렀을 시
					 			cell.textContent = this.value;
					 			cells.push(cell.textContent);
					 			
					 			const anyInputsLeft = 
					 				Array.from(e_selectedRows[0].children).some(cell =>
					 				cell.querySelector('input'));
					 			
				 				if(!anyInputsLeft) {	// 마지막 <td> 수정이 끝날 시
				 					if (confirm("수정을 마치시겠습니까?")) {
					 					location.href = `./factory_material_edit.jsp?cells=` + encodeURIComponent(cells.join(',')) + `&matNo=` + matNo;
					 				}
				 				}
					 			
					 		}
					 	});
					 }
				 }
			 }
		  });


    });

    // 연락처 관리 테이블 불러오기
    document.getElementById('contact_management_button').addEventListener('click', function() {
      const contentArea = document.getElementById('content_area');
      contentArea.className = 'content';
      contentArea.innerHTML = `
    	  <td>
    	    <div class="button-container">
    	        <button id="add_button">추가</button>
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
      const deleteButton = document.getElementById('delete_button');
      const addButton = document.getElementById('add_button');
      const editButton = document.getElementById('edit_button');
      
      
      for (let i = 0; i < sup_col_names.length; i++) {
    	  let th = document.createElement('th');
    	  th.appendChild(document.createTextNode(sup_col_names[i]));
    	  tr.appendChild(th);
      }
      
      let tbody_tr;
      let tbody_td;
      
      <% while (rs2.next()) { 
      		SupplyContact sp = new SupplyContact();
      		sp.setSup_no(rs2.getInt("SUP_NO"));
      		sp.setSup_name(rs2.getString("SUP_NAME"));
      		sp.setSup_phone(rs2.getString("SUP_PHONE"));
      		sp.setSup_address(rs2.getString("SUP_ADDRESS"));
      		sp.setSup_email(rs2.getString("SUP_EMAIL"));
      		
      		%>
      		
      		tbody_tr = document.createElement('tr');
      		
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= sp.getSup_no()%>"))
      		tbody_tr.appendChild(tbody_td);
			
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= sp.getSup_name()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= sp.getSup_phone()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= sp.getSup_address()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		tbody_td = document.createElement('td');
      		tbody_td.appendChild(document.createTextNode("<%= sp.getSup_email()%>"))
      		tbody_tr.appendChild(tbody_td);
      		
      		
      		
      		tbody.appendChild(tbody_tr);
        <%}
      rs.close();%>
      let selectedRows = [];

  	  document.querySelectorAll('tr').forEach(row => {
  		  row.addEventListener("click", function() {
  			 if (selectedRows.includes(this)) {
  				// Deselect the row
  				selectedRows = selectedRows.filter(r => r != this);
  				this.style.backgroundColor = "";
  			 }  else {
  				// Select the row 
  				selectedRows.forEach(r => r.style.backgroundColor = "");
  				selectedRows = [this];
  				this.style.backgroundColor = "royalblue";
  			 }
  		  });
  	  });
  	  
  	  // 행 버튼 동작
	  // 삭제 버튼
	  
	  deleteButton.addEventListener("click", function(){
		 if (selectedRows.length == 0) {	// 선택한 행이 없을 시
			 alert("항목을 선택해주세요.");
		 } else {
			 if (confirm("정말 삭제하시겠습니까?")) {
				 for (i = 0; i < selectedRows.length; i++) {	// 모든 선택된 행
					 const supNo = selectedRows[i].children[0].textContent;	// NO 칼럼 값
					 selectedRows[i].remove();
					 console.log("Deleting material with NO:", supNo);	
					 
				 	 location.href = `./factory_sup_delete.jsp?supNo=` + supNo;
				 }
				 selectedRows = [];	// 선택된 행들 집합 리셋
			 }
		 }
	  });
  	  
  	  // 수정 버튼
	  
	  editButton.addEventListener("click", function(){
			 if (selectedRows.length == 0) {	// 선택한 행이 없을 시
				 alert("항목을 선택해주세요.");
			 	 console.log("No selected row");
			 } else {
				 console.log("row selected");
				 if (confirm("수정하시겠습니까?")) {
					 let e_selectedRows = selectedRows;
					 console.log("e_selectedRows", e_selectedRows);
					 
					 const cells = [];
					 const supNo = e_selectedRows[0].children[0].textContent;
					 
					 for (i = 1; i < e_selectedRows[0].children.length; i++) {  // NO 칼럼을 제외한 모든 <td> 셀 조회
						const cell = e_selectedRows[0].children[i];
					 	const originalValue = cell.textContent; 
					 	
					 	// input 필드 만들기
					 	const input = document.createElement("input");
					 	input.type = "text";
					 	input.value = originalValue;
					 	
					 	// <td> content 를 input값으로 교체
					 	cell.textContent = "";
					 	cell.appendChild(input);
					 	
					    // Add event listener to save on Enter key press
					 	input.addEventListener("keyup", function(event){ 
					 		if (event.key === "Enter") {	// Enter 눌렀을 시
					 			cell.textContent = this.value;
					 			cells.push(cell.textContent);
					 			
					 			const anyInputsLeft = 
					 				Array.from(e_selectedRows[0].children).some(cell =>
					 				cell.querySelector('input'));
					 			
				 				if(!anyInputsLeft) {	// 마지막 <td> 수정이 끝날 시
				 					if (confirm("수정을 마치시겠습니까?")) {
					 					location.href = `./factory_sup_edit.jsp?cells=` + encodeURIComponent(cells.join(',')) + `&supNo=` + supNo;
					 				}
				 				}
					 			
					 		}
					 	});
					 }
				 }
			 }
		  });
    });
})
  </script>
  <%	DBManager.dbClose(conn, pstmt, null);
		} catch (SQLException se) {
			se.printStackTrace();
		}
  %>
</body>
</html>