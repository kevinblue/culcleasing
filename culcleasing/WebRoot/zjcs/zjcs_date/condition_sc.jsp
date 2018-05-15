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


String start_date=getStr(request.getParameter("start_date"));

String sqlstr;
ResultSet rs;
sqlstr="update contract_condition_temp set start_date='"+start_date+"' where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
System.out.println("sqlstr============="+sqlstr);
db.executeUpdate(sqlstr);

String year_rate="";
String income_number="";
String lease_money="";
String period_type="";
String income_number_year="";

sqlstr="select * from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	year_rate = getDBStr(rs.getString("year_rate"));
	income_number = getDBStr(rs.getString("income_number"));
	lease_money = getDBStr(rs.getString("lease_money"));
	period_type = getDBStr(rs.getString("period_type"));
	income_number_year = getDBStr(rs.getString("income_number_year"));
}rs.close();

List l_plan_date = new ArrayList();

Rent rent_hm = new Rent(year_rate, income_number, lease_money,
			"0", period_type, income_number_year,
			start_date);

HashMap hm=rent_hm.getPlan();
l_plan_date=(List)hm.get("plan_date");


for(int i=0;i<l_plan_date.size();i++){
	sqlstr="update fund_rent_plan_temp set plan_date='"+l_plan_date.get(i)+"' where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' and rent_list="+(i+1)+"";
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