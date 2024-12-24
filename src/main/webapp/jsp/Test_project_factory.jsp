<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="taemin.DBManager" %>
<%@ page import="taemin.MainMaterial" %>
<%@ page import="taemin.SupplyContact" %>


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
    <div class="header box"><h1>NaturalYak</h1>
      <div class="header-right" >' '님 어서오세요<br>
        <button class="logout_button"><strong>로그아웃</strong></button>
        </div>
    </div>
    <div class="main">
      <div class="side box">
        <h1 class="side_so"></h1>
        <button id="material_management_button" class="side_box1"><h3>자재 관리</h3></button>
        <button id="contact_management_button" class="side_box1"><h3>연락처 관리</h3></button>
        <button class="side_box1"><h3>테스트 용</h3></button>
      </div>
      <div  class="center box">
        <div class="solid_box">
          <div><h2>공지 사항</h2></div>
          <div>
          <input class="search_input" type="text"placeholder="검색..."><button class="search_button"></button>
          </div>
        </div>
        <div class="table_button">
          <button id="delete_button" class="table_button_delete">삭제</button>
          <button id="edit_button" class="table_button_correction">수정</button>
          <button id="add_button" class="table_button_update">추가</button>
        </div>
        <div id="content_area">
        </div>
      	 </div>
          </div>
        <div class="footbar">
    	 <div class="footbar_button">
        	
        	<span id="current_page">
    	</div>
	</div>
</body>


