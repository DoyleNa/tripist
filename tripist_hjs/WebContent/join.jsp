<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*" 
    import="org.apache.commons.lang3.StringUtils"%>
 <%
 	String errorMsg = null;
 	Connection conn =null;
 	PreparedStatement stmt=null;
 	ResultSet rs =null;
 	
 	String dbUrl ="jdbc:mysql://localhost:3306/tripist_db";
	String dbUser ="hoy";
	String dbPassword ="8956";
	
	request.setCharacterEncoding("utf-8");
	String mem_uid = request.getParameter("mem_uid");
	String pwd = request.getParameter("pwd");
	String email = request.getParameter("email");
	String pwd_confirm = request.getParameter("pwd_confirm");
	String nationality = request.getParameter("nationality");
	

 	
 	
 	List<String> errorMsgs = new ArrayList<String>();
 	
 	int result = 0;
 	
 	
 	if(mem_uid == null || mem_uid.trim().length() == 0)
 	{
 		errorMsgs.add("ID를 입력해 주세요");
 	}
 	if(pwd == null || pwd.length() < 6)
 	{
 		errorMsgs.add("비밀번호는 6자리 이상 입력해주세요 ");
 		out.println(pwd);
 	}
 	if (!pwd.equals(pwd_confirm)) {
		errorMsgs.add("비밀번호가 일치하지 않습니다.");
	}
 	if(nationality == null || nationality.trim().length() == 0)
 	{
 		errorMsgs.add("거주하시는지역을 입력해주세요 .");
 	}
 	
 	
 	//회원정보 DB로 전송
 	if(errorMsgs.size() == 0)
 	{
 		try{
 			Class.forName("com.mysql.jdbc.Driver");
 			conn =DriverManager.getConnection(dbUrl, dbUser, dbPassword);
 			//SQL 문
 			
 			stmt = conn.prepareStatement("INSERT INTO users(uid, pwd, email,nationality)"+
 			"VALUES(?,?,?,?)");
 			
 			stmt.setString(1, mem_uid);
 			stmt.setString(2, pwd);
 			stmt.setString(3, email);
 			stmt.setString(4, nationality);
 			
 		
 			
 			result = stmt.executeUpdate();
 			if (result != 1){
 				errorMsgs.add("등록에 실패하였습니다");
 				
 			}	
 			
 		} catch (SQLException e){
 			errorMsgs.add("SQL 에러 : " +e.getMessage());
 			e.printStackTrace();
 		}
		
 		
 	}
 	
 %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href ="css/bootstrap.min.css" rel ="stylesheet">
	<link href ="css/tripist.css" rel ="stylesheet">
	<script src ="js/jquery-1.8.2.min.js"></script>
	<script src ="js/bootstrpa.min.js"></script>
</head>
<body>


	<div class ="container" >
		<% if (errorMsgs.size() > 0) { %>
		<div class ="alert alert-error">
			<h3>Errors:</h3>
			<ul>
				<%for(String msg :errorMsgs) { %>
				<li><%=msg %></li>
				<%} %>
			</ul>
		</div>
		<div class ="form-action">
		<a onclick ="history.back);" class ="btn">메인화면으로</a></div>
		<% } else if (result == 1){ %>
		<div class ="alert alert-success">
		<b><%= mem_uid %>님 등록해주셔서 감사합니다.</b>
		</div>
		<div class ="form-action">
		<a href="main_page.jsp" class ="btn">start tripist</a>
		</div>
		<%} %>
		
	</div>
	

</body>
</html>