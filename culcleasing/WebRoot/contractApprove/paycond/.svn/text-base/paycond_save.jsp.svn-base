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
	//新增资金计划
//===========================================
	
//获取基础参数
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );

//获取资金计划数据参数
String id = getStr( request.getParameter("make_contract_id") );
String pay_way = getStr( request.getParameter("pay_way") );//款项方式
String fee_type = getStr( request.getParameter("fee_type") );//款项内容
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
String tax_type_invoice=getStr(request.getParameter("tax_type_invoice"));


//基本变量
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
ResultSet rs = null;
 
//1查询交易结构临时表的资金计划
sqlstr = "select currency,equip_amt,first_payment,caution_money,handling_charge,management_fee,nominalprice,return_amt,before_interest,";
sqlstr+= "rate_subsidy,discount_rate,other_income,other_expenditure,consulting_fee_in,consulting_fee_out,insure_money,rent_start_date";
sqlstr+= " from contract_condition_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";
/* 
名称	收支情况
1-设备金额	支  equip_amt 1
2-首付款   	收  first_payment
3-租赁保证金	收  caution_money
4-租赁手续费	收  handling_charge
5-管理费	    收  management_fee
6-残值收入	收  nominalprice
7-厂商返利	收  return_amt
8-租前息	    收  before_interest
9-利息补贴	收  rate_subsidy

10-贴现息   	支  discount_rate 1
11-其他收入	收  other_income

12-其他支出	支  other_expenditure 1
13-咨询费收入	收  consulting_fee_in
14-咨询费支出	支  consulting_fee_out 1

15-保费金额	支  insure_money 1
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

rs = db.executeQuery(sqlstr);
if(rs.next()){//查询数据
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
}
rs.close();

//-=============2判断资金计划的金额是否超出商务条件金额-=======================
//2.1先查询出已经生产资金计划的金额
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
//2.2判断金额是否超出
int outFlag = 0;
String fee_type_name = "";
String cond_plan_money = "";


if("11".equals(fee_type)){//判断首付款是否超出
	fee_type_name = "首付款";
	cond_plan_money = first_payment;
}else if("13".equals(fee_type)){//厂商返利
	fee_type_name = "厂商返利";
	cond_plan_money = return_amt;
}else if("14".equals(fee_type)){//手续费
	fee_type_name = "手续费";
	cond_plan_money = handling_charge;
}else if("15".equals(fee_type)){//保证金
	fee_type_name = "保证金";
	cond_plan_money = caution_money;
}else if("16".equals(fee_type)){//管理费
	fee_type_name = "管理费";
	cond_plan_money = management_fee;
}else if("17".equals(fee_type)){//设备款
	fee_type_name = "设备款";
	cond_plan_money = equip_amt;
}else if("18".equals(fee_type)){//咨询费支出
	fee_type_name = "咨询费支出";
	cond_plan_money = consulting_fee_out;
}else if("19".equals(fee_type)){//留购价款
	fee_type_name = "留购价款";
	cond_plan_money = "无商务条件";
}else if("20".equals(fee_type)){//其他收入
	fee_type_name = "其他收入";
	cond_plan_money = other_income;
}else if("21".equals(fee_type)){//其他支出
	fee_type_name = "其他支出";
	cond_plan_money = other_expenditure;
}else if("22".equals(fee_type)){//租前息
	fee_type_name = "其他支出";
	cond_plan_money = before_interest;
}else if("23".equals(fee_type)){//残值收入
	fee_type_name = "残值收入";
	cond_plan_money = nominalprice;
}else if("24".equals(fee_type)){//贴现息
	fee_type_name = "贴现息";
	cond_plan_money = discount_rate;
}else if("25".equals(fee_type)){//咨询费收入
	fee_type_name = "咨询费收入";
	cond_plan_money = consulting_fee_in;
}else if("26".equals(fee_type)){//保费金额
	fee_type_name = "保费金额";
	cond_plan_money = "9999999999";
	//cond_plan_money = insure_money;
}else if("27".equals(fee_type)){//利息补贴
	fee_type_name = "利息补贴";
	cond_plan_money = "9999999999";
	//cond_plan_money = rate_subsidy;
}else if("30".equals(fee_type)){//利息补贴
	fee_type_name = "退款保证金";
	cond_plan_money = caution_money;
}else{
	fee_type_name = "资金款项";
	cond_plan_money = "9999999999";
}
	

if( !"".equals(fee_type_name) && !"".equals(cond_plan_money) ){
	//System.out.println(Double.parseDouble(first_payment)+"___"+alCalMoney+"___"+plan_money);
	if( Double.parseDouble(cond_plan_money) - alCalMoney - Double.parseDouble(plan_money) <0 ){//超出
		//System.out.println("超出了!");
		outFlag = 1;
	}
}else{
	outFlag = 0;
}

//2.3插入资金计划
if(outFlag==0){//没有超出则插入数据库
	sqlstr = "insert into contract_fund_fund_charge_plan_temp(make_contract_id,payment_id,doc_id,contract_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,curr_plan_money,plan_money,currency,pay_obj,";
	sqlstr+=" pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,tax_type_invoice,creator,create_date,modificator,modify_date)";
	// 付款 -- 设备款
	sqlstr+=" select '"+id+"','"+CommonTool.getUUID()+"','"+doc_id+"','"+contract_id+"','"+pay_type+"','"+fee_type+"','"+fee_name+"','"+(fee_num+1)+"','"+plan_date+"','未核销','"+plan_money+"','"+plan_money+"','"+currency+"','"+pay_obj+"',";
	sqlstr+="'"+pay_bank_name+"','"+pay_bank_no+"','"+plan_bank_name+"','"+plan_bank_no+"','"+pay_way+"','"+fpnote+"','"+tax_type_invoice+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
	flag = db.executeUpdate(sqlstr);
	LogWriter.logDebug(request, "插入新的资金计划款项名称："+fee_type_name+" 款项金额："+plan_money+"___"+sqlstr);
	
	String sqlLog = LogWriter.getSqlIntoDB(request, "签约审批", "资金计划", "插入新的资金计划款项名称："+fee_type_name+" 款项金额："+plan_money, sqlstr.substring(0,20));
	db.executeUpdate(sqlLog);
}

db.close();

//3返回判断
if(outFlag==1){
%>
	<script type="text/javascript">
		opener.alert("金额超出商务条件设定金额，<%=fee_type_name %>商务条件金额：<%=CurrencyUtil.convertFinance(cond_plan_money) %>，资金计划已使用：<%=CurrencyUtil.convertFinance(alCalMoney) %>");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%			
}else{
	if(flag>0){%>
	<script type="text/javascript">
		opener.alert("新增资金计划 [<%=fee_type_name %>] 生成成功!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>	
	<%}else{
%>
	<script type="text/javascript">
		opener.alert("新增资金计划  [<%=fee_type_name %>]  生成失败!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}	
	</script>
<%}} %>
</BODY>
</HTML>
