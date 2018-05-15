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
<script src="../../js/validator.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/public.js"></SCRIPT>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>
<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<script language="javascript" src="/dict/js/ajax_popupDialog.js"></script>
</head>
<body>
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
<BUTTON class="btn_2" name="btnSave" value="保存"  type="submit" >
<img src="../../images/save.gif" align="absmiddle" border="0">保存</button>
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
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;height:500px;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="savetype" value="add">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<th scope="row">申请金额（设备金额）</th>
    <td><input name="equip_amt" type="text" value="0" dataType="money" size="20" maxlength="100" maxB="100"  Require="true"><span class="biTian">*</span>
	</td>
    <th scope="row">租金概算本金</th>
    <td><input name="lease_money" type="text" value="0" dataType="money" size="20" maxlength="50" maxB="50" value="<%=lease_money %>"  Require="true">
    <span class="biTian">*</span></td>
  </tr>
  <tr>
  	<th  scope="row">租赁合同总金额</th>
	<td><input name="total_amt" type="text" value="0" dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  	<th scope="row">我司实际需动用资金</th>
    <td><input name="actual_fund" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
</tr>
  <tr>
  	<th scope="row">租赁期限（月）</th>
    <td><input name="lease_term" type="text" value="0"  dataType="Number" size="20" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span>
	</td>
	<th  scope="row">每年还租期数</th>
	<td><input name="income_number" type="text" value="0"  size="20" maxlength="250" maxB="250"  Require="true"><span class="biTian">*</span></td>
  </tr>	
  <tr>
  	<th scope="row">租赁年利率</th>
    <td><input name="year_rate" type="text" value="0"  dataType="money" size="20" maxlength="10" maxB="10"  Require="true">%<span class="biTian">*</span>
	</td>
	<th  scope="row">利率浮动类型</th>
	<td><input name="rate_float_type" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
   <tr>
  	<th scope="row">期初（期末）支付</th>
    <td><select name="period_type">
        <script>w(mSetOpt('0',"期初|期末","1|0"));</script>
        </select><span class="biTian">*</span>
	</td>
	<th  scope="row">结算方式</th>
	<td><select name="settle_method"></select><span class="biTian">*</span></td>
  </tr>	
  <tr>
  	<th scope="row">每月偿付日</th>
    <td><input name="income_day" type="text" value="0"  dataType="Number" size="20" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span>
	</td>
	<th  scope="row">项目粗利</th>
	<td><input name="rough_earn" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
	</tr>
	  <tr>
  	<th scope="row">首期租金偿付日期</th>
    <td><input name="charge_first_date" type="text" value="<%=getSystemDate(0) %>"  dataType="date" size="20" maxlength="10" maxB="10"  Require="true"><img  onClick="openCalendar(charge_first_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span>
	</td>
	<th  scope="row">二期租金偿付日期</th>
	<td><input name="rent_first_date" type="text" value="<%=getSystemDate(0) %>"  dataType="date" size="20" maxlength="10" maxB="10"  Require="true"><img  onClick="openCalendar(rent_first_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>

  </tr>
	<tr>
	<th  scope="row">首付款比率</th>
	<td><input name="first_payment_ratio" type="text" value="0"  dataType="money" size="20" maxlength="10" maxB="10"  Require="true" onPropertychange="getMoney(document.forms[0].first_payment_ratio.value,document.forms[0].first_payment)">%<span class="biTian">*</span></td>
  
  
  	<th scope="row">租金首付款</th>
    <td><input name="first_payment" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
</tr>

  <tr>
	<th  scope="row">保证金比率</th>
	<td><input name="caution_money_ratio" type="text" value="0"  dataType="money" size="20" maxlength="10" maxB="10"  Require="true" onPropertychange="getMoney(document.forms[0].caution_money_ratio.value,document.forms[0].caution_money)">%<span class="biTian">*</span></td>
  
  	<th scope="row">租赁保证金</th>
    <td><input name="caution_money" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
	 </tr>
  <tr>
	<th  scope="row">承租人保证金比率</th>
	<td><input name="lessee_caution_ratio" type="text" value="0"  dataType="money" size="20" maxlength="10" maxB="10"  Require="true" onPropertychange="getMoney(document.forms[0].lessee_caution_ratio.value,document.forms[0].lessee_caution_money)">%<span class="biTian">*</span></td>
 
  <th  scope="row">承租人保证金金额</th>
	<td><input name="lessee_caution_money" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  	</tr>
  <tr>
  	<th scope="row">供应商保证金比率</th>
    <td><input name="vndr_caution_ratio" type="text" value="0"  dataType="money" size="20" maxlength="10" maxB="10"  Require="true" onPropertychange="getMoney(document.forms[0].vndr_caution_ratio.value,document.forms[0].vndr_caution_money)">%<span class="biTian">*</span>
	</td>
	<th  scope="row">供应商保证金金额</th>
	<td><input name="vndr_caution_money" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<th scope="row">代理商保证金比率</th>
    <td><input name="sale_caution_ratio" type="text" value="0"  dataType="money" size="20" maxlength="10" maxB="10"  Require="true" onPropertychange="getMoney(document.forms[0].sale_caution_ratio.value,document.forms[0].sale_caution_money)">%<span class="biTian">*</span>
	</td>
	<th  scope="row">代理商保证金金额</th>
	<td><input name="sale_caution_money" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<th scope="row">保证金抵扣比率</th>
    <td><input name="caution_deduction_ratio" type="text" value="0"  dataType="money" size="20" maxlength="10" maxB="10"  Require="true" onPropertychange="getMoney(document.forms[0].caution_deduction_ratio.value,document.forms[0].caution_deduction_money)"><span class="biTian">*</span>
	</td>
	<th  scope="row">保证金抵扣金额</th>
	<td><input name="caution_deduction_money" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
   <tr>
  	<th scope="row">手续费比率</th>
    <td><input name="handling_charge_ratio" type="text" value="0"  dataType="money" size="20" maxlength="10" maxB="10"  Require="true"  onPropertychange="getMoney(document.forms[0].handling_charge_ratio.value,document.forms[0].handling_charge)">%<span class="biTian">*</span>
	</td>
	<th  scope="row">手续费</th>
	<td><input name="handling_charge" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<th scope="row">厂商返利比率</th>
    <td><input name="return_ratio" type="text" value="0"  dataType="money" size="20" maxlength="10" maxB="10"  Require="true" onPropertychange="getMoney(document.forms[0].return_ratio.value,document.forms[0].return_amt)">%<span class="biTian">*</span>
	</td>
	<th  scope="row">厂商返利</th>
	<td><input name="return_amt" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<th scope="row">监管费比率</th>
    <td><input name="supervision_fee_ratio" type="text" value="0"  dataType="money" size="20" maxlength="10" maxB="10"  Require="true" onPropertychange="getMoney(document.forms[0].supervision_fee_ratio.value,document.forms[0].supervision_fee)">%<span class="biTian">*</span>
	</td>
	<th  scope="row">监管费</th>
	<td><input name="supervision_fee" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<th scope="row">咨询费</th>
    <td><input name="consulting_fee" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
	<th  scope="row">其他费用</th>
	<td><input name="other_fee" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<th scope="row">期末残值（或名义留购价）</th>
    <td><input name="nominalprice" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
	<th  scope="row">保险费(我司支付)</th>
	<td><input name="insurance_lessor" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<th scope="row">保险费(客户自付)</th>
    <td><input name="insurance_lessee" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
	<th  scope="row">K系数</th>
	<td><input name="redressalk" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  </tr>
  <tr>
  	<th scope="row">罚息利率</th>
    <td><input name="pena_rate" type="text" value="0"  dataType="money" size="20" maxlength="10" maxB="10"  Require="true">%<span class="biTian">*</span>
	</td>
	
  
  	<th scope="row">年平均收益（静态收益）</th>
    <td><input name="year_earn" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span>
	</td>
	</tr>

  <tr>
	<th  scope="row">年内部收益率IRR</th>
	<td><input name="irr" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  
  	
	<th  scope="row">计划IRR</th>
	<td><input name="plan_irr" id="irr" type="text" value="0"  dataType="money" size="20" maxlength="20" maxB="20"  Require="true"><span class="biTian">*</span></td>
  	</tr>
</table>
</div>
</div>
</form>
</body>
</html>
<script language="javascript"> 
dict_list("settle_method","BalanceWay","","name");
function getMoney(varvalue,varobject){
	varobject.value=document.forms[0].total_amt.value*varvalue/100;
}
</script>