<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 偿还计划变更</title>
<!-- 租金计划变更--当前租金计划查询 sea  -->
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<body style="overflow:auto;" >
<%
	
    String proj_id = getStr(request.getParameter("proj_id"));//项目编号
    String contract_id = getStr(request.getParameter("contract_id"));//合同编号
    String doc_id = getStr(request.getParameter("doc_id"));//文档编号
    
	String sqlstrs = " select * from contract_condition where contract_id = '"+contract_id+"' "; 
	ResultSet rs_one = db.executeQuery(sqlstrs);
	System.out.println("contract_condition==>==>  : "+sqlstrs);
	String income_number = "";//还租次数
	while(rs_one.next()){
		income_number = getDBStr(rs_one.getString("income_number"));
		System.out.println("income_number==>==>  : "+income_number);
	}
	rs_one.close();
    String sqlstr = "";
    ResultSet rs;
	//查询当前的回笼计划，在正式表‘fund_rent_plan’表中查询
	sqlstr = "select * from fund_rent_plan where contract_id='" + contract_id + "' order by rent_list"; 
	rs = db.executeQuery(sqlstr); 
	System.out.println("sqlstr==)))))))))))))  "+sqlstr);
 %>

<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">

    <form name="list">
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>计划日期</th>
		<th>期数</th>
		<th>租金</th>
		<th>本金</th>
		<th>利率(%)</th>
		<th>利息</th>
		<th>剩余本金</th>
		<th>回笼状态</th>
      </tr>
<%
	while(rs.next()){
%>
		<tr>
			<td align="center">
				<%=getDBDateStr(rs.getString("plan_date"))%>
			</td>
		<%
			//增加超链接时只给 未回笼的增加  并且第一期不能进行变更
			if(getDBStr(rs.getString("plan_status")).equals("未回笼") && !getDBStr(rs.getString("rent_list")).equals("1")){ 
		%>
			<td align="center">
				<!--  该连接所带值依次为：文档编号，项目编号，期数  -->
				<a target="ets_info" 
				href="zq_ets.jsp?doc_id=<%=doc_id%>&proj_id=<%=proj_id%>&start_rent_list=<%=getDBStr(rs.getString("rent_list"))%>&contract_id=<%=contract_id%>&income_number=<%=income_number%>">
				<%=getDBStr(rs.getString("rent_list"))%>
				</a>
			</td>
		<%
			}else{ 
			//corpus_market,interest_market,corpus_overage_market
		%>
			<td align="center">
				<%=getDBStr(rs.getString("rent_list"))%>
			</td>
		<%} %>
			<td align="center">
				<%=formatNumberStr(getDBStr(rs.getString("rent")),"#,##0.00")%>
			</td>
			<td align="center">
				<%=formatNumberStr(getDBStr(rs.getString("corpus_market")),"#,##0.00")%>
			</td>
			<td align="center">
				<%=formatNumberInterest(getDBStr(rs.getString("year_rate")))%>
			</td>
			<td align="center">
				<%=formatNumberStr(getDBStr(rs.getString("interest_market")),"#,##0.00")%>
			</td>
			<td align="center">
				<%=formatNumberStr(getDBStr(rs.getString("corpus_overage_market")),"#,##0.00")%>
			</td>
			<td align="center">
				<%=getDBStr(rs.getString("plan_status"))%>
			</td>
      </tr>
<%
	}
	rs.close();
	db.close();
%>
    </table>
</form>
</div>
</div>
</body>

</html>
