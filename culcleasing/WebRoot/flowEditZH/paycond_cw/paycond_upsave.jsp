<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

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
//===========================================
	//�޸��ʽ�ƻ�����
//===========================================
	
String item_id = getStr( request.getParameter("item_id") );//����
String plan_date = getStr( request.getParameter("plan_date") );//����
String tax_type_invoice = getStr( request.getParameter("tax_type_invoice") );//����

int flag = 0;

String sqlstr = "Update contract_fund_fund_charge_plan_temp set plan_date='"+plan_date+"',tax_type_invoice='"+tax_type_invoice+"' where id='"+item_id+"'";

flag=db.executeUpdate(sqlstr);
	
if(flag>0){
%>
    <script type="text/javascript">
		opener.alert("�޸��ʽ�ƻ� [�ո�����] �ɹ�!");	
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%
}else{
%>
    <script type="text/javascript">
		opener.alert("�޸��ʽ�ƻ� [�ո�����] ʧ��!");	
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%	
}
%>
</body></html>
<%if(null != db){db.close();}%>