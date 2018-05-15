<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 租金偿还计划</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
	//租金计划
	String begin_id = getStr(request.getParameter("begin_id"));//合同编号
	String doc_id = getStr(request.getParameter("doc_id"));//文档编号

	//查询租金本金利息的三个分别得总合
	String  count_rent = "";
	String  count_corpus = "";
	String  count_interest = "";
	
	String query_count = "";
	query_count = "select sum(rent) as count_rent,sum(corpus) as count_corpus,sum(interest) as count_interest from fund_rent_plan_temp where begin_id='"+begin_id+"' and doc_id='"+doc_id+"'";
	
	rs = db.executeQuery(query_count);
	if(rs.next()){
		count_rent = formatNumberDoubleTwo(getDBStr(rs.getString("count_rent")));
		count_corpus = formatNumberDoubleTwo(getDBStr(rs.getString("count_corpus")));
		count_interest = formatNumberDoubleTwo(getDBStr(rs.getString("count_interest")));
	}
	rs.close();
 %>
 
<body  onload="public_onload(0);">
<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>期项</th>
		<th>应收日期</th>
        <th>租金</th>
        <th>本金</th>
        <th>利息</th>
        <th>状态</th>
        <th>本金余额</th>      
        <th>计划收款银行</th>      
        <th>计划收款账号</th>      
      </tr>
<%	  
	//---查询租金计划--
	sqlstr = "select rent_list,plan_date,rent,plan_status,corpus,interest,corpus_overage,plan_bank_name,plan_bank_no from fund_rent_plan_temp ";
	sqlstr += " where begin_id='"+begin_id+"' and doc_id='"+doc_id+"' order by rent_list";
	LogWriter.logDebug(request, "起租 - 租金计划 -- sqlstr查询sql语句==>> "+sqlstr);
	rs = db.executeQuery(sqlstr);
	while(rs.next()) {
%>
      <tr class="maintab_content_table_title">
		<td><%=CurrencyUtil.convertIntAmount(rs.getString("rent_list")) %></td> 
		<td><%=getDBDateStr(rs.getString("plan_date")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("rent")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("corpus")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("interest")) %></td> 
		<td><%=getDBStr(rs.getString("plan_status")) %></td> 
		<td><%=CurrencyUtil.convertFinance(rs.getString("corpus_overage")) %></td> 
		<td><%=getDBStr(rs.getString("plan_bank_name")) %></td> 
		<td><%=getDBStr(rs.getString("plan_bank_no")) %></td> 
      </tr>
<%
	}
db.close();
%>
	<tr class="maintab_content_table_title" > 
		<td colspan="">&nbsp;</td>
		<td colspan="">&nbsp;</td>
		<td colspan="">合计:<%=formatNumberStr( count_rent,"#,##0.00") %></td>
		<td colspan="">合计:<%=formatNumberStr( count_corpus,"#,##0.00") %></td>
		<td colspan="">合计:<%=formatNumberStr( count_interest,"#,##0.00") %></td>
		<td colspan="">&nbsp;</td>
	</tr>
   </table>
</div>
</div>

</body>
</html>
