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
	String save = getStr(request.getParameter("save"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String contract_id = getStr(request.getParameter("contract_id"));
	String readonly = getStr(request.getParameter("readonly"));
	String edit_rent =  getStr(request.getParameter("edit_rent"));
	String eachRent = getStr(request.getParameter("rent"));
	String irr = getStr(request.getParameter("irr"));
	String charge_first_date = "";
    String rent_first_date = "";
    String start_date = "";
    String lease_term = "";
    String caution_deduction_money = "";
    String equip_amt = "";
    String first_payment = "";
    String caution_money = "";
    String handling_charge = "";
    String return_amt = "";
    String supervision_fee = "";
    String consulting_fee = "";
    String other_fee = "";
     String nominalprice = "";
    String insurance_lessor = "";
    int income_number = 0;
    int income_number_year = 0;
    String year_rate ="";
    String lease_money = "0";
    String period_type = "";
    String sql = "";
    sql = "select * from contract_condition_temp where contract_id='"+contract_id+"'";
	System.out.println(sql);
	ResultSet rsCdt = db.executeQuery(sql);
	if(rsCdt.next()){
		charge_first_date = getDBDateStr(rsCdt.getString("first_date"));
		rent_first_date = getDBDateStr(rsCdt.getString("second_date"));
		start_date = getDBDateStr(rsCdt.getString("start_date"));
		lease_term = getDBStr(rsCdt.getString("lease_term"));
		income_number = rsCdt.getInt("income_number");
		income_number_year = rsCdt.getInt("income_number_year");
		year_rate = getDBStr(rsCdt.getString("year_rate"));
		//lease_money = getDBStr(rsCdt.getString("lease_money"));
		caution_deduction_money = getDBStr(rsCdt.getString("caution_deduction_money"));
		period_type =getDBStr(rsCdt.getString("period_type"));
		equip_amt =getDBStr(rsCdt.getString("equip_amt"));
		first_payment =getDBStr(rsCdt.getString("first_payment"));
		caution_money =getDBStr(rsCdt.getString("caution_money"));
		handling_charge =getDBStr(rsCdt.getString("handling_charge"));
		return_amt =getDBStr(rsCdt.getString("return_amt"));
		supervision_fee =getDBStr(rsCdt.getString("supervision_fee"));
		consulting_fee =getDBStr(rsCdt.getString("consulting_fee"));
		other_fee =getDBStr(rsCdt.getString("other_fee"));
		nominalprice =getDBStr(rsCdt.getString("nominalprice"));
		insurance_lessor =getDBStr(rsCdt.getString("insurance_lessor"));
	}
	year_rate = getStr(request.getParameter("new_year_rate"));
	rsCdt.close();
	ResultSet rsPlan = null;
	ArrayList al = null;
	//年还租次数
	lease_money = getStr(request.getParameter("lease_money"));
	//展期后期数
	String ets_number = getStr(request.getParameter("ets_number"));
	//开始展期的期数
	String volume_id = getStr(request.getParameter("volume"));
	//开始展期的租金计划id
	String fund_id = getStr(request.getParameter("fund_id"));
	//展期手续费
	String exceedhandling_charge = getStr(request.getParameter("exceedhandling_charge"));
	//根据PMT生成租金
	String strSql = "select * from ";
    strSql += "fund_rent_plan_temp";
    strSql +=" where contract_id='" + contract_id + "'";
    strSql +=" and measure_id='"+doc_id+"' ";
    strSql+=" order by rent_list";
    System.out.println(strSql);
    rsPlan = db.executeQuery(strSql);
    
 %>


<form method="post" action="" target="new_plan">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap >
									<%if(readonly!=null&&readonly.equals("1")){}else{ %>修改预计租金 <input type="text" name="edit_rent" size="10" value="<%=edit_rent!=null&&!edit_rent.equals("")?edit_rent:eachRent %>"> <BUTTON class="btn_2" name="btnSave" value="租金调整"  type="button" onclick="fun_save()">
									<img src="../../images/save.gif" align="absmiddle" border="0">租金调整</button><%} %>
									<BUTTON class="btn_2" name="btnSave" value="察看现金流"  type="button" onclick="fun_xj()">
									<img src="../../images/save.gif" align="absmiddle" border="0">察看现金流</button>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- end cwCellTop -->
<% %>
<input type="hidden" name="charge_first_date" value="<%=charge_first_date %>">
<input type="hidden" name="rent_first_date" value="<%=rent_first_date %>">
<input type="hidden" name="start_date" value="<%=start_date %>">
<input type="hidden" name="lease_term" value="<%= lease_term%>">
<input type="hidden" name="income_number" value="<%=income_number %>">
<input type="hidden" name="income_number_year" value="<%=income_number_year %>">
<input type="hidden" name="new_year_rate" value="<%=year_rate %>">
<input type="hidden" name="lease_money" value="<%=lease_money %>">
<input type="hidden" name="caution_deduction_money" value="<%=caution_deduction_money %>">
<input type="hidden" name="period_type" value="<%=period_type %>">

<input type="hidden" name="equip_amt" value="<%=equip_amt %>">
<input type="hidden" name="first_payment" value="<%=first_payment %>">
<input type="hidden" name="caution_money" value="<%=caution_money %>">
<input type="hidden" name="handling_charge" value="<%=handling_charge %>">
<input type="hidden" name="return_amt" value="<%=return_amt %>">
<input type="hidden" name="supervision_fee" value="<%=supervision_fee %>">
<input type="hidden" name="consulting_fee" value="<%=consulting_fee %>">
<input type="hidden" name="other_fee" value="<%=other_fee %>">
<input type="hidden" name="nominalprice" value="<%=nominalprice %>">
<input type="hidden" name="insurance_lessor" value="<%=insurance_lessor %>">
<input type="hidden" name="new_rent" value="<%=eachRent %>">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="ets_number" value="<%=ets_number %>">
<input type="hidden" name="volume" value="<%=volume_id %>">
<input type="hidden" name="fund_id" value="<%=fund_id %>">
<input type="hidden" name="readonly" value="<%=readonly %>">
<input type="hidden" name="exceedhandling_charge" value="<%=exceedhandling_charge %>">
<input type="hidden" name="savetype" value="add">
<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">

    

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
		double dAllCorpus = 0;
		double dAllInsteret = 0;
		double dAllRent = 0;
		double dAlleptdRent = 0;
		while(rsPlan.next()){
		 %>
		<tr class="maintab_content_table_title" >
		<td><%=getDBDateStr(rsPlan.getString("plan_date"))%></td>
		<%int ivolume_id = 0;
		ivolume_id = Integer.parseInt(volume_id);
		 %>
		<td><%if(Integer.parseInt(getDBStr(rsPlan.getString("rent_list")))>=ivolume_id){ %><input type="hidden" name="rent_list" value="<%=getDBStr(rsPlan.getString("rent_list")) %>"><%}%><%=getDBStr(rsPlan.getString("rent_list"))%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("corpus")),"#,##0.00")%></td>
		<td><%=formatNumberInterest(getDBStr(rsPlan.getString("year_rate")))%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("interest")),"#,##0.00")%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("eptd_rent")),"#,##0.00")%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("rent")),"#,##0.00")%></td>
		<%
		dAllCorpus += Double.parseDouble(getDBStr(rsPlan.getString("corpus")));
		dAllInsteret += Double.parseDouble(getDBStr(rsPlan.getString("interest")));
		dAllRent += Double.parseDouble(getDBStr(rsPlan.getString("rent")));
		if(getDBStr(rsPlan.getString("eptd_rent"))!=null&&!getDBStr(rsPlan.getString("eptd_rent")).equals("")){
		dAlleptdRent += Double.parseDouble(getDBStr(rsPlan.getString("eptd_rent")));
		}
		double dadjust = 0;
		if(rsPlan.getBigDecimal("rent")!=null&&rsPlan.getBigDecimal("eptd_rent")!=null)
		dadjust = rsPlan.getBigDecimal("rent").doubleValue()-rsPlan.getBigDecimal("eptd_rent").doubleValue(); %>
		<td><%if(getDBStr(rsPlan.getString("plan_status")).equals("未回笼")&&Integer.parseInt(getDBStr(rsPlan.getString("rent_list")))>=ivolume_id){ %><input type="text" name="adjust_amount_<%=getDBStr(rsPlan.getString("rent_list")) %>" value="<%=dadjust%>"><%}else{ %><input type="hidden" name="adjust_amount_<%=getDBStr(rsPlan.getString("rent_list")) %>" value="<%=dadjust%>"><%=formatNumberDouble(dadjust)%><%} %></td>
      </tr>
	<%} %>
	
	<tr class="maintab_content_table_title">
		<td></td>
		<td></td>
		<td><%=formatNumberDouble(dAllCorpus) %></td>
		<td></td>
		<td><%=formatNumberDouble(dAllInsteret) %></td>
		<td><%=formatNumberDouble(dAlleptdRent) %></td>
		<td><%=formatNumberDouble(dAllRent) %></td>
		<td>IRR:<%=irr %></td>
      </tr>
    </table>


</div>
</div>
</form>
</body>

</html>
<script language="javascript">
function fun_hl(){
	document.forms[0].action="zq_newrent.jsp";
	document.forms[0].target="new_plan";
	document.forms[0].submit();
}
function fun_save(){
	document.forms[0].action="zq_save.jsp";
	document.forms[0].target="new_plan";
	document.forms[0].submit();
}
function fun_xj(){
	document.forms[0].action="zq_cash.jsp";
	document.forms[0].target="_black";
	document.forms[0].submit();
}
</script>
<%db.close();%>