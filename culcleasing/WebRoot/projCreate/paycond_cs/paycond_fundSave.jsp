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
	//�����ʽ�ƻ�
//===========================================
	
//��ȡ��������
String type = getStr( request.getParameter("type") );
String item_id = getStr( request.getParameter("item_id") );
String doc_id = getStr( request.getParameter("doc_id") );

//��������
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//��ǰ��½��
String datestr = getSystemDate(0); //��ȡϵͳʱ��

int flag = 0;
String msg = "";
 
if("del".equals(type)){//ɾ�����ʽ�ƻ�
	//2.1��ɾ���ʽ�ƻ�����ǰ������
	sqlstr = "delete from proj_fund_fund_charge_condition_temp where doc_id='doc_id' and payment_id='"+item_id+"'";
	db.executeUpdate(sqlstr);

	//2.2��ɾ���ʽ�ƻ�����
	sqlstr = "delete from proj_fund_fund_charge_plan_temp where measure_id='"+doc_id+"' and payment_id='"+item_id+"'";
	flag = db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "ɾ���ʽ�ƻ����");
	
	msg = "ɾ���ʽ�ƻ�";
}

//3�����ж�
if(flag>0){%>
<script type="text/javascript">
	window.close();
	opener.alert("<%=msg %>�ɹ�!");
	opener.location.reload();
</script>	
<%}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("<%=msg %>ʧ��!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
<%if(null != db){db.close();}%>