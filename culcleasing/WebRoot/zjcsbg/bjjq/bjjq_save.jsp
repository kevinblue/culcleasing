<%@ page contentType="text/html; charset=gbk" language="java"%>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<%@ page import="com.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="gcns" scope="page" class="com.service.GeneContractNetFlowService" />
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
String zfr_date = getStr( request.getParameter("zfr_date") );
String start_rent_list = getStr( request.getParameter("start_rent_list") );
String handling_charge = getStr( request.getParameter("handling_charge") );
String interest_handling_charge = getStr( request.getParameter("interest_handling_charge") );
String message="";
String _zfr_date;
String overdue_month="0";


_zfr_date=zfr_date.substring(8,10);

sqlstr="select datediff(month,plan_date,'"+zfr_date+"') as overdue_month from fund_rent_plan where contract_id='"+contract_id+"' and rent_list="+start_rent_list;
System.out.println(sqlstr);
rs=db.executeQuery(sqlstr);
if(rs.next()){
	overdue_month=getDBStr(rs.getString("overdue_month"));
}rs.close();

ResultSet rsPd = null;
String strPd = "";
sqlstr="select plan_date from fund_rent_plan where contract_id='"+contract_id+"' and rent_list="+start_rent_list;
System.out.println(sqlstr);
rsPd=db.executeQuery(sqlstr);
if(rsPd.next()){
	strPd=getDBStr(rsPd.getString("plan_date"));
}rsPd.close();

sqlstr="delete from fund_rent_adjust where measure_id='"+doc_id+"'";
System.out.println(sqlstr);
db.executeUpdate(sqlstr);
sqlstr="insert into fund_rent_adjust(measure_id,contract_id,adjust_type,start_list,payday_delay,handling_charge,interest_handling_charge,apply_flag,interest_handling_date) values('"+doc_id+"','"+contract_id+"','延期',"+start_rent_list+",'"+zfr_date+"',"+handling_charge+","+interest_handling_charge+",'0','"+strPd+"')";
System.out.println(sqlstr);
db.executeUpdate(sqlstr);

//
int iCountTemp=0;
ResultSet rsCountTemp = null;
sqlstr = "select count(*) as count from fund_rent_plan_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"'"; 
System.out.println(sqlstr);
rsCountTemp = db.executeQuery(sqlstr); 
if(rsCountTemp.next()){
	iCountTemp =Integer.parseInt(getDBStr(rsCountTemp.getString("count")));
}
rsCountTemp.close();
if(iCountTemp>0){
	sqlstr = "delete from fund_rent_plan_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"'"; 
	System.out.println(sqlstr);
	db.executeUpdate(sqlstr);
}else{
	
}
sqlstr = "insert into fund_rent_plan_temp (measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date) select '"+doc_id+"',getdate(),contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date from fund_rent_plan  where fund_rent_plan.contract_id='"+contract_id+"'";
System.out.println(sqlstr);
db.executeUpdate(sqlstr);
//
	sqlstr = "update fund_rent_plan_temp set plan_date=dateadd(mm,"+overdue_month+",plan_date) where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' and rent_list>="+start_rent_list;
	System.out.println(sqlstr);
	db.executeUpdate(sqlstr);

	
	gcns.GeneContractNetFlow(contract_id,doc_id,dqczy);


message="修改成功!";

db.close();

%>
<script>
			window.close();
			opener.alert("<%=message%>");
			opener.location.reload();
		</script>