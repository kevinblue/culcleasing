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
String contract_id = getStr( request.getParameter("contract_id") );
String item_id = getStr( request.getParameter("item_id") );//����

//��ȡ�ʽ�ƻ����ݲ���
String fee_type = getStr( request.getParameter("fee_type") );//��������
System.out.println("���"+fee_type);
String fee_name = getStr( request.getParameter("fee_name") );//��������
String pay_obj = getStr( request.getParameter("pay_obj") );
String pay_bank_name = getStr( request.getParameter("pay_bank_name") );
String pay_bank_no = getStr( request.getParameter("pay_bank_no") );
String plan_bank_name = getStr( request.getParameter("plan_bank_name") );
String plan_bank_no = getStr( request.getParameter("plan_bank_no") );
String plan_date = getStr( request.getParameter("plan_date") );
String currency = getStr( request.getParameter("currency") );
String plan_money = getStr( request.getParameter("plan_money") );
String pay_type = getStr( request.getParameter("pay_type") );
String fpnote = getStr( request.getParameter("fpnote") );

//��������
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//��ǰ��½��
String datestr = getSystemDate(0); //��ȡϵͳʱ��

int flag = 0;

//2.3�޸��ʽ�ƻ�

	sqlstr = "update contract_fund_fund_charge_plan_bxf set fee_name='"+fee_name+"',pay_obj='"+pay_obj+"',plan_date='"+plan_date+"'"+
	",curr_plan_money='"+plan_money+"',plan_money='"+plan_money+"',currency='"+currency+"',pay_bank_name='"+pay_bank_name+"'"+
	",pay_bank_no='"+pay_bank_no+"',";
	sqlstr +="plan_bank_name='"+plan_bank_name+"',plan_bank_no='"+plan_bank_no+"'"+
	",fee_type='"+fee_type+"',pay_type='"+pay_type+"',fpnote='"+fpnote+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+item_id+"'";
	
	flag = db.executeUpdate(sqlstr);

db.close();

//3�����ж�

	if(flag>0){%>
	<script type="text/javascript">
		//window.close();
		opener.alert("�޸��ʽ�ƻ��ɹ�!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>	
	<%}else{
%>
	<script type="text/javascript">
		//window.close();
		opener.alert("�޸��ʽ�ƻ�ʧ��!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%} %>
</BODY>
</HTML>
