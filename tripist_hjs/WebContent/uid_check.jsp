<%-- JSP ������ ���� ���� --%>
<%@ page info="uid_check.jsp" errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=euc-kr" %> 
<%@ page language="java" import="java.sql.*,java.io.*,java.net.*" %>
<%-- JSP ������ ���� �� --%>


<%-- �ڹٺ��� ���� �� --%>

<%-- JSP �ڵ� ���� --%>
<%	String errorMsg=null;

String actionUrl;
String uid ="";

Connection conn =null;
PreparedStatement stmt = null;
ResultSet rs = null;

String dbUrl ="jdbc:mysql://localhost:3306/tripist_db";
String dbUser ="hoy";
String dbPassword ="8956";

    int check_count = 0;  // �ش緹�ڵ� ī���

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
<%-- JSP �ڵ� �� --%>

<%-- HTML �ڵ� ���� --%>
<html>
<head>
<title>���̵� �ߺ��˻�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%-- �ܺ� ��Ÿ�Ͻ�Ʈ ���� --%>
<link rel="StyleSheet" href="style.css" type="text/css">
<%-- �ڹٽ�ũ��Ʈ ���� ���� --%>
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

    if(!checkValue(form.uid, '���̵�', 5, 16)){
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
        if(lmin==lmax) alert(cmt+'��'+lmin+'Byte�̾�� �մϴ�.');
        else alert(cmt+'��'+lmin+'~'+lmax+'Byte �̳��� �Է��ϼž� �մϴ�.');
        target.focus();
        return false;
    }

    if(astr.length > 1){
        for (i=0; i<tValue.length; i++){
            if(astr.indexOf(tValue.substring(i,i+1))<0){
                alert(cmt+'�� ����� �� ���� ���ڰ� �ԷµǾ����ϴ�.');
                target.focus();
                return false;
            }
        }
    }
    return true;
}
-->
</script>
<%-- �ڹٽ�ũ��Ʈ ���� �� %>
</head>
<body text="#000000" bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<%-- FORM �±� ���� --%>
<form name="id_check" method="post" action="uid_check.jsp">
  <input type="hidden" name="check_count" value="<%=check_count%>">
  <table width="300" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td>���ϴ� ���̵� �Է��ϼ���.</td>
    </tr>
  </table>
  <table width="300" border="0" bgcolor="#B6C1D6" height="39" align="center">
    <tr> 
      <td bgcolor="#ffffff" width="40%" align="center"> 
        <input type="text" name="uid" value="<%=uid%>" onFocus="this.value=''" maxlength="16" size="16" class="oneborder">
        <input type="button" value="�ߺ�Ȯ��" onClick="doCheck()" class="oneborder">
      </td>
    </tr>
    <tr>
      <td>
<%
    if(check_count > 0){
%>
      [<%=uid%>]�� ��ϵǾ��ִ� ���̵��Դϴ�.<br> �ٽ� �õ����ֽʽÿ�.
<%
    }else{
%>
      [<%=uid%>]�� ��� �����մϴ�.
<%
    }
%>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td align="center">
        <input type="button" value="Ȯ��" onClick="checkEnd()" class="oneborder">
      </td>
    </tr>
  </table>
</form>
<%-- FORM �±� �� --%>
</body>
</html>
<%-- HTML �ڵ� �� --%>