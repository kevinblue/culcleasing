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
String begin_id = getStr(request.getParameter("begin_id"));//合同编号
String doc_id = getStr(request.getParameter("doc_id"));//文档编号

//获取资金计划数据参数

String plan_bank_name = getStr( request.getParameter("plan_bank_name") );
String plan_bank_no = getStr( request.getParameter("plan_bank_no") );
String start_list = getStr( request.getParameter("start_list") );
String end_list = getStr( request.getParameter("end_list") );
//新增是否保理
String factoring = getStr( request.getParameter("factoring") );
//基本变量
String sqlstr;
String dqczy = (String) session.getAttribute("czyid");//当前登陆人
String datestr = getSystemDate(0); //获取系统时间

int flag = 0;
//批量修改计划收款银行
if((start_list!=null && !start_list.equals("")) && (end_list!=null && !end_list.equals("")) && (plan_bank_name!=null && !plan_bank_name.equals("")) &&		   (plan_bank_no!=null && !plan_bank_no.equals("")) ){
	String sqlstr1="update fund_rent_plan_temp set plan_bank_name='"+plan_bank_name+"',plan_bank_no='"+plan_bank_no+"' ,modificator='"+dqczy+"',modify_date='"+datestr+"' where begin_id='"+begin_id+"' and doc_id='"+doc_id+"' and rent_list>='"+start_list+"' and rent_list<='"+end_list+"' and plan_status='未回笼'";
	System.out.println("vvvvvvvvv"+sqlstr1);
	flag = db.executeUpdate(sqlstr1);
}
if ( (factoring!=null && !factoring.equals("")) && (start_list!=null && !start_list.equals("")) && (end_list!=null && !end_list.equals(""))){
	String sqlstr1="update fund_rent_plan_temp set factoring='"+factoring+"' ,modificator='"+dqczy+"',modify_date='"+datestr+"' where begin_id='"+begin_id+"' and doc_id='"+doc_id+"' and rent_list>='"+start_list+"' and rent_list<='"+end_list+"' and plan_status='未回笼'";
	System.out.println("vvvvvvvvv"+sqlstr1);
	flag += db.executeUpdate(sqlstr1);
}
db.close();
//3返回判断
	if(flag>0){%>
	<script type="text/javascript">
		alert("数据更新成功!");
		window.parent.location.reload();
		this.close();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("数据更新失败!");
		window.parent.location.reload();
		this.close();
	</script>
<%} %>
</BODY>
</HTML>
