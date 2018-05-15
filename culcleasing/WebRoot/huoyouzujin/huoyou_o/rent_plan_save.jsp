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
//获取参数
String contract_id =getStr(request.getParameter("contract_id"));
String doc_id= getStr(request.getParameter("doc_id"));
String begin_id = getStr(request.getParameter("begin_id"));
String sysDate = getSystemDate(0);						   //当前时间
String user_id = (String)session.getAttribute("czyid");    //当前登陆人


//String rl=getStr(request.getParameter("rent_list"));
//String rent_list =rl.split("\\.")[0];
String rent_list =getStr(request.getParameter("rent_list"));
String equip_operation_revenue =getStr(request.getParameter("equip_operation_revenue"));

String leas_separate_ratio =getStr(request.getParameter("leas_separate_ratio"));
String leas_plan_rent =getStr(request.getParameter("leas_plan_rent"));
String leas_other_out =getStr(request.getParameter("leas_other_out"));

String leas_fact_rent =getStr(request.getParameter("leas_fact_rent"));
String leas_all_in =getStr(request.getParameter("leas_all_in"));

String leas_rent_start_date =getStr(request.getParameter("leas_rent_start_date"));
String leas_rent_end_date =getStr(request.getParameter("leas_rent_end_date"));

String plan_date =getStr(request.getParameter("plan_date"));
String income_hire_date =getStr(request.getParameter("income_hire_date"));

String plan_bank_name =getStr(request.getParameter("plan_bank_name"));
String plan_bank_no =getStr(request.getParameter("plan_bank_no"));

int flag=0;
String sqlstr = "";
String datestr = getSystemDate(0); //获取系统时间
		
String str="doc_id,contract_id,begin_id,uuid,rent_list,equip_operation_revenue,leas_separate_ratio,leas_plan_rent,";
str +="leas_other_out,leas_fact_rent,leas_all_in,curr_leas_all_in,leas_rent_start_date,leas_rent_end_date,income_hire_date,";
str +="plan_date,plan_status,creator,create_date,modificator,modify_date,plan_bank_name,plan_bank_no";
 		
sqlstr = "insert into fund_rent_plan_medi_temp ("+str+") values('"+doc_id+"','"+contract_id+"','"+begin_id+"','"+CommonTool.getUUID()+"','"+rent_list+"',";
sqlstr +="'"+equip_operation_revenue+"','"+leas_separate_ratio+"','"+leas_plan_rent+"','"+leas_other_out+"',";
sqlstr +="'"+leas_fact_rent+"','"+leas_all_in+"','"+leas_all_in+"','"+leas_rent_start_date+"','"+leas_rent_end_date+"','"+income_hire_date+"','"+plan_date+"','未核销','"+user_id+"','"+sysDate+"','"+user_id+"','"+sysDate+"','"+plan_bank_name+"','"+plan_bank_no+"')";
LogWriter.logDebug(request,"添加或有租金计划:"+sqlstr);
flag = db.executeUpdate(sqlstr);
db.close();
if(flag>0){
%>
	<script type="text/javascript">
		opener.alert("添加成功!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%}else{%>
	<script type="text/javascript">
		opener.alert("添加失败!");
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
