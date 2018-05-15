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
    String flag = getStr(request.getParameter("flag"));
    String strSql = "select * from ";
    strSql += "fund_rent_plan_temp";
    strSql +=" where contract_id='" + contract_id + "'";
    strSql += " and measure_id='"+doc_id+"'";
    strSql+=" order by rent_list";
    ResultSet rsPlan = null;
    System.out.println(strSql);
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
		<th>预计租金</th>
		<th>实际租金</th>
		<th>调整额</th>
      </tr>
   
	<% while(rsPlan.next()){
		 %>
		<tr class="maintab_content_table_title" style="<%if(!getDBStr(rsPlan.getString("plan_status")).equals("0")){ %>color:rad;<%}else{ %>cursor:hand;<%} %>" >
		<td><%=getDBDateStr(rsPlan.getString("plan_date"))%></td>
		<td><%=getDBStr(rsPlan.getString("rent_list"))%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("corpus")),"#,##0.00")%></td>
		<td><%=formatNumberInterest(getDBStr(rsPlan.getString("year_rate")))%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("interest")),"#,##0.00")%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("eptd_rent")),"#,##0.00")%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("rent")),"#,##0.00")%></td>
		<%double dadjust = rsPlan.getBigDecimal("rent").doubleValue()-rsPlan.getBigDecimal("eptd_rent").doubleValue(); %>
		<td><input type="hidden" name="adjust_amount_<%=getDBStr(rsPlan.getString("rent_list")) %>" value="0"><%=formatNumberDouble(dadjust)%></td>
      </tr>
      <%} %>
    </table>
</form>

</div>
</div>

</body>

</html>
<%db.close();%>
