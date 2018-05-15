<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %>
<%@page import="com.tenwa.culc.util.MathExtend"%> 
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<%

//获取基础参数
String match_id = getStr( request.getParameter("match_id") );
String id = getStr( request.getParameter("id") );//主键
//获取修改参数
String refund_corpus=getStr(request.getParameter("refund_corpus"));
String refund_interest=getStr(request.getParameter("refund_interest"));
String refund_otherfee_money= getStr(request.getParameter("refund_otherfee_money")) ;
String refund_money= MathExtend.add(MathExtend.add(refund_corpus, refund_interest),refund_otherfee_money);
String refund_money_bx= MathExtend.add(refund_corpus, refund_interest);
String refund_otherfee_type=getStr( request.getParameter("refund_otherfee_type") );
if( "0.00".equals(refund_otherfee_money) || "0".equals(refund_otherfee_money) ){
	refund_otherfee_type="无";
}
//CurrencyUtil.convertFinance(refund_money);

System.out.println("refund_money:::"+refund_money);
//基本变量
String sqlstr;
String sqlstr1;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

String fact_date=getStr(request.getParameter("fact_date"));

int flag = 0;

//2.3修改资金计划
sqlstr = "update financing_refund_income set refund_fact_date='"+fact_date+"',refund_corpus='"+refund_corpus+"',refund_interest='"+refund_interest+"'"+
		",refund_money='"+refund_money+"',refund_otherfee_money='"+refund_otherfee_money+"',modifactor='"+dqczy+"',refund_otherfee_type='"+refund_otherfee_type+"'"+
		",modify_date='"+datestr+"' where id='"+id+"'";
		System.out.println("sqlstr:::"+sqlstr);

		flag = db.executeUpdate(sqlstr);
sqlstr1 = "update financing_refund_plan set refund_corpus='"+refund_corpus+"',refund_interest='"+refund_interest+"'"+
		",refund_money='"+refund_money_bx+"',refund_subtotal='"+refund_money+"',refund_otherfee_money='"+refund_otherfee_money+"',modifactor='"+dqczy+"',refund_otherfee_type='"+refund_otherfee_type+"'"+
		",modify_date='"+datestr+"' where refund_plan_id='"+match_id+"'";
		flag += db.executeUpdate(sqlstr1);

db.close();

//3返回判断

if(flag>0){%>
	<script type="text/javascript">
		//window.close();
		opener.alert("还款修订成功!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>	
<%}else{
%>
	<script type="text/javascript">
		//window.close();
		opener.alert("还款修订失败!");
		opener.location.reload();
		if(window.opener){
			window.opener=null;window.open('','_self');
			window.close();} 
		 else{history.back()}
	</script>
<%} %>
</BODY>
</HTML>
