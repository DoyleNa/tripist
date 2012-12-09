<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>

<%
	String errorMsg = null;

	String actionUrl;
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	String dbUrl = "jdbc:mysql://localhost:3306/tripist_db?useUnicode=true&characterEncoding=utf8";
	String dbUser = "skehdlf";
	String dbPassword = "ndi9150";

	actionUrl = "register_trip.jsp";
	String userid = request.getParameter("userid");
%>

<!DOCTYPE html>
<html>
<head>
	<title>Make a Trip</title>
	<link href="css/tripist.css" rel="stylesheet">
	<link href="http://static.scripting.com/github/bootstrap2/css/bootstrap.css" rel="stylesheet">
	<link rel="stylesheet" href="css/jquery-ui-1.9.2.custom.css" />
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
	<script src="http://static.scripting.com/github/bootstrap2/js/jquery.js"></script>
	<script src="http://static.scripting.com/github/bootstrap2/js/bootstrap-modal.js"></script>
	<script src='jquery-1.8.2.min.js'></script>
	<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
	<script src="js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript">		
		$(function() {
			$('.datepicker').datepicker();
		});
	</script>		
</head>
<body>
	<div id="wrap">
		<jsp:include page="share/header.jsp">
			<jsp:param name="current" value="Trip" />
		</jsp:include>
		<div id="body">			
			<form class="form-horizontal" action="<%=actionUrl%>" method="post">
				<input type="hidden" name="userid" value="<%=userid%>">
				<label for="tripname">여행 이름</label> 
				<input type="text" 	name="trip_name"> 						
				<label for="arrival_date">출발일</label>
				<input type="text" name="arrival_date" class="datepicker">								
				<div class="divButton">
					<input type="submit" name="confirm" value="여행생성">
				</div>
			</form>

			<jsp:include page="share/footer.jsp" />
		</div>
	</div>
</body>
</html>
