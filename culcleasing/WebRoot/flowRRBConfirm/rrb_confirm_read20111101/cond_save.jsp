<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.log.LogWriter"%> 
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租前息确认流程</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>
<BODY>
<%
	//0.基础参数
	String user_id = (String)session.getAttribute("czyid");//当前登陆人
	String sysDate = getSystemDate(0);
	int flag = 0;
	String sqlstr = "";
	
	//================1.封装ConditionBean================
	//1.1==获取参数
	String doc_id = getStr(request.getParameter("doc_id")); //文档编号 measure_id
    String contract_id = getStr(request.getParameter("contract_id")); //合同编号
    //1.1.1费用类参数
	String lease_money = getZeroStr(getStr(request.getParameter("lease_money")));//租赁本金
	String actual_fund = getZeroStr(getStr(request.getParameter("actual_fund")));//净融资额
	String actual_fund_ratio = getZeroStr(getStr(request.getParameter("actual_fund_ratio")));//净融资额比例 

	String before_interest = getZeroStr(getStr(request.getParameter("before_interest")));//租前息
	String before_interest_type = getZeroStr(getStr(request.getParameter("before_interest_type")));//租前息_是否算本

	//1.1.5基础参数
    String modify_date = sysDate;//更新日期
	String modificator = user_id;//更新人
	
	//1.2==更新商务条件信息
	if("是".equals(before_interest_type)){
		sqlstr = "Update contract_condition_temp set before_interest='"+before_interest+"',before_interest_type='"+before_interest_type+"',lease_money="+lease_money+",";
		sqlstr+= " actual_fund="+actual_fund+"',actual_fund_ratio='"+actual_fund_ratio+"',modificator='"+modificator+"',modify_date='"+modify_date+"' ";
		sqlstr+= " Where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";
	}else{
		sqlstr = "Update contract_condition_temp set before_interest='"+before_interest+"',before_interest_type='"+before_interest_type+"',lease_money='"+lease_money+"',";
		sqlstr+= " actual_fund='"+actual_fund+"',actual_fund_ratio='"+actual_fund_ratio+"',modificator='"+modificator+"',modify_date='"+modify_date+"' ";
		sqlstr+= " Where contract_id='"+contract_id+"' and doc_id='"+doc_id+"'";
	}
	
	LogWriter.logDebug(request, "租前息确认完毕，租前息金额："+before_interest+" 是否算本："+before_interest_type+" Sql:"+sqlstr);
	flag = db.executeUpdate(sqlstr);
		

//所有操作成功后转向页面暂时未有明确需求未做 ***********************************************************
if(flag>0){
%>
    <script type="text/javascript">
		alert("租前息更新成功!");
		window.parent.location.reload();
	    window.close();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("租前息更新失败!");
		window.parent.location.reload();
		this.close();
	</script>
<%	
}
%>
