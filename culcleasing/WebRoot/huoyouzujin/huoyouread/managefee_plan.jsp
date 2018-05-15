<%@ page language="java" import="java.util.*" pageEncoding="utf-8" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>   
    <title>或有租金修订(管理服务费)</title>
         <script type="text/javascript"  src="../../js/jquery.js"></script>
	    <script type="text/javascript">
			$(document).ready(function(){	
				$(":input").attr("disabled","disabled");//设置控件
				$("input[disabled='true']").css({color: "#808080", background: "#F4F4F4",border:"0" });
				$(function(){
				  	$("#t").mouseover(function(){
			        	$("#top").stop(true,true).slideToggle();     
					});
				});
										   
			});			
	    </script>
	    <script src="../../js/calend.js"></script>
	    <!-- 公共变量 -->
		<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css" >
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
		<script src="../../js/comm.js"></script>
		<%@ include file="../../public/commonVariable.jsp"%>
		<!-- 公共变量 -->
  </head>

  <body style="overflow:auto;">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2"  cellspacing="1" width="100%" class="maintab_content_table">
    	<tr class="maintab_content_table_title">
    		<th>管理服务费期次	</th>
    		<th>租赁物件当月运营月收入</th>
    		
    		<th>管理方服务费金额</th>    		
    		<th>管理方分成比例</th>
    		
    		<th>计划付款时间</th>
    	</tr>
    	<%
    	String nowDateTime = getSystemDate(0);//当前格式化之后的时间
   		String contract_id=getStr(request.getParameter("contract_id"));
   		String doc_id=getStr(request.getParameter("doc_id"));
   		String begin_id=getStr(request.getParameter("begin_id"));
    		
    		int i=1;
    		String str="managefee_list,equip_operation_revenue,managefee_money,manage_separate_ratio,";
    		str +="managefee_pay_side,plan_date";
    		String sql = "select "+str+" from fund_managefee_plan_medi_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and begin_id='"+begin_id+"' ";
    		rs = db.executeQuery(sql);
    		while(rs.next()){
    			i++;				
    	%>
    	<form action="managefee_plan_up.jsp" target="blank" method="get">
	    	<tr>
	    		<input type="hidden" name="contract_id" readonly="readonly" value="<%=contract_id %>">
				<td class="noNewLine"><%=getDBStr(rs.getString("managefee_list")) %></td>
				<td class="noNewLine"><%=CurrencyUtil.convertFinance(rs.getString("equip_operation_revenue")) %></td>
				<td class="noNewLine"><%=CurrencyUtil.convertFinance(rs.getString("managefee_money")) %></td>
				<td class="noNewLine"><%=getDBStr(rs.getString("manage_separate_ratio")) %>%</td>
				<td class="noNewLine"><%=getDBDateStr(rs.getString("plan_date")) %></td>
	    	</tr>
    	</form>
    	<%}rs.close(); %>

    </table>
  </body>
</html>
