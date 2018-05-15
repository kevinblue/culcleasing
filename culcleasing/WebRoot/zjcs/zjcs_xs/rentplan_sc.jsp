<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<%@ page import="com.rent.*" %> 
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

String doc_id = getStr( request.getParameter("doc_id") );
String contract_id = getStr( request.getParameter("contract_id") );
String []rent_adjust_arr = request.getParameterValues("rent_adjust");

String sqlstr;
ResultSet rs;

String year_rate="";
String lease_money="";
String start_date="";
String income_number="";
String lease_interval="";
String period_type="";

String caution_money="";
String supervision_fee="";
String nominalprice="";

String rent_adjust="";
List l_rent_adjust=new ArrayList();
for (int i=0;i<rent_adjust_arr.length;i++){
	l_rent_adjust.add(rent_adjust_arr[i]);
}
sqlstr="select * from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	year_rate=getDBStr(rs.getString("year_rate"));
	lease_money=getDBStr(rs.getString("lease_money"));
	start_date=getDBDateStr(rs.getString("start_date"));
	income_number=getDBStr(rs.getString("income_number"));
	lease_interval=getDBStr(rs.getString("income_number_year"));
	period_type=getDBStr(rs.getString("period_type"));
	
	caution_money=getDBStr(rs.getString("caution_money"));
	supervision_fee=getDBStr(rs.getString("supervision_fee"));
	nominalprice=getDBStr(rs.getString("nominalprice"));
}rs.close();


List l_plan_date = new ArrayList();
List l_rent = new ArrayList();
List l_corpus = new ArrayList();
List l_interest = new ArrayList();
List l_corpus_overage = new ArrayList();

HcRent rent_hm = new HcRent(year_rate, income_number, lease_money,
			lease_interval, start_date, period_type, l_rent_adjust);

HashMap hm=rent_hm.getPlan();
l_plan_date=(List)hm.get("plan_date");
l_rent=(List)hm.get("rent");
l_corpus=(List)hm.get("corpus");
l_interest=(List)hm.get("interest");
l_corpus_overage=(List)hm.get("corpus_overage");

//irr
String irr="0";
String lease_money_irr=""+(Double.parseDouble(lease_money)-Double.parseDouble(caution_money)-Double.parseDouble(supervision_fee)-Double.parseDouble(nominalprice));
System.out.println("lease_money_irr====="+lease_money_irr);
Irr i_rr = new Irr();
irr=i_rr.getIRR(i_rr.getCashFlow(l_plan_date,l_rent,period_type,lease_interval,lease_money_irr));
irr=Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(irr)*100));
sqlstr="update contract_condition_temp set irr="+irr+" where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
//直线法利息
List l_straight_interest = new ArrayList();
l_straight_interest=Tools.getStInterest(l_interest);

sqlstr="delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
for(int i=0;i<l_rent.size();i++){
	rent_adjust=(String)l_rent_adjust.get(i);
	if(rent_adjust.equals("")){
		sqlstr="insert into fund_rent_plan_temp(measure_id,contract_id,straight_interest,rent_list,plan_date,plan_status,rent,corpus,interest,corpus_overage,year_rate) select '"+doc_id+"','"+contract_id+"',"+l_straight_interest.get(i)+","+(i+1)+",'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+l_corpus.get(i)+","+l_interest.get(i)+","+l_corpus_overage.get(i)+","+year_rate;
	}else{
		sqlstr="insert into fund_rent_plan_temp(measure_id,contract_id,straight_interest,rent_adjust,rent_list,plan_date,plan_status,rent,corpus,interest,corpus_overage,year_rate) select '"+doc_id+"','"+contract_id+"',"+l_straight_interest.get(i)+","+l_rent_adjust.get(i)+","+(i+1)+",'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+l_corpus.get(i)+","+l_interest.get(i)+","+l_corpus_overage.get(i)+","+year_rate;
	}
	
	//System.out.println("sqlstr2====="+sqlstr);
	db.executeUpdate(sqlstr);
}

db.close();

%>
<script>
			window.close();
			opener.alert("成功!");
			opener.parent.location.reload();
		</script>