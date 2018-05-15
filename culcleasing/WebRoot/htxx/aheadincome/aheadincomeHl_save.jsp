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
String premature_corpus = getStr( request.getParameter("premature_corpus") );
String agree_premature_corpus = getStr( request.getParameter("agree_premature_corpus") );
String break_handling_charge = getStr( request.getParameter("break_handling_charge") );
String agree_handling_charge = getStr( request.getParameter("agree_handling_charge") );
String nominalprice = getStr( request.getParameter("nominalprice") );
String agree_nominalprice = getStr( request.getParameter("agree_nominalprice") );
String overdue_corpus = getStr( request.getParameter("overdue_corpus") );
String agree_overdue_corpus = getStr( request.getParameter("agree_overdue_corpus") );
String overdue_interest = getStr( request.getParameter("overdue_interest") );
String agree_overdue_interest = getStr( request.getParameter("agree_overdue_interest") );
String overdue_penalty = getStr( request.getParameter("overdue_penalty") );
String agree_overdue_penalty = getStr( request.getParameter("agree_overdue_penalty") );
String period_interest = getStr( request.getParameter("period_interest") );
String agree_period_interest = getStr( request.getParameter("agree_period_interest") );
String remain_caution_money = getStr( request.getParameter("remain_caution_money") );
String agree_exempt_amt = getStr( request.getParameter("agree_exempt_amt") );
String obligation_total = getStr( request.getParameter("obligation_total") );
String agree_obligation_total = getStr( request.getParameter("agree_obligation_total") );


String message="确认成功!";

sqlstr="update contract_abnormal_end set premature_corpus="+premature_corpus+",agree_premature_corpus="+agree_premature_corpus+",break_handling_charge="+break_handling_charge+",agree_handling_charge="+agree_handling_charge+",agree_nominalprice="+agree_nominalprice+",nominalprice="+nominalprice+",agree_overdue_corpus="+agree_overdue_corpus+",overdue_corpus="+overdue_corpus+",agree_overdue_interest="+agree_overdue_interest+",overdue_interest="+overdue_interest+",agree_overdue_penalty="+agree_overdue_penalty+",overdue_penalty="+overdue_penalty+",agree_period_interest="+agree_period_interest+",period_interest="+period_interest+",remain_caution_money="+remain_caution_money+",agree_exempt_amt="+agree_exempt_amt+",obligation_total="+obligation_total+",agree_obligation_total="+agree_obligation_total+" where contract_id='"+contract_id+"'";

db.executeUpdate(sqlstr);



db.close();
%>
<script>
			window.close();
			opener.alert("<%=message%>");
			opener.location.reload();
		</script>