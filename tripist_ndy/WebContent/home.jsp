<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*"%>
    <%
    request.setCharacterEncoding("UTF-8");
    String userid = request.getParameter("userid"); 
    System.out.println("userid="+userid);
    %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Welcome to Tripist</title>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/tripist.css" rel="stylesheet">
		<script src="js/jquery-1.8.2.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
	</head>
<body>
	<jsp:include page="share/header.jsp">
  		<jsp:param name="current" value="Home"/>
	</jsp:include>
	<div id="wrap">
		<div class="form-action">
			<a href="make_trip.jsp?userid=<%=userid%>" class="btn btn-primary">Make Trip</a>
		</div>
	</div>
	<jsp:include page = "share/footer.jsp" />
</body>
</html>