<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
<%
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/tripist";
	String dbUser = "web";
	String dbPassword = "asdf";
	
	request.setCharacterEncoding("utf-8");
	String	tripid = request.getParameter("tripid");
	String trip_name = request.getParameter("trip_name");
	String destination = request.getParameter("destination");
	String transportation = request.getParameter("transportation");
	String arrive_date = request.getParameter("arrive_date");
	String depart_date = request.getParameter("depart_date");
  String reserved = request.getParameter("reserved");
  String cost = request.getParameter("cost");
	String todo = request.getParameter("todo");
	String todo_date = request.getParameter("todo_date");
	String todo_time = request.getParameter("todo_time");
	String gid = request.getParameter("gid");


	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (trip_name == null || trip_name.trim().length() == 0) {
		errorMsgs.add("여행 이름을 반드시 입력해주세요.");
	}
	
	if (destination == null || destination.trim().length() == 0) {
		errorMsgs.add("목적지를 반드시 입력해주세요.");
	}
	
	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"INSERT INTO travel(trip_name, destination, transportation,arrive_date,depart_date,cost, todo,  todo_date, todo_time,reserved) " +
					"VALUES(?, ?, ?, ?, ?, ?, ?, ? ,?, ? )"
					);

			stmt.setString(1, trip_name);
			stmt.setString(2, destination);
			stmt.setString(3, transportation);
			stmt.setString(4, arrive_date);
			stmt.setString(5, depart_date);
			stmt.setString(6, cost);
			stmt.setString(7, todo);
			stmt.setString(8, todo_date);
			stmt.setString(9, todo_time);
			stmt.setString(10, reserved);

			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("등록에 실패하였습니다.");
			}
		} catch (SQLException e) {
			errorMsgs.add("SQL 에러: " + e.getMessage());
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Make a Trip</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>


 	<div class="container">
 		<% if (errorMsgs.size() > 0) { %>
 			<div class="alert alert-error">
 				<h3>Errors:</h3>
 				<ul>
 					<% for(String msg: errorMsgs) { %>
 						<li><%=msg %></li>
 					<% } %>
 				</ul>
 			</div>
		 	<div class="form-action">
		 		<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
		 	</div>
	 	<% } else if (result == 1) { %>
	 		<div class="alert alert-success">
	 			<b><%=trip_name %></b>이 정상적으로 등록되었습니다
	 		</div>
		 	<div class="form-action">
		 		<a onclick="history.back();" class="btn">뒤로</a>
		 	</div>
	 		
<%} %>
 	</div>
</body>
</html>