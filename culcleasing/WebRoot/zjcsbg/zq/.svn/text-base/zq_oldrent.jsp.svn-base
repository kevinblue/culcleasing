<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
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
    String readonly = getStr(request.getParameter("readonly"));
    
    String strSql = "select * from ";
    strSql += "fund_rent_plan";
    strSql +=" where contract_id='" + contract_id + "'";
    strSql+=" order by rent_list";
    ResultSet rsPlan = null;
    System.out.println(strSql);
    rsPlan = db1.executeQuery(strSql);
    ResultSet rsCount = null;
    int iCount = 0;
	String sqlstr = "select count(*) as count from contract_condition_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"'"; 
	System.out.println(sqlstr);
	rsCount = db.executeQuery(sqlstr); 
	if(rsCount.next()){
		iCount =Integer.parseInt(getDBStr(rsCount.getString("count")));
	}
	rsCount.close();
	if(iCount>0){
		//
	}else{
		sqlstr = "insert into contract_condition_temp (contract_id,equip_amt,lease_money,lease_term,income_number_year,income_number,year_rate,rate_float_type,period_type,settle_method,income_day,start_date,first_date,second_date,first_payment_ratio,first_payment,caution_money_ratio,caution_money,lessee_caution_ratio,lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio,sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio,handling_charge,return_ratio,return_amt,supervision_fee_ratio,supervision_fee,consulting_fee,other_fee,nominalprice,insurance_method,insurance_lessor,insurance_lessee,redressalk,pena_rate,total_amt,actual_fund,rough_earn,year_earn,irr,plan_irr,creator,create_date,measure_id) select '"+contract_id+"',equip_amt,lease_money,lease_term,income_number_year,income_number,year_rate,rate_float_type,period_type,settle_method,income_day,start_date,first_date,second_date,first_payment_ratio,first_payment,caution_money_ratio,caution_money,lessee_caution_ratio,lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio,sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio,handling_charge,return_ratio,return_amt,supervision_fee_ratio,supervision_fee,consulting_fee,other_fee,nominalprice,insurance_method,insurance_lessor,insurance_lessee,redressalk,pena_rate,total_amt,actual_fund,rough_earn,year_earn,irr,plan_irr,creator,create_date,'"+doc_id+"' from contract_condition  where contract_condition.contract_id='"+contract_id+"'";
		System.out.println(sqlstr);
		db.executeUpdate(sqlstr);
	}
	db.close();
 %>


	

<!-- end cwCellTop -->

<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">

    <form name="list">
	<input type="hidden" name="readonly" value="<%=readonly %>">
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
   
	<%
		while(rsPlan.next()){
		 %>
		<tr class="maintab_content_table_title" style="<%if(!getDBStr(rsPlan.getString("plan_status")).equals("未回笼")){ %>color:rad;<%}else{ %>cursor:hand;<%} %>" >
		<td><%=getDBDateStr(rsPlan.getString("plan_date"))%></td>
		<td><%if(getDBStr(rsPlan.getString("plan_status")).equals("未回笼")&&!(readonly!=null&&readonly.equals("1"))){ %><a target="ets_info" href="zq_ets.jsp?fund_id=<%=getDBStr(rsPlan.getString("id")) %>&volume=<%=getDBStr(rsPlan.getString("rent_list"))%>&contract_id=<%=contract_id %>&doc_id=<%=doc_id %>&readonly=<%=readonly %>"><%}%><%=getDBStr(rsPlan.getString("rent_list"))%><%if(getDBStr(rsPlan.getString("plan_status")).equals("未回笼")){ %></a><%} %></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("corpus")),"#,##0.00")%></td>
		<td><%=formatNumberInterest(getDBStr(rsPlan.getString("year_rate")))%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("interest")),"#,##0.00")%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("eptd_rent")),"#,##0.00")%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("rent")),"#,##0.00")%></td>
		<%double dadjust = 0;
		if(rsPlan.getBigDecimal("rent")!=null&&rsPlan.getBigDecimal("eptd_rent")!=null)
		dadjust = rsPlan.getBigDecimal("rent").doubleValue()-rsPlan.getBigDecimal("eptd_rent").doubleValue(); %>
		<td><%=formatNumberDouble(dadjust)%></td>
      </tr>
	<%}
	rsPlan.close();
	db1.close();
	 %>
    </table>
</form>

</div>
</div>

</body>

</html>

