<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%
//===========================================
	//修改资金计划
//===========================================
	
//获取基础参数
String item_id = getStr( request.getParameter("item_id") );//主键

//获取资金计划数据参数
String make_contract_id = getStr( request.getParameter("make_contract_id") );
String fee_name = getStr( request.getParameter("fee_name") );//款项名称
String pay_obj = getStr( request.getParameter("pay_obj") );
String pay_bank_name = getStr( request.getParameter("pay_bank_name") );
String pay_bank_no = getStr( request.getParameter("pay_bank_no") );
String plan_bank_name = getStr( request.getParameter("plan_bank_name") );
String plan_bank_no = getStr( request.getParameter("plan_bank_no") );
String plan_date = getStr( request.getParameter("plan_date") );
String currency = getStr( request.getParameter("currency") );
String plan_money = getStr( request.getParameter("plan_money") );
String pay_type = getStr( request.getParameter("pay_type") );
String fpnote = getStr( request.getParameter("fpnote") );

//基本变量
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
String fee_type_name="保费资金付款";

//2.3修改资金计划
sqlstr = "update contract_fund_fund_charge_plan_bxf_temp set make_contract_id='"+make_contract_id+"', fee_name='"+fee_name+"',pay_obj='"+pay_obj+"',plan_date='"+plan_date+"',curr_plan_money='"+plan_money+"',plan_money='"+plan_money+"',";
sqlstr +=" currency='"+currency+"',pay_bank_name='"+pay_bank_name+"',pay_bank_no='"+pay_bank_no+"',";
sqlstr +="plan_bank_name='"+plan_bank_name+"',plan_bank_no='"+plan_bank_no+"',pay_type='"+pay_type+"',fpnote='"+fpnote+"',modificator='"+dqczy+"',modify_date='"+datestr+"' where id='"+item_id+"'";

flag = db.executeUpdate(sqlstr);
LogWriter.logDebug(request, "修改资金计划款项名称："+fee_type_name+" 款项金额："+plan_money);

db.close();

if(flag>0){%>
	<script type="text/javascript">
		opener.alert("修改资金计划 [<%=fee_type_name %>] 成功!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>	
	<%}else{
%>
	<script type="text/javascript">
		opener.alert("修改资金计划  [<%=fee_type_name %>] 失败!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%} %>
</BODY>
</HTML>
