<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>项目租金测算 - 项目交易结构</title>
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
<%String lease_money="0";
lease_money = getZeroStr(getStr(request.getParameter("lease_money")));
String project_id = getStr(request.getParameter("project_id"));
String fund_id = getStr(request.getParameter("fund_id"));
String volume = getStr(request.getParameter("volume"));
String jg = getStr(request.getParameter("jg"));
String zq = getStr(request.getParameter("zq"));
 %>
<form name="form1" method="post" action="zjbcxm_save.jsp" onSubmit="return Validator.Validate(this,3);">

<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<%
	String equip_amt = "0";
	String lease_term = "0";
	String income_number = "0";
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
	String plan_irr = "0";
	String first_date = "0";
	String second_date = "0";
	
	String sqlstr = "select * from proj_condition where proj_id='" + project_id + "'"; 
	System.out.println(sqlstr);
	ResultSet rs = db.executeQuery(sqlstr); 
	if(rs.next()){
		equip_amt = formatNumberDoubleTwo(getDBStr(rs.getString("equip_amt")));
		lease_money = formatNumberDoubleTwo(getDBStr(rs.getString("lease_money")));
		lease_term = formatNumberDoubleZero(getDBStr(rs.getString("lease_term")));
		income_number = formatNumberDoubleZero(getDBStr(rs.getString("income_number")));
		year_rate = formatNumberDoubleFour(getDBStr(rs.getString("year_rate")));
		rate_float_type = getDBStr(rs.getString("rate_float_type"));
		period_type = getDBStr(rs.getString("period_type"));
		settle_method = getDBStr(rs.getString("settle_method"));
		income_day = formatNumberDoubleZero(getDBStr(rs.getString("income_day")));
		first_payment_ratio = formatNumberDoubleFour(getDBStr(rs.getString("first_payment_ratio")));
		first_payment = formatNumberDoubleTwo(getDBStr(rs.getString("first_payment")));
		caution_money_ratio = formatNumberDoubleFour(getDBStr(rs.getString("caution_money_ratio")));
		caution_money = formatNumberDoubleTwo(getDBStr(rs.getString("caution_money")));
		lessee_caution_ratio = formatNumberDoubleFour(getDBStr(rs.getString("lessee_caution_ratio")));
		lessee_caution_money = formatNumberDoubleTwo(getDBStr(rs.getString("lessee_caution_money")));
		vndr_caution_ratio = formatNumberDoubleFour(getDBStr(rs.getString("vndr_caution_ratio")));
		vndr_caution_money = formatNumberDoubleTwo(getDBStr(rs.getString("vndr_caution_money")));
		sale_caution_ratio = formatNumberDoubleFour(getDBStr(rs.getString("sale_caution_ratio")));
		sale_caution_money = formatNumberDoubleTwo(getDBStr(rs.getString("sale_caution_money")));
		caution_deduction_ratio = formatNumberDoubleFour(getDBStr(rs.getString("caution_deduction_ratio")));
		caution_deduction_money = formatNumberDoubleTwo(getDBStr(rs.getString("caution_deduction_money")));
		handling_charge_ratio = formatNumberDoubleFour(getDBStr(rs.getString("handling_charge_ratio")));
		handling_charge = formatNumberDoubleTwo(getDBStr(rs.getString("handling_charge")));
		return_ratio = formatNumberDoubleFour(getDBStr(rs.getString("return_ratio")));
		return_amt = formatNumberDoubleTwo(getDBStr(rs.getString("return_amt")));
		supervision_fee_ratio = formatNumberDoubleFour(getDBStr(rs.getString("supervision_fee_ratio")));
		supervision_fee = formatNumberDoubleTwo(getDBStr(rs.getString("supervision_fee")));
		consulting_fee = formatNumberDoubleTwo(getDBStr(rs.getString("consulting_fee")));
		other_fee = formatNumberDoubleTwo(getDBStr(rs.getString("other_fee")));
		nominalprice = formatNumberDoubleTwo(getDBStr(rs.getString("nominalprice")));
		insurance_method = getDBStr(rs.getString("insurance_method"));
		insurance_lessor = formatNumberDoubleTwo(getDBStr(rs.getString("insurance_lessor")));
		insurance_lessee = formatNumberDoubleTwo(getDBStr(rs.getString("insurance_lessee")));
		redressalk = formatNumberDoubleFour(getDBStr(rs.getString("redressalk")));
		pena_rate = formatNumberDoubleFour(getDBStr(rs.getString("pena_rate")));
		total_amt = formatNumberDoubleTwo(getDBStr(rs.getString("total_amt")));
		actual_fund = formatNumberDoubleTwo(getDBStr(rs.getString("actual_fund")));
		rough_earn = formatNumberDoubleTwo(getDBStr(rs.getString("rough_earn")));
		year_earn = formatNumberDoubleTwo(getDBStr(rs.getString("year_earn")));
		irr = formatNumberDoubleFour(getDBStr(rs.getString("irr")));
		first_date = getDBDateStr(rs.getString("first_date"));
		second_date = getDBDateStr(rs.getString("second_date"));
	}
	rs.close();
	db.close();
 %>
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

<BUTTON class="btn_2" name="btnReset" value="取消" onclick="window.location.href='zjbcxm_cond.jsp?project_id=<%=project_id %>'">
<img src="../../images/hg.gif" align="absmiddle" border="0">取消</button>
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
<input type="hidden" name="project_id" value="<%=project_id %>">
<input type="hidden" name="fund_id" value="<%=fund_id %>">
<input type="hidden" name="volume" value="<%=volume %>">
<input type="hidden" name="zq" value="<%=zq %>">
<input type="hidden" name="jg" value="<%=jg %>">
<input type="hidden" name="savetype" value="add">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<th scope="row">申请金额（设备金额）</th>
    <td><%=equip_amt %>
	</td>
    <th scope="row">租金概算本金</th>
    <td><%=lease_money %></td>
  </tr>
  <tr>
  	<th  scope="row">租赁合同总金额</th>
	<td><%=total_amt %></td>
  	<th scope="row">我司实际需动用资金</th>
    <td><%=actual_fund %>
	</td>
</tr>
  <tr>
  	<th scope="row">租赁期限（月）</th>
    <td><%=lease_term %>
	</td>
	<th  scope="row">每年还租期数</th>
	<td><%=income_number %>
  </tr>	
  <tr>
  	<th scope="row">租赁年利率</th>
    <td><%=year_rate %>
	</td>
	<th  scope="row">利率浮动类型</th>
	<td><%=rate_float_type %></td>
  </tr>
   <tr>
  	<th scope="row">期初（期末）支付</th>
    <td><%=period_type.equals("1")?"期初":"期末" %>
	</td>
	<th  scope="row">结算方式</th>
	<td><select name="settle_method" disabled="true"></select><span class="biTian">*</span></td>
  </tr>	
  <tr>
  	<th scope="row">每月偿付日</th>
    <td><%=income_day %>
	</td>
	<th  scope="row">项目粗利</th>
	<td><%=rough_earn %></td>
	</tr>
	  <tr>
  	<th scope="row">首期租金偿付日期</th>
    <td><%=first_date %>
	</td>
	<th  scope="row">二期租金偿付日期</th>
	<td><%=second_date %></td>

  </tr>
	<tr>
	<th  scope="row">首付款比率</th>
	<td><%=first_payment_ratio %></td>
  
  
  	<th scope="row">租金首付款</th>
    <td><%=first_payment %>
	</td>
</tr>

  <tr>
	<th  scope="row">保证金比率</th>
	<td><%=caution_money_ratio %></td>
  
  	<th scope="row">租赁保证金</th>
    <td><%=caution_money %>
	</td>
	 </tr>
  <tr>
	<th  scope="row">承租人保证金比率</th>
	<td><%=lessee_caution_ratio %></td>
 
  <th  scope="row">承租人保证金金额</th>
	<td><%=lessee_caution_money %></td>
  	</tr>
  <tr>
  	<th scope="row">供应商保证金比率</th>
    <td><%=vndr_caution_ratio %>
	</td>
	<th  scope="row">供应商保证金金额</th>
	<td><%=vndr_caution_money %></td>
  </tr>
  <tr>
  	<th scope="row">代理商保证金比率</th>
    <td><%=sale_caution_ratio %>
	</td>
	<th  scope="row">代理商保证金金额</th>
	<td><%=sale_caution_money %></td>
  </tr>
  <tr>
  	<th scope="row">保证金抵扣比率</th>
    <td><%=caution_deduction_ratio %>
	</td>
	<th  scope="row">保证金抵扣金额</th>
	<td><%=caution_deduction_money %></td>
  </tr>
   <tr>
  	<th scope="row">手续费比率</th>
    <td><%=handling_charge_ratio %>
	</td>
	<th  scope="row">手续费</th>
	<td><%=handling_charge %></td>
  </tr>
  <tr>
  	<th scope="row">厂商返利比率</th>
    <td><%=return_ratio %>
	</td>
	<th  scope="row">厂商返利</th>
	<td><%=return_amt %></td>
  </tr>
  <tr>
  	<th scope="row">监管费比率</th>
    <td><%=supervision_fee_ratio %>
	</td>
	<th  scope="row">监管费</th>
	<td><%=supervision_fee %></td>
  </tr>
  <tr>
  	<th scope="row">咨询费</th>
    <td><%=consulting_fee %>
	</td>
	<th  scope="row">其他费用</th>
	<td><%=other_fee %></td>
  </tr>
  <tr>
  	<th scope="row">期末残值（或名义留购价）</th>
    <td><%=nominalprice %>
	</td>
	<th  scope="row">保险费(我司支付)</th>
	<td><%=insurance_lessor %></td>
  </tr>
  <tr>
  	<th scope="row">保险费(客户自付)</th>
    <td><%=insurance_lessee %>
	</td>
	<th  scope="row">K系数</th>
	<td><%=redressalk %></td>
  </tr>
  <tr>
  	<th scope="row">罚息利率</th>
    <td><%=pena_rate %>
	</td>
	
  
  	<th scope="row">年平均收益（静态收益）</th>
    <td><%=year_earn %>
	</td>
	</tr>

  <tr>
	<th  scope="row">年内部收益率IRR</th>
	<td><%=irr %></td>
  </tr>

</table>
</div>
</div>
</form>
</body>
</html>
<script language="javascript"> 
dict_list("settle_method","BalanceWay","<%=settle_method %>","name");
</script>