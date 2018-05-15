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

String user_id = (String)session.getAttribute("czyid");    //当前登陆人
String sysDate = getSystemDate(0);						   //当前时间

String otherfee_list =getStr(request.getParameter("otherfee_list"));
String otherfee_feetype =getStr(request.getParameter("otherfee_feetypet"));
String otherfee_paytype =getStr(request.getParameter("otherfee_paytype"));
String otherfee_money =getStr(request.getParameter("otherfee_money"));
String plan_date =getStr(request.getParameter("plan_date"));

int flag=0;
String sqlstr;


String str="doc_id,contract_id,begin_id,uuid,otherfee_list,otherfee_feetype,otherfee_paytype,otherfee_money,curr_otherfee_money,";
str +="plan_date,plan_status,creator,create_date,modificator,modify_date";
 		
sqlstr = "insert into fund_otherfee_plan_medi_temp ("+str+") values('"+doc_id+"','"+contract_id+"','"+begin_id+"','"+CommonTool.getUUID()+"','"+otherfee_list+"',";
sqlstr +="'"+otherfee_feetype+"','"+otherfee_paytype+"','"+otherfee_money+"','"+otherfee_money+"','"+plan_date+"','未核销','"+user_id+"','"+sysDate+"','"+user_id+"','"+sysDate+"')";
LogWriter.logDebug(request,"添加其他费用:"+sqlstr);
flag = db.executeUpdate(sqlstr);

db.close();
if(flag>0){
%>
<script type="text/javascript">
	opener.alert("添加其他费用成功!");
	opener.location.reload();
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
<%}else{%>
<script type="text/javascript">
	opener.alert("添加其他费用失败!");
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
