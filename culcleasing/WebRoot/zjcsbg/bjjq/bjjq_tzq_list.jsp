<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 租金回笼计划</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body style="overflow:auto;" >
<%
	ArrayList alCash=new ArrayList();
	String strSql = "";
	int int_count = 0;
	ArrayList al = new ArrayList();
    String contract_id = getStr(request.getParameter("contract_id"));
    String fund_id = getStr(request.getParameter("fund_id"));
    String doc_id = getStr(request.getParameter("doc_id"));
    String ets_number = getStr(request.getParameter("ets_number"));
    
    strSql = "select count(*) as count from fund_contract_plan_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"'";
    ResultSet rsCount = null;
    ResultSet rsPlan = null;
    ResultSet rsOld = null;
    System.out.println(strSql);
    rsCount = db.executeQuery(strSql);
    if(rsCount.next()){
    	int_count = Integer.parseInt(rsCount.getString("count"));
    }
    rsCount.close();
	if(int_count>0){
	    strSql = "select * from fund_contract_plan_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"' order by plan_list";
	    System.out.println(strSql);
	    rsPlan = db.executeQuery(strSql);
	    while(rsPlan.next()){
	    	HashMap hm = new HashMap();
	    	hm.put("rent_date",getDBDateStr(rsPlan.getString("plan_date")));
	    	hm.put("volume",getDBStr(rsPlan.getString("plan_list")));
	    	hm.put("corpus",formatNumberStr(getDBStr(rsPlan.getString("corpus")),"#,##0.00"));
	    	hm.put("year_rate",formatNumberInterest(getDBStr(rsPlan.getString("year_rate"))));
	    	hm.put("interest",formatNumberStr(getDBStr(rsPlan.getString("interest")),"#,##0.00"));
	    	hm.put("rent",formatNumberStr(getDBStr(rsPlan.getString("rent")),"#,##0.00"));
	    	hm.put("caution_deduction",formatNumberStr(getDBStr(rsPlan.getString("caution_deduction")),"#,##0.00"));
	    	hm.put("otherinput",formatNumberStr(getDBStr(rsPlan.getString("fund_in")),"#,##0.00"));
	    	hm.put("otheroutput",formatNumberStr(getDBStr(rsPlan.getString("fund_out")),"#,##0.00"));
	    	hm.put("net_flow",formatNumberStr(getDBStr(rsPlan.getString("net_flow")),"###0.00"));
	    	alCash.add(hm);
	    }
	    rsPlan.close();
    }else{
    	 
    }
    
 %>


	

<!-- end cwCellTop -->

<div id="divH" class="tabBody" style="background:#ffffff;width:100%;overflow:auto;">
<div id="TD_tab_0">


    <form name="list">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>请款日</th>
		<th>序号</th>
		<th>本金</th>
		<th>利率(%)</th>
		<th>利息</th>
		<th>租金</th>
		<th>保证金抵扣租金</th>
		<th>其他收入</th>
		<th>其他支出</th>
		<th>净流量</th>
      <%
     ArrayList alirr = new ArrayList();
     
		for(int i=0;i<alCash.size();i++){
		HashMap hm = (HashMap)alCash.get(i);
		 %>
		<tr>
		<td><%=hm.get("rent_date")%></td>
		<td><%=hm.get("volume")%></td>
		<td><%=hm.get("corpus")%></td>
		<td><%=hm.get("year_rate")%></td>
		<td><%=hm.get("interest")%></td>
		<td><%=hm.get("rent")%></td>
		<td><%=hm.get("caution_deduction") %></td>
		<td><%=hm.get("otherinput") %></td>
		<td><%=hm.get("otheroutput") %></td>
		<td><%=hm.get("net_flow") %></td>
		<%
		alirr.add(new BigDecimal((String)hm.get("net_flow"))); %>
      </tr>
      
	<%}
	 %>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td>IRR:<%=formatNumberDoubleSix(Double.parseDouble(getIRR(alirr,"1","1","12"))*100) %></td>
      </tr>
    </table>
</form>
<%
	
	db.close();
	
 %>
</div>
</div>

</body>
</html>


