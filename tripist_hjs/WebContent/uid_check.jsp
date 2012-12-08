<%-- JSP 페이지 정의 시작 --%>
<%@ page info="uid_check.jsp" errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=euc-kr" %> 
<%@ page language="java" import="java.sql.*,java.io.*,java.net.*" %>
<%-- JSP 페이지 정의 끝 --%>


<%-- 자바빈즈 선언 끝 --%>

<%-- JSP 코드 시작 --%>
<%	String errorMsg=null;

String actionUrl;
String uid ="";

Connection conn =null;
PreparedStatement stmt = null;
ResultSet rs = null;

String dbUrl ="jdbc:mysql://localhost:3306/tripist_db";
String dbUser ="hoy";
String dbPassword ="8956";

    int check_count = 0;  // 해당레코드 카운드

    try {
    	Class.forName("com.mysql.jdbc.Driver");
		conn =DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		stmt =conn.prepareStatement("SELECT COUNT(*) AS count FORM users WHERE uid='"+uid+"'");
		rs = stmt.executeQuery();
		rs.next();
		check_count = rs.getInt("count");
		rs.close();
    } catch(SQLException e){
    } finally {
       
    }
%>
<%-- JSP 코드 끝 --%>

<%-- HTML 코드 시작 --%>
<html>
<head>
<title>아이디 중복검사</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%-- 외부 스타일시트 지정 --%>
<link rel="StyleSheet" href="style.css" type="text/css">
<%-- 자바스크립트 영역 시작 --%>
<script language="JavaScript">
<!--
function checkEnd(){
    var form = document.id_check;

    opener.join.uid.value       = form.uid.value;
    opener.join.uid_check.value = form.check_count.value;
    self.close();
}

function doCheck(){
    var form = document.id_check;

    if(!checkValue(form.uid, '아이디', 5, 16)){
        return;
    }

    form.submit();
}

function checkValue(target, cmt, lmin, lmax){
    var Alpha = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var Digit = '1234567890';
    var astr = Alpha+Digit;
    var i;
    var tValue = target.value;
    if(tValue.length < lmin || tValue.length > lmax){
        if(lmin==lmax) alert(cmt+'는'+lmin+'Byte이어야 합니다.');
        else alert(cmt+'는'+lmin+'~'+lmax+'Byte 이내로 입력하셔야 합니다.');
        target.focus();
        return false;
    }

    if(astr.length > 1){
        for (i=0; i<tValue.length; i++){
            if(astr.indexOf(tValue.substring(i,i+1))<0){
                alert(cmt+'에 허용할 수 없는 문자가 입력되었습니다.');
                target.focus();
                return false;
            }
        }
    }
    return true;
}
-->
</script>
<%-- 자바스크립트 영역 끝 %>
</head>
<body text="#000000" bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<%-- FORM 태그 시작 --%>
<form name="id_check" method="post" action="uid_check.jsp">
  <input type="hidden" name="check_count" value="<%=check_count%>">
  <table width="300" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>원하는 아이디를 입력하세요.</td>
    </tr>
  </table>
  <table width="300" border="0" bgcolor="#B6C1D6" height="39" align="center">
    <tr> 
      <td bgcolor="#ffffff" width="40%" align="center"> 
        <input type="text" name="uid" value="<%=uid%>" onFocus="this.value=''" maxlength="16" size="16" class="oneborder">
        <input type="button" value="중복확인" onClick="doCheck()" class="oneborder">
      </td>
    </tr>
    <tr>
      <td>
<%
    if(check_count > 0){
%>
      [<%=uid%>]은 등록되어있는 아이디입니다.<br> 다시 시도해주십시오.
<%
    }else{
%>
      [<%=uid%>]은 사용 가능합니다.
<%
    }
%>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td align="center">
        <input type="button" value="확인" onClick="checkEnd()" class="oneborder">
      </td>
    </tr>
  </table>
</form>
<%-- FORM 태그 끝 --%>
</body>
</html>
<%-- HTML 코드 끝 --%>