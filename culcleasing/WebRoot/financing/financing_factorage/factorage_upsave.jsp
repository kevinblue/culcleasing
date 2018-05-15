<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
	
//获取基础参数
String item_id = getStr( request.getParameter("item_id") );//主键

String factorage_type = getStr( request.getParameter("factorage_type") );
String factorage_paytype = getStr( request.getParameter("factorage_paytype") );
String factorage_date = getStr( request.getParameter("factorage_date") );
String factorage_money = getStr( request.getParameter("factorage_money") );
String factorage_remark = getStr( request.getParameter("factorage_remark") );
String currency_type = getStr( request.getParameter("currency_type") );
//基本变量
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;

//2.3修改资金计划

	sqlstr = "update financing_drawings_factorage set factorage_type='"+factorage_type+"',factorage_paytype='"+factorage_paytype+"',factorage_date='"+factorage_date+"'"+
	",factorage_money='"+factorage_money+"',factorage_remark='"+factorage_remark+"',modifactor='"+dqczy+"',modify_date='"+datestr+"',currency='"+currency_type+"' where id='"+item_id+"'";
	
	flag = db.executeUpdate(sqlstr);

db.close();

//3返回判断

	if(flag>0){%>
	<script type="text/javascript">
		//window.close();
		opener.alert("修改手续费成功!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>	
	<%}else{
%>
	<script type="text/javascript">
		//window.close();
		opener.alert("修改手续费失败!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%} %>
</BODY>
</HTML>
