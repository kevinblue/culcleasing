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
String managefee_list =getStr(request.getParameter("managefee_list"));

int flag=0;
String sqlstr = "";
String msg = "";

if("修改".equals(type)){
	String equip_operation_revenue =getStr(request.getParameter("equip_operation_revenue"));
	String managefee_money =getStr(request.getParameter("managefee_money"));
	String manage_separate_ratio =getStr(request.getParameter("manage_separate_ratio"));
	String plan_date =getStr(request.getParameter("plan_date"));

	sqlstr  ="update fund_managefee_plan_medi_temp set equip_operation_revenue='"+equip_operation_revenue+"',";
	sqlstr +="managefee_money='"+managefee_money+"',manage_separate_ratio='"+manage_separate_ratio+"',";
	sqlstr +="plan_date='"+plan_date+"'";
	sqlstr +="where begin_id='"+begin_id+"' and doc_id='"+doc_id+"' and contract_id='"+contract_id+"' and managefee_list='"+managefee_list+"'";

	flag = db.executeUpdate(sqlstr);
	msg = "修改管理费";
}else if("删除".equals(type)){
	sqlstr  ="Delete from fund_managefee_plan_medi_temp where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' and doc_id='"+doc_id+"' and managefee_list='"+managefee_list+"'";
	LogWriter.logDebug(request,"删除管理费:"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	msg = "删除管理费";
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
