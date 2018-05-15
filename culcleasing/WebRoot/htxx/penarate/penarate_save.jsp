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
String sqlstr;
ResultSet rs;
String dqczy = (String) session.getAttribute("czyid");
String czid = getStr( request.getParameter("czid") );
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );

String pena_rate = getStr( request.getParameter("pena_rate") );
String pena_chs = getStr( request.getParameter("pena_chs") );






int flag=0;
String message="";
if ( stype.equals("add")){ 
	sqlstr="insert into base_pena_rate (pena_rate,pena_chs) values("+pena_rate+",'"+pena_chs+"')";
	flag = db.executeUpdate(sqlstr);
	message="添加罚息利率";
}
if ( stype.equals("mod")){ 
		sqlstr="update base_pena_rate set pena_chs='"+pena_chs+"',pena_rate="+pena_rate+" where id="+czid;
		flag = db.executeUpdate(sqlstr);
	message="修改罚息利率";
}
if ( stype.equals("del") ){ 
	sqlstr="delete from base_pena_rate where  id="+czid;
	flag = db.executeUpdate(sqlstr);
	message="删除罚息利率";
}



if(flag!=0){
%>
<script>
			window.close();
			opener.alert("<%=message%>成功!");
			opener.location.reload();
		</script>
<%
}else{
%>
<script>
			window.close();
			opener.alert("<%=message%>失败!");
			opener.location.reload();
		</script>
<%}db.close();%>