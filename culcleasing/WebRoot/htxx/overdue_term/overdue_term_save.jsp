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
String message="";
String _zfr_date;
String overdue_month="0";


_zfr_date=zfr_date.substring(8,10);

sqlstr="select datediff(month,plan_date,'"+zfr_date+"') as overdue_month from fund_rent_plan where contract_id='"+contract_id+"' and rent_list="+start_rent_list;
rs=db.executeQuery(sqlstr);
if(rs.next()){
	overdue_month=getDBStr(rs.getString("overdue_month"));
}rs.close();

sqlstr="delete from fund_rent_plan_temp where measure_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
sqlstr="insert into fund_rent_plan_temp(measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date) select '"+doc_id+"','"+curr_date+"',contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date from fund_rent_plan where contract_id='"+contract_id+"' and rent_list<"+start_rent_list+" union select '"+doc_id+"','"+curr_date+"',contract_id,rent_list,plan_status,case when substring(convert(varchar(10),dateadd(month,"+overdue_month+",plan_date),121),1,8)+'"+_zfr_date+"'>dbo.getMonthLastDay(dateadd(month,"+overdue_month+",plan_date)) then dbo.getMonthLastDay(dateadd(month,"+overdue_month+",plan_date)) else substring(convert(varchar(10),dateadd(month,"+overdue_month+",plan_date),121),1,8)+'"+_zfr_date+"' end,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date from fund_rent_plan where contract_id='"+contract_id+"' and rent_list>="+start_rent_list;
db.executeUpdate(sqlstr);

sqlstr="delete from fund_rent_adjust where measure_id='"+doc_id+"'";
db.executeUpdate(sqlstr);
sqlstr="insert into fund_rent_adjust(measure_id,contract_id,adjust_type,start_list,payday_delay,handling_charge) values('"+doc_id+"','"+contract_id+"','延期',"+start_rent_list+",'"+zfr_date+"',"+handling_charge+")";
db.executeUpdate(sqlstr);
//插入合同日程表(临时)
gcns.GeneContractNetFlow(contract_id,doc_id,dqczy);

db.close();

%>
<script>
			window.close();
			opener.alert("延期调整成功");
			opener.location.reload();
		</script>