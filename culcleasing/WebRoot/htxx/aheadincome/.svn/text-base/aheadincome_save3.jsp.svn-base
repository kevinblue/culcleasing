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
String agree_amt = getStr( request.getParameter("agree_amt") );
String difference_amt = "0";
String difference_memo=getStr( request.getParameter("difference_memo") );

String ahead_amt="0";

sqlstr="select isnull(ahead_amt,0) as ahead_amt from contract_ahead_repayment where contract_ahead_repayment.doc_id='"+doc_id+"'";
rs=db.executeQuery(sqlstr);
while(rs.next()){
	ahead_amt=getDBStr( rs.getString("ahead_amt"));
}rs.close();

difference_amt=String.valueOf(Double.parseDouble(ahead_amt)-Double.parseDouble(agree_amt));



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
	sqlstr="update contract_ahead_repayment set agree_amt="+agree_amt+",difference_amt="+difference_amt+",difference_memo='"+difference_memo+"' where contract_id='"+contract_id+"'";
	db.executeUpdate(sqlstr);
}

db.close();
%>
<script>
			window.close();
			opener.alert("<%=message%>");
			opener.location.reload();
		</script>