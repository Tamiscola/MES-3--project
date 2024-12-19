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
      <div id="head_box1">Natural Yak</div>
      <div id="right_welcome">''어서오세요 <br>
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

    });

    // 연락처 관리 버튼 클릭 이벤트
    document.getElementById('contact_management_button').addEventListener('click', function() {
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
      
      
      for (let i = 0; i < sup_col_names.length; i++) {
    	  let th = document.createElement('th');
    	  th.appendChild(document.createTextNode(sup_col_names[i]));
    	  tr.appendChild(th);
      }
      
      let tbody_tr;
      let tbody_td;
      
      <% while (rs2.next()) { 
      		SupplyContact sp = new SupplyContact();
      		sp.setSup_name(rs2.getString("SUP_NAME"));
      		sp.setSup_phone(rs2.getString("SUP_PHONE"));
      		sp.setSup_address(rs2.getString("SUP_ADDRESS"));
      		sp.setSup_email(rs2.getString("SUP_EMAIL"));
      		
      		%>
      		
      		tbody_tr = document.createElement('tr');
			
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