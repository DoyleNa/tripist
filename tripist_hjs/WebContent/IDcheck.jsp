<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	String id=request.getParameter("id");
	out.println(id);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
 	String dbUrl ="jdbc:mysql://localhost:3306/tripist_db";
	String dbUser ="hoy";
	String dbPassword ="8956";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		
		out.println(id);
		stmt = conn.prepareStatement("SELECT * FROM users WHERE uid=?");
		stmt.setString(1, id);
		rs = stmt.executeQuery();
		
		if(rs.next()){
		
			out.println("중복된아이디입니다");
		
		
			
		}else{
			out.println("사용가능");

		
		
		}
		}catch(Exception e){}
		
	
		
	
%>

<body>

</body>
</html>