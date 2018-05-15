<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金偿还进展</title>
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

<%
	//租金计划
	String proj_id = getStr(request.getParameter("proj_id"));//项目编号
	String contract_id = "";
	
	sqlstr = "Select contract_id from contract_info where proj_id='"+proj_id+"'";
	rs = db.executeQuery(sqlstr);
	if(rs.next()){
		contract_id = getDBStr(rs.getString("contract_id"));
	}
	rs.close();
	
	//查询租金本金利息的三个分别得总合
	String  count_rent = "";
	String  count_corpus = "";
	String  count_interest = "";
	
	String query_count = "";
	query_count = "select sum(rent) as count_rent,sum(corpus) as count_corpus,sum(interest) as count_interest from fund_rent_plan where contract_id='"+contract_id+"'";
	
	rs = db.executeQuery(query_count);
	if(rs.next()){
		count_rent = formatNumberDoubleTwo(getDBStr(rs.getString("count_rent")));
		count_corpus = formatNumberDoubleTwo(getDBStr(rs.getString("count_corpus")));
		count_interest = formatNumberDoubleTwo(getDBStr(rs.getString("count_interest")));
	}
	rs.close();
 %>
 
<body style="height: 700px;overflow:auto;">

<!--列表开始-->
<div style="vertical-align:top;width:100%;overflow:auto;position: relative; left: 0px; top: 10px"  id="mydiv";>
   <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
   class="maintab_content_table" >
      <tr class="maintab_content_table_title">
		<th>期项</th>
		<th>应收日期</th>
        <th>租金</th>
        <th>本金</th>
        <th>利息</th>
        <th>本金余额</th>      
        <th>计划收款银行</th>      
        <th>计划收款账号</th> 
        <th>状态</th>     
      </tr>
      <tbody id="data">
<%	  
	//---查询租金计划--
	sqlstr = "select rent_list,plan_date,rent,corpus,interest,corpus_overage,plan_bank_name,plan_bank_no,plan_status from fund_rent_plan ";
	sqlstr += " where contract_id='"+contract_id+"' order by begin_id,rent_list";
	LogWriter.logDebug(request, "项目总表 - 租金偿还进展 -- sqlstr查询sql语句==>> "+sqlstr);
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
		<td><%=getDBStr(rs.getString("plan_bank_name")) %></td> 
		<td><%=getDBStr(rs.getString("plan_bank_no")) %></td> 
		<td><%=getDBStr(rs.getString("plan_status")) %></td> 	
      </tr>
<%
	}
db.close();
%>
	</tbody>
	<tr> 
		<td colspan="">&nbsp;</td>
		<td colspan="">&nbsp;</td>
		<td colspan="" style="font-weight: bold;">合计:<%=formatNumberStr( count_rent,"#,##0.00") %></td>
		<td colspan="" style="font-weight: bold;">合计:<%=formatNumberStr( count_corpus,"#,##0.00") %></td>
		<td colspan="" style="font-weight: bold;">合计:<%=formatNumberStr( count_interest,"#,##0.00") %></td>
		<td colspan="">&nbsp;</td>	<td colspan="">&nbsp;</td>
		<td colspan="">&nbsp;</td>	<td colspan="">&nbsp;</td>
	</tr>
   </table>
</div>

</body>
</html>
