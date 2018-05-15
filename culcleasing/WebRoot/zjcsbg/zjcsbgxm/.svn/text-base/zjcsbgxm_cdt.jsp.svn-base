<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title> 租金测算 - 项目交易结构</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>
<script src="../../js/rent.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<body  onload="setDivHeightJsp('divH',-55);fun_rent();"  style="overflow:auto;">
<%String lease_money="0";
lease_money = getZeroStr(getStr(request.getParameter("lease_money")));
String proj_id = getStr(request.getParameter("proj_id")); 
String doc_id = getStr(request.getParameter("doc_id"));
String csflag = getStr(request.getParameter("cs"));
String rent = getStr(request.getParameter("rent"));
String readonly = getStr(request.getParameter("readonly"));
%>
<%
	String equip_amt = "0";
	String lease_term = "0";
	String income_number = "0";
	String income_number_year = "0";
	String year_rate = "0";
	String rate_float_type = "0";
	String period_type = "0";
	String settle_method = "0";
	String income_day = "0";
	String first_payment_ratio = "0";
	String first_payment = "0";
	String caution_money_ratio = "0";
	String caution_money = "0";
	String lessee_caution_ratio = "0";
	String lessee_caution_money = "0";
	String vndr_caution_ratio = "0";
	String vndr_caution_money = "0";
	String sale_caution_ratio = "0";
	String sale_caution_money = "0";
	String caution_deduction_ratio = "0";
	String caution_deduction_money = "0";
	String handling_charge_ratio = "0";
	String handling_charge = "0";
	String return_ratio = "0";
	String return_amt = "0";
	String supervision_fee_ratio = "0";
	String supervision_fee = "0";
	String consulting_fee = "0";
	String other_fee = "0";
	String nominalprice = "0";
	String insurance_method = "0";
	String insurance_lessor = "0";
	String insurance_lessee = "0";
	String redressalk = "0";
	String pena_rate = "0";
	String total_amt = "0";
	String actual_fund = "0";
	String rough_earn = "0";
	String year_earn = "0";
	String irr = "0";
	String first_date = getSystemDate(0);
	String second_date = getSystemDate(0);
	String start_date = getSystemDate(0);
	ResultSet rsCount = null;
	int iCount = 0;
	String sqlstr = "";
	sqlstr = "select count(*) as count from proj_condition_temp where proj_id='" + proj_id + "' and measure_id='"+doc_id+"'"; 
	System.out.println(sqlstr);
	rsCount = db.executeQuery(sqlstr); 
	if(rsCount.next()){
		iCount =Integer.parseInt(getDBStr(rsCount.getString("count")));
	}
	if(iCount>0){
		//
	}else{
		sqlstr = "insert into proj_condition_temp (proj_id,equip_amt,lease_money,lease_term,income_number_year,income_number,year_rate,rate_float_type,period_type,settle_method,income_day,start_date,first_date,second_date,first_payment_ratio,first_payment,caution_money_ratio,caution_money,lessee_caution_ratio,lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio,sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio,handling_charge,return_ratio,return_amt,supervision_fee_ratio,supervision_fee,consulting_fee,other_fee,nominalprice,insurance_method,insurance_lessor,insurance_lessee,redressalk,pena_rate,total_amt,actual_fund,rough_earn,year_earn,irr,plan_irr,creator,create_date,measure_id) select '"+proj_id+"',equip_amt,lease_money,lease_term,income_number_year,income_number,year_rate,rate_float_type,period_type,settle_method,income_day,start_date,first_date,second_date,first_payment_ratio,first_payment,caution_money_ratio,caution_money,lessee_caution_ratio,lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio,sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio,handling_charge,return_ratio,return_amt,supervision_fee_ratio,supervision_fee,consulting_fee,other_fee,nominalprice,insurance_method,insurance_lessor,insurance_lessee,redressalk,pena_rate,total_amt,actual_fund,rough_earn,year_earn,irr,plan_irr,creator,create_date,'"+doc_id+"' from proj_condition  where proj_condition.proj_id='"+proj_id+"'";
		System.out.println(sqlstr);
		db.executeUpdate(sqlstr);
	}
	
	sqlstr = "select * from proj_condition_temp where proj_id='" + proj_id + "' and measure_id='"+doc_id+"'";
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	if(rs.next()){
		equip_amt = formatNumberDoubleTwo(getDBStr(rs.getString("equip_amt")));
		lease_money = formatNumberDoubleTwo(getDBStr(rs.getString("lease_money")));
		lease_term = formatNumberDoubleZero(getDBStr(rs.getString("lease_term")));
		income_number = formatNumberDoubleZero(getDBStr(rs.getString("income_number")));
		income_number_year = formatNumberDoubleSix(getDBStr(rs.getString("income_number_year")));
		year_rate = formatNumberDoubleSix(getDBStr(rs.getString("year_rate")));
		rate_float_type = getDBStr(rs.getString("rate_float_type"));
		period_type = getDBStr(rs.getString("period_type"));
		settle_method = getDBStr(rs.getString("settle_method"));
		income_day = formatNumberDoubleZero(getDBStr(rs.getString("income_day")));
		first_payment_ratio = formatNumberDoubleSix(getDBStr(rs.getString("first_payment_ratio")));
		first_payment = formatNumberDoubleTwo(getDBStr(rs.getString("first_payment")));
		caution_money_ratio = formatNumberDoubleSix(getDBStr(rs.getString("caution_money_ratio")));
		caution_money = formatNumberDoubleTwo(getDBStr(rs.getString("caution_money")));
		lessee_caution_ratio = formatNumberDoubleSix(getDBStr(rs.getString("lessee_caution_ratio")));
		lessee_caution_money = formatNumberDoubleTwo(getDBStr(rs.getString("lessee_caution_money")));
		vndr_caution_ratio = formatNumberDoubleSix(getDBStr(rs.getString("vndr_caution_ratio")));
		vndr_caution_money = formatNumberDoubleTwo(getDBStr(rs.getString("vndr_caution_money")));
		sale_caution_ratio = formatNumberDoubleSix(getDBStr(rs.getString("sale_caution_ratio")));
		sale_caution_money = formatNumberDoubleTwo(getDBStr(rs.getString("sale_caution_money")));
		caution_deduction_ratio = formatNumberDoubleSix(getDBStr(rs.getString("caution_deduction_ratio")));
		caution_deduction_money = formatNumberDoubleTwo(getDBStr(rs.getString("caution_deduction_money")));
		handling_charge_ratio = formatNumberDoubleSix(getDBStr(rs.getString("handling_charge_ratio")));
		handling_charge = formatNumberDoubleTwo(getDBStr(rs.getString("handling_charge")));
		return_ratio = formatNumberDoubleSix(getDBStr(rs.getString("return_ratio")));
		return_amt = formatNumberDoubleTwo(getDBStr(rs.getString("return_amt")));
		supervision_fee_ratio = formatNumberDoubleSix(getDBStr(rs.getString("supervision_fee_ratio")));
		supervision_fee = formatNumberDoubleTwo(getDBStr(rs.getString("supervision_fee")));
		consulting_fee = formatNumberDoubleTwo(getDBStr(rs.getString("consulting_fee")));
		other_fee = formatNumberDoubleTwo(getDBStr(rs.getString("other_fee")));
		nominalprice = formatNumberDoubleTwo(getDBStr(rs.getString("nominalprice")));
		insurance_method = getDBStr(rs.getString("insurance_method"));
		insurance_lessor = formatNumberDoubleTwo(getDBStr(rs.getString("insurance_lessor")));
		insurance_lessee = formatNumberDoubleTwo(getDBStr(rs.getString("insurance_lessee")));
		redressalk = formatNumberDoubleSix(getDBStr(rs.getString("redressalk")));
		pena_rate = formatNumberDoubleSix(getDBStr(rs.getString("pena_rate")));
		total_amt = formatNumberDoubleTwo(getDBStr(rs.getString("total_amt")));
		actual_fund = formatNumberDoubleTwo(getDBStr(rs.getString("actual_fund")));
		rough_earn = formatNumberDoubleTwo(getDBStr(rs.getString("rough_earn")));
		year_earn = formatNumberDoubleTwo(getDBStr(rs.getString("year_earn")));
		irr = formatNumberDoubleSix(getDBStr(rs.getString("irr")));
		first_date = getDBDateStr(rs.getString("first_date"));
		second_date = getDBDateStr(rs.getString("second_date"));
		start_date  = getDBDateStr(rs.getString("start_date"));
	}
	rs.close();
	String sumrent = "";
	sqlstr = "select sum(rent) as sumrent from fund_rent_plan_proj where proj_id='"+proj_id+"'";
	System.out.println(sqlstr);
	ResultSet rssum = db.executeQuery(sqlstr);
	if(rssum.next()){
		sumrent = getDBStr(rssum.getString("sumrent"));
	}
	rssum.close();
	sqlstr = "select pena_rate,pena_chs from base_pena_rate";
	System.out.println(sqlstr);
	ResultSet rsPena = db.executeQuery(sqlstr);
	String textPena = "";
	String valuePena = "";
	while (rsPena.next()){
		textPena+="|"+getDBStr(rsPena.getString("pena_chs"));
		valuePena+="|"+formatNumberDoubleSix(getDBStr(rsPena.getString("pena_rate")));
	}
	rsPena.close();
	db.close();
 %>
<form name="form1" id="form1" method="post" target="rentplan" action="zjcsbgxm_save.jsp" onSubmit="return Validator.Validate(document.getElementById('form1'),3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->

<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
</td></tr> 
<tr>
<td>
<!--操作按钮开始-->
<table border="0" cellspacing="0" cellpadding="0">    
<tr class="maintab_dh"><td nowrap >	
    </td></tr>
</table>
<!--操作按钮结束-->
</td>
</tr>
<tr><td height="1" bgcolor="#DFDFDF"></td></tr>
<tr><td height="5"></td></tr>
<tr><td width="100%">
 <table border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td id="Form_tab_1" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
  <td id="Form_tab_2" class="Form_tab" width=0 align=center onclick="chgTabN()"  valign="middle"></td>
 </tr>
 </table></td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->
<!-- end cwCellTop -->
<div id="mydiv" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="proj_id" value="<%=proj_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="cs" value="<%=csflag %>">
<input type="hidden" name="savetype" value="add_deal">
<input type="hidden" name="readonly" value="<%=readonly %>">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<td>申请金额（设备金额）</td>
    <td><input name="equip_amt" type="text" value="<%=equip_amt %>" dataType="Rate" size="20" maxlength="100" maxB="100"  Require="true"  onPropertychange="fun_sub(document.forms[0].equip_amt.value,document.forms[0].equip_amt.value*document.forms[0].first_payment_ratio.value/100,document.forms[0].lease_money)" onblur="fun_equipChange();"><span class="biTian">*</span>
	</td>
    <td>租金概算本金</td>
    <td><input name="lease_money" type="text" value="<%=lease_money %>" dataType="Rate" size="20" maxlength="50" maxB="50" value="<%=lease_money %>"  Require="true"  readonly  onPropertychange="fun_corpusToRent()">
    <span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>租赁合同总金额</td>
	<td><input type="button" value="=" onclick="fun_contract()"><input name="total_amt" type="text" value="<%=total_amt %>" dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  	<td>我司实际需动用资金</td>
    <td><input type="button" value="=" onclick="fun_charge()"><input name="actual_fund" type="text" value="<%=actual_fund %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
</tr>
  <tr>
  	<td>还租次数</td>
    <td><input name="income_number" onPropertychange="fun_term(document.forms[0].income_number_year.value)" type="text" value="<%=income_number %>" dataType="Number" size="10" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span>
	</td>
	<td>还租方式</td>
	<td><select name="income_number_year" onPropertychange="fun_term(this.options[this.options.selectedIndex].value)" Require="true"><script>w(mSetOpt('<%=formatNumberDoubleZero(income_number_year) %>',"月付|季付|半年付|年付","12|4|2|1"));</script></select><span class="biTian">*</span>
	租赁期限（月）<input name="lease_term" type="text" value="<%=lease_term %>" dataType="Number" size="10" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span>
	</td>
  </tr>	
  <tr>
  	<td>期初（期末）支付</td>
    <td><select name="period_type" onPropertyChange="fun_period(this.options[this.options.selectedIndex].value)">
        <script>w(mSetOpt('<%=period_type%>',"期初|期末","1|0"));</script>
        </select><span class="biTian">*</span>
	</td>
	<td>利率浮动类型</td>
	<td><select name="rate_float_type"  Require="true"><script>w(mSetOpt('<%=rate_float_type%>',"浮动利率|固定利率"));</script></select><span class="biTian">*</span></td>
  </tr>
  <tr>
	<td>租赁年利率</td>
    <td><input name="year_rate" type="text" value="<%=year_rate %>"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onPropertychange="fun_rent()">%<span class="biTian">*</span>
	</td>
	<td>租金计算方式</td>
	<td><select name="rent_style" onPropertychange="fun_style(this.options[this.options.selectedIndex].value)"><script>w(mSetOpt('',"已知利率算租金|已知租金算利率","0|1"));</script></select></td>
  </tr>	
  <tr>
  	<td>每月偿付日</td>
    <td><input name="income_day" type="text" value="<%=income_day %>"  dataType="Number" size="10" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span></td>
	<td>结算方式</td>
	<td><select name="settle_method"></select></td>
  </tr>
  <tr>
  	<td>首期租金偿付日期</td>
    <td><input name="charge_first_date" type="text" value="<%=first_date %>"  onPropertychange="fun_term(document.forms[0].income_number_year.value);fun_secDate(document.forms[0].income_number_year.value);" dataType="Date" size="10" maxlength="10" maxB="10"  Require="true"><img  onClick="openCalendar(charge_first_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span>
	</td>
	<td>二期租金偿付日期</td>
	<td><input name="rent_first_date" type="text" value="<%=second_date %>"  onPropertychange="fun_term(document.forms[0].income_number_year.value)" dataType="Date" size="10" maxlength="10" maxB="10"  Require="true"><img  onClick="openCalendar(rent_first_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  </tr>
   <tr>
  	<td>预定起租日</td>
  	<td><input name="start_date" type="text" value="<%=start_date %>"  dataType="Date" size="10" maxlength="10" maxB="10"  Require="true"><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  	<td></td>
  	<td></td>
  </tr>
	<tr>
	<td>首付款比率</td>
	<td><input name="first_payment_ratio" type="text" value="<%=first_payment_ratio %>"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].first_payment_ratio.value,document.forms[0].first_payment,document.forms[0].equip_amt.value);" onPropertychange="fun_sub(document.forms[0].equip_amt.value,document.forms[0].first_payment.value,document.forms[0].lease_money);">%<span class="biTian">*</span></td>
  
  
  	<td>租金首付款</td>
    <td><input name="first_payment" type="text" value="<%=first_payment %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].first_payment.value,document.forms[0].first_payment_ratio,document.forms[0].equip_amt.value)" onPropertychange="fun_sub(document.forms[0].equip_amt.value,document.forms[0].first_payment.value,document.forms[0].lease_money);"><span class="biTian">*</span>
	</td>
</tr>

  <tr>
	<td>保证金比率</td>
	<td><input name="caution_money_ratio" type="text" value="<%=caution_money_ratio %>"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].caution_money_ratio.value,document.forms[0].caution_money,document.forms[0].equip_amt.value);" onPropertychange="fun_margin()">%<span class="biTian">*</span></td>
  
  	<td>租赁保证金</td>
    <td><input name="caution_money" type="text" value="<%=caution_money %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].caution_money.value,document.forms[0].caution_money_ratio,document.forms[0].equip_amt.value);fun_marginMoney();"><span class="biTian">*</span>
	</td>
	 </tr>
  <tr>
	<td>承租人保证金比率</td>
	<td><input name="lessee_caution_ratio" type="text" value="<%=lessee_caution_ratio %>"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].lessee_caution_ratio.value,document.forms[0].lessee_caution_money,document.forms[0].equip_amt.value)">%<span class="biTian">*</span></td>
 
  <td>承租人保证金金额</td>
	<td><input name="lessee_caution_money" type="text" value="<%=lessee_caution_money %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].lessee_caution_money.value,document.forms[0].lessee_caution_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  	</tr>
  <tr>
  	<td>供应商保证金比率</td>
    <td><input name="vndr_caution_ratio" type="text" value="<%=vndr_caution_ratio %>"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].vndr_caution_ratio.value,document.forms[0].vndr_caution_money,document.forms[0].equip_amt.value)">%<span class="biTian">*</span>
	</td>
	<td>供应商保证金金额</td>
	<td><input name="vndr_caution_money" type="text" value="<%=vndr_caution_money %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].vndr_caution_money.value,document.forms[0].vndr_caution_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>代理商保证金比率</td>
    <td><input name="sale_caution_ratio" type="text" value="<%=sale_caution_ratio %>"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].sale_caution_ratio.value,document.forms[0].sale_caution_money,document.forms[0].equip_amt.value)">%<span class="biTian">*</span>
	</td>
	<td>代理商保证金金额</td>
	<td><input name="sale_caution_money" type="text" value="<%=sale_caution_money %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].sale_caution_money.value,document.forms[0].sale_caution_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>保证金抵扣比率</td>
    <td><input name="caution_deduction_ratio" type="text" value="<%=caution_deduction_ratio %>"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].caution_deduction_ratio.value,document.forms[0].caution_deduction_money,document.forms[0].equip_amt.value)">%<span class="biTian">*</span>
	</td>
	<td>保证金抵扣金额</td>
	<td><input name="caution_deduction_money" type="text" value="<%=caution_deduction_money %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].caution_deduction_money.value,document.forms[0].caution_deduction_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
   <tr>
  	<td>手续费比率</td>
    <td><input name="handling_charge_ratio" type="text" value="<%=handling_charge_ratio %>"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true"  onblur="getMoney(document.forms[0].handling_charge_ratio.value,document.forms[0].handling_charge,document.forms[0].equip_amt.value)">%<span class="biTian">*</span>
	</td>
	<td>手续费</td>
	<td><input name="handling_charge" type="text" value="<%=handling_charge %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"  onblur="fun_getRadio(document.forms[0].handling_charge.value,document.forms[0].handling_charge_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>厂商返利比率</td>
    <td><input name="return_ratio" type="text" value="<%=return_ratio %>"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].return_ratio.value,document.forms[0].return_amt,document.forms[0].equip_amt.value)">%<span class="biTian">*</span>
	</td>
	<td>厂商返利</td>
	<td><input name="return_amt" type="text" value="<%=return_amt %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].return_amt.value,document.forms[0].return_ratio,document.forms[0].equip_amt.value,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>监管费比率</td>
    <td><input name="supervision_fee_ratio" type="text" value="<%=supervision_fee_ratio %>"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].supervision_fee_ratio.value,document.forms[0].supervision_fee,document.forms[0].equip_amt.value)">%<span class="biTian">*</span>
	</td>
	<td>监管费</td>
	<td><input name="supervision_fee" type="text" value="<%=supervision_fee %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].supervision_fee.value,document.forms[0].supervision_fee_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>我司支付的介绍费</td>
    <td><input name="consulting_fee" type="text" value="<%=consulting_fee %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
	<td>我司支付的其他费用</td>
	<td><input name="other_fee" type="text" value="<%=other_fee %>"  dataType="Money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>期末残值（或名义留购价）</td>
    <td><input name="nominalprice" type="text" value="<%=nominalprice %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
	<td>保险费(我司支付)</td>
	<td><input name="insurance_lessor" type="text" value="<%=insurance_lessor %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>保险费(客户自付)</td>
    <td><input name="insurance_lessee" type="text" value="<%=insurance_lessee %>"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
	<td>保险费支付方式</td>
	<td><select name="insurance_method"  Require="true"></select><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>罚息利率</td>
    <td><select name="pena_rate" Require="true"><script>w(mSetOpt('<%=pena_rate %>',"<%=textPena%>","<%=valuePena%>"));</script></select><span class="biTian">*</span>
	</td>
	
  
  	<td>年平均收益（静态收益）</td>
    <td><input type="button" value="=" onclick="fun_earn()"><input name="year_earn" type="text" value="<%=year_earn %>"  dataType="Rate" size="10" maxlength="20" maxB="20"  Require="true"> % <span class="biTian">*</span>
	</td>
	</tr>

  <tr>
	<td>年内部收益率IRR</td>
	<td><input name="irr" type="text" value="<%=irr %>" dataType="Rate" size="10" maxlength="20" maxB="20"  Require="true"> % <span class="biTian">*</span></td>
  
  	
	<td></td>
	<td></td>
  	</tr>
  <tr>
  	<td>项目粗利</td>
	<td><input name="rough_earn" type="text" value="<%=rough_earn %>" dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
	<td>租金</td>
	<td><input type="hidden" name="allRent" value="<%=sumrent %>" onPropertyChange="fun_contract()"><input type="button" value="=" onclick="fun_rent();"><input type="text" name="rent" size="20" value="<%=rent %>" dataType="Rate" onPropertychange="fun_subRent('<%=sumrent %>')"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if(readonly!=null&&readonly.equals("1")){}else{ %><input type="button" value="预算" onclick="if(Validator.Validate(document.getElementById('form1'),3)){fun_rent();fun_prodRent();}"><%} %></td>
  </tr>	
</table>
</div>
</div>
</form>
</body>
</html>
<script language="javascript"> 
dict_list("settle_method","BalanceWay","<%=settle_method%>","name");
dict_list("insurance_method","InsuranceType","<%=insurance_method%>","name");

function fun_period(varValue){
	fun_period_rent(varValue,"zjcsbgxm_check.jsp");
}
function fun_interest(){
	fun_interest_rent("zjcsbgxm_check.jsp");
}

function fun_rentSub(){
	fun_rentSub_rent("zjcsbgxm_save.jsp","rentplan","add_deal",form1);
}
</script>