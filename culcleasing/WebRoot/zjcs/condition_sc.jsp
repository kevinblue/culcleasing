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

String equip_amt=getStr(request.getParameter("equip_amt"));
String lease_amt=getStr(request.getParameter("lease_amt"));
String first_payment_ratio=getStr(request.getParameter("first_payment_ratio"));
String first_payment=getStr(request.getParameter("first_payment"));
String lease_money=getStr(request.getParameter("lease_money"));
String insurer=getStr(request.getParameter("insurer"));
String insurance=getStr(request.getParameter("insurance"));
String insurance_flag=getStr(request.getParameter("insurance_flag"));
String lsh_insurance=getStr(request.getParameter("lsh_insurance"));
String cust_insurance=getStr(request.getParameter("cust_insurance"));
String csa_flag=getStr(request.getParameter("csa_flag"));
String csa_financing=getStr(request.getParameter("csa_financing"));
String csa_cost=getStr(request.getParameter("csa_cost"));
String csa_hours=getStr(request.getParameter("csa_hours"));
String machine_price=getStr(request.getParameter("machine_price"));
String gps_flag=getStr(request.getParameter("gps_flag"));
String gps_cost=getStr(request.getParameter("gps_cost"));
String income_number_year=getStr(request.getParameter("income_number_year"));
String start_date=getStr(request.getParameter("start_date"));
String income_number=getStr(request.getParameter("income_number"));
String lease_term=getStr(request.getParameter("lease_term"));
String income_day=getStr(request.getParameter("income_day"));
String year_rate=getStr(request.getParameter("year_rate"));
//String per_rent=getStr(request.getParameter("per_rent"));
String supervision_fee=getStr(request.getParameter("supervision_fee"));
String handling_charge=getStr(request.getParameter("handling_charge"));
String caution_money=getStr(request.getParameter("caution_money"));
String return_amt=getStr(request.getParameter("return_amt"));
String tax=getStr(request.getParameter("tax"));
String commision=getStr(request.getParameter("commision"));
String nominalprice=getStr(request.getParameter("nominalprice"));
String pena_rate=getStr(request.getParameter("pena_rate"));
//String irr=getStr(request.getParameter("irr"));
String peroid_payment=getStr(request.getParameter("peroid_payment"));
String begin_payment=getStr(request.getParameter("begin_payment"));
String period_type=getStr(request.getParameter("period_type"));

csa_financing=csa_financing.equals("")?"否":csa_financing;
lsh_insurance=lsh_insurance.equals("")?"0":lsh_insurance;
cust_insurance=cust_insurance.equals("")?"0":cust_insurance;
csa_cost=csa_cost.equals("")?"0":csa_cost;
gps_cost=gps_cost.equals("")?"0":gps_cost;
supervision_fee=supervision_fee.equals("")?"0":supervision_fee;
handling_charge=handling_charge.equals("")?"0":handling_charge;
caution_money=caution_money.equals("")?"0":caution_money;
return_amt=return_amt.equals("")?"0":return_amt;
tax=tax.equals("")?"0":tax;
commision=commision.equals("")?"0":commision;
nominalprice=nominalprice.equals("")?"0":nominalprice;

String sqlstr;
ResultSet rs;
sqlstr="delete from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
sqlstr="insert into contract_condition_temp (measure_id,contract_id,csa_hours,first_date,creator,create_date,equip_amt,lease_amt,first_payment_ratio,first_payment,lease_money,insurer,insurance,insurance_flag,lsh_insurance,cust_insurance,csa_flag,csa_financing,csa_cost,machine_price,gps_flag,gps_cost,income_number_year,start_date,income_number,lease_term,income_day,year_rate,supervision_fee,handling_charge,caution_money,return_amt,tax,commision,nominalprice,pena_rate,peroid_payment,begin_payment,period_type) select '"+doc_id+"','"+contract_id+"',"+csa_hours+",'"+start_date+"','"+dqczy+"','"+curr_date+"',"+equip_amt+","+lease_amt+","+first_payment_ratio+","+first_payment+","+lease_money+",'"+insurer+"',"+insurance+",'"+insurance_flag+"',"+lsh_insurance+","+cust_insurance+",'"+csa_flag+"','"+csa_financing+"',"+csa_cost+","+machine_price+",'"+gps_flag+"',"+gps_cost+","+income_number_year+",'"+start_date+"',"+income_number+","+lease_term+","+income_day+","+year_rate+","+supervision_fee+","+handling_charge+","+caution_money+","+return_amt+","+tax+","+commision+","+nominalprice+","+pena_rate+","+peroid_payment+","+begin_payment+",'"+period_type+"'";
//System.out.println("sqlstr1====="+sqlstr);
db.executeUpdate(sqlstr);


List l_plan_date = new ArrayList();
List l_rent = new ArrayList();
List l_corpus = new ArrayList();
List l_interest = new ArrayList();
List l_corpus_overage = new ArrayList();

Rent rent_hm = new Rent(year_rate, income_number, lease_money,
			"0", period_type, income_number_year,
			start_date);

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
irr=i_rr.getIRR(i_rr.getCashFlow(l_plan_date,l_rent,period_type,income_number_year,lease_money_irr));
irr=Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(irr)*100));
sqlstr="update contract_condition_temp set irr="+irr+" where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
//直线法利息
List l_straight_interest = new ArrayList();
l_straight_interest=Tools.getStInterest(l_interest);


sqlstr="delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
for(int i=0;i<l_rent.size();i++){
	sqlstr="insert into fund_rent_plan_temp(measure_id,contract_id,straight_interest,rent_list,plan_date,plan_status,rent,corpus,interest,corpus_overage,year_rate) select '"+doc_id+"','"+contract_id+"',"+l_straight_interest.get(i)+","+(i+1)+",'"+l_plan_date.get(i)+"','未回笼',"+l_rent.get(i)+","+l_corpus.get(i)+","+l_interest.get(i)+","+l_corpus_overage.get(i)+","+year_rate;
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