<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
    
 <%
	String errorMsg = null;

	String actionUrl;
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/tripist";
	String dbUser = "web";
	String dbPassword = "asdf";
	
	// 사용자 정보를 위한 변수 초기화
	String tripid="";
	String trip_name="";
	String destination="";
	String transportation="";
	String arrive_date="";
	String depart_date="";
	String cost="";
	String todo="";
	String todo_date="";
	String todo_time="";
	String gid="";
	String reserved="";
	
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("tripid"));
	} catch (Exception e) {}
	
	try {
		    Class.forName("com.mysql.jdbc.Driver");

		    // DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

	 		// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM travel WHERE tripid = ?");
			stmt.setInt(1, id);
			
			// 수행
	 		rs = stmt.executeQuery();
			
			if (rs.next()) {
				tripid = rs.getString("tripid");
				trip_name = rs.getString("trip_name");
				destination = rs.getString("destination");
				transportation = rs.getString("transportation");
				arrive_date = rs.getString("arrive_date");
		  	depart_date = rs.getString("depart_date");
				reserved = rs.getString("reserved");
		  	cost = rs.getString("cost");
				todo = rs.getString("todo");
				todo_date = rs.getString("todo_date");
				todo_time = rs.getString("todo_time");
				//gid = rs.getString("gid");
	
			}
		}catch (SQLException e) {
			errorMsg = "SQL 에러: " + e.getMessage();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	
		actionUrl = "register.jsp";

%>   
	
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Make a Trip</title>
	<link href="css/tripist.css" rel="stylesheet">
	<link href="css/tripist.css" rel="stylesheet">
	<link href="http://static.scripting.com/github/bootstrap2/css/bootstrap.css" rel="stylesheet">
	<link rel="stylesheet" href="css/jquery-ui-1.9.2.custom.css"/>  
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
	<script src="http://static.scripting.com/github/bootstrap2/js/jquery.js"></script>
	<script src="http://static.scripting.com/github/bootstrap2/js/bootstrap-modal.js"></script>
	<script src='jquery-1.8.2.min.js'></script>
	<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
  <script src="js/jquery-ui-1.9.2.custom.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
</head>
<body>

	
<div id="wrap">
 <%
 if (errorMsg != null && errorMsg.length() > 0 ) {
		// SQL 에러의 경우 에러 메시지 출력
		out.print("<div class='alert'>" + errorMsg + "</div>");
 }
 %>
	<div id="top">
		<img src="img/top.jpg" alt="top_image">
	</div>

	<div id="body">
  
  	<div id="navbar">
      <ul>
       <li><a href="main.html">HOME</a></li>
        <li><a href="home_page.html">TRIP</a></li>
       <li><a href="friends_page.html">FRIENDS</a></li>
       <li><a href="group_page.html">MYGROUP</a></li>
      </ul>
		</div>
	
<form class="form-horizontal" action="<%=actionUrl%>" method="post">
 	<%
			  	if (id > 0) {
			  		out.println("<input type='hidden' name='tripid' value='"+tripid+"'>");

			  	}
	%>

 <label for="tripname">please enter the trip name</label>
 <input type="text" name="trip_name" value="<%=trip_name %>"> 
 <label for="searchTextField">destination</label> 
 <input type="text" id="searchTextField" name="destination" value="<%=destination %>"> 
	<div id="map_canvas"></div>
 <input type="checkbox" name="by_air"> by Airplane <br>
 <input type="text" placeholder="number" name="transportation" value="<%=transportation %>">
 <input type="text" placeholder="arrive date" name="arrive_date" class="datepicker" value="<%=arrive_date%>">
 <input type="text" placeholder="depart date" name="depart_date" class="datepicker" value="<%=depart_date%>"> <br>
 <input type="checkbox" name="air_reserv"> reserved
 <input type="checkbox" name="air_not_reserv"> not reserved <br>


 <input type="checkbox" name="by_car"> by Car <br>
 <input type="text" placeholder="name" name="car_name">
 <input type="text" placeholder="arrive date" name="car_arrive_date" class="datepicker">
 <input type="text" placeholder="depart date" name="car_depart_date" class="datepicker"> <br>
 <input type="checkbox" name="car_reserv"> reserved
 <input type="checkbox" name="car_not_reserv"> not reserved <br>

 <input type="checkbox" name="by_train"> By train <br>
 <input type="text" placeholder="number" name="train_number">
 <input type="text" placeholder="arrive date" name="train_arrive_date" class="datepicker">
 <input type="text" placeholder="depart date" name="train_depart_date" class="datepicker"> <br>
 <input type="checkbox" name="train_reserv"> reserved
 <input type="checkbox" name="train_not_reserv"> not reserved <br> 

 <br>
<div>
 <table id="tab">
	<thead>
	<tr>
		<th></th>
		<th> To DO List </th>
		<th> cost </th>
		<th> Date </th>
		<th> Time </th>
	</tr>
</thead>
<tbody>
</tbody>
</table>
<input type="button" value="일정추가" id="add">
<input type="button" value="일정삭제" id="del">
</div>
<div id="sample_row" style="display:none">
	<table>
	<tr>
		<td><input type='checkbox'></td>
		<td><input type="text" name="todo" value="<%=todo%>"></td>
		<td><input type="text" name="cost" value="<%=cost %>"></td>
		<td><input type="text" name="todo_date" class="datepicker" value="<%=todo_date%>"></td>
		<td><input type="text" name="todo_time" value="<%=todo_time%>"></td>
	</tr>
</table>
</div>

<div class ="divButton" >
	<input type ="submit" name ="confirm" value ="CONFIRM" >
<!--  <input type ="submit" name ="SAVE" value ="SAVE" > -->	
</div>
</form>

<div id="footer">
	2012 MJU WEBPROGRAMMING A-1 reserved TRIPIST
</div>
</div>
</div>
</body>
</html>



<script type="text/javascript">
$(function() {
	$('#add').click(function() {
		$("#tab").find("tbody").append("<tr>"+$('#sample_row').find('tr').html()+"</tr>");
	});
	$('#del').click(function() {
		if (confirm("정말 삭제하시겠습니까?")) {
			$("tr input[type='checkbox']").each(function() {
				if ($(this).attr('checked')) {
					$(this).parents("tr").empty();
				}
			});
			recalculate();
		}
	});
	$('#add').click();
});

$(function() { 
	$( ".datepicker" ).datepicker();    
});
function initialize() {
    var mapOptions = {
      center: new google.maps.LatLng(-33.8688, 151.2195),
      zoom: 8,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById('map_canvas'),
      mapOptions);

    var input = document.getElementById('searchTextField');
    var autocomplete = new google.maps.places.Autocomplete(input);

    autocomplete.bindTo('bounds', map);

    var infowindow = new google.maps.InfoWindow();
    var marker = new google.maps.Marker({
      map: map
    });

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      infowindow.close();
      marker.setVisible(false);
      input.className = '';
      var place = autocomplete.getPlace();
      if (!place.geometry) {
        // Inform the user that the place was not found and return.
        input.className = 'notfound';
        return;
      }

      // If the place has a geometry, then present it on a map.
      if (place.geometry.viewport) {
        map.fitBounds(place.geometry.viewport);
      } else {
        map.setCenter(place.geometry.location);
        map.setZoom(8);  // Why 17? Because it looks good.
      }
      var image = new google.maps.MarkerImage(
          place.icon,
          new google.maps.Size(71, 71),
          new google.maps.Point(0, 0),
          new google.maps.Point(17, 34),
          new google.maps.Size(35, 35));
      marker.setIcon(image);
      marker.setPosition(place.geometry.location);

      var address = '';
      if (place.address_components) {
        address = [
          (place.address_components[0] && place.address_components[0].short_name || ''),
          (place.address_components[1] && place.address_components[1].short_name || ''),
          (place.address_components[2] && place.address_components[2].short_name || '')
        ].join(' ');
      }

      infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
      infowindow.open(map, marker);
    });

    // Sets a listener on a radio button to change the filter type on Places
    // Autocomplete.
    /*
    function setupClickListener(id, types) {
      var radioButton = document.getElementById(id);
      google.maps.event.addDomListener(radioButton, 'click', function() {
        autocomplete.setTypes(types);
      });
    }
    */
  }
  google.maps.event.addDomListener(window, 'load', initialize);
  
</script>
