<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.culc.util.ConvertUtil"%>
<%@page import="com.tenwa.log.LogWriter"%>
<%@page import="com.tenwa.culc.bean.BeginInfoBean"%>
<%@page import="com.tenwa.culc.service.BeginService"%>
<%@ include file="../../func/common_simple.jsp"%>

<jsp:useBean id="db" scope="page" class="dbconn.Conn" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 交易结构及租金处理</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script type="text/javascript" src="../../DatePicker/WdatePicker.js"></script>
</head>
<BODY>
<%
	//0.基础参数
	String sqlstr = "";
	String dqczy = (String) session.getAttribute("czyid");//当前登陆人
	String datestr = getSystemDate(0); //获取系统时间

	int flag = 0;
	//================1.封装ConditionBean================
	//1.1==获取参数
	String doc_id = getStr(request.getParameter("doc_id")); //文档编号 measure_id
    String begin_id = getStr(request.getParameter("begin_id")); //起租编号
    String invoice_type = getStr(request.getParameter("invoice_type"));
    String is_open = getStr(request.getParameter("is_open"));
    String rate_float_amt = getStr(request.getParameter("rate_float_amt"));
	if(rate_float_amt.equals("") || rate_float_amt==null)
	{
		rate_float_amt="0";
	}
    String rate_float_type = getStr(request.getParameter("rate_float_type"));
    String adjust_style = getStr(request.getParameter("adjust_style"));
    String into_batch = getStr(request.getParameter("into_batch"));
    String plan_bank_name = getStr(request.getParameter("plan_bank_name"));
    String plan_bank_no = getStr(request.getParameter("plan_bank_no"));
    String start_date =getStr(request.getParameter("start_date"));
    String factoring=getStr(request.getParameter("factoring"));

	String pena_rate=getStr(request.getParameter("pena_rate"));
	String free_defa_inter_day=getStr(request.getParameter("free_defa_inter_day"));
	String new_irr=getStr(request.getParameter("new_irr"));
	String income_day=getStr(request.getParameter("income_day"));
	String tax_type=getStr(request.getParameter("tax_type"));
	String tax_type_invoice=getStr(request.getParameter("tax_type_invoice"));
    
  
		
	//================更新相关信息-财务修改================
	//,fact_irr='"+new_irr+"'
	sqlstr = "Update begin_info_temp set invoice_type='"+invoice_type+"',rate_float_amt='"+rate_float_amt+"',rate_float_type="+rate_float_type+", ";
	sqlstr += "into_batch='"+into_batch+"',factoring='"+factoring+"',tax_type_invoice='"+tax_type_invoice+"',tax_type='"+tax_type+"',rent_start_date='"+start_date+"',pena_rate='"+pena_rate+"',free_defa_inter_day='"+free_defa_inter_day+"',income_day='"+income_day+"',adjust_style='"+adjust_style+"'";
	sqlstr += " where begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
	LogWriter.logDebug(request, "财务更新起租信息数据："+sqlstr);
		
	flag = db.executeUpdate(sqlstr);
	
System.out.println("flag"+flag);
	db.close();
//所有操作成功后转向页面暂时未有明确需求未做 ***********************************************************
if(flag>0){
%>
    <script type="text/javascript">
		alert("数据更新成功!");
alert("数据更新成功!"+tax_type);
		window.parent.location.reload();
	    window.close();
	</script>
<%
}else{
%>
    <script type="text/javascript">
		alert("数据更新失败!");
		window.parent.location.reload();
		this.close();
	</script>
<%	
}
%>
