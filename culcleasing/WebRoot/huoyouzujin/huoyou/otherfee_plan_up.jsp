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
String i_index =getStr(request.getParameter("i_index"));
String type =getStr(request.getParameter("up"));
String contract_id =getStr(request.getParameter("contract_id"));
String begin_id =getStr(request.getParameter("begin_id"));
String doc_id =getStr(request.getParameter("doc_id"));
String otherfee_list =getStr(request.getParameter("otherfee_list"));

int flag=0;
String sqlstr="";
String msg="";

if("修改".equals(type)){
	String otherfee_feetype =getStr(request.getParameter("otherfee_feetype"+i_index));
	String otherfee_paytype =getStr(request.getParameter("otherfee_paytype"));
	String otherfee_money =getStr(request.getParameter("otherfee_money"));
	String plan_date =getStr(request.getParameter("plan_date"));

	sqlstr  ="update fund_otherfee_plan_medi_temp set otherfee_feetype='"+otherfee_feetype+"',";
	sqlstr +="otherfee_paytype='"+otherfee_paytype+"',otherfee_money='"+otherfee_money+"',plan_date='"+plan_date+"'";
	sqlstr +="where begin_id='"+begin_id+"' and doc_id='"+doc_id+"' and contract_id='"+contract_id+"' and otherfee_list='"+otherfee_list+"'";
	
	LogWriter.logDebug(request,"修改其他费用:"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	msg = "修改其他费用";
}else if("删除".equals(type)){
	sqlstr  ="Delete from fund_otherfee_plan_medi_temp where contract_id='"+contract_id+"' and begin_id='"+begin_id+"' and doc_id='"+doc_id+"' and otherfee_list='"+otherfee_list+"'";
	LogWriter.logDebug(request,"删除管理费:"+sqlstr);
	flag = db.executeUpdate(sqlstr);
	msg = "删除其他费用";			
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
