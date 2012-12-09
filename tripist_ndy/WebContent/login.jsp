<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*" import ="java.sql.*"
    import = "org.apache.commons.lang3.StringUtils"%>
<% 
	String dbUrl ="jdbc:mysql://localhost:3306/tripist_db?useUnicode=true&characterEncoding=utf8";
	String dbUser ="skehdlf";
	String dbPassword ="ndi9150";


	
	String id = request.getParameter("uid");
	String pwd =request.getParameter("pwd");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet  rs = null;
	
	Boolean isLogin = false;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
		conn = DriverManager.getConnection(dbUrl , dbUser, dbPassword);
		
		stmt = conn.prepareStatement("select * from users where userid='" + id + "' and passwd='" + pwd + "'" );;
		rs = stmt.executeQuery();
		while (rs.next())
		{
			session.setMaxInactiveInterval(3600);
			session.setAttribute("id", "true");
			
			out.print(id);
			out.print("님 로그인됫습니다");
			isLogin = true;
			%>
			<br/>
			<a href="home.jsp?userid=<%=id%>">메인페이지로 이동</a>
			<%
		}
		if(!isLogin)
		{
			out.print("회원정보가 없습니다");
			%>
			<input type ="button" name="input" value="뒤로가기" onClick="javascript:window.loaciton.href('Main.jsp')"/>
					
			<%
		}
	}catch(ClassNotFoundException cnfe){
		out.println("클래스문제" +cnfe.getMessage());
	}catch(SQLException e){
		out.println("slq문제" + e.getMessage());
	}
	
	%>