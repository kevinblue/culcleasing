<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金展期 - 租金回笼计划</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body style="overflow:auto;" >
<%
	
	String contract_id = getStr(request.getParameter("contract_id"));
    String doc_id = getStr(request.getParameter("doc_id"));
    String strSql = "select * from fund_contract_plan where contract_id='" + contract_id + "' and measure_id='"+doc_id+"' order by plan_list";
    ResultSet rsPlan = null;
    rsPlan = db.executeQuery(strSql);
 %>


	

<!-- end cwCellTop -->

<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">

    <form name="list">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>请款日</th>
		<th>期数</th>
		<th>本金</th>
		<th>利率(%)</th>
		<th>利息</th>
		<th>租金</th>
		<th>其他收入</th>
		<th>其他支出</th>
		<th>净流量</th>
      </tr>
     <%
     ArrayList alirr = new ArrayList();
    while(rsPlan.next()){
		 %>
		<tr class="maintab_content_table_title">
		<td><%=getDBDateStr(rsPlan.getString("plan_date"))%></td>
		<td><%=getDBStr(rsPlan.getString("plan_list"))%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("corpus")),"#,##0.00")%></td>
		<td><%=formatNumberInterest(getDBStr(rsPlan.getString("year_rate")))%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("interest")),"#,##0.00")%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("rent")),"#,##0.00")%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("fund_in")),"#,##0.00") %></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("fund_out")),"#,##0.00") %></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("net_flow")),"#,##0.00") %></td>
		<%alirr.add(new BigDecimal(getDBStr(rsPlan.getString("net_flow")))); %>
      </tr>
      
	<%} %>
	
	<tr class="maintab_content_table_title">
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td>IRR:<%=formatNumberDouble(Double.parseDouble(getIRR(alirr,"1","1","12"))*100) %></td>
      </tr>
    
    </table>
</form>

</div>
</div>

</body>
</html>

<%db.close();%>