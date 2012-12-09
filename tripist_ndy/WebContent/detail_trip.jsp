<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>

<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/tripist_db";
	String dbUser = "skehdlf";
	String dbPassword = "ndi9150";
	String trip_name = "";
	request.setCharacterEncoding("UTF-8"); 
	String userid=request.getParameter("userid");
	try{
	trip_name = String.valueOf(request.getParameter("trip_name"));
	}catch(Exception e){}
	System.out.println("trip_name:"+trip_name);
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
		<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
		<script type="text/javascript">		
		$(function() {
			$('.datepicker').datepicker();
		});
		</script>
	</head>
<body>	
	<jsp:include page="share/header.jsp">
  		<jsp:param name="current" value="Home"/>
	</jsp:include>
	<div id="wrap">
		<form class="form-horizontal" action="register_detail_trip.jsp" method="post">
			<input type="hidden" name="trip_name" value="<%=trip_name%>">
			<input type="hidden" name="userid" value="<%=userid%>">
			<label for="searchTextField">목적지</label>
			<input type="text" id="searchTextField" name="destination">
			<div id="map_canvas"></div>
			<label for="vehicle">이동수단</label> 
			<select name="vehicle">
				<option value="car">차량</option>
				<option value="plane">비행기</option>
				<option value="train">기차</option>
			</select>
			<label for="vehicle_detail">이동수단 상세정보</label>
			<input type="text" name="vehicle_detail">
			<label for="end_date">일정종료일</label>
			<input type="text" name="end_date" class="datepicker">
			<label for="to_do">할 일</label>
			<input type="text" name="to_do">			
			<div class="divButton">
					<input type="submit" name="confirm" value="일정추가">
			</div>
		</form>
	</div>
	<jsp:include page="share/footer.jsp"/>
</body>
</html>
<script type="text/javascript">
    var mapOptions = {
      center: new google.maps.LatLng(-33.8688, 151.2195),
      zoom: 8,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);     
      var input = document.getElementById('searchTextField');     
      autocomplete = new google.maps.places.Autocomplete(input);
 </script>