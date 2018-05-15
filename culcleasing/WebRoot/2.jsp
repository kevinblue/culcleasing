<%@ page contentType="text/html; charset=gb2312" language="java" errorPage="" %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 

<html xmlns="http//www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>用户角色</title>


<%

String czid;
czid=request.getParameter("aaa");
out.print("aaa111="+czid);
System.out.println("sqlstr==================");
%>


</body>
</html>

