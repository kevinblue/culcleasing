<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title> 租金测算 - 项目交易结构</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/rent.js"></script>
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<body onload="setDivHeight('divH',-55)"  style="overflow:auto;">
<%String lease_money = getStr(request.getParameter("lease_money")); %>
<form name="form1" method="post" target="qs" action="zjcs_fc.jsp" onSubmit="return Validator.Validate(this,3);">

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
 </td></tr> 
<tr><td class="tab_subline" width="100%" height="2"></td></tr>
</table>
<!-- end cwTop -->
<!-- end cwCellTop -->
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<td>申请金额（设备金额）</td>
    <td><input name="equip_amt" type="text" value="0" dataType="Rate" size="20" maxlength="100" maxB="100"  Require="true" onPropertychange="fun_sub(document.forms[0].equip_amt.value,document.forms[0].equip_amt.value*document.forms[0].first_payment_ratio.value/100,document.forms[0].lease_money);" onblur="fun_equipChange();"><span class="biTian">*</span>
	</td>
    <td>租金概算本金</td>
    <td><input name="lease_money" type="text" value="0" dataType="Rate" size="20" maxlength="50" maxB="50" value="<%=lease_money %>"  Require="true" readonly onPropertychange="fun_corpusToRent()">
    <span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>租赁合同总金额</td>
	<td><input type="button" value="=" onclick="fun_contract()"><input name="total_amt" type="text" value="0" dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  	<td>我司实际需动用资金</td>
    <td><input type="button" value="=" onclick="fun_charge()"><input name="actual_fund" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
  </tr>
  <tr>
  	<td>还租次数</td>
    <td><input name="income_number" onPropertychange="fun_term(document.forms[0].income_number_year.value)" type="text" value="0" dataType="Number" size="10" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span>
	</td>
	<td>还租方式</td>
	<td><select name="income_number_year" onPropertychange="fun_term(this.options[this.options.selectedIndex].value)" Require="true"><script>w(mSetOpt('12',"月付|季付|半年付|年付","12|4|2|1"));</script></select><span class="biTian">*</span>
	租赁期限（月）<input name="lease_term" type="text" value="0" dataType="Number" size="10" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span>
	</td>
  </tr>	
  <tr>
  	<td>期初（期末）支付</td>
    <td><select name="period_type" onPropertyChange="fun_period(this.options[this.options.selectedIndex].value)">
        <script>w(mSetOpt('0',"期初|期末","1|0"));</script>
        </select><span class="biTian">*</span>
	</td>
	<td>利率浮动类型</td>
	<td><select name="rate_float_type"  Require="true"><script>w(mSetOpt('浮动利率',"浮动利率|固定利率"));</script></select><span class="biTian">*</span></td>
  </tr>
  <tr>
	<td>租赁年利率</td>
    <td><input name="year_rate" type="text" value="0"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onPropertychange="fun_rent()"> %<span class="biTian">*</span>
	</td>
	<td>租金计算方式</td>
	<td><select name="rent_style" onPropertychange="fun_style(this.options[this.options.selectedIndex].value)"><script>w(mSetOpt('0',"已知利率算租金|已知租金算利率","0|1"));</script></select></td>
  </tr>	
  <tr>
  	<td>每月偿付日</td>
    <td><input name="income_day" type="text" value="0"  dataType="Number" size="10" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span></td>
	<td>结算方式</td>
	<td><select name="settle_method"></select><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>首期租金偿付日期</td>
    <td><input name="charge_first_date" onPropertychange="fun_term(document.forms[0].income_number_year.value);fun_secDate(document.forms[0].income_number_year.value);" type="text" value="<%=getSystemDate(0) %>"  dataType="Date" size="10" maxlength="10" maxB="10"  Require="true"><img  onClick="openCalendar(charge_first_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span>
	</td>
	<td>二期租金偿付日期</td>
	<td><input name="rent_first_date" onPropertychange="fun_term(document.forms[0].income_number_year.value)" type="text" value="<%=getDateAdd(getSystemDate(0),1,"mm") %>"  dataType="Date" size="10" maxlength="10" maxB="10"  Require="true"><img  onClick="openCalendar(rent_first_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>预定起租日</td>
  	<td><input name="start_date" type="text" value="<%=getSystemDate(0) %>"  dataType="Date" size="10" maxlength="10" maxB="10"  Require="true"><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
  	<td></td>
  	<td></td>
  </tr>
	<tr>
	<td>首付款比率</td>
	<td><input name="first_payment_ratio" type="text" value="0"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].first_payment_ratio.value,document.forms[0].first_payment,document.forms[0].equip_amt.value);" onPropertychange="fun_sub(document.forms[0].equip_amt.value,document.forms[0].equip_amt.value*document.forms[0].first_payment_ratio.value/100,document.forms[0].lease_money)"> %<span class="biTian">*</span></td>
  	<td>租金首付款</td>
    <td><input name="first_payment" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].first_payment.value,document.forms[0].first_payment_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span>
	</td>
  </tr>
  <tr>
	<td>保证金比率</td>
	<td><input name="caution_money_ratio" type="text" value="0"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].caution_money_ratio.value,document.forms[0].caution_money,document.forms[0].equip_amt.value);" onPropertychange="fun_margin()"> %<span class="biTian">*</span></td>
  
  	<td>租赁保证金</td>
    <td><input name="caution_money" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"  onblur="fun_getRadio(document.forms[0].caution_money.value,document.forms[0].caution_money_ratio,document.forms[0].equip_amt.value);fun_marginMoney();"><span class="biTian">*</span>
	</td>
	 </tr>
  <tr>
	<td>承租人保证金比率</td>
	<td><input name="lessee_caution_ratio" type="text" value="0"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].lessee_caution_ratio.value,document.forms[0].lessee_caution_money,document.forms[0].equip_amt.value)"> %<span class="biTian">*</span></td>
 
  <td>承租人保证金金额</td>
	<td><input name="lessee_caution_money" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].lessee_caution_money.value,document.forms[0].lessee_caution_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  	</tr>
  <tr>
  	<td>供应商保证金比率</td>
    <td><input name="vndr_caution_ratio" type="text" value="0"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].vndr_caution_ratio.value,document.forms[0].vndr_caution_money,document.forms[0].equip_amt.value)"> %<span class="biTian">*</span>
	</td>
	<td>供应商保证金金额</td>
	<td><input name="vndr_caution_money" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].vndr_caution_money.value,document.forms[0].vndr_caution_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>代理商保证金比率</td>
    <td><input name="sale_caution_ratio" type="text" value="0"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].sale_caution_ratio.value,document.forms[0].sale_caution_money,document.forms[0].equip_amt.value)"> %<span class="biTian">*</span>
	</td>
	<td>代理商保证金金额</td>
	<td><input name="sale_caution_money" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].sale_caution_money.value,document.forms[0].sale_caution_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>保证金抵扣比率</td>
    <td><input name="caution_deduction_ratio" type="text" value="0"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].caution_deduction_ratio.value,document.forms[0].caution_deduction_money,document.forms[0].equip_amt.value)"> %<span class="biTian">*</span>
	</td>
	<td>保证金抵扣金额</td>
	<td><input name="caution_deduction_money" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"  onblur="fun_getRadio(document.forms[0].caution_deduction_money.value,document.forms[0].caution_deduction_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
   <tr>
  	<td>手续费比率</td>
    <td><input name="handling_charge_ratio" type="text" value="0"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true"  onblur="getMoney(document.forms[0].handling_charge_ratio.value,document.forms[0].handling_charge,document.forms[0].equip_amt.value)"> %<span class="biTian">*</span>
	</td>
	<td>手续费</td>
	<td><input name="handling_charge" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"  onblur="fun_getRadio(document.forms[0].handling_charge.value,document.forms[0].handling_charge_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>厂商返利比率</td>
    <td><input name="return_ratio" type="text" value="0"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].return_ratio.value,document.forms[0].return_amt,document.forms[0].equip_amt.value)"> %<span class="biTian">*</span>
	</td>
	<td>厂商返利</td>
	<td><input name="return_amt" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"  onblur="fun_getRadio(document.forms[0].return_amt.value,document.forms[0].return_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>监管费比率</td>
    <td><input name="supervision_fee_ratio" type="text" value="0"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true" onblur="getMoney(document.forms[0].supervision_fee_ratio.value,document.forms[0].supervision_fee,document.forms[0].equip_amt.value)"> %<span class="biTian">*</span>
	</td>
	<td>监管费</td>
	<td><input name="supervision_fee" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true" onblur="fun_getRadio(document.forms[0].supervision_fee.value,document.forms[0].supervision_fee_ratio,document.forms[0].equip_amt.value)"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>我司支付的介绍费</td>
    <td><input name="consulting_fee" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
	<td>我司支付的其他费用</td>
	<td><input name="other_fee" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>期末残值（或名义留购价）</td>
    <td><input name="nominalprice" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
	<td>保险费(我司支付)</td>
	<td><input name="insurance_lessor" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<td>保险费(客户自付)</td>
    <td><input name="insurance_lessee" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
	<td></td>
	<td></td>
  </tr>
  <tr>
  	<td>罚息利率</td>
    <td><input name="pena_rate" type="text" value="0"  dataType="Rate" size="10" maxlength="10" maxB="10"  Require="true"> %<span class="biTian">*</span>
	</td>
  	<td>年平均收益（静态收益）</td>
    <td><input type="button" value="=" onclick="fun_earn()"><input name="year_earn" type="text" value="0"  dataType="Rate" size="10" maxlength="20" maxB="20"  Require="true"> % <span class="biTian">*</span>
	</td>
	</tr>
  <tr>
	<td>年内部收益率IRR</td>
	<td><input name="irr" type="text" value="0"  dataType="Rate" size="10" maxlength="20" maxB="20"  Require="true"> % <span class="biTian">*</span></td>
	<td></td>
	<td></td>
  	</tr>
  <tr>
  	<td>项目粗利</td>
	<td><input name="rough_earn" type="text" value="0"  dataType="Rate" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
	
	<td>租金</td>
	<td><input type="hidden" name="allRent" onPropertyChange="fun_contract()"><input type="text" name="rent" size="20" onPropertyChange="fun_subRent()"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="预算" onclick="if(Validator.Validate(document.getElementById('form1'),3)){fun_prodRent();}"> </td>
  </tr>	
</table>
</div>
</div>
</form>
</body>
</html>
<script language="javascript"> 
dict_list("settle_method","BalanceWay","BalanceWay3","name");

function fun_period(varValue){
	fun_period_rent(varValue,"zjcsbg_check.jsp");
}
function fun_interest(){
	fun_interest_rent("zjcsbg_check.jsp");
}

function fun_rentSub(){
	fun_rentSub_rent("zjcsbg_rent.jsp","rentplan");
}


</script>