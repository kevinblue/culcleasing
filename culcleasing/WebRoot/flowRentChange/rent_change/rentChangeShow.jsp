<%@page import="com.tenwa.culc.util.ERPDataSource"%>
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

<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
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
			  	<BUTTON class="btn_2" onClick="dataHander('add_modal','cond_upload.jsp?contract_id=<%=contract_id %>&begin_id=<%=begin_id %>&doc_id=<%=doc_id %>');">
				<img src="../../images/fdmo_23.gif" align="absmiddle" border="0">租金上传</button>
				 <%
				 ResultSet rs1=null;
				String sqlstr1="select before_rate,after_rate,contract_id from dbo.fund_adjust_interest_contract_bgz where contract_id= '"+contract_id+"' and doc_id='"+doc_id+"' and begin_id='"+begin_id+"'";
				//System.out.println("======================"+sqlstr);
				rs1=db1.executeQuery(sqlstr1);
				String before_rate="0.0";
				String after_rate="0.0";
				
				ERPDataSource erp = new ERPDataSource();
				String sqlstrRate2 ="select top 1 year_rate from fund_rent_plan_temp where contract_id= '"+contract_id+"' and doc_id='"+doc_id+"' and begin_id='"+begin_id+"' and oth_remark = '租金变更前' order by rent_list desc";
				ResultSet rs2=erp.executeQuery(sqlstrRate2);
				if(rs2.next()){
					before_rate = rs2.getString("year_rate");
				}
				String sqlstrRate3 ="select top 1 year_rate from fund_rent_plan_temp where contract_id= '"+contract_id+"' and doc_id='"+doc_id+"' and begin_id='"+begin_id+"' and oth_remark = '租金变更后' order by rent_list desc";
				ResultSet rs3=erp.executeQuery(sqlstrRate3);
				if(rs3.next()){
					after_rate = rs3.getString("year_rate");
				}
				
				if(null != rs2){
					rs2.close();
				}
				if(null != rs3){
					rs3.close();
				}
				if(null != erp){
					erp.close();
				}
				
				if(rs1.next()){
			 %>
			<b  style="color:red;">是否央行调息：是</b>
			<b  style="color:red;">&nbsp;&nbsp;</b>
			<b  style="color:red;">调息前利率：<%=CurrencyUtil.convertFinance(before_rate) %>%</b>
			<b  style="color:red;">调息后利率：<%=CurrencyUtil.convertFinance(after_rate) %>%</b>
			<%}else{%>
			<b  style="color:red;">是否央行调息：否</b>
			<b  style="color:red;">&nbsp;&nbsp;</b>
			<b  style="color:red;">变更前利率：<%=CurrencyUtil.convertFinance(before_rate) %>%</b>
			<b  style="color:red;">变更后利率：<%=CurrencyUtil.convertFinance(after_rate) %>%</b>	
			<% }
			if(null != rs1){
				rs1.close();
			}
			%>
			  </td>
		
		  </tr>
		  <tr height="2%">
			  <td width="60%">变更前偿还计划</td>
			  <td width="40%">变更后偿还计划</td>
		  </tr>
		</table>
		</td>
	  </tr>		
	  
      <tr>
	  <!-- $$$$$$$$$$$$$$- 变更前偿还计划 -$$$$$$$$$$$$$$ -->
	  <td width="60%" valign="top">
		  <table border="0" style="border-collapse:collapse;overflow: auto;" align="left" cellpadding="2" 
		  	cellspacing="1" width="100%" 
		  	class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>期次</th>
					<th>计划日期</th>
					<th>租金</th>
					<th>本金</th>
					<th>租息</th>
					<th>剩余本金</th>
					<th>开票日期</th>
					<th>是否开票</th>
					<th>计划收款银行</th>
					<th>计划收款账号</th>
					<th>状态</th>
				  </tr>
				  <tbody id="data">
				  <%
					sqlstr = "select i.invoice_date,invoice_is,frp.rent_list,plan_date,rent,corpus,interest,corpus_overage,plan_bank_name,plan_bank_no,plan_status from fund_rent_plan_temp frp left join invoice_rent_detail i on i.begin_id=frp.begin_id and i.rent_list=frp.rent_list ";
					sqlstr += " where frp.begin_id='"+begin_id+"' and doc_id='"+doc_id+"' and oth_remark='租金变更前' order by frp.rent_list";
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
					<td><%=getDBStr(rs.getString("invoice_date")) %></td> 
					<td><%=getDBStr(rs.getString("invoice_is")) %></td> 
					<td><%=getDBStr(rs.getString("plan_bank_name")) %></td>
					<td><%=getDBStr(rs.getString("plan_bank_no")) %></td>
					<td><%=getDBStr(rs.getString("plan_status")) %></td> 
				  </tr>
				  <%}
				  	rs.close();
				  %>
				  </tbody>
			  </table>
		  </td>
		
		  <!-- $$$$$$$$$$$$$$- 变更后偿还计划 -$$$$$$$$$$$$$$ -->
		  <td width=40%" valign="top">
		  	<table border="0" style="border-collapse:collapse;overflow: auto;" align="center" 
		  		cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
				 <tr class="cwDLHead">
					<th>期次</th>
					<th>计划日期</th>

					<th>租金</th>
					<th>本金</th>
					<th>租息</th>
					<th>剩余本金</th>
					<th>计划收款银行</th>
					<th>计划收款账号</th>
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
					<td><%=getDBStr(rs.getString("plan_bank_name")) %></td>
					<td><%=getDBStr(rs.getString("plan_bank_no")) %></td>

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
<%if(null != db1){db1.close();}%>