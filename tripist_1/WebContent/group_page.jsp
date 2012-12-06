<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" %>
<%
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;

	String dbUrl = "jdbc:mysql://localhost:3306/tripist_db";
	String dbUser = "id001";
	String dbPassword = "12345";
	
	String actionUrl;
	String errorMsg = null;
	String uid = "";
	String gid = "";

	 // Request로 ID가 있는지 확인
	  int id = 0;
	  try {
	    id = Integer.parseInt(request.getParameter("gid"));
	  } catch (Exception e) {}

	  if (id > 0) {
	    try {
	        Class.forName("com.mysql.jdbc.Driver");

	        // DB 접속
	      conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

	      // 질의 준비
	      stmt = conn.prepareStatement("SELECT gid FROM mass ");
	      stmt.setInt(1, id);
	      
	      // 수행
	      rs = stmt.executeQuery();
	      
	      if (rs.next()) {
	        uid = rs.getString("uid");
	        gid = rs.getString("gid");
	      }
	    }catch (SQLException e) {
	      errorMsg = "SQL 에러: " + e.getMessage();
	    } finally {
	      // 무슨 일이 있어도 리소스를 제대로 종료
	      if (rs != null) try{rs.close();} catch(SQLException e) {}
	      if (stmt != null) try{stmt.close();} catch(SQLException e) {}
	      if (conn != null) try{conn.close();} catch(SQLException e) {}
	    }
	  } else {
	    errorMsg = "ID가 지정되지 않았습니다.";
	  }
	%>    


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>group_page</title>
	<link href="css/tripist.css" rel="stylesheet">
	<link href="http://static.scripting.com/github/bootstrap2/css/bootstrap.css" rel="stylesheet">
	<script src="http://static.scripting.com/github/bootstrap2/js/jquery.js"></script>
	<script src="http://static.scripting.com/github/bootstrap2/js/bootstrap-modal.js"></script>

	<script>
		$(document).ready(function(){
			$('#windowTitleDialog').bind('show', function () {
				document.getElementById ("xlInput").value = document.title;
				});
			});
			function closeDialog () {
				$('#windowTitleDialog').modal('hide'); 
			};
			function okClicked () {
				document.title = document.getElementById ("xlInput").value;
				closeDialog ();
			};
		</script>		
</head>
		
<body>

<div id="wrap">
 <% 
		 if (errorMsg != null && errorMsg.length() > 0 ) {
  	  // SQL 에러의 경우 에러 메시지 출력
  	  out.print("<div class='alert'>" + errorMsg + "</div>");
		 } else {
 	%>
	<div id="top">
		<img src="img/top.jpg" alt="top_image">
	</div>
	
	<div id="body">
		<div id="navbar">
			<ul>
				<li><a href="#">HOME</a></li>
   			<li><a href="#">TRIP</a></li>
   			<li><a href="#">FRIENDS</a></li>
   			<li><a href="#">MYGROUP</a></li>
			</ul>
		</div>
		
		<div id = "MainText">
			<h1>Make Group</h1>
		
			<!-- 그룹리스트들을 버튼으로 반복해서 만듬 -->		
			<div class ="divButton" >
				<a data-toggle ="modal" href ="#group" class = "btn btn- primary btn-large"><%=rs.getString("gid") %></a>
			</div>
 		</div>
		
 	<div id="footer">
		2012 MJU WEBPROGRAMMING A-1 reserved TRIPIST
	</div>
</div>

	<div class ="modal hide fade" id="group">
			<div class ="modal-header">
				<a href= "#" class ="close" data-dismiss ="modal">&times;</a>

				<h2>Find Your Friends</h2>
			</div>
			
			<div class  ="modal-body">		
					<input type= "text" name= "user_name" id= "user_name">
					<input type= "button" name= "find" value= "Find_Friends">
			</div>
			
			<div class = "modal-footer">
				<input type ="submit" name ="AddBtn" value ="Add in Group"/>
			</div>
		</div>
		<%} %>
	</div>
</body>
</html>