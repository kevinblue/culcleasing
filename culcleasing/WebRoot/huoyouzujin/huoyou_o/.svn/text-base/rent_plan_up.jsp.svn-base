<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%

String type =getStr(request.getParameter("up"));
String contract_id =getStr(request.getParameter("contract_id"));
String begin_id =getStr(request.getParameter("begin_id"));
String doc_id =getStr(request.getParameter("doc_id"));
String rent_list =getStr(request.getParameter("rent_list"));

int flag=0;
String msg = "";
String sqlstr = "";
String datestr = getSystemDate(0); //获取系统时间

if("修改".equals(type)){
	String equip_operation_revenue =getStr(request.getParameter("equip_operation_revenue"));
	String leas_rent_start_date =getStr(request.getParameter("leas_rent_start_date"));
	String leas_rent_end_date =getStr(request.getParameter("leas_rent_end_date"));
	String leas_separate_ratio =getStr(request.getParameter("leas_separate_ratio"));
	String leas_plan_rent =getStr(request.getParameter("leas_plan_rent"));
	String leas_other_out =getStr(request.getParameter("leas_other_out"));

	String leas_fact_rent =getStr(request.getParameter("leas_fact_rent"));
	String leas_all_in =getStr(request.getParameter("leas_all_in"));
	String income_hire_date =getStr(request.getParameter("income_hire_date"));
	String plan_date =getStr(request.getParameter("plan_date"));

	
	sqlstr ="Update fund_rent_plan_medi_temp set equip_operation_revenue='"+equip_operation_revenue+"',";
	sqlstr+="leas_rent_start_date='"+leas_rent_start_date+"',leas_rent_end_date='"+leas_rent_end_date+"',";
	sqlstr +="leas_separate_ratio='"+leas_separate_ratio+"',leas_plan_rent='"+leas_plan_rent+"',leas_other_out='"+leas_other_out+"',";
	sqlstr +="leas_fact_rent='"+leas_fact_rent+"',leas_all_in='"+leas_all_in+"',income_hire_date='"+income_hire_date+"',plan_date='"+plan_date+"'";
	sqlstr +="where contract_id='"+contract_id+"' and rent_list='"+rent_list+"'";
	LogWriter.logDebug(request,"修改或有租金计划:"+sqlstr);
	System.out.println("修改或有租金----"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	msg = "修改或有租金";
	
}else if("删除".equals(type)){
	sqlstr  ="Delete from fund_rent_plan_medi_temp where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' and doc_id='"+doc_id+"' and rent_list='"+rent_list+"'";
	LogWriter.logDebug(request,"删除或有租金计划:"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	msg = "删除或有租金";
	
}
db.close();
if (flag>0){
%>
<script type="text/javascript">
	opener.alert("<%=msg %>成功!");
	opener.location.reload();
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>
<%}else{ %>
<script type="text/javascript">
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
