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
String id = getStr( request.getParameter("id") );
String remark = getStr( request.getParameter("remark") );

int flag = 0;
 
//1查询交易结构临时表的资金计划
String sqlstr = "update contract_fund_fund_charge_condition_temp set remark = '"+remark+"' where id = '"+id+"'";
flag +=db.executeUpdate(sqlstr);
if(db!=null){
db.close();
}
	if(flag>0){%>
	<script type="text/javascript">
		opener.alert("修改付款前提备注成功!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>	
	<%}else{
%>
	<script type="text/javascript">
		opener.alert("修改付款前提备注失败!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%} %>
</BODY>
</HTML>
