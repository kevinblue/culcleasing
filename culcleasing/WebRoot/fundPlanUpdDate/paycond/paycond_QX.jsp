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
	//ȡ�����۹�ϵ
//===========================================
	
//��ȡ��������
String item_id = getStr( request.getParameter("item_id") );
String doc_id = getStr( request.getParameter("doc_id") );


int flag = 0;
String msg = "";
String sqlstr3="update contract_fund_fund_charge_ZK set flag=2 where fund_uuid='"+item_id+"' and doc_id<>'"+doc_id+"'";
flag=db.executeUpdate(sqlstr3);


String sqlstr1="delete from contract_fund_fund_charge_ZK where fund_uuid='"+item_id+"' and doc_id='"+doc_id+"'";
flag+= db.executeUpdate(sqlstr1);
msg="ȡ�����۹�ϵ";
//3�����ж�
if(flag>0){%>
<script type="text/javascript">
		window.opener.alert("<%=msg %>�ɹ�!");
		window.opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
</script>	
<%}else{
%>
	<script type="text/javascript">
		window.opener.alert("<%=msg %>ʧ��!");
		window.opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}	
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>