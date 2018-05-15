<%@ page language="java" import="java.util.*" pageEncoding="utf-8" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>   
<title>或有租金修订(其他金额)</title>
<script type="text/javascript"  src="../../js/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){	
	$(":input").attr("disabled","disabled");//设置控件
	$("input[disabled='true']").css({color: "#808080", background: "#F4F4F4",border:"0" });							   
});			
</script>
<script type="text/javascript"  src="../../js/jquery.js"></script>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script src="../../js/calend.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css" >
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

 <body style="overflow:auto;">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2"  
    cellspacing="1" width="100%" class="maintab_content_table">
   	<tr class="maintab_content_table_title">
   		<th width="100px;">其他金额期次</th>
   		<th>款项类型</th>
   		
   		<th>款项方式</th>    		
   		<th>其他费用金额</th>
   		<th>计划收支时间</th>
   	</tr>
    <%
    	String contract_id=getStr(request.getParameter("contract_id"));
   		String doc_id=getStr(request.getParameter("doc_id"));
   		String begin_id=getStr(request.getParameter("begin_id"));

   		String str="otherfee_list,otherfee_feetype,otherfee_paytype,otherfee_money,";
   		str +="plan_date";
   		String sql = "select "+str+" from fund_otherfee_plan_medi_temp where  contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and begin_id='"+begin_id+"' ";
   		rs = db.executeQuery(sql);
   		while(rs.next()){
    %>
    	<tr>
			<td class="noNewLine"><%=getDBStr(rs.getString("otherfee_list")) %></td>
			<td class="noNewLine"><%=getDBStr(rs.getString("otherfee_feetype")) %></td>
			<td class="noNewLine"><%=getDBStr(rs.getString("otherfee_paytype")) %></td>
			<td class="noNewLine"><%=CurrencyUtil.convertFinance(rs.getString("otherfee_money")) %></td>
			<td class="noNewLine"><%=getDBDateStr(rs.getString("plan_date")) %></td>
    	</tr>
   	<%}db.close(); %>
    </table>
  </body>
</html>
