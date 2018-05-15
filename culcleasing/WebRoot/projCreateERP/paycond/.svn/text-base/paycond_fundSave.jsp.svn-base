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
	//新增资金计划
//===========================================
	
//获取基础参数
String type = getStr( request.getParameter("type") );
String item_id = getStr( request.getParameter("item_id") );
String doc_id = getStr( request.getParameter("doc_id") );

//基本变量
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
String msg = "";
 
if("del".equals(type)){//删除该资金计划
	//2.1先删除资金计划付款前提数据
	sqlstr = "delete from proj_fund_fund_charge_condition_temp where doc_id='doc_id' and payment_id='"+item_id+"'";
	db.executeUpdate(sqlstr);

	//2.2先删除资金计划数据
	sqlstr = "delete from proj_fund_fund_charge_plan_temp where measure_id='"+doc_id+"' and payment_id='"+item_id+"'";
	flag = db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "删除资金计划完成");
	
	msg = "删除资金计划";
}

//3返回判断
if(flag>0){%>
<script type="text/javascript">
	window.close();
	opener.alert("<%=msg %>成功!");
	opener.location.reload();
</script>	
<%}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>失败!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>