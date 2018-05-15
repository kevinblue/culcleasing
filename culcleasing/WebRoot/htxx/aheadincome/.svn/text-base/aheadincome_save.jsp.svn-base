<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
String dqczy = (String) session.getAttribute("czyid");
String curr_date = getSystemDate(0);
String stype = getStr( request.getParameter("savetype") );
String sqlstr;
ResultSet rs;




String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String applicant = getStr( request.getParameter("applicant") );
String apply_date = getStr( request.getParameter("apply_date") );

String rent_interval="";
String pay_day="";
String contract_amt="";
String first_payment="";
String lease_money="";
String received_caution_money="";
String received_handling_charge="";
String received_return="";
String received_insurance="";
String received_list="";
String received_rent="";
String received_amt="";
String undue_list="";
String undue_rent="";
String overdue_list="";
String overdue_rent="";
String overdue_penalty="";
String nominalprice="";
String risk_exposure="";

//偿还间隔,首付款,租赁本金,名义留购价
sqlstr="select case when isnull(contract_condition.income_number_year,0)=0 then '' else 12/contract_condition.income_number_year end as rent_interval,isnull(contract_condition.first_payment,0) as first_payment,isnull(contract_condition.lease_money,0) as lease_money,isnull(contract_condition.nominalprice,0) as nominalprice from contract_condition where contract_condition.contract_id='"+contract_id+"'";
System.out.println("sqlstr000=========================================="+sqlstr);
rs=db.executeQuery(sqlstr);
if(rs.next()){
	rent_interval=getDBStr( rs.getString("rent_interval"));
	first_payment=getDBStr( rs.getString("first_payment"));
	lease_money=getDBStr( rs.getString("lease_money"));
	nominalprice=getDBStr( rs.getString("nominalprice"));
}else{
	System.out.println("error is 偿还间隔,首付款,租赁本金,名义留购价");
}rs.close();
//支付日
sqlstr="select substring(convert(varchar(10),max(fund_rent_plan.plan_date),121),9,10) as pay_day from fund_rent_plan where fund_rent_plan.contract_id='"+contract_id+"' and fund_rent_plan.plan_date<='"+apply_date+"'";
System.out.println("sqlstr001=========================================="+sqlstr);
rs=db.executeQuery(sqlstr);
if(rs.next()){
	pay_day=getDBStr( rs.getString("pay_day"));
}else{
	System.out.println("error is 支付日");
}rs.close();
//合同总金额
sqlstr="select isnull(sum(fund_rent_plan.rent),0) as contract_amt from fund_rent_plan where fund_rent_plan.contract_id='"+contract_id+"'";
System.out.println("sqlstr002=========================================="+sqlstr);
rs=db.executeQuery(sqlstr);
if(rs.next()){
	contract_amt=getDBStr( rs.getString("contract_amt"));
}else{
	System.out.println("error is 合同总金额");
}rs.close();
//已收保证金,已收手续费,已收返利,已收保险费
sqlstr="select isnull(sum(case when fund_fund_charge.fee_type='108' then fund_fund_charge.fact_money else 0 end),0) as received_caution_money, isnull(sum(case when fund_fund_charge.fee_type='103' then fund_fund_charge.fact_money else 0 end),0) as received_handling_charge, isnull(sum(case when fund_fund_charge.fee_type='105' then fund_fund_charge.fact_money else 0 end),0) as received_return, isnull(sum(case when fund_fund_charge.fee_type='102' then fund_fund_charge.fact_money else 0 end),0) as received_insurance from fund_fund_charge where fund_fund_charge.contract_id='"+contract_id+"' and fund_fund_charge.fact_date<dateadd(day,1,'"+apply_date+"') and fund_fund_charge.item_method='收款'";
System.out.println("sqlstr003=========================================="+sqlstr);
rs=db.executeQuery(sqlstr);
if(rs.next()){
	received_caution_money=getDBStr( rs.getString("received_caution_money"));
	received_handling_charge=getDBStr( rs.getString("received_handling_charge"));
	received_return=getDBStr( rs.getString("received_return"));
	received_insurance=getDBStr( rs.getString("received_insurance"));
}else{
	System.out.println("error is 已收保证金,已收手续费,已收返利,已收保险费");
}rs.close();
//已支付期数,逾期期数,逾期租金,逾期罚息,风险敞口
sqlstr="select isnull(dbo.bb_hadRecNub('1970-01-01','"+apply_date+"','"+contract_id+"'),0) as received_list,isnull(dbo.bb_getBadNub('1970-01-01','"+apply_date+"','"+contract_id+"'),0) as overdue_list,isnull(dbo.bb_getBadRent('1970-01-01','"+apply_date+"','"+contract_id+"'),0) as overdue_rent,isnull(dbo.bb_getPunishInterest('1970-01-01','"+apply_date+"','"+contract_id+"'),0) as overdue_penalty,isnull(dbo.bb_getRemFxck('1970-01-01','"+apply_date+"','"+contract_id+"'),0) as risk_exposure";
System.out.println("sqlstr004=========================================="+sqlstr);
rs=db.executeQuery(sqlstr);
if(rs.next()){
	received_list=getDBStr( rs.getString("received_list"));
	overdue_list=getDBStr( rs.getString("overdue_list"));
	overdue_rent=getDBStr( rs.getString("overdue_rent"));
	overdue_penalty=getDBStr( rs.getString("overdue_penalty"));
	risk_exposure=getDBStr( rs.getString("risk_exposure"));
}else{
	System.out.println("error is 已支付期数,逾期期数,逾期租金,逾期罚息,风险敞口");
}rs.close();

//已支付租金
sqlstr="select isnull(sum(fund_rent_income.rent),0)+isnull(sum(fund_rent_income.rent_adjust),0) as received_rent from fund_rent_income where fund_rent_income.contract_id='"+contract_id+"' and fund_rent_income.hire_date<dateadd(day,1,'"+apply_date+"')";
System.out.println("sqlstr005=========================================="+sqlstr);
rs=db.executeQuery(sqlstr);
if(rs.next()){
	received_rent=getDBStr( rs.getString("received_rent"));
}else{
	System.out.println("error is 已支付租金");
}rs.close();
//已收金额
received_amt=String.valueOf(Double.parseDouble(received_caution_money)+Double.parseDouble(received_handling_charge)+Double.parseDouble(received_return)+Double.parseDouble(received_insurance)+Double.parseDouble(received_rent));
//未到期期数,未到期租金
sqlstr="select count(*) as undue_list,isnull(sum(fund_rent_plan.rent),0)-(select isnull(sum(rent),0)+isnull(sum(rent_adjust),0) from fund_rent_income where contract_id='"+contract_id+"' and plan_list in (select rent_list from fund_rent_plan where contract_id='"+contract_id+"' and plan_date>'"+apply_date+"')) as undue_rent from fund_rent_plan where fund_rent_plan.contract_id='"+contract_id+"' and fund_rent_plan.plan_date>'"+apply_date+"'";
System.out.println("sqlstr006=========================================="+sqlstr);
rs=db.executeQuery(sqlstr);
if(rs.next()){
	undue_list=getDBStr( rs.getString("undue_list"));
	undue_rent=getDBStr( rs.getString("undue_rent"));
}else{
	System.out.println("error is 未到期期数,未到期租金");
}rs.close();

String flag="";
String message="保存成功!";
sqlstr="select * from contract_ahead_repayment where doc_id='"+doc_id+"'";
System.out.println("sqlstr007=========================================="+sqlstr);
rs=db.executeQuery(sqlstr);
if(rs.next()){
	flag="1";
}rs.close();

if(flag.equals("")){
	if(pay_day.equals("")){
		sqlstr="insert into contract_ahead_repayment(doc_id,contract_id,applicant,apply_date,rent_interval,contract_amt,first_payment,lease_money,received_caution_money,received_handling_charge,received_return,received_insurance,received_list,received_rent,received_amt,undue_list,undue_rent,overdue_list,overdue_rent,overdue_penalty,nominalprice,risk_exposure) values('"+doc_id+"','"+contract_id+"','"+applicant+"','"+apply_date+"',"+rent_interval+","+contract_amt+","+first_payment+","+lease_money+","+received_caution_money+","+received_handling_charge+","+received_return+","+received_insurance+","+received_list+","+received_rent+","+received_amt+","+undue_list+","+undue_rent+","+overdue_list+","+overdue_rent+","+overdue_penalty+","+nominalprice+","+risk_exposure+")";
		System.out.println("sqlstr008=========================================="+sqlstr);
		db.executeUpdate(sqlstr);
	}else{
		sqlstr="insert into contract_ahead_repayment(doc_id,contract_id,applicant,apply_date,rent_interval,pay_day,contract_amt,first_payment,lease_money,received_caution_money,received_handling_charge,received_return,received_insurance,received_list,received_rent,received_amt,undue_list,undue_rent,overdue_list,overdue_rent,overdue_penalty,nominalprice,risk_exposure) values('"+doc_id+"','"+contract_id+"','"+applicant+"','"+apply_date+"',"+rent_interval+","+pay_day+","+contract_amt+","+first_payment+","+lease_money+","+received_caution_money+","+received_handling_charge+","+received_return+","+received_insurance+","+received_list+","+received_rent+","+received_amt+","+undue_list+","+undue_rent+","+overdue_list+","+overdue_rent+","+overdue_penalty+","+nominalprice+","+risk_exposure+")";
		System.out.println("sqlstr008=========================================="+sqlstr);
		db.executeUpdate(sqlstr);
	}
	
}else{
	if(pay_day.equals("")){
		sqlstr="update contract_ahead_repayment set applicant='"+applicant+"',apply_date='"+apply_date+"',rent_interval="+rent_interval+",contract_amt="+contract_amt +",first_payment="+first_payment +",lease_money="+lease_money +",received_caution_money="+received_caution_money +",received_handling_charge="+received_handling_charge +",received_return="+received_return +",received_insurance="+received_insurance +",received_list="+received_list +",received_rent="+received_rent +",received_amt="+received_amt +",undue_list="+undue_list +",undue_rent="+undue_rent +",overdue_list="+overdue_list +",overdue_rent="+overdue_rent +",overdue_penalty="+overdue_penalty +",nominalprice="+nominalprice +",risk_exposure="+risk_exposure+" where doc_id='"+doc_id+"'";
		System.out.println("sqlstr009=========================================="+sqlstr);
		db.executeUpdate(sqlstr);
	}else{
		sqlstr="update contract_ahead_repayment set applicant='"+applicant+"',apply_date='"+apply_date+"',rent_interval="+rent_interval+",pay_day="+pay_day+",contract_amt="+contract_amt +",first_payment="+first_payment +",lease_money="+lease_money +",received_caution_money="+received_caution_money +",received_handling_charge="+received_handling_charge +",received_return="+received_return +",received_insurance="+received_insurance +",received_list="+received_list +",received_rent="+received_rent +",received_amt="+received_amt +",undue_list="+undue_list +",undue_rent="+undue_rent +",overdue_list="+overdue_list +",overdue_rent="+overdue_rent +",overdue_penalty="+overdue_penalty +",nominalprice="+nominalprice +",risk_exposure="+risk_exposure+" where doc_id='"+doc_id+"'";
		System.out.println("sqlstr009=========================================="+sqlstr);
		db.executeUpdate(sqlstr);
	}
	
}

db.close();
%>
<script>
			window.close();
			opener.alert("<%=message%>");
			opener.location.reload();
		</script>