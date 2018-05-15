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
String apply_date = getStr( request.getParameter("apply_date") );
String discount_rate = getStr( request.getParameter("discount_rate") );

String billing_manager=getStr( request.getParameter("billing_manager") );
String billing_date=getStr( request.getParameter("billing_date") );
String effective_date=getStr( request.getParameter("effective_date") );
String caution_deduction_money=getStr( request.getParameter("caution_deduction_money") );
String other_amt=getStr( request.getParameter("other_amt") );
String rent_discount="0";
String ahead_amt="0";

List l_rent = new ArrayList();
double caution_money=Double.parseDouble(caution_deduction_money);
String mark="0";
int j=1;
//System.out.println("caution_money=============================================="+caution_money);
sqlstr="select fund_rent_plan.contract_id,fund_rent_plan.rent_list,isnull(fund_rent_plan.rent,0)-isnull(sum(fund_rent_income.rent),0)-isnull(sum(rent_adjust),0) as rent from fund_rent_plan left join fund_rent_income on fund_rent_plan.contract_id=fund_rent_income.contract_id and fund_rent_plan.rent_list=fund_rent_income.plan_list where fund_rent_plan.contract_id='"+contract_id+"' and fund_rent_plan.plan_date>='"+billing_date+"' group by fund_rent_plan.contract_id,fund_rent_plan.rent_list,fund_rent_plan.rent order by fund_rent_plan.rent_list desc";
System.out.println("sqlstr0=============================================="+sqlstr);
rs=db.executeQuery(sqlstr);
while(rs.next()){
	caution_money=caution_money-rs.getDouble("rent");
	if(mark.equals("1")){
		l_rent.add(getDBStr( rs.getString("rent")));
	}
	if(caution_money<0 && mark.equals("0")){
		l_rent.add(String.valueOf(-caution_money));
		mark="1";
	}
	
}rs.close();
System.out.println("sqlstr1=============================================="+l_rent);
for (int i=l_rent.size()-1;i>=0;i--) {
	rent_discount=String.valueOf(Double.parseDouble(rent_discount)+Double.parseDouble(l_rent.get(i).toString())/(1+j*Double.parseDouble(discount_rate)));
	j++;
}

ahead_amt=String.valueOf(Double.parseDouble(rent_discount)+Double.parseDouble(other_amt));



String flag="";
String message="保存成功!";
sqlstr="select * from contract_ahead_repayment where doc_id='"+doc_id+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	flag="1";
}rs.close();

if(flag.equals("")){
	//只做update
	//sqlstr="insert into contract_ahead_repayment(contract_id,applicant,apply_date,rent_interval,pay_day,contract_amt,first_payment,lease_money,received_caution_money,received_handling_charge,received_return,received_insurance,received_list,received_rent,received_amt,undue_list,undue_rent,overdue_list,overdue_rent,overdue_penalty,nominalprice,risk_exposure) values('"+contract_id+"','"+applicant+"','"+apply_date+"',"+rent_interval+","+pay_day+","+contract_amt+","+first_payment+","+lease_money+","+received_caution_money+","+received_handling_charge+","+received_return+","+received_insurance+","+received_list+","+received_rent+","+received_amt+","+undue_list+","+undue_rent+","+overdue_list+","+overdue_rent+","+overdue_penalty+","+nominalprice+","+risk_exposure+")";
	//db.executeUpdate(sqlstr);
}else{
	sqlstr="update contract_ahead_repayment set billing_manager='"+billing_manager+"',billing_date='"+billing_date+"',effective_date='"+effective_date+"',caution_deduction_money="+caution_deduction_money+",other_amt="+other_amt +",rent_discount="+rent_discount +",ahead_amt="+ahead_amt+" where doc_id='"+doc_id+"'";
	db.executeUpdate(sqlstr);
}

db.close();
%>
<script>
			window.close();
			opener.alert("<%=message%>");
			opener.location.reload();
		</script>