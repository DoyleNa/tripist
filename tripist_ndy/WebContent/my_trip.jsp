<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" import="org.apache.commons.lang3.StringUtils"%>
<% 
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/tripist_db?useUnicode=true&characterEncoding=utf8";
	String dbUser = "skehdlf";
	String dbPassword = "ndi9150";
	int travel_count = 0;
	String trip_name = "";
	request.setCharacterEncoding("UTF-8");
	String userid = request.getParameter("userid");
	String tripid = "";
	int tripidList[] = new int[100];
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(dbUrl,dbUser,dbPassword);
		
		stmt = conn.prepareStatement("select count(*) from travel where group_name=?");
		stmt.setString(1, userid);
		rs = stmt.executeQuery();
		
		if(rs.next()){
			travel_count = rs.getInt("count(*)");
		}
	}catch(SQLException e){
		
	}finally{
		if (rs != null) try{rs.close();} catch(SQLException e) {}
		if (stmt != null) try{stmt.close();} catch(SQLException e) {}
		if (conn != null) try{conn.close();} catch(SQLException e) {}
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>My Trip</title>
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
			<h3><%=userid%>님이 현재 계획중이신 여행은 <%=String.valueOf(travel_count) %>개 입니다.</h3>
			<%
				try{							
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection(dbUrl,dbUser,dbPassword);
					stmt = conn.prepareStatement("select tripid from travel where group_name=?");
					stmt.setString(1,userid);
					rs = stmt.executeQuery();
					int cnt=0;
					while(rs.next()){
						tripidList[cnt] = rs.getInt("tripid");
						cnt++;
					}					
				}catch(SQLException e){}
				finally{
					if (rs != null) try{rs.close();} catch(SQLException e) {}
					if (stmt != null) try{stmt.close();} catch(SQLException e) {}
					if (conn != null) try{conn.close();} catch(SQLException e) {}
				}
			%>
			<table>
				<tbody>					
					<%for(int i=0;i<travel_count;i++){
						try{							
							Class.forName("com.mysql.jdbc.Driver");
							conn = DriverManager.getConnection(dbUrl,dbUser,dbPassword);
							stmt = conn.prepareStatement("select tripname from travel where tripid=?");
							stmt.setInt(1,tripidList[i]);
							rs = stmt.executeQuery();
							if(rs.next()){
								trip_name = rs.getString("tripname");
							}
						}catch(SQLException e){}
						finally{
							if (rs != null) try{rs.close();} catch(SQLException e) {}
							if (stmt != null) try{stmt.close();} catch(SQLException e) {}
							if (conn != null) try{conn.close();} catch(SQLException e) {}
						}
					%>
						<tr>
							<td><a href="show.jsp?tripid=<%=tripidList[i]%>"><%=trip_name%></a></td>
						</tr>	
					<%}%>
				</tbody>
			</table>
		</div>
	<jsp:include page = "share/footer.jsp" />
</body>
</html>