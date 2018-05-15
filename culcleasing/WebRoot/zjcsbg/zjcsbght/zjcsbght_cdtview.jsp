<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title> 租金测算 - 合同交易结构</title>
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
String contract_id = getStr(request.getParameter("contract_id")); 
String doc_id = getStr(request.getParameter("doc_id"));
String csflag = getStr(request.getParameter("cs"));
String rent = getStr(request.getParameter("rent"));
String readonly = getStr(request.getParameter("readonly"));
%>
<%
	String equip_amt = "0";
	String lease_term = "0";
	String income_number = "0";
	String year_rate = "0";
	String rate_float_type = "0";
	String period_type = "0";
	String settle_method = "0";
	String income_day = "0";
	String income_number_year = "0";
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
	String first_date = getSystemDate(0);
	String second_date = getSystemDate(0);
	String start_date = getSystemDate(0);
	int iCount = 0;
	String sqlstr = "select * from contract_condition_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"'"; 
	ResultSet rs = db.executeQuery(sqlstr); 
	if(rs.next()){
		equip_amt = formatNumberDoubleTwo(getDBStr(rs.getString("equip_amt")));
		lease_money = formatNumberDoubleTwo(getDBStr(rs.getString("lease_money")));
		lease_term = formatNumberDoubleZero(getDBStr(rs.getString("lease_term")));
		income_number = formatNumberDoubleZero(getDBStr(rs.getString("income_number")));
		income_number_year = formatNumberDoubleZero(getDBStr(rs.getString("income_number_year")));
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
		if(iCount>0){
		plan_irr = formatNumberDoubleSix(getDBStr(rs.getString("plan_irr")));
		}
		first_date = getDBDateStr(rs.getString("first_date"));
		second_date = getDBDateStr(rs.getString("second_date"));
		start_date  = getDBDateStr(rs.getString("start_date"));
	}
	rs.close();
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
<form name="form1" method="post" action="zjcsbght_cdt.jsp" onSubmit="return Validator.Validate(this,3);">

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
<%if(readonly!=null&&readonly.equals("1")){}else{ %><BUTTON class="btn_2" name="btnSave" value="修改"  type="button" onclick="fun_edit()">
<img src="../../images/save.gif" align="absmiddle" border="0">修改</button><%} %>
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
<div id="divH" class="tabBody" style="background:#ffffff;width:96%;overflow:auto;">
<div id="TD_tab_0">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="cs" value="<%=csflag %>">
<input type="hidden" name="savetype" value="add">
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<td>申请金额（设备金额）</td>
    <td><%=equip_amt %>
	</td>
    <td>租金概算本金</td>
    <td><%=lease_money %></td>
  </tr>
  <tr>
  	<td>租赁合同总金额</td>
	<td><%=total_amt %></td>
  	<td>我司实际需动用资金</td>
    <td><%=actual_fund %>
	</td>
</tr>
  <tr>
  	<td>还租次数</td>
    <td><%=income_number %>
	</td>
	<td>每年还租期数</td>
	<td><%=formatNumberDoubleZero(income_number_year).equals("12")?"月付":formatNumberDoubleZero(income_number_year).equals("4")?"季付":formatNumberDoubleZero(income_number_year).equals("2")?"半年付":"年付" %> 租赁期限 <%=lease_term %></td>
  </tr>	
  <tr>
  	<td>期初（期末）支付</td>
    <td><%=period_type.equals("1")?"期初":"期末" %>
	</td>
	<td>利率浮动类型</td>
	<td><%=rate_float_type %></td>
  </tr>
  <tr>
	<td>租赁年利率</td>
    <td><%=year_rate %> %
	</td>
	<td></td>
	<td></td>
  </tr>	
  <tr>
  	<td>每月偿付日</td>
    <td><%=income_day %></td>
	<td>结算方式</td>
	<td><select name="settle_method" disabled="true"></select></td>
  </tr>
  <tr>
  	<td>首期租金偿付日期</td>
    <td><%=first_date %>
	</td>
	<td>二期租金偿付日期</td>
	<td><%=second_date %></td>
  </tr>
  <tr>
  	<td>约定起租日</td>
  	<td><%=start_date %></td>
  	<td></td>
  	<td></td>
  </tr>
	<tr>
	<td>首付款比率</td>
	<td><%=first_payment_ratio %> %</td>
  
  
  	<td>租金首付款</td>
    <td><%=first_payment %>
	</td>
</tr>

  <tr>
	<td>保证金比率</td>
	<td><%=caution_money_ratio %> %</td>
  
  	<td>租赁保证金</td>
    <td><%=caution_money %>
	</td>
	 </tr>
  <tr>
	<td>承租人保证金比率</td>
	<td><%=lessee_caution_ratio %> %</td>
 
  <td>承租人保证金金额</td>
	<td><%=lessee_caution_money %></td>
  	</tr>
  <tr>
  	<td>供应商保证金比率</td>
    <td><%=vndr_caution_ratio %> %
	</td>
	<td>供应商保证金金额</td>
	<td><%=vndr_caution_money %></td>
  </tr>
  <tr>
  	<td>代理商保证金比率</td>
    <td><%=sale_caution_ratio %> %
	</td>
	<td>代理商保证金金额</td>
	<td><%=sale_caution_money %></td>
  </tr>
  <tr>
  	<td>保证金抵扣比率</td>
    <td><%=caution_deduction_ratio %> %
	</td>
	<td>保证金抵扣金额</td>
	<td><%=caution_deduction_money %></td>
  </tr>
   <tr>
  	<td>手续费比率</td>
    <td><%=handling_charge_ratio %> %
	</td>
	<td>手续费</td>
	<td><%=handling_charge %></td>
  </tr>
  <tr>
  	<td>厂商返利比率</td>
    <td><%=return_ratio %> %
	</td>
	<td>厂商返利</td>
	<td><%=return_amt %></td>
  </tr>
  <tr>
  	<td>监管费比率</td>
    <td><%=supervision_fee_ratio %> %
	</td>
	<td>监管费</td>
	<td><%=supervision_fee %></td>
  </tr>
  <tr>
  	<td>我司支付的介绍费</td>
    <td><%=consulting_fee %></td>
	<td>我司支付的其他费用</td>
	<td><%=other_fee %></td>
  </tr>
  <tr>
  	<td>期末残值（或名义留购价）</td>
    <td><%=nominalprice %>
	</td>
	<td>保险费(我司支付)</td>
	<td><%=insurance_lessor %></td>
  </tr>
  <tr>
  	<td>保险费(客户自付)</td>
    <td><%=insurance_lessee %></td>
	<td>保险费支付方式</td>
	<td><select name="insurance_method"   disabled="true"></select></td>
  </tr>
  <tr>
  	<td>罚息利率</td>
    <td><select name="pena_rate" Require="true"  disabled="true"><script>w(mSetOpt('<%=pena_rate %>',"<%=textPena%>","<%=valuePena%>"));</script></select><span class="biTian">*</span></td>
  	<td>年平均收益（静态收益）</td>
    <td><%=year_earn %> %</td>
	</tr>

  <tr>
	<td>年内部收益率IRR</td>
	<td><%=irr %> %</td>
  
  	
	<td></td>
	<td></td>
  	</tr>
  <tr>
  	<td>项目粗利</td>
	<td><%=rough_earn %></td>
	<td></td>
	<td></td>

  </tr>	
</table>
</div>
</div>
</form>
</body>
</html>
<script language="javascript"> 
dict_list("settle_method","BalanceWay","<%=settle_method %>","name");
dict_list("insurance_method","InsuranceType","<%=insurance_method%>","name");
function fun_prodRent(){
		document.forms[0].action="zjcsbght_rent.jsp";
		document.forms[0].target="rentplan";
		document.forms[0].submit();
}
function fun_edit(){
document.forms[0].action="zjcsbght_cdt.jsp";
		document.forms[0].target="con";
		document.forms[0].submit();
}
</script>