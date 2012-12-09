<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid="doyle";
	String[][] menu = {
		{"./home.jsp?userid="+userid, "Home" },
		{"./my_trip.jsp?userid="+userid, "Trip" },
		{"./group.jsp?userid="+userid, "MyGroup" }
	};
  String currentMenu = request.getParameter("current");
%>    
	<!-- Navbar
  ================================================== -->
  <div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container">
        <a class="brand" href="./home.jsp?userid=<%=userid%>">Tripist</a>
        <div class="nav-collapse collapse">
          <ul class="nav">
          <%
          	for(String[] menuItem : menu) {
          		if (currentMenu != null && currentMenu.equals(menuItem[1])) {
          			out.println("<li class='active'>");
          		} else {
          			out.println("<li class=''>");
          		}
          		
          		out.println("<a href='"+menuItem[0]+"'>"+menuItem[1]+"</a>");
          		out.println("</li>");
          	}
          %>
          </ul>
        </div>
      </div>
    </div>
  </div>
<div class="container" style="padding-top:50px">
		<div id="top">
			<img src="img/top.jpg" alt="top_image">
		</div>
 </div>
 	
 	