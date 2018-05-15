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
	
//获取基础参数
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String item_id = getStr( request.getParameter("item_id") );//主键

//获取资金计划数据参数
String id=getStr( request.getParameter("make_contract_id") );
String pay_way = getStr( request.getParameter("pay_way") );//款项方式
String fee_type = getStr( request.getParameter("fee_type") );//款项内容
String fee_name = getStr( request.getParameter("fee_name") );//款项名称
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

//基本变量
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
ResultSet rs = null;
 
//1查询交易结构临时表的资金计划
sqlstr = "select before_interest  from contract_condition_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";
/* 
名称	收支情况
1-设备金额	支  equip_amt
2-首付款   	收  first_payment
3-租赁保证金	收  caution_money
4-租赁手续费	收  handling_charge
5-管理费	    收  management_fee
6-残值收入	收  nominalprice
7-厂商返利	收  return_amt
8-租前息	    收  before_interest
9-利息补贴	收  rate_subsidy

10-贴现息   	支  discount_rate
11-其他收入	收  other_income

12-其他支出	支  other_expenditure
13-咨询费收入	收  consulting_fee_in
14-咨询费支出	支  consulting_fee_out

15-保费金额	支  insure_money
*/
//--定义资金参数--

String before_interest = "";


rs = db.executeQuery(sqlstr);
if(rs.next()){//查询数据
	before_interest = getDBStr(rs.getString("before_interest"));
}
rs.close();

//-=============2判断资金计划的金额是否超出商务条件金额-=======================
//2.1先查询出已经生产资金计划的金额
double alCalMoney = 0;
sqlstr = "select sum(isnull(plan_money,0)) as alCalMoney from contract_fund_fund_charge_plan_temp";
sqlstr+= " where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and fee_type='"+fee_type+"' and id<>'"+item_id+"' ";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	alCalMoney = rs.getDouble("alCalMoney");
}
rs.close();
//2.2判断金额是否超出
int outFlag = 0;
String fee_type_name = "";
String cond_plan_money = "";

if("22".equals(fee_type)){//租前息
	fee_type_name = "其他支出";
	cond_plan_money = before_interest;
}

if( !"".equals(fee_type_name) && !"".equals(cond_plan_money) ){
	//System.out.println(Double.parseDouble(first_payment)+"___"+alCalMoney+"___"+plan_money);
	System.out.println(Double.parseDouble(cond_plan_money)+"___"+alCalMoney+"___"+plan_money);
	if( Double.parseDouble(cond_plan_money) - alCalMoney - Double.parseDouble(plan_money) <0 ){//超出
		//System.out.println("超出了!");
		outFlag = 1;
	}
}else{
	outFlag = 0;
}

//2.3插入资金计划
if(outFlag==0){//没有超出则插入数据库

	sqlstr = "update contract_fund_fund_charge_plan_temp set make_contract_id='"+id+"',fee_name='"+fee_name+"',pay_obj='"+pay_obj+"',plan_date='"+plan_date+"',curr_plan_money='"+plan_money+"',plan_money='"+plan_money+"',currency='"+currency+"',pay_bank_name='"+pay_bank_name+"',pay_bank_no='"+pay_bank_no+"',";
	sqlstr +="plan_bank_name='"+plan_bank_name+"',plan_bank_no='"+plan_bank_no+"',pay_type='"+pay_type+"',fpnote='"+fpnote+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+item_id+"'";
	
	flag = db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "修改资金计划款项名称："+fee_type_name+" 款项金额："+plan_money);
}

db.close();

//3返回判断
if(outFlag==1){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("金额超出商务条件设定金额，<%=fee_type_name %>商务条件金额：<%=CurrencyUtil.convertFinance(cond_plan_money) %>，资金计划已使用：<%=CurrencyUtil.convertFinance(alCalMoney) %>");
		opener.location.reload();
	</script>
<%			
}else{
	if(flag>0){%>
	<script type="text/javascript">
		window.close();
		opener.alert("修改资金计划 [<%=fee_type_name %>] 成功!");
		opener.location.reload();
	</script>	
	<%}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("修改资金计划  [<%=fee_type_name %>] 失败!");
		opener.location.reload();
	</script>
<%}} %>
</BODY>
</HTML>
