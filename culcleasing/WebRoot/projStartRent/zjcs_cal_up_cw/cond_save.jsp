<%@ page contentType="text/html; charset=gbk" language="java" errorPage="/public/pageError.jsp" %>

<%@ page import="java.sql.*" %> 
<%@ page import="com.tenwa.log.LogWriter"%>
<%@ include file="../../func/common_simple.jsp"%>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link href="../../css/global.css" rel="stylesheet" type="text/css">
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
	String contract_id = getStr(request.getParameter("contract_id")); //合同编号
    String begin_id = getStr(request.getParameter("begin_id")); //起租编号
    String invoice_type = getStr(request.getParameter("invoice_type"));
    String is_open = getStr(request.getParameter("is_open"));
    String rate_float_amt = getStr(request.getParameter("rate_float_amt"));
    String rate_float_type = getStr(request.getParameter("rate_float_type"));
    String adjust_style = getStr(request.getParameter("adjust_style"));
    String into_batch = getStr(request.getParameter("into_batch"));
    String plan_bank_name = getStr(request.getParameter("plan_bank_name"));
    String plan_bank_no = getStr(request.getParameter("plan_bank_no"));
    String start_date =getStr(request.getParameter("start_date"));
    //sys2012-2-3
	String factoring=getStr(request.getParameter("factoring"));
    
    //String fact_irr = getStr(request.getParameter("fact_irr"));
    //2012-4-23 Jaffe 修改 罚息日利率 pena_rate
	String pena_rate=getStr(request.getParameter("pena_rate"));

	//2012-9-12新增税种
	String tax_type=getStr(request.getParameter("tax_type"));
	//2012-11-20 zhangqi新增增值税发票类型
	String tax_type_invoice=getStr(request.getParameter("tax_type_invoice"));
	LogWriter.logDebug(request, "新增增值税发票类型:"+tax_type_invoice);
		
	//================更新相关信息-财务修改================
//	sqlstr= "Update begin_info_temp set invoice_type='"+invoice_type+"',fact_irr='"+fact_irr+"' where begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
	sqlstr = "Update begin_info_temp set invoice_type='"+invoice_type+"',is_open='"+is_open+"',rate_float_amt='"+rate_float_amt+"',rate_float_type='"+rate_float_type+"', ";
	sqlstr += "adjust_style='"+adjust_style+"',into_batch='"+into_batch+"',plan_bank_name='"+plan_bank_name+"',plan_bank_no='"+plan_bank_no+"',factoring='"+factoring+"',start_date='"+start_date+"',pena_rate='"+pena_rate+"',tax_type='"+tax_type+"',tax_type_invoice='"+tax_type_invoice+"'";
	sqlstr += " where begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
	LogWriter.logDebug(request, "财务更新起租信息数据："+sqlstr);
		
	flag = db.executeUpdate(sqlstr);
	
	//更新所有租金计划的计划收款银行信息
	sqlstr = "Update fund_rent_plan_temp set plan_bank_name='"+plan_bank_name+"',plan_bank_no='"+plan_bank_no+"' Where begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
	LogWriter.logDebug(request, "财务更新起租租金计划收取银行："+sqlstr);
	flag += db.executeUpdate(sqlstr);
	String sqlStr1="update contract_condition set tax_type='"+tax_type+"' where contract_id='"+contract_id+"'";
	flag+=db.executeUpdate(sqlStr1);
	db.close();

//所有操作成功
if(flag>0){
%>
    <script type="text/javascript">
		alert("数据更新成功!");
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
