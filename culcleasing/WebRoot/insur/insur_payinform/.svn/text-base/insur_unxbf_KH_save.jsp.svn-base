<%@ page contentType="text/html; charset=gbk" language="java"%>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
	String id = (String)request.getParameter("id");
	String next_date = request.getParameter("next_pay_date");
	String sqlstr = "update insur_info set next_pay_date='"+next_date+"' where id="+id;
	int flag = 0;
	flag = db.executeUpdate(sqlstr);
	db.close();
if(flag>0){
%>
	<script type="text/javascript">
		window.opener.alert("保费支付成功!");
		window.opener.location.reload();
//		window.opener="";

		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.opener.alert("保费支付失败!");
		window.opener.location.reload();

		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}

//		window.opener="";
	</script>
<%} %>
</BODY>
</HTML>
