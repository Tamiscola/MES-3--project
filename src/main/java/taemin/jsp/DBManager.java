package taemin.jsp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBManager {
	//@return Connection 객체 -> 오라클 접속 클래스 객체
	public static Connection getDBConnection() {
		Connection conn = null;

		try {
			// JDBC 드라이버 등록
			Class.forName("oracle.jdbc.OracleDriver");
			// 등록된 드라이버를 실제 Connection 클래스 변수에 연결
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521/orcl",
					"test1",
					"1234"
			);
			System.out.println("Oracle DB접속 성공");
		} catch(Exception e) {
			e.printStackTrace();
			//exit();		// 에러일 경우에는 무조건 종료f
			System.err.println("DB 접속 에러");
			
		}
		
		return conn;
	}
	
	public static void dbClose(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
			
		} catch(SQLException se) {
			System.err.println("Oracle DB IO 오류 -> " + se.getMessage());
		}
	}
}
