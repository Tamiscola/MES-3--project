<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <title>Pagination Example</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f4f4f4;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination a {
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: #007bff;
        }
        .pagination a.active {
            font-weight: bold;
            background-color: #007bff;
            color: #fff;
        }
    </style>
</head>
<body>
    <h1>Pagination Example</h1>
<%
    final int rowsPerPage = 10;
    int currentPage = 1;
    int materialTotalRows = 0;
    int materialTotalPages = 0;

    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }

    try (Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@1.220.247.78:1522/orcl",
			"mini_2410_team3",
			"1234")) {
        // 1. 자재의 전체 데이터 개수 가져오기
        String mat_count_sql = "SELECT COUNT(*) AS total FROM MAIN_MATERIAL";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(mat_count_sql)) {
            if (rs.next()) {
                materialTotalRows = rs.getInt("total");
            }
        }

        // 2. 총 페이지 수 계산
        materialTotalPages = (int) Math.ceil((double) materialTotalRows / rowsPerPage);

        // 3. 특정 페이지 데이터 가져오기
        int offset = (currentPage - 1) * rowsPerPage;
        String materialDataQuery = "SELECT * FROM MAIN_MATERIAL LIMIT ?, ?";
        try (PreparedStatement pstmt = conn.prepareStatement(materialDataQuery)) {
            pstmt.setInt(1, offset);
            pstmt.setInt(2, rowsPerPage);

            try (ResultSet rs = pstmt.executeQuery()) {
%>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Material Name</th>
            </tr>
        </thead>
        <tbody>
<%
                while (rs.next()) {
%>
            <tr>
                <td><%= rs.getInt("No") %></td>
                <td><%= rs.getString("COLOR") %></td>
            </tr>
<%
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
        </tbody>
    </table>

    <div class="pagination">
<%
    for (int i = 1; i <= materialTotalPages; i++) {
        if (i == currentPage) {
%>
        <a href="?page=<%= i %>" class="active"><%= i %></a>
<%
        } else {
%>
        <a href="?page=<%= i %>"><%= i %></a>
<%
        }
    }
%>
    </div>
</body>
</html>
