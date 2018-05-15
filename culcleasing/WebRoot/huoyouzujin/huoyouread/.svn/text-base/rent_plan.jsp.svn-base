<%@ page language="java" import="java.util.*" pageEncoding="utf-8" errorPage="/public/pageError.jsp"%>
<%@page import="com.tenwa.util.CurrencyUtil"%>
<%@ include file="../../public/simpleHeadImport.jsp"%>


<html>
  <head>   
    <title>或有租金修订</title>
    <script src="../../js/comm.js"></script>
    <script src="../../js/calend.js"></script>
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

	    <!-- 公共变量 -->
		<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css" >
		<link href="../../css/global.css" rel="stylesheet" type="text/css">
		<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">

		<%@ include file="../../public/commonVariable.jsp"%>
		<!-- 公共变量 -->
  </head>
  
  
		<%
    		String nowDateTime = getSystemDate(0);//当前格式化之后的时间
    		int i=1;
    		String contract_id=getStr(request.getParameter("contract_id"));
    		String doc_id=getStr(request.getParameter("doc_id"));
    		String begin_id=getStr(request.getParameter("begin_id"));
    		String plan_bank_name ="";
    		String plan_bank_no ="";
    	%>	
  <body style="overflow:auto;">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2"  cellspacing="1" width="100%" class="maintab_content_table">
    	<tr class="maintab_content_table_title">
    		<th>租金期次	</th>
    		<th>租赁物件当月运营月收入</th>
    		
    		<th>租赁公司分成比例</th>    		
    		<th>我司应收租金合计</th>
    		<th>其他减项</th>
    		
    		<th>我司实收租金</th>
    		<th>我司累计所得</th>    		
    		<th>计划收取时间</th>
    	</tr>
    	
    	
    		
    		
    		<% 
    		String str="rent_list,equip_operation_revenue,leas_separate_ratio,leas_plan_rent,";
    		str +="leas_other_out,leas_fact_rent,leas_all_in,plan_date,plan_bank_name,plan_bank_no";
    		String sql = "select "+str+" from fund_rent_plan_medi_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and begin_id='"+begin_id+"' ";
    		rs = db.executeQuery(sql);
    		while(rs.next()){		
    	%>
	    	<tr>
				<td class="noNewLine"><%=getDBStr(rs.getString("rent_list")) %></td>
				<td class="noNewLine"><%=CurrencyUtil.convertFinance(rs.getString("equip_operation_revenue")) %></td>
				<td class="noNewLine"><%=getDBStr(rs.getString("leas_separate_ratio")) %></td>
				<td class="noNewLine"><%=CurrencyUtil.convertFinance(rs.getString("leas_plan_rent")) %></td>
				<td class="noNewLine"><%=CurrencyUtil.convertFinance(rs.getString("leas_other_out")) %></td>
				<td class="noNewLine"><%=CurrencyUtil.convertFinance(rs.getString("leas_fact_rent")) %></td>
				<td class="noNewLine"><%=CurrencyUtil.convertFinance(rs.getString("leas_all_in")) %></td>
				<td class="noNewLine"><%=getDBDateStr(rs.getString("plan_date")) %></td>
	    	</tr>
    	<%}rs.close(); %>
    </table>
  </body>
</html>
