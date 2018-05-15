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
String zfr_date = getStr( request.getParameter("zfr_date") );
String start_rent_list = getStr( request.getParameter("start_rent_list") );
String message="";
String flag="";
String start_rent_list_tmp="0";



if(contract_id.equals("") || zfr_date.equals("") || start_rent_list.equals("") || doc_id.equals("")){
	message="修改失败!";
}else{
	sqlstr="select min(rent_list) as min_rent_list from fund_rent_plan where contract_id='"+contract_id+"' and plan_status<>'已回笼'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		start_rent_list_tmp=getDBStr(rs.getString("min_rent_list"));
	}rs.close();
	
	if(Integer.parseInt(start_rent_list_tmp)>Integer.parseInt(start_rent_list)){
		start_rent_list=start_rent_list_tmp;
	}
	
	sqlstr="select * from fund_rent_plan_temp where measure_id='"+doc_id+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		flag="1";
	}rs.close();
	if(flag.equals("")){
		sqlstr="insert into fund_rent_plan_temp(measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date) select '"+doc_id+"','"+curr_date+"',contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date from fund_rent_plan where contract_id='"+contract_id+"' and rent_list<"+start_rent_list+" union select '"+doc_id+"','"+curr_date+"',contract_id,rent_list,plan_status,case when substring(convert(varchar(10),plan_date,121),1,8)+'"+zfr_date+"'>dbo.getMonthLastDay(plan_date) then dbo.getMonthLastDay(plan_date) else substring(convert(varchar(10),plan_date,121),1,8)+'"+zfr_date+"' end,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date from fund_rent_plan where contract_id='"+contract_id+"' and rent_list>="+start_rent_list;
	}else{
		sqlstr="update fund_rent_plan_temp set measure_date='"+curr_date+"',plan_date=case when substring(convert(varchar(10),plan_date,121),1,8)+'"+zfr_date+"'>dbo.getMonthLastDay(plan_date) then dbo.getMonthLastDay(plan_date) else substring(convert(varchar(10),plan_date,121),1,8)+'"+zfr_date+"' end where measure_id='"+doc_id+"' and rent_list>="+start_rent_list;
	}
	db.executeUpdate(sqlstr);
	message="修改成功!";
}

db.close();
%>
<script>
			window.close();
			opener.alert("<%=message%>");
			opener.location.reload();
		</script>