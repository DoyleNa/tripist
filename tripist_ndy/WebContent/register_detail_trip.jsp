<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/tripist_db?useUnicode=true&characterEncoding=utf8";
	String dbUser = "skehdlf";
	String dbPassword = "ndi9150";
	
	request.setCharacterEncoding("UTF-8");
	
	String userid = request.getParameter("userid");
	String trip_name = request.getParameter("trip_name");
	String destination = request.getParameter("destination");
	String vehicle = request.getParameter("vehicle");
	String vehicle_detail = request.getParameter("vehicle_detail");
	String end_date = request.getParameter("end_date");
	String to_do = request.getParameter("to_do");
	
	int tripid = 0;
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;	
	
	if (destination == null || destination.trim().length() == 0) {
		errorMsgs.add("목적지를 반드시 입력해주세요.");
	}
	if (vehicle == null || vehicle.trim().length() == 0) {
		errorMsgs.add("이동수단을 반드시 선택해주세요.");
	}
	if (end_date == null || end_date.trim().length() == 0) {
		errorMsgs.add("출발일을 반드시 선택해주세요.");
	}
	
	if(errorMsgs.size() == 0){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbUrl,dbUser,dbPassword);
			
			stmt = conn.prepareStatement(
			"select tripid from travel where tripname=?");
			stmt.setString(1,trip_name);
			
			rs = stmt.executeQuery();
			if(rs.next()){
				tripid = rs.getInt("tripid");
			}
			System.out.println("tripid="+tripid);
			
			stmt = conn.prepareStatement("insert into detail_travel(destination,vehicle,vehicle_detail,to_do,end_day,tripid)"+
					" values(?,?,?,?,?,?)");
			stmt.setString(1, destination);
			stmt.setString(2, vehicle);
			stmt.setString(3, vehicle_detail);
			stmt.setString(4, to_do);
			stmt.setString(5,end_date);
			stmt.setInt(6, tripid);
			result = stmt.executeUpdate();
			if(result != 1){
				errorMsgs.add("일정추가에 실패하였습니다.");
			}
		}catch(SQLException e){
			errorMsgs.add("SQL 에러: " + e.getMessage());
		}
		finally{
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
		<title>Make Trip</title>
		<link href="css/tripist.css" rel="stylesheet">
		<link href="http://static.scripting.com/github/bootstrap2/css/bootstrap.css" rel="stylesheet">
		<link rel="stylesheet" href="css/jquery-ui-1.9.2.custom.css" />
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
		<script src="http://static.scripting.com/github/bootstrap2/js/jquery.js"></script>
		<script src="http://static.scripting.com/github/bootstrap2/js/bootstrap-modal.js"></script>
		<script src='jquery-1.8.2.min.js'></script>
		<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
		<script src="js/jquery-ui-1.9.2.custom.js"></script>
	</head>
<body>
	<jsp:include page="share/header.jsp">
			<jsp:param name="current" value="Trip" />
	</jsp:include>
	<div id="wrap">
		<div class="container">
			<%if(errorMsgs.size() > 0){%>
			<div class="alert alert-error">
				<h3>Errors:</h3>
				<ul>
					<%for(String msg:errorMsgs){ %>
						<li><%=msg%></li>
					<%}%>
				</ul>
			</div>
			<div class="from-action">
				<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
			</div>
			<%} else if(result == 1) {%>
			<form action="home.jsp" method="post">
				<input type="hidden" name="userid" value="<%=userid%>">
				<input type="submit" name="gohome" value="Home">
			</form>
			<form action="detail_trip.jsp" method="post">
				<input type="hidden" name="trip_name" value="<%=trip_name %>">
				<input type="submit" name="detail_trip" value="일정 추가하기">
			</form>
			<%} %>
		</div>
	</div>
	<jsp:include page="share/footer.jsp" />
</body>
</html>