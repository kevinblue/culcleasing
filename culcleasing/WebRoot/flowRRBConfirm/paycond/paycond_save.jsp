<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
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
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );
//��ȡ�ʽ�ƻ����ݲ���
String id=getStr( request.getParameter("make_contract_id") );
String pay_way = getStr( request.getParameter("pay_way") );//���ʽ
String fee_type = getStr( request.getParameter("fee_type") );//��������
String fee_name = getStr( request.getParameter("fee_name") );
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
ResultSet rs = null;
 
//1��ѯ���׽ṹ��ʱ�����ʽ�ƻ�
sqlstr = "select before_interest from contract_condition_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";
/* 
����	��֧���
1-�豸���	֧  equip_amt 1
2-�׸���   	��  first_payment
3-���ޱ�֤��	��  caution_money
4-����������	��  handling_charge
5-������	    ��  management_fee
6-��ֵ����	��  nominalprice
7-���̷���	��  return_amt
8-��ǰϢ	    ��  before_interest
9-��Ϣ����	��  rate_subsidy

10-����Ϣ   	֧  discount_rate 1
11-��������	��  other_income

12-����֧��	֧  other_expenditure 1
13-��ѯ������	��  consulting_fee_in
14-��ѯ��֧��	֧  consulting_fee_out 1

15-���ѽ��	֧  insure_money 1
*/
//--�����ʽ����--
String before_interest = "";

rs = db.executeQuery(sqlstr);
if(rs.next()){//��ѯ����
	before_interest = getDBStr(rs.getString("before_interest"));
}
rs.close();

//-=============2�ж��ʽ�ƻ��Ľ���Ƿ񳬳������������-=======================
//2.1�Ȳ�ѯ���Ѿ������ʽ�ƻ��Ľ��
double alCalMoney = 0;
int fee_num = 0;
sqlstr = "select sum(isnull(plan_money,0)) as alCalMoney,count(fee_num) as fee_num from contract_fund_fund_charge_plan_temp";
sqlstr+= " where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and fee_type='"+fee_type+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	alCalMoney = rs.getDouble("alCalMoney");
	fee_num = rs.getInt("fee_num");
}
rs.close();
//2.2�жϽ���Ƿ񳬳�
int outFlag = 0;
String fee_type_name = "";
String cond_plan_money = "";


if("22".equals(fee_type)){//��ǰϢ
	fee_type_name = "��ǰϢ";
	cond_plan_money = before_interest;
}

if( !"".equals(fee_type_name) && !"".equals(cond_plan_money) ){
	//System.out.println(Double.parseDouble(first_payment)+"___"+alCalMoney+"___"+plan_money);
	if( Double.parseDouble(cond_plan_money) - alCalMoney - Double.parseDouble(plan_money) < 0 ){//����
		//System.out.println("������!");
		outFlag = 1;
	}
}else{
	outFlag = 0;
}

//2.3�����ʽ�ƻ�
if(outFlag==0){//û�г�����������ݿ�
	sqlstr = "insert into contract_fund_fund_charge_plan_temp(make_contract_id,payment_id,doc_id,contract_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,curr_plan_money,plan_money,currency,pay_obj,";
	sqlstr+=" pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)";
	// ���� -- �豸��
	sqlstr+=" select '"+id+"','"+CommonTool.getUUID()+"','"+doc_id+"','"+contract_id+"','"+pay_type+"','"+fee_type+"','"+fee_name+"','"+(fee_num+1)+"','"+plan_date+"','δ����','"+plan_money+"','"+plan_money+"','"+currency+"','"+pay_obj+"',";
	sqlstr+=" '"+pay_bank_name+"','"+pay_bank_no+"','"+plan_bank_name+"','"+plan_bank_no+"','"+pay_way+"','"+fpnote+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
	flag = db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "�����µ��ʽ�ƻ��������ƣ�"+fee_type_name+" �����"+plan_money+"___"+sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "ǩԼ����", "�ʽ�ƻ�", "�����µ��ʽ�ƻ��������ƣ�"+fee_type_name+" �����"+plan_money, sqlstr.substring(0,20));
	db.executeUpdate(sqlLog);
}

db.close();

//3�����ж�
if(outFlag==1){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("�������������趨��<%=fee_type_name %>����������<%=CurrencyUtil.convertFinance(cond_plan_money) %>���ʽ�ƻ���ʹ�ã�<%=CurrencyUtil.convertFinance(alCalMoney) %>");
		opener.location.reload();
	</script>
<%			
}else{
	if(flag>0){%>
	<script type="text/javascript">
		window.close();
		opener.alert("�����ʽ�ƻ� [<%=fee_type_name %>] ���ɳɹ�!");
		opener.location.reload();
	</script>	
	<%}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("�����ʽ�ƻ�  [<%=fee_type_name %>]  ����ʧ��!");
		opener.location.reload();
	</script>
<%}} %>
</BODY>
</HTML>