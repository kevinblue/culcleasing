<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

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
//===========================================
	//资金计划付款前提
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
 
if("add".equals(type)){//添加付款前提
	String[] cond_id = request.getParameterValues("cond"); 
	String ckAmount = getStr( request.getParameter("ckAmount") );

	//2.1先删除付款前提
	sqlstr = "delete from proj_fund_fund_charge_condition_temp where payment_id='"+item_id+"' and doc_id='"+doc_id+"'";
	db.executeUpdate(sqlstr);
	
	System.out.println("ckAmount选中付款前提数量"+ckAmount);
	//LogWriter.logDebug(request, ckAmount+"sadasdsad"+cond_id.length+"___"+cond_id[0]);
	//System.out.println("sadasdsad"+cond_id.length+"___"+cond_id[0]);
	//2.2插入新的付款前提
	if("0".equals(ckAmount)){
		sqlstr = "";
		flag = 111111;
	}else{
		sqlstr = "";
		for(int i=0;i<cond_id.length;i++){
			sqlstr += " insert into proj_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
			sqlstr += " select '"+item_id+"','"+doc_id+"','"+cond_id[i]+"','未收',''";
		}
		flag = db.executeUpdate(sqlstr);
	}

	LogWriter.logDebug(request, "设置项目付款前提");
	
	msg = "设置项目付款前提";
}

//3返回判断
if(flag>0){%>
	<script type="text/javascript">
		//window.close();
		opener.alert("<%=msg %>成功!");
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
		opener.alert("<%=msg %>失败!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}			
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>