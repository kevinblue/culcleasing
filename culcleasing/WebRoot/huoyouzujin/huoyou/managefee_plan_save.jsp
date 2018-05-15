<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.culc.util.CommonTool"%> 
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%

String begin_id = getStr(request.getParameter("begin_id"));
String contract_id =getStr(request.getParameter("contract_id"));
String doc_id= getStr(request.getParameter("doc_id"));

String sysDate = getSystemDate(0);						   //当前时间
String user_id = (String)session.getAttribute("czyid");    //当前登陆人

String managefee_list =getStr(request.getParameter("managefee_list"));
String equip_operation_revenue =getStr(request.getParameter("equip_operation_revenue"));
String managefee_money =getStr(request.getParameter("managefee_money"));
String manage_separate_ratio =getStr(request.getParameter("manage_separate_ratio"));
String plan_date =getStr(request.getParameter("plan_date"));
String managefee_pay_side=getStr(request.getParameter("managefee_pay_side"));

int flag=0;
String sqlstr;

String datestr = getSystemDate(0); //获取系统时间

String str="doc_id,contract_id,begin_id,uuid,managefee_list,equip_operation_revenue,managefee_money,curr_managefee_money,manage_separate_ratio,";
str +="plan_date,plan_status,creator,create_date,modificator,modify_date,managefee_pay_side";
		
sqlstr = "insert into fund_managefee_plan_medi_temp ("+str+") values('"+doc_id+"','"+contract_id+"','"+begin_id+"','"+CommonTool.getUUID()+"','"+managefee_list+"',";
sqlstr +="'"+equip_operation_revenue+"','"+managefee_money+"','"+managefee_money+"','"+manage_separate_ratio+"',";
sqlstr +="'"+plan_date+"','未核销','"+user_id+"','"+sysDate+"','"+user_id+"','"+sysDate+"','"+managefee_pay_side+"')";
flag = db.executeUpdate(sqlstr);
				
db.close();
if(flag>0){
%>
<script type="text/javascript">
	opener.alert("添加管理费成功!");
	opener.location.reload();
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
<%}else{%>
<script type="text/javascript">
	opener.alert("添加管理费失败!");
	opener.location.reload();
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
<%	}
%>
</BODY>
</HTML>
