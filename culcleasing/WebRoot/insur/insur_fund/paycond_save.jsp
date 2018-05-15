<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@page import="com.tenwa.culc.util.CommonTool"%>
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
	//新增资金计划
//===========================================
	
//获取基础参数
String contract_id = getStr( request.getParameter("contract_id") );
String doc_id = getStr( request.getParameter("doc_id") );
String cust_id = getStr( request.getParameter("cust_id") );
String cust_name = getStr( request.getParameter("cust_name") );

//获取资金计划数据参数
String id = getStr( request.getParameter("make_contract_id") );
String pay_way = getStr( request.getParameter("pay_way") );//款项方式
String fee_type = getStr( request.getParameter("fee_type") );//款项内容
String fee_name = getStr( request.getParameter("fee_name") );
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
ResultSet rs = null; 
//保费不做超过判断 2012-3-27 Jaffe
//2.1先查询出已经生产资金计划的金额
int fee_num = 0;
sqlstr = "select count(fee_num) as fee_num from contract_fund_fund_charge_plan_bxf_temp";
sqlstr+= " where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and fee_type='"+fee_type+"'";
rs = db.executeQuery(sqlstr);
if(rs.next()){
	fee_num = rs.getInt("fee_num");
}
rs.close();

//2.3插入资金计划
sqlstr = "insert into contract_fund_fund_charge_plan_bxf_temp(make_contract_id,payment_id,doc_id,contract_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,curr_plan_money,plan_money,currency,pay_obj,";
sqlstr+=" pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)";
// 付款 -- 设备款
sqlstr+=" select '"+id+"','"+CommonTool.getUUID()+"','"+doc_id+"','"+contract_id+"','"+pay_type+"','"+fee_type+"','"+fee_name+"','"+(fee_num+1)+"','"+plan_date+"','未核销','"+plan_money+"','"+plan_money+"','"+currency+"','"+pay_obj+"',";
sqlstr+="'"+pay_bank_name+"','"+pay_bank_no+"','"+plan_bank_name+"','"+plan_bank_no+"','"+pay_way+"','"+fpnote+"','"+dqczy+"','"+datestr+"','"+dqczy+"','"+datestr+"'";
flag = db.executeUpdate(sqlstr);
LogWriter.logDebug(request, "插入新的资金计划款项名称：[保费资金付款] 款项金额："+plan_money+"___"+sqlstr);

String sqlLog = LogWriter.getSqlIntoDB(request, "付款保费资金计划制定", "资金计划", "插入新的资金计划款项名称：[保费资金付款]款项金额："+plan_money, sqlstr.substring(0,20));
db.executeUpdate(sqlLog);

db.close();

//3返回判断
if(flag>0){%>
<script type="text/javascript">
	opener.alert("新增资金计划 [保费资金付款] 生成成功!");
	opener.location.reload();
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}
</script>	
<%}else{
%>
<script type="text/javascript">
	opener.alert("新增资金计划  [保费资金付款]  生成失败!");
	opener.location.reload();
	if(window.opener){
		window.opener=null;window.open('','_self');
		window.close();} 
	 else{history.back()}	
</script>
<%} %>
</BODY>
</HTML>
