<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="taemin.DBManager" %>
<%@ page import="taemin.MainMaterial" %>
<%@ page import="taemin.SupplyContact" %>
<%@ page import="taemin.Announcement" %>



<%

String userId = (String)session.getAttribute("userId");
String userName = null;


try{
	Connection conn = DBManager.getDBConnection();
String nmsql = "SELECT name FROM login WHERE id = ?";
PreparedStatement nmpstmt = conn.prepareStatement(nmsql);
nmpstmt.setString(1, userId);

ResultSet rs10 = nmpstmt.executeQuery();
if(rs10.next()) {
	session.setAttribute("userName", rs10.getString("name"));
	
	
}
	rs10.close();
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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/project1_factory.css">
  <style>
  </style>
</head>
<body>
  <div class="parent">
    <div class="header box"><h1>Natural Yak</h1>
      <div class="header-right" ><%= session.getAttribute("userName") %>님 어서오세요<br>
        <button id="logout_button" class="logout_button"><strong>로그아웃</strong></button></div>

    </div>
    <div class="main">
      <div class="side box">
        <h1 class="side_so"></h1>
        <button id="material_management_button" class="side_box1"><h3>자재 관리</h3></button>
        <button id="contact_management_button" class="side_box1"><h3>연락처 관리</h3></button>
        <button id="announcement_management_button" class="side_box1"class="side_box1"><h3>공지사항</h3></button>
        
      </div>
      <div  class="center box">
        <div class="solid_box">
          <div><h2>공지 사항</h2></div>
          <div>     
       		<input class="search_input" type="text"placeholder="검색..." name="search_input"><button class="search_button"></button>
          </div>
        </div>
        <div class="table_button">
          <button id="delete_button" class="table_button_delete">삭제</button>
          <button id="edit_button" class="table_button_correction">수정</button>
          <button id="add_button" class="table_button_update">추가</button>
        </div>
        <div id="content_area">
        </div>
        <div id="page_buttons">
        </div>
</body>
<% 
Connection conn = null;
try {
	conn = DBManager.getDBConnection();
	
	String mat_sql = "SELECT * FROM MAIN_MATERIAL";
	String sup_sql = "SELECT * FROM SUPPLY_CONTACT";
	String announcement_sql = "SELECT * FROM ANNOUNCEMENT";

    PreparedStatement pstmt = conn.prepareStatement(mat_sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    PreparedStatement pstmt2 = conn.prepareStatement(sup_sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    PreparedStatement pstmt3 = conn.prepareStatement(announcement_sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    
	ResultSet rs = pstmt.executeQuery(mat_sql);
	ResultSet rs2 = pstmt2.executeQuery(sup_sql);
	ResultSet rs3 = pstmt3.executeQuery(announcement_sql);
	
	ResultSetMetaData rsmd = rs.getMetaData();
	ResultSetMetaData rsmd2 = rs2.getMetaData();
	ResultSetMetaData rsmd3 = rs3.getMetaData();
	
	int n_cols = rsmd.getColumnCount();
	int n_cols2 = rsmd2.getColumnCount();
	int n_cols3 = rsmd3.getColumnCount();
	
	// 페이지 만들기용 변수들
	int matRows = 0;
	int supRows = 0;
	int annRows = 0;
	
	int matPages = 0;
	int supPages = 0;
	int annPages = 0;
	
	int rowsPerPage = 10;
	
	// Count total rows
	rs.last();
	matRows = rs.getRow();	// retrieves the current row number, in this case, total number of rows in the ResultSet.
	matPages = Math.ceilDiv(matRows, rowsPerPage);
  	System.out.println("matPages :" + matPages);
%>
 <script>
 // 주재료, 공급업체 테이블 칼럼 이름 불러오기
 let mat_col_names = [];
 let sup_col_names = [];
 let announcement_col_names = [];
 
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
 
 <% 
 for (int l = 1; l <= n_cols3; l++) {
 %>
 	announcement_col_names.push("<%= rsmd3.getColumnName(l) %>");
 <%
 }
 %>
 
 console.log("Material Columns:", mat_col_names);
 console.log("Supply Columns:", sup_col_names);
 console.log("Announcement Columns:", announcement_col_names);
 
document.addEventListener('DOMContentLoaded', function() {
	let selectedRows = []
	let searchInput = document.querySelector('.search_input');
    const searchButton = document.querySelector('.search_button');
    let pageButtonsBox = document.querySelector('#page_buttons');
    let pageNumbers = [];
    
	// 페이지 버튼 기능 
    for (let p = 1; p <= <%= matPages %>; p++) {
		  let page = document.createElement('button');
		  page.textContent = p;
		  pageNumbers.push(page.textContent);
		  pageButtonsBox.appendChild(page);
	  }
    

    // 자재관리 테이블 버튼 클릭 이벤트   => id="mat_table"
    document.getElementById('material_management_button').addEventListener('click', function() {
      document.querySelector('.solid_box > div:first-child > h2').textContent = "자재 관리"
      const contentArea = document.getElementById('content_area');
      
      // 테이블 생성
      contentArea.innerHTML = `
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
      const logoutButton = document.getElementById('logout_button');
      
      //자재 DB 불러오기
      let tr = document.querySelector('thead tr');
      const tbody = document.querySelector('tbody');
      let showingRowsNum = 10;
      
      // <th> 칼럼 행 생성
      for (let i = 0; i < mat_col_names.length; i++) {
    	  let th = document.createElement('th');
    	  th.appendChild(document.createTextNode(mat_col_names[i]));
    	  tr.appendChild(th);
      }
      
      // <tr> 본문 행 생성
      let tbody_tr;
      let tbody_td;
      let totalRows = [];
      
      document.querySelectorAll('#page_buttons > button').forEach(btn => {
    	  btn.addEventListener("click", function() {
    		  console.log("Button clicked:", btn.textContent);
    	      fetch('material_table.jsp?page=' + btn.textContent)
    	      	.then((response) => response.text())
    	      	.then((data) => {
    	      		// Update the content area with the response
    	      		contentArea.innerHTML = data;
    	      		addRowEventListeners();
    	      		
    	      	})
    	      	.catch((error) => {
    		    	            console.error("Error fetching data:", error);
    		    	        });
    	  });
      });



	  
    
	  
	  // 검색 기능
      searchInput.addEventListener("keyup", function(event){
    	  if (event.key === "Enter") {
	    	  let searchWord = searchInput.value;
	    	  console.log("searchWord : " + searchWord);
	    	// Send an AJAX request to search_handler.jsp
	    	    fetch(`material_search_handler.jsp?searchWord=` + encodeURIComponent(searchWord))
	    	        .then((response) => response.text()) // Expecting raw HTML or JSON from the server
	    	        .then((data) => {
	    	            // Update the content area with the response
	    	            const contentArea = document.getElementById("content_area");
	    	            contentArea.innerHTML = data; // Dynamically inject the response into the page
	    	        })
	    	        .catch((error) => {
	    	            console.error("Error fetching data:", error);
	    	        });
    	  }
    	 
      });

	  
	  //행 선택 동작
	  function addRowEventListeners() {
		  document.querySelectorAll('#content_area > table > tbody > tr').forEach(row => {
			  row.addEventListener("click", function(event) {
				  // 단일행 선택 동작
				 if (selectedRows.includes(this)) {
					// Deselect the row
					selectedRows = selectedRows.filter(r => r != this);
					this.classList.remove('selected');
					console.log("selected Rows", selectedRows);
				 }  else {
					// Select the row 
					selectedRows.forEach(r => r.classList.remove('selected'));
					selectedRows = [this];
					this.classList.add('selected');
					console.log("selected Rows", this);
				 }
			  });
		  });
	  }
	  
	  
	  // 삭제 버튼 동작
	  
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

	addButton.addEventListener("click", function(){
		location.href = "factory_material_add.jsp"
	});

	  
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
					 const originalCells = [];
					 const matNo = e_selectedRows[0].children[0].textContent;
					 
					 
					 for (i = 1; i < e_selectedRows[0].children.length; i++) {  // NO 칼럼을 제외한 모든 <td> 셀 조회
						const cell = e_selectedRows[0].children[i];
					 	const originalValue = cell.textContent;
					 	originalCells.push(originalValue);
					 	
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
					 		else if (event.key ==="Escape"){
					 			Array.from(e_selectedRows[0].children).forEach((c, index) => {
					 				if (index > 0) {		// skip 'NO' column
					 					c.textContent = originalCells[index - 1];	// 243 줄에서 originalCells 는 NO 칼럼값이 push되지 않았다.
					 				}
					 			});
					 		}
					 	});
					 }
				 }
			 }
		  });


    });

    // 연락처 관리 테이블 불러오기  => id="sup_table"
    document.getElementById('contact_management_button').addEventListener('click', function() {
      document.querySelector('.solid_box > div:first-child > h2').textContent = "공급업체 연락처"
      const contentArea = document.getElementById('content_area');
      contentArea.className = 'content';
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
    	  	supRows += 1;
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
      
   	  // 검색 기능
      searchInput.addEventListener("keyup", function(event){
    	  if (event.key === "Enter") {
	    	  let searchWord = searchInput.value;
	    	  console.log("searchWord : " + searchWord);
	    	// Send an AJAX request to search_handler.jsp
	    	    fetch(`sup_search_handler.jsp?searchWord=` + encodeURIComponent(searchWord))
	    	        .then((response) => response.text()) // Expecting raw HTML or JSON from the server
	    	        .then((data) => {
	    	            // Update the content area with the response
	    	            const contentArea = document.getElementById("content_area");
	    	            contentArea.innerHTML = data; // Dynamically inject the response into the page
	    	        })
	    	        .catch((error) => {
	    	            console.error("Error fetching data:", error);
	    	        });
    	  }
    	 
      });

      

      //행 선택 동작
	  document.querySelectorAll('#content_area > table > tbody > tr').forEach(row => {
		  row.addEventListener("click", function(event) {
			  // 단일행 선택 동작
			 if (selectedRows.includes(this)) {
				// Deselect the row
				selectedRows = selectedRows.filter(r => r != this);
				this.classList.remove('selected');
				console.log("selected Rows", selectedRows);
			 }  else {
				// Select the row 
				selectedRows.forEach(r => r.classList.remove('selected'));
				selectedRows = [this];
				this.classList.add('selected');
				console.log("selected Rows", this);
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
  	  
	  // 추가 버튼
	  addButton.addEventListener("click", function(){
		location.href = "factory_sup_add.jsp"
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
		
					 const cells = [];											// DB 업데이트 참고변수
					 const originalCells = [];
					 const supNo = e_selectedRows[0].children[0].textContent;
					 
					 for (i = 1; i < e_selectedRows[0].children.length; i++) {  // NO 칼럼을 제외한 모든 <td> 셀 조회
						const cell = e_selectedRows[0].children[i];
					 	const originalValue = cell.textContent; 
					 	originalCells.push(originalValue);
					 						 	
					 	// input 필드 만들기
					 	const input = document.createElement("input");
					 	input.type = "text";
					 	input.value = originalValue;			// Sets the current value
					 	input.defaultValue = originalValue;		//  Explicitly sets the default 
					 	
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
					 		else if (event.key ==="Escape"){
					 			Array.from(e_selectedRows[0].children).forEach((c, index) => {
					 				if (index > 0) {		// skip 'SUP_NO' column
					 					c.textContent = originalCells[index - 1];	// 405 줄에서 originalCells 는 NO 칼럼값이 push되지 않았다.
					 				}
					 			});
					 		}
					 	}); 
					 }

				 }
			 }
		  });
    });
    
    
    //공지사항
    document.getElementById('announcement_management_button').addEventListener('click', function() {
        document.querySelector('.solid_box > div:first-child > h2').textContent = "공지사항"
        
      
      
        const contentArea = document.getElementById('content_area');
        contentArea.className = 'content';
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
     
        
        
        
        
        for (let l = 0; l < announcement_col_names.length; l++) {
      	  let th = document.createElement('th');
      	  th.appendChild(document.createTextNode(announcement_col_names[l]));
      	  tr.appendChild(th);
        }
        
        let tbody_tr;
        let tbody_td;
        
        <% 
        while (rs3.next()) { 
        	annRows += 1;
            Announcement an = new Announcement();
            an.setNo(rs3.getInt("NO"));
            an.setWriter(rs3.getString("WRITER"));
            an.setContent(rs3.getString("CONTENT"));
          
            
            
    %>
            tbody_tr = document.createElement('tr');
            
            tbody_td = document.createElement('td');
            tbody_td.appendChild(document.createTextNode("<%= an.getNo()%>"));
            tbody_tr.appendChild(tbody_td);

            tbody_td = document.createElement('td');
            tbody_td.appendChild(document.createTextNode("<%= an.getWriter()%>"));
            tbody_tr.appendChild(tbody_td);
            
            tbody_td = document.createElement('td');
            tbody_td.appendChild(document.createTextNode("<%= an.getContent()%>"));
            tbody_tr.appendChild(tbody_td);
            
            
            
            

            
            
            tbody.appendChild(tbody_tr);
    <% } 
        rs3.close();
    %>

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