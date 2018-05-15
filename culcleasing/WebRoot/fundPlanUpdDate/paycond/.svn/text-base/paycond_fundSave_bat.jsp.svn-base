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
	//新增资金计划
//===========================================
	
//获取基础参数
String type = getStr( request.getParameter("type") );
//String item_id = getStr( request.getParameter("item_id") );
String[] ids = request.getParameterValues("list");
String doc_id = getStr( request.getParameter("doc_id") );

//基本变量
String sqlstr="";
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
int length =0;
String msg = "";
 
//if("del".equals(type)){//删除该资金计划
	//2.1先删除资金计划付款前提数据
	//sqlstr = "delete from contract_fund_fund_charge_condition_temp where doc_id='"+doc_id+"' and payment_id='"+item_id+"'";
	//db.executeUpdate(sqlstr);
	if(ids == null){
		length = 0;
	}else{
		length = ids.length;
	}
	for(int i = 0; i < length; i++) {
		//2.2先删除资金计划数据
		sqlstr = "delete from contract_fund_fund_charge_plan_temp where doc_id='"+doc_id+"' and payment_id='"+ids[i]+"'";
		flag += db.executeUpdate(sqlstr); 
	}
	
	System.out.println("aaaaaaaaaaaaaaaaa ======"+sqlstr);
	LogWriter.logDebug(request, "删除"+length+"条资金计划完成");
	
	msg = "删除"+length+"条资金计划";
//}

//3返回判断
if(flag == length){%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>成功!");
		window.opener.location.reload();
	</script>	
<%}else{
%>
	<script type="text/javascript">
		window.close();
		window.opener.alert("<%=msg %>失败!");
		window.opener.location.reload();
	</script>
<%} 

%>
</BODY>
</HTML>
<%if(null != db){db.close();}%>