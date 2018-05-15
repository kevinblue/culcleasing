<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金变更前后对比</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>

<script Language="Javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/stleasing_tabledata_nonewline.js"></script>
<script type="text/javascript" src="../../js/stleasing_function.js"></script>
<link href="../../css/stleasing_tabledata.css" rel="stylesheet" type="text/css">
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<body onload="public_onload(0);">
<table border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;margin-left: 10px;">
    <tr>
        <td style="color:#E46344;font-size: 16px;font-weight: bold">租金变更前后对比</td>
    </tr>
</table>
<div style="vertical-align:top;width:100%;overflow:auto;position: relative;margin-top: 10px;"  id="mydiv">

<% 
    String contract_id = getStr(request.getParameter("contract_id"));//合同编号
    String begin_id = getStr(request.getParameter("begin_id"));
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号
%>

<form name="list">
	<table align="center" width="100%">
	  <tr><td colspan="2">
		<table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
		  <tr height="2%">
			  <td colspan="2">
			  </td>
		  </tr>
		  <tr height="2%">
			  <td width="50%">变更息前偿还计划</td>
			  <td width="50%">变更后偿还计划</td>
		  </tr>
		</table>
		</td>
	  </tr>		
	  
      <tr>
	  <!-- $$$$$$$$$$$$$$- 变更前偿还计划 -$$$$$$$$$$$$$$ -->
	  <td width="50%" valign="top">
		  <table border="0" style="border-collapse:collapse;overflow: auto;" align="left" cellpadding="2" 
		  	cellspacing="1" width="100%" 
		  	class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>期次</th>
					<th>计划日期</th>
					<th>利率</th>
					<th>租金</th>
					<th>本金</th>
					<th>租息</th>
					<th>状态</th>
				  </tr>
				  <tbody id="data">
				  <%
					sqlstr = "select rent_list,plan_date,rent,corpus,interest,corpus_overage,plan_bank_name,plan_bank_no,plan_status from fund_rent_plan_temp ";
					sqlstr += " where begin_id='"+begin_id+"' and doc_id='"+doc_id+"' and oth_remark='租金变更前' order by rent_list";
					LogWriter.logDebug(request, "起租 - 租金变更前 -- 租金计划 -- sqlstr查询sql语句==>> "+sqlstr);
					rs = db.executeQuery(sqlstr);
					while(rs.next()) {
				  %>
				  <tr>
					<td><%=CurrencyUtil.convertIntAmount(rs.getString("rent_list")) %></td> 
					<td><%=getDBDateStr(rs.getString("plan_date")) %></td> 
					<td><%=CurrencyUtil.convertFinance(rs.getString("rent")) %></td> 
					<td><%=CurrencyUtil.convertFinance(rs.getString("corpus")) %></td> 
					<td><%=CurrencyUtil.convertFinance(rs.getString("interest")) %></td> 
					<td><%=CurrencyUtil.convertFinance(rs.getString("corpus_overage")) %></td> 
					<td><%=getDBStr(rs.getString("plan_status")) %></td> 
				  </tr>
				  <%}
				  	rs.close();
				  %>
				  </tbody>
			  </table>
		  </td>
		
		  <!-- $$$$$$$$$$$$$$- 变更后偿还计划 -$$$$$$$$$$$$$$ -->
		  <td width="50%" valign="top">
		  	<table border="0" style="border-collapse:collapse;overflow: auto;" align="center" 
		  		cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>期次</th>
					<th>计划日期</th>
					<th>利率</th>
					<th>租金</th>
					<th>本金</th>
					<th>租息</th>
					<!-- 
					<th>状态</th>
					-->
				  </tr>
				  <tbody id="data">
				  <%
					sqlstr = "select rent_list,plan_date,rent,corpus,interest,corpus_overage,plan_bank_name,plan_bank_no,plan_status from fund_rent_plan_temp ";
					sqlstr += " where begin_id='"+begin_id+"' and doc_id='"+doc_id+"' and oth_remark='租金变更后' order by rent_list";
					LogWriter.logDebug(request, "起租 - 租金变更后 - 租金计划 -- sqlstr查询sql语句==>> "+sqlstr);
					rs = db.executeQuery(sqlstr);
				  	while (rs.next()) {
				  %>
				  <tr>
					<td><%=CurrencyUtil.convertIntAmount(rs.getString("rent_list")) %></td> 
					<td><%=getDBDateStr(rs.getString("plan_date")) %></td> 
					<td><%=CurrencyUtil.convertFinance(rs.getString("rent")) %></td> 
					<td><%=CurrencyUtil.convertFinance(rs.getString("corpus")) %></td> 
					<td><%=CurrencyUtil.convertFinance(rs.getString("interest")) %></td> 
					<td><%=CurrencyUtil.convertFinance(rs.getString("corpus_overage")) %></td> 
					<%--
					<td><%=getDBStr(rs.getString("plan_status")) %></td> 
					--%>
				  </tr>
				  <%
				  	}
				  	db.close();
				  %>
				  </tbody>
			  </table>
		  </td>
      </tr>
    </table>
</form>
</div>
</body>
</html>
