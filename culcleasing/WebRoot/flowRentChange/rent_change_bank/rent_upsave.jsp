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
	//�޸��ʽ�ƻ�
//===========================================
	
//��ȡ��������

String item_id = getStr( request.getParameter("item_id") );//����

//��ȡ�ʽ�ƻ����ݲ���

String plan_bank_name = getStr( request.getParameter("plan_bank_name") );
String plan_bank_no = getStr( request.getParameter("plan_bank_no") );
//�����Ƿ���
String factoring = getStr( request.getParameter("factoring") );
//��������
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//��ǰ��½��
String datestr = getSystemDate(0); //��ȡϵͳʱ��

int flag = 0;
	sqlstr = "update fund_rent_plan_temp set plan_bank_name='"+plan_bank_name+"',plan_bank_no='"+plan_bank_no+"',factoring='"+factoring+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+item_id+"'";
	
	flag = db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "�޸����ƻ��ƻ��տ����У�"+plan_bank_name+" �ƻ��տ������˺�"+plan_bank_no);


db.close();

//3�����ж�
	if(flag>0){%>
	<script type="text/javascript">
		opener.alert("�޸����ƻ��ɹ�!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>	
	<%}else{%>
	<script type="text/javascript">
		opener.alert("�޸����ƻ�ʧ��!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%} %>
</BODY>
</HTML>
