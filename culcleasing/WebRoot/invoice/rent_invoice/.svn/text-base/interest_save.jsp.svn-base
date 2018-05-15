<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

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
String id = getStr( request.getParameter("item_id") );//id编号
String interest=getStr( request.getParameter("interest"));




//基本变量
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
	sqlstr = "update report_month_plan_accrued_temp set interest='"+interest+"' where id='"+id+"'";
	System.out.print("sql"+sqlstr);
	flag = db.executeUpdate(sqlstr);
db.close();

//3返回判断

if(flag>0){%>
	<script type="text/javascript">
		window.close();
		opener.alert("修改利息成功!");
		opener.location.reload();
	</script>	
	<%}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("修改利息失败!");
		opener.location.reload()
	</script>
<%} %>
</BODY>
</HTML>
