<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>
<%
	String errorMsg=null;
	
	String actionUrl;
	
	Connection conn =null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl ="jdbc:mysql://localhost:3306/tripist_db";
	String dbUser ="hoy";
	String dbPassword ="8956";
	
	String uid ="";
	String pwd ="";
	String email="";
	String pwd_confrim ="";
	String nationality ="";
	String CreateTime ="";
	
	
	
	
	%>    
<!DOCTYPE html>
<html lang="ko"> 
<head>
	<meta charset="utf-8">
	<title>MAIN</title>

	<link href="http://static.scripting.com/github/bootstrap2/css/bootstrap.css" rel="stylesheet">
		<script src="http://static.scripting.com/github/bootstrap2/js/jquery.js"></script>
		<script src="http://static.scripting.com/github/bootstrap2/js/bootstrap-modal.js"></script>
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
		<style>
		 body{
		 	padding-top :20px;
		 	padding-bottom: 40px;
		 }
		 #wrap{
		 	margin: 0 auto;
		 	max-width: 960px;
		 }
		 #MainText{
		 	margin: 60px 0;
		 	text-align: center;
		 }
		 #MainText >hr {
		 	margin: 30px 0;
		 }
		 #MainText h1 {
		 	font-size: 72px;
		 	line-height: 1;
		 }
		 #MainText .divButton {font-size: 21px;
		 	padding :14px 24px;}
		 

		</style>
		<script>
function chk_id(f){
 
id=f.mem_uid.value;
 
if(f.mem_uid.value ==""){
 alert("ID를 입력 하세요");
 f.mem_uid.focus();
 return;
}
 
w=window.open("IDcheck.jsp?id="+id,"","width=200,height=150");
}
</script>



</head>

<body>

<div id="wrap">
	<div id="top">
		<img src="img/top.jpg" alt="top_image">
	</div>

	<div id="container">
  	<div id = "MainText">
  		<hr>
		<h1>Hello!</h1>
		<p> this home page is bblaahahaaaha</p>
	
		

		<div class ="divButton" >
			<a data-toggle ="modal" href ="#login" class = "btn btn-primary btn-large">LOG-IN</a>
			<a data-toggle ="modal" href ="#join" class = "btn btn-primary btn-large">JOIN</a>
		</div>
		<hr>
 	</div>
 	<!----footer---->
 	<div id="footer">
		2012 MJU WEBPROGRAMMING A-1 reserved TRIPIST
	</div>
</div>
</div>
<!--------------login Modal ------------------>
<div class ="modal hide fade" id="login">
			<%actionUrl = "login.jsp"; %>
			<form class ="form-horizontal" action="<%=actionUrl%>" method ="post">
				<fieldset>

				<div class ="modal-header">
				<a href= "#" class ="close" data-dismiss ="modal">&times;</a>
				<div id ="legend">
					<legend>Sign In</legend>
				</div>
				</div>

				<div class  ="modal-body">
					
					<div class ="control-group">
						<label class= "control-label" for ="name">Username : </label>
						<div id ="controls">
							<input type ="text" placeholder ="input your username" name= "uid">
						</div>
					</div>
					<div class ="control-group">
						<label class= "control-label" for ="name">Password : </label>
						<div id ="controls">
							<input type ="password" placeholder ="input your password" name= "pwd">
						</div>
					</div>
				</div>
			
				<div class = "modal-footer">
				<input type ="submit" name ="loginBtn" value ="log-in"  class = "btn btn-primary btn-large"/>
				</div>
			    </fieldset>
			</form>
</div>
	<!------------------sign up------------------>
		<div class="modal hide fade" id="join">
			<% actionUrl = "join.jsp"; %>
			<form class ="form-horizontal" action ="<%=actionUrl %>" method ="post"> 
				<fieldset>
					<div class ="modal-header">
					<a href ="#" class ="close" data-dismiss ="modal">&times;</a>
						<div id ="legend">
							<legend>Sign Up</legend>
						</div>
			 		</div>
					<div class  ="modal-body">
					
						<div class ="control-group">
							<label class= "control-label" for ="uid">Username : </label>
							<div id ="controls">
								<input type ="text" placeholder ="input your username" name= "mem_uid" value="<%=uid%>" >
								<input type=button value=" 중복체크" onClick="chk_id(this.form)">
							</div>
						</div>
						
						<div class ="control-group">
							<label class= "control-label" for ="pwd">Password : </label>
							<div id ="controls">
								<input type ="password" placeholder ="input your password" name= "pwd" >
							</div>

						
						</div>
						<div class ="control-group">
							<label class= "control-label" for ="pwd_confirm">Password Confirmation</label>
							<div id ="controls">	
								<input type ="password" placeholder ="	retype your password" name= "pwd_confirm">
							</div>
						</div>
						<div class ="control-group">
							<label class ="control-label" for ="email">E-mail</label>
							<div id ="controls">
								<input type ="email" name ="email" >
							</div>
						</div>

						<!---지역정보 입력해야되 ---->
						<div class ="control-group">
						<label class ="control-label" for ="nationality">거주 지역 :</label>
						<div id ="controls">
							<input type ="text" id="serachTextField" name="nationality" >
							<div id="map_canvas"></div>
						</div>
						</div>
						
					

					</div>

					<div class ="modal-footer">
					<div class ="form-actions">
					
						<input type ="submit" value ="log-in"  class = "btn btn-primary btn-large"/>
						</div>
				
					</div>
				</fieldset>
			</form>
		</div>
	
	
<script language= "javascript">
function checkEnd(){
	var form = document.id_check;
	
	opener.join.uid.value = form.uid.value;
	opener.join.userid_check.value= form.check_count.value;
	self.close();
}
function doCheck(){
	var form =document.id_check;
	if(!checkValue(form.uid)){
		return;
	}
	form.submit();
}

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
</body>
</html>