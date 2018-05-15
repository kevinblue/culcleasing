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
//===========================================
	//修改资金计划
//===========================================
	
//获取基础参数

String item_id = getStr( request.getParameter("item_id") );//主键

//获取资金计划数据参数

String plan_bank_name = getStr( request.getParameter("plan_bank_name") );
String plan_bank_no = getStr( request.getParameter("plan_bank_no") );
//新增是否保理
String factoring = getStr( request.getParameter("factoring") );
//基本变量
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
	sqlstr = "update fund_rent_plan_temp set plan_bank_name='"+plan_bank_name+"',plan_bank_no='"+plan_bank_no+"',factoring='"+factoring+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+item_id+"'";
	
	flag = db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "修改租金计划计划收款银行："+plan_bank_name+" 计划收款银行账号"+plan_bank_no);


db.close();

//3返回判断
	if(flag>0){%>
	<script type="text/javascript">
		opener.alert("修改租金计划成功!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>	
	<%}else{%>
	<script type="text/javascript">
		opener.alert("修改租金计划失败!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%} %>
</BODY>
</HTML>
