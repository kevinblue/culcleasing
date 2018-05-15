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
    		<th>其他金额期次	</th>
    		<th>款项类型</th>
    		
    		<th>款项方式</th>    		
    		<th>其他费用金额</th>
    		<th>计划收支时间</th>

    	</tr>
    	<%
    	String nowDateTime = getSystemDate(0);//当前格式化之后的时间
    	String contract_id=getStr(request.getParameter("contract_id"));
   		String doc_id=getStr(request.getParameter("doc_id"));
   		String begin_id=getStr(request.getParameter("begin_id"));

   		String otherfee_paytype="";
   		String otherfee_feetype="";
    		int i=1;
    		String str="otherfee_list,otherfee_feetype,otherfee_paytype,otherfee_money,";
    		str +="plan_date";
    		String sql = "select "+str+" from fund_otherfee_plan_medi_temp where  contract_id='"+contract_id+"' and doc_id='"+doc_id+"' and begin_id='"+begin_id+"' ";
    		LogWriter.logDebug(request,"11111111111111111我需要的sqlstr:"+sql);
    		rs = db.executeQuery(sql);
    		while(rs.next()){
    			i++;		
    			otherfee_paytype= getDBStr(rs.getString("otherfee_paytype"));
    			otherfee_feetype=getDBStr(rs.getString("otherfee_feetype"));
    					
    	%>


    	<form action="otherfee_plan_up.jsp" target="blank" method="get">
	    	<tr>
	    		<input type="hidden" name="contract_id" readonly="readonly" value="<%=contract_id %>">
	    		<input type="hidden" name="i" readonly="i" value="<%=i %>">
				<td class="noNewLine"><%=getDBStr(rs.getString("otherfee_list")) %></td>
				<td class="noNewLine">
				<select style="width:100" name="otherfee_feetype<%=i %>" id="otherfee_feetype"  ></select>
				<script language="javascript" class="text">
					dict_list("otherfee_feetype<%=i %>","root.otherfee_feetype","<%=otherfee_feetype%>","name");
				</script>
				</td>
				
				<td class="noNewLine"><%=otherfee_paytype %></td>
				<td class="noNewLine"><%=CurrencyUtil.convertFinance(rs.getString("otherfee_money")) %></td>
				<td class="noNewLine"><%=getDBDateStr(rs.getString("plan_date")) %></td>
	    	</tr>
    	</form>
    	<%}rs.close(); %>
    </table>
  </body>
</html>
