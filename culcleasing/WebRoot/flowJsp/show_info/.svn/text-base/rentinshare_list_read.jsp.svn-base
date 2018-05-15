<%@ page contentType="text/html; charset=gbk" language="java"  errorPage="/public/pageError.jsp" %>
<%@ page import="com.tenwa.util.CurrencyUtil"%>

<%@ include file="../../public/simpleHeadImport.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 收益分摊表</title>
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/calend.js"></script>
<script type="text/javascript"></script>
</head>

<!-- 公共变量 -->
<%@ include file="../../public/commonVariable.jsp"%>
<!-- 公共变量 -->

<%
	//获取查询条件
	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id")); 
	//市场现金流
	sqlstr = " select * from fund_contract_income_share_temp where contract_id='"+contract_id+"' and doc_id='"+doc_id+"' order by plan_date"; 
	System.out.println("签约审批-收益分摊 -- sqlstr查询sql语句==>> "+sqlstr);
	rs = db.executeQuery(sqlstr);
%>
<body onLoad="public_onload(0)">
<form name="form1" action="rentcash_list_read.jsp"  onSubmit="return goPage()">
<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" 
    height="100%" class="maintab_content_table" >
      <tr class="maintab_content_table_title">
	    <th>期项</th>
	    <th>日期</th>
		<th>租金</th>
		<th>确认的融资收入</th>
		<th>投资净额减少</th>
		<th>租赁投资净额余额</th>
      </tr>
<%	  
	while(rs.next()) {
%>
      <tr>
      	<td nowrap align="center"><%=CurrencyUtil.convertIntAmount(rs.getString("rent_list")) %></td>
      	<td nowrap align="center"><%=getDBDateStr(rs.getString("plan_date"))%></td>
		<td nowrap align="center"><%=CurrencyUtil.convertFinance(rs.getString("rent"))%></td>
		<td nowrap align="center"><%=CurrencyUtil.convertFinance(rs.getString("leas_confirm_income"))%></td>
		<td nowrap align="center"><%=CurrencyUtil.convertFinance(rs.getString("leas_reduce"))%></td>
		<td nowrap align="center"><%=CurrencyUtil.convertFinance(rs.getString("leas_left"))%></td>
      </tr>
      
<%
	}
rs.close(); 
db.close();
%>
	  <tr>
	  	<td nowrap align="left" colspan="7">
	  	<font color="red">
	  		文档编号为:<%=doc_id%>&nbsp;
	  	</font>
	  	</td>
	  </tr>
    </table>
  </div>
  </div>
  
</form>
</body>
</html>
