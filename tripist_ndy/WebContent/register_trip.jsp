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
	String arrival_date = request.getParameter("arrival_date");
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (trip_name == null || trip_name.trim().length() == 0) {
		errorMsgs.add("여행 이름을 반드시 입력해주세요.");
	}	
	if (arrival_date == null || arrival_date.trim().length() == 0) {
		errorMsgs.add("출발일을 반드시 선택해주세요.");
	}
	
	if(errorMsgs.size() == 0){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbUrl,dbUser,dbPassword);
			
			stmt = conn.prepareStatement("insert into travel(tripname,start_day,group_name) values(?,?,?)");
			stmt.setString(1,trip_name);
			stmt.setString(2, arrival_date);
			stmt.setString(3, userid);		//group명을 우선 userid로 생성
			
			result = stmt.executeUpdate();
			if(result != 1){
				errorMsgs.add("등록에 실패하였습니다.");
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
			<div class="continer">
				<%if(errorMsgs.size() > 0){ %>
					<div class="alert alert-error">
						<h3>Errors:</h3>
						<ul>
							<%for(String msg:errorMsgs){%>
								<li><%=msg%></li>
							<%}%>
						</ul>
					</div>
					<div class="from-action">
						<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
					</div>
				<%} else if(result == 1){%>
					<div class="alert alert-success">
						<b><%=trip_name%></b>이 정상적으로 등록되었습니다.
					</div>
					<div class="from-action">
						<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
					</div>
					<form action="detail_trip.jsp" method="post">
						<input type="hidden" name="trip_name" value="<%=trip_name %>">
						<input type="hidden" name="userid" value="<%=userid%>">
						<input type="submit" name="detail_trip" value="일정 추가하기">
					</form>
				<%}%>	
			</div>
		</div>
	<jsp:include page="share/footer.jsp" />
</body>
</html>