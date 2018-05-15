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
    
    ResultSet rsPlan = null;
	    strSql = "select * from fund_contract_plan_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"'  order by plan_list";
	    System.out.println(strSql);
	    rsPlan = db.executeQuery(strSql);
	    while(rsPlan.next()){
	    	HashMap hm = new HashMap();
	    	hm.put("rent_date",getDBDateStr(rsPlan.getString("plan_date")));
	    	hm.put("volume",getDBStr(rsPlan.getString("plan_list")));
	    	String return_corpus=getDBStr(rsPlan.getString("corpus"));
	    	hm.put("corpus",return_corpus!=null&&!return_corpus.equals("")?formatNumberStr(return_corpus,"#,##0.00"):"");
	    	String return_year_rate = getDBStr(rsPlan.getString("year_rate"));
	    	hm.put("year_rate",return_year_rate!=null&&!return_year_rate.equals("")?formatNumberDoubleSix(return_year_rate):"");
	    	String return_interest = getDBStr(rsPlan.getString("interest"));
	    	hm.put("interest",return_interest!=null&&!return_interest.equals("")?formatNumberStr(return_interest,"#,##0.00"):"");
	    	String return_rent = getDBStr(rsPlan.getString("rent"));
	    	hm.put("rent",return_rent!=null&&!return_rent.equals("")?formatNumberStr(return_rent,"#,##0.00"):"");
	    	String return_caution_deduction = getDBStr(rsPlan.getString("caution_deduction"));
	    	hm.put("caution_deduction",return_caution_deduction!=null&&!return_caution_deduction.equals("")?formatNumberStr(return_caution_deduction,"#,##0.00"):"");
	    	String return_fund_in = getDBStr(rsPlan.getString("fund_in"));
	    	hm.put("otherinput",return_fund_in!=null&&!return_fund_in.equals("")?formatNumberStr(return_fund_in,"#,##0.00"):"");
	    	String return_fund_out = getDBStr(rsPlan.getString("fund_out"));
	    	hm.put("otheroutput",return_fund_out!=null&&!return_fund_out.equals("")?formatNumberStr(return_fund_out,"#,##0.00"):"");
	    	String return_net_flow = getDBStr(rsPlan.getString("net_flow"));
	    	hm.put("net_flow",return_net_flow!=null&&!return_net_flow.equals("")?formatNumberStr(return_net_flow,"###0.00"):"");
	    	alCash.add(hm);
	    }
	    rsPlan.close();
   
    
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


