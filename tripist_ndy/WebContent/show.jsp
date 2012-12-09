<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" import="org.apache.commons.lang3.StringUtils"%>
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/tripist_db?useUnicode=true&characterEncoding=utf8";
	String dbUser = "skehdlf";
	String dbPassword = "ndi9150";
	
	request.setCharacterEncoding("UTF-8");
	int tripid = Integer.parseInt(request.getParameter("tripid"));
	String tripname = "";
	String start_date = "";
	String destination = "";
	String end_date = "";
	String vehicle = "";
	String vehicle_detail = "";
	String to_do = "";			
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(dbUrl,dbUser,dbPassword);		
		stmt = conn.prepareStatement("select * from travel where tripid=?");
		stmt.setInt(1, tripid);
		rs = stmt.executeQuery();
		while(rs.next()){
			tripname = rs.getString("tripname");
			start_date = rs.getString("start_day");			
		}
		
		stmt = conn.prepareStatement("select * from detail_travel where tripid=?");
		stmt.setInt(1, tripid);
	%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Show your Trip</title>
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
	<div>
	<h3><%=tripname%></h3>
	
	<%
		
		}catch(SQLException e){
		
	}finally{
		if (rs != null) try{rs.close();} catch(SQLException e) {}
		if (stmt != null) try{stmt.close();} catch(SQLException e) {}
		if (conn != null) try{conn.close();} catch(SQLException e) {}
	}
%>
	</div>
	<jsp:include page = "share/footer.jsp" />
</body>
</html>