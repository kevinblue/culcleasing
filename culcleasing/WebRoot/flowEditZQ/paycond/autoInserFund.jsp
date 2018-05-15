<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
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
	//自动生成资金计划
//===========================================
	

//获取参数
String proj_id = getStr( request.getParameter("proj_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String cust_id = getStr( request.getParameter("cust_id") );

String sqlstr="";
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
ResultSet rs = null;
 
//1查询交易结构临时表的资金计划
sqlstr = "select currency,equip_amt,first_payment,caution_money,handling_charge,management_fee,nominalprice,return_amt,before_interest,";
sqlstr+= "rate_subsidy,discount_rate,other_income,other_expenditure,consulting_fee_in,consulting_fee_out,insure_money,rent_start_date";
sqlstr+= " from proj_condition_temp where proj_id='"+proj_id+"' and doc_id='"+doc_id+"'";
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
String equip_amt = "";
String first_payment = "";
String caution_money = "";
String handling_charge = "";
String management_fee = "";
String nominalprice = "";
String return_amt = "";
String before_interest = "";
String rate_subsidy = "";
String discount_rate = "";
String other_income = "";
String other_expenditure = "";
String consulting_fee_in = "";
String consulting_fee_out = "";
String insure_money = "";
String currency = "";
String rent_start_date = "";

rs = db.executeQuery(sqlstr);
if(rs.next()){//查询数据
	currency = getDBStr(rs.getString("currency"));
	equip_amt = getDBStr(rs.getString("equip_amt"));
	first_payment = getDBStr(rs.getString("first_payment"));
	caution_money = getDBStr(rs.getString("caution_money"));
	handling_charge = getDBStr(rs.getString("handling_charge"));
	management_fee = getDBStr(rs.getString("management_fee"));
	nominalprice = getDBStr(rs.getString("nominalprice"));
	return_amt = getDBStr(rs.getString("return_amt"));
	before_interest = getDBStr(rs.getString("before_interest"));
	rate_subsidy = getDBStr(rs.getString("rate_subsidy"));
	discount_rate = getDBStr(rs.getString("discount_rate"));
	other_income = getDBStr(rs.getString("other_income"));
	other_expenditure = getDBStr(rs.getString("other_expenditure"));
	consulting_fee_in = getDBStr(rs.getString("consulting_fee_in"));
	consulting_fee_out = getDBStr(rs.getString("consulting_fee_out"));
	insure_money = getDBStr(rs.getString("insure_money"));
	rent_start_date = getDBDateStr(rs.getString("rent_start_date"));
}else{
	flag = -1;
}
rs.close();

if(flag ==0 ){

//2插入proj_fund_fund_charge_plan_temp 项目资金计划临时表
//2.1先删除资金计划付款前提数据
sqlstr = "delete from proj_fund_fund_charge_condition_temp where doc_id='"+doc_id+"' and payment_id in(select payment_id from proj_fund_fund_charge_plan_temp ";
sqlstr +=" where proj_id='"+proj_id+"' and measure_id='"+doc_id+"')";
db.executeUpdate(sqlstr);

//2.2先删除资金计划数据
sqlstr = "delete from proj_fund_fund_charge_plan_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
LogWriter.logDebug(request, "删除资金计划完成");

//2.3插入新的资金计划
//payment_id,measure_id,proj_id,pay_type,fee_type,fee_num,plan_date,plan_money,currency,pay_obj,pay_bank_name,pay_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date

sqlstr = "insert into proj_fund_fund_charge_plan_temp(payment_id,measure_id,proj_id,pay_type,fee_type,fee_num,fee_name,plan_date,plan_status,curr_plan_money,plan_money,currency,pay_obj,";
sqlstr+=" pay_bank_name,pay_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)";
// 付款 -- 设备款
sqlstr+=" select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'17','1','设备款',null,'未核销','"+equip_amt+"','"+equip_amt+"','"+currency+"',null,";
sqlstr+=" null,null,'付款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
// 付款 -- 10-贴现息   	支  discount_rate
if(!"".equals(discount_rate) && discount_rate!=null && !"0".equals(discount_rate) && !"0.00".equals(discount_rate)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'24','1','贴现息',null,'未核销','"+discount_rate+"','"+discount_rate+"','"+currency+"',null,";
	sqlstr+=" null,null,'付款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
} 
// 付款 -- 12-其他支出	支  other_expenditure
if(!"".equals(other_expenditure) && other_expenditure!=null && !"0".equals(other_expenditure) && !"0.00".equals(other_expenditure)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'21','1','其他支出',null,'未核销','"+other_expenditure+"','"+other_expenditure+"','"+currency+"',null,";
	sqlstr+=" null,null,'付款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
// 付款 -- 14-咨询费支出	支  consulting_fee_out
if(!"".equals(consulting_fee_out) && consulting_fee_out!=null && !"0".equals(consulting_fee_out) && !"0.00".equals(consulting_fee_out)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'18','1','咨询费支出',null,'未核销','"+consulting_fee_out+"','"+consulting_fee_out+"','"+currency+"',null,";
	sqlstr+=" null,null,'付款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
// 付款 -- 15-保费金额	支  insure_money
//if(!"".equals(insure_money) && insure_money!=null && !"0".equals(insure_money) && !"0.00".equals(insure_money)){
	//sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'26','1','保费金额',null,'未核销','"+insure_money+"','"+insure_money+"','"+currency+"',null,";
	//sqlstr+=" null,null,'付款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
//}

// 收款 -- 2-首付款   	收  first_payment
if(!"".equals(caution_money) && caution_money!=null && !"0".equals(caution_money)  && !"0.00".equals(caution_money)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'11','1','首付款','"+rent_start_date+"','未核销','"+first_payment+"','"+first_payment+"','"+currency+"','"+cust_id+"',";
	sqlstr+=" null,null,'收款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
// 收款 -- 3-租赁保证金	收  caution_money
if(!"".equals(caution_money) && caution_money!=null && !"0".equals(caution_money)  && !"0.00".equals(caution_money)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'15','1','租赁保证金','"+rent_start_date+"','未核销','"+caution_money+"','"+caution_money+"','"+currency+"','"+cust_id+"',";
	sqlstr+=" null,null,'收款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
	
	//生成一笔保证金支付 30 
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'30','1','退款保证金',null,'未核销','"+caution_money+"','"+caution_money+"','"+currency+"','"+cust_id+"',";
	sqlstr+=" null,null,'付款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
// 收款 -- 4-租赁手续费	收  handling_charge
if(!"".equals(handling_charge) && handling_charge!=null && !"0".equals(handling_charge) && !"0.00".equals(handling_charge)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'14','1','租赁手续费','"+rent_start_date+"','未核销','"+handling_charge+"','"+handling_charge+"','"+currency+"','"+cust_id+"',";
	sqlstr+=" null,null,'收款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
// 收款 -- 5-管理费	    收  management_fee
if(!"".equals(management_fee) && management_fee!=null && !"0".equals(management_fee) && !"0.00".equals(management_fee)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'16','1','管理费','"+rent_start_date+"','未核销','"+management_fee+"','"+management_fee+"','"+currency+"','"+cust_id+"',";
	sqlstr+=" null,null,'收款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
// 收款 -- 6-残值收入	收  nominalprice
if(!"".equals(nominalprice) && nominalprice!=null && !"0".equals(nominalprice) && !"0.00".equals(nominalprice)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'23','1','残值收入','"+rent_start_date+"','未核销','"+nominalprice+"','"+nominalprice+"','"+currency+"','"+cust_id+"',";
	sqlstr+=" null,null,'收款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
// 收款 -- 7-厂商返利	收  return_amt
if(!"".equals(return_amt) && return_amt!=null && !"0".equals(return_amt) && !"0.00".equals(return_amt)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'13','1','厂商返利','"+rent_start_date+"','未核销','"+return_amt+"','"+return_amt+"','"+currency+"','"+cust_id+"',";
	sqlstr+=" null,null,'收款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
// 收款 -- 8-租前息	收  before_interest
if(!"".equals(before_interest) && before_interest!=null && !"0".equals(before_interest) && !"0.00".equals(before_interest)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'22','1','租前息','"+rent_start_date+"','未核销','"+before_interest+"','"+before_interest+"','"+currency+"','"+cust_id+"',";
	sqlstr+=" null,null,'收款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
// 收款 -- 9-利息补贴	收  rate_subsidy
if(!"".equals(rate_subsidy) && rate_subsidy!=null && !"0".equals(rate_subsidy) && !"0.00".equals(rate_subsidy)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'27','1','利息补贴','"+rent_start_date+"','未核销','"+rate_subsidy+"','"+rate_subsidy+"','"+currency+"','"+cust_id+"',";
	sqlstr+=" null,null,'收款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
// 收款 -- 11-其他收入	收  other_income
if(!"".equals(other_income) && other_income!=null && !"0".equals(other_income) && !"0.00".equals(other_income)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'20','1','其他收入','"+rent_start_date+"','未核销','"+other_income+"','"+other_income+"','"+currency+"','"+cust_id+"',";
	sqlstr+=" null,null,'收款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
// 收款 -- 13-咨询费收入	收  consulting_fee_in
if(!"".equals(consulting_fee_in) && consulting_fee_in!=null && !"0".equals(consulting_fee_in) && !"0.00".equals(consulting_fee_in)){
	sqlstr+=" union select '"+CommonTool.getUUID()+"','"+doc_id+"','"+proj_id+"',null,'25','1','咨询费收入','"+rent_start_date+"','未核销','"+consulting_fee_in+"','"+consulting_fee_in+"','"+currency+"','"+cust_id+"',";
	sqlstr+=" null,null,'收款',null,'"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
}
LogWriter.logDebug(request, "插入新的资金计划"+sqlstr);

flag = db.executeUpdate(sqlstr);

LogWriter.logDebug(request, "自动生成项目的资金计划，项目编号："+proj_id);

String sqlLog = LogWriter.getSqlIntoDB(request, "项目立项", "资金计划", "自动生成项目："+proj_id+" 资金计划数据", sqlstr.substring(0,20));
db.executeUpdate(sqlLog);
}
db.close();

//3返回
if (flag == -1){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("商务条件未确定，不能自动生成资金计划!");
		opener.location.reload();
	</script>
<%	
}else if(flag>0){
%>
	<script type="text/javascript">
		window.close();
		opener.alert("资金计划生成成功!");
		opener.location.reload();
	</script>
<%			
}else{
%>
	<script type="text/javascript">
		window.close();
		opener.alert("资金计划生成失败!");
		opener.location.reload();
	</script>
<%} %>
</BODY>
</HTML>
