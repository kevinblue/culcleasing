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

String billing_manager=getStr( request.getParameter("billing_manager") );
String billing_date=getStr( request.getParameter("billing_date") );
String effective_date=getStr( request.getParameter("effective_date") );

String price_factor_name1=getStr( request.getParameter("price_factor_name1") );
String price_factor1=getStr( request.getParameter("price_factor1") );price_factor1=price_factor1.equals("")?"0":price_factor1;
String price_factor_name2=getStr( request.getParameter("price_factor_name2") );
String price_factor2=getStr( request.getParameter("price_factor2") );price_factor2=price_factor2.equals("")?"0":price_factor2;
String price_factor_name3=getStr( request.getParameter("price_factor_name3") );
String price_factor3=getStr( request.getParameter("price_factor3") );price_factor3=price_factor3.equals("")?"0":price_factor3;
String price_factor_name4=getStr( request.getParameter("price_factor_name4") );
String price_factor4=getStr( request.getParameter("price_factor4") );price_factor4=price_factor4.equals("")?"0":price_factor4;
String price_factor_name5=getStr( request.getParameter("price_factor_name5") );
String price_factor5=getStr( request.getParameter("price_factor5") );price_factor5=price_factor5.equals("")?"0":price_factor5;
String price_factor_name6=getStr( request.getParameter("price_factor_name6") );
String price_factor6=getStr( request.getParameter("price_factor6") );price_factor6=price_factor6.equals("")?"0":price_factor6;
String price_factor_name7=getStr( request.getParameter("price_factor_name7") );
String price_factor7=getStr( request.getParameter("price_factor7") );price_factor7=price_factor7.equals("")?"0":price_factor7;
String price_factor_name8=getStr( request.getParameter("price_factor_name8") );
String price_factor8=getStr( request.getParameter("price_factor8") );price_factor8=price_factor8.equals("")?"0":price_factor8;
String back_amt=getStr( request.getParameter("back_amt") );back_amt=back_amt.equals("")?"0":back_amt;





String flag="";
String message="保存成功!";
sqlstr="select * from contract_ahead_break where doc_id='"+doc_id+"'";
rs=db.executeQuery(sqlstr);
if(rs.next()){
	flag="1";
}rs.close();

if(flag.equals("")){
	//只做update
	//sqlstr="insert into contract_ahead_break(contract_id,applicant,apply_date,rent_interval,pay_day,contract_amt,first_payment,lease_money,received_caution_money,received_handling_charge,received_return,received_insurance,received_list,received_rent,received_amt,undue_list,undue_rent,overdue_list,overdue_rent,overdue_penalty,nominalprice,risk_exposure) values('"+contract_id+"','"+applicant+"','"+apply_date+"',"+rent_interval+","+pay_day+","+contract_amt+","+first_payment+","+lease_money+","+received_caution_money+","+received_handling_charge+","+received_return+","+received_insurance+","+received_list+","+received_rent+","+received_amt+","+undue_list+","+undue_rent+","+overdue_list+","+overdue_rent+","+overdue_penalty+","+nominalprice+","+risk_exposure+")";
	//db.executeUpdate(sqlstr);
}else{
	sqlstr="update contract_ahead_break set billing_manager='"+billing_manager+"',billing_date='"+billing_date+"',effective_date='"+effective_date+"',price_factor_name1='"+price_factor_name1+"',price_factor1="+price_factor1 +",price_factor_name2='"+price_factor_name2+"',price_factor2="+price_factor2+",price_factor_name3='"+price_factor_name3+"',price_factor3="+price_factor3+",price_factor_name4='"+price_factor_name4+"',price_factor4="+price_factor4+",price_factor_name5='"+price_factor_name5+"',price_factor5="+price_factor5+",price_factor_name6='"+price_factor_name6+"',price_factor6="+price_factor6+",price_factor_name7='"+price_factor_name7+"',price_factor7="+price_factor7+",price_factor_name8='"+price_factor_name8+"',price_factor8="+price_factor8+",back_amt="+back_amt+" where doc_id='"+doc_id+"'";
	System.out.println("sqlstr=================================================="+sqlstr);
	db.executeUpdate(sqlstr);
}

db.close();
%>
<script>
			window.close();
			opener.alert("<%=message%>");
			opener.location.reload();
		</script>