<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String czid= getStr( request.getParameter("czid") );
String cust_id = getStr( request.getParameter("cust_id") );
String inter_cust_id = getStr( request.getParameter("inter_cust_id") );
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;
String datestr = getSystemDate(1); //获取系统时间

if ( stype.equals("mod") ){      //修改操作
	//String czid = getStr( request.getParameter("id") );
		sqlstr = "delete from inter_custid_join where cust_id_b='"+cust_id+"'";
		System.out.println(sqlstr);
		db.executeUpdate(sqlstr);
		sqlstr = "insert into inter_custid_join (cust_id_b,cust_id_f) values ('"+cust_id+"','"+inter_cust_id+"')";
		System.out.println(sqlstr);
		db.executeUpdate(sqlstr);
%>
		<script>
			window.close();
			opener.alert("修改成功!");
			opener.location.reload();
		</script>
<%
	
}

db.close();
%>


</BODY>
</HTML>

