<%@ page contentType="text/html; charset=gbk" language="java"
	errorPage="/public/pageError.jsp"%>

<%@ page import="java.sql.*"%>
<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.util.CommonTool"%>
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
String contract_id = getStr( request.getParameter("contract_id") );
//�ʽ�ƻ�����
String pay_way = getStr( request.getParameter("pay_way") );//���ʽ
String fee_type = getStr( request.getParameter("fee_type") );//��������
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
String msg = "";
ResultSet rs = null;

 
if("del".equals(type)){//ɾ�����ʽ�ƻ�
	//2.2ɾ���ʽ�ƻ�����
	sqlstr = "delete from contract_fund_fund_charge_plan_bxf where payment_id='"+item_id+"'";
	flag = db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "ɾ�����Ѽƻ����");
	
	msg = "ɾ�����Ѽƻ�";
}
if("add".equals(type)){
	
	
	int fee_num = 0;
	sqlstr = "select max(fee_num) as fee_num from contract_fund_fund_charge_plan_bxf";
	sqlstr+= " where contract_id='"+contract_id+"' and id<>'"+item_id+"' and fee_type='"+fee_type+"'";
	rs = db.executeQuery(sqlstr);
	if(rs.next()){
		fee_num = rs.getInt("fee_num");
	}
	rs.close();
	//2.3�����ʽ�ƻ�
		sqlstr = "insert into contract_fund_fund_charge_plan_bxf(payment_id,make_contract_id,"+
		"contract_id,pay_type,fee_type,fee_name,fee_num,plan_date,zk_money,curr_plan_money,plan_money,plan_status,"+
		"currency,pay_obj,pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,"+
		"creator,create_date,modificator,modify_date)";
		// ���� -- �豸��
		sqlstr+=" select '"+CommonTool.getUUID()+"','','"+contract_id+"','"+pay_type+"','"+fee_type+"','"+fee_name+"','"+(fee_num+1)+"','"+plan_date+"',0,"+
		"'"+plan_money+"','"+plan_money+"','δ����','"+currency+"','"+pay_obj+"',";
		sqlstr+=" '"+pay_bank_name+"','"+pay_bank_no+"','"+plan_bank_name+"','"+plan_bank_no+"','"+pay_way+"','"+fpnote+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
		flag = db.executeUpdate(sqlstr);
		
		msg = "�������Ѽƻ�";
	
	db.close();
	
}

//3�����ж�
if(flag>0){%>
		<script type="text/javascript">
		window.opener.alert("<%=msg%>�ɹ�!");
		window.opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
</script>
		<%
			} else {
		%>
		<script type="text/javascript">
		window.opener.alert("<%=msg%>ʧ��!");
		window.opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}	
	</script>
		<%
		}
		%>
	</BODY>
</HTML>