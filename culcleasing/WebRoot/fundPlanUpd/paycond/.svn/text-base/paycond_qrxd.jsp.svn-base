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

//新增6-25
String updType = getStr( request.getParameter("updType") ); //类型
String itemselect = request.getParameter("itemselect"); //id
System.out.println("========================"+itemselect);

int flag1=0;
String msg="";
//确认修订
if(updType.equals("qrxd")){
String sqlstr1="update contract_fund_fund_charge_plan_temp set oth_remark=2 where id='"+itemselect+"'";
flag1=db.executeUpdate(sqlstr1);
System.out.println("========================"+sqlstr1);
System.out.println("========================"+flag1);
msg="参与修订";
}
if(updType.equals("zbxd")){
String sqlstr1="update contract_fund_fund_charge_plan_temp set oth_remark=null where id='"+itemselect+"'";
flag1=db.executeUpdate(sqlstr1);
System.out.println("========================"+sqlstr1);
System.out.println("========================"+flag1);
msg="暂不修订";
}

db.close();

//3返回判断
if(flag1>0){%>
	
	<script type="text/javascript">
		opener.alert("<%=msg%>成功!");
	opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
	<%}else{%>
	<script type="text/javascript">
		opener.alert("确认修订失败！");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%} %>
</BODY>
</HTML>
