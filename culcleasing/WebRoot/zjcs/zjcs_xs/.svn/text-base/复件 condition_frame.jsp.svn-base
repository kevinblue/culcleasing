<%@ page contentType="text/html; charset=gbk" language="java" %>
<%@ page import="dbconn.*" %>  
<%@ page import="java.sql.*" %>
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 租金测算</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<link href="../../css/mainstyle.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/validator.js"></script>

<script language="javascript" src="/dict/js/js_dictionary.js"></script>
<SCRIPT  Language="Javascript"  SRC="/tenwa/js/publicEvent.js"></SCRIPT>


</head>
<body style="overflow:auto;">

<form name="form1" method="post" target="_black" action="condition_sc.jsp" onSubmit="return Validator.Validate(this,3);">


<table  class="title_top" width=100% height=100% align=center cellspacing=0 border="0" cellpadding="0">

<tr valign="top">
<td  align=center width=100% height=100%>
<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
<tr>
<td>
<!--操作按钮开始-->
<%
	
	String doc_id = getStr(request.getParameter("doc_id"));
	String contract_id = getStr(request.getParameter("contract_id"));
	String model = getStr(request.getParameter("model"));
	
	ResultSet rs;
	String sqlstr="";
	String wherestr=" where 1=1";
	
	//如果临时表中没有数据则将before表中的数据插入临时表
	int i_count=0;
	sqlstr="select count(*) as i_count from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	//System.out.println("sqlstr11111==============="+sqlstr);
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		i_count=rs.getInt("i_count");
	}rs.close();
	if(i_count>0){
	
	}else{
		sqlstr="insert into contract_condition_temp(measure_id, contract_id, lease_amt, period_type, equip_amt, machine_price, begin_payment, first_payment_ratio, first_payment, lease_money, insurance_flag, insurer, insurance, lsh_insurance, cust_insurance, csa_flag, csa_financing, csa_hours, csa_cost, gps_flag, gps_cost, income_number_year, start_date, actual_start_date, first_date, income_number, lease_term, income_day, year_rate, supervision_fee, handling_charge, caution_money, return_amt, tax, commision, nominalprice, pena_rate, irr, plan_irr, peroid_payment, creator, create_date, modify_date, modificator) select '"+doc_id+"',contract_id, lease_amt, period_type, equip_amt, machine_price, begin_payment, first_payment_ratio, first_payment, lease_money, insurance_flag, insurer, insurance, lsh_insurance, cust_insurance, csa_flag, csa_financing, csa_hours, csa_cost, gps_flag, gps_cost, income_number_year, start_date, actual_start_date, first_date, income_number, lease_term, income_day, year_rate, supervision_fee, handling_charge, caution_money, return_amt, tax, commision, nominalprice, pena_rate, irr, plan_irr, peroid_payment, creator, create_date, modify_date, modificator from contract_condition where contract_id='"+contract_id+"'";
		db.executeUpdate(sqlstr);
	}
	//System.out.println("sqlstr==============="+sqlstr);
	String insurer_value="";
	String insurer_str="";
	sqlstr="select * from ifelc_conf_dictionary where parentid='insurance'";
	rs=db.executeQuery(sqlstr);
	while(rs.next()){
		insurer_value+=getDBStr(rs.getString("name"))+"|";
		insurer_str+=getDBStr(rs.getString("title"))+"|";
	}rs.close();
	if(insurer_value.length()>0){
		insurer_value=insurer_value.substring(0,insurer_value.length()-1);
		insurer_str=insurer_str.substring(0,insurer_str.length()-1);
	}
	
	
	//csa_fees="100";
	
	String equip_amt="";
	String lease_amt="";
	String first_payment_ratio="";
	String first_payment="";
	String lease_money="";
	String insurer="";
	String insurance="";
	String insurance_flag="";
	String lsh_insurance="";
	String cust_insurance="";
	String csa_flag="";
	String csa_financing="";
	String csa_cost="";
	String machine_price="";
	String gps_flag="";
	String gps_cost="";
	String income_number_year="";
	String start_date="";
	String income_number="";
	String lease_term="";
	String income_day="";
	String year_rate="";
	String per_rent="";
	String supervision_fee="";
	String handling_charge="";
	String caution_money="";
	String return_amt="";
	String tax="";
	String commision="";
	String nominalprice="";
	String pena_rate="";
	String irr="";
	String peroid_payment="";
	String begin_payment="";
	String csa_hours="";
	String period_type="";
	
	sqlstr="select * from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		equip_amt=formatNumberDoubleTwo(getDBStr(rs.getString("equip_amt")));
		lease_amt=formatNumberDoubleTwo(getDBStr(rs.getString("lease_amt")));
		first_payment_ratio=formatNumberDoubleTwo(getDBStr(rs.getString("first_payment_ratio")));
		first_payment=formatNumberDoubleTwo(getDBStr(rs.getString("first_payment")));
		lease_money=formatNumberDoubleTwo(getDBStr(rs.getString("lease_money")));
		insurer=getDBStr(rs.getString("insurer"));
		insurance=formatNumberDoubleTwo(getDBStr(rs.getString("insurance")));
		insurance_flag=getDBStr(rs.getString("insurance_flag"));
		lsh_insurance=formatNumberDoubleTwo(getDBStr(rs.getString("lsh_insurance")));
		cust_insurance=formatNumberDoubleTwo(getDBStr(rs.getString("cust_insurance")));
		csa_flag=getDBStr(rs.getString("csa_flag"));
		csa_financing=getDBStr(rs.getString("csa_financing"));
		csa_cost=formatNumberDoubleTwo(getDBStr(rs.getString("csa_cost")));
		machine_price=formatNumberDoubleTwo(getDBStr(rs.getString("machine_price")));
		gps_flag=getDBStr(rs.getString("gps_flag"));
		gps_cost=formatNumberDoubleTwo(getDBStr(rs.getString("gps_cost")));
		income_number_year=getDBStr(rs.getString("income_number_year"));
		start_date=getDBDateStr(rs.getString("start_date"));
		income_number=getDBStr(rs.getString("income_number"));
		lease_term=getDBStr(rs.getString("lease_term"));
		income_day=getDBStr(rs.getString("income_day"));
		year_rate=formatNumberDoubleTwo(getDBStr(rs.getString("year_rate")));
		//per_rent=formatNumberDoubleTwo(getDBStr(rs.getString("000000")));
		supervision_fee=formatNumberDoubleTwo(getDBStr(rs.getString("supervision_fee")));
		handling_charge=formatNumberDoubleTwo(getDBStr(rs.getString("handling_charge")));
		caution_money=formatNumberDoubleTwo(getDBStr(rs.getString("caution_money")));
		return_amt=formatNumberDoubleTwo(getDBStr(rs.getString("return_amt")));
		tax=formatNumberDoubleTwo(getDBStr(rs.getString("tax")));
		commision=formatNumberDoubleTwo(getDBStr(rs.getString("commision")));
		nominalprice=formatNumberDoubleTwo(getDBStr(rs.getString("nominalprice")));
		pena_rate=formatNumberDoubleTwo(getDBStr(rs.getString("pena_rate")));
		irr=formatNumberDoubleTwo(getDBStr(rs.getString("irr")));
		peroid_payment=formatNumberDoubleTwo(getDBStr(rs.getString("peroid_payment")));
		begin_payment=formatNumberDoubleTwo(getDBStr(rs.getString("begin_payment")));
		csa_hours=getDBStr(rs.getString("csa_hours"));
		period_type=getDBStr(rs.getString("period_type"));
	}rs.close();
	
	sqlstr="select rent as per_rent from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' and rent_list=1";
	rs=db.executeQuery(sqlstr);
	if(rs.next()){
		per_rent=formatNumberDoubleTwo(getDBStr(rs.getString("per_rent")));
	}rs.close();
	
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
<tr class="maintab_dh"></tr>
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
<input name="doc_id" type="hidden" value="<%=doc_id %>"/>
<input name="model" type="hidden" value="<%=model %>"/>
<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
  <tr>
  	<th>合同编号</th>
    <td><input name="contract_id" type="text" size="15" maxB="30" readonly value="<%=contract_id %>"></td>
    <th>项目间隔</th>
    <td><select name="income_number_year" onChange="iny_change();">
        <script>w(mSetOpt('<%=income_number_year %>',"月付|季付|半年付|年付","1|3|6|12"));</script>
        </select>
	</td>
	<th>期数</th>
    <td><input name="income_number" value="<%=income_number %>" type="text"   size="10" maxB="20" dataType="Integer" Require="true" onPropertyChange="iny_change();"><span class="biTian">*</span></td>
    
	
  </tr>
  <tr>
  	<th>租赁期限</th>
    <td><input name="lease_term" value="<%=lease_term %>" type="text"   size="10" maxB="20" dataType="Integer" readonly onPropertyChange="insur_change();"></td>
  	<th>整机价格</th>
    <td><input name="machine_price" value="<%=machine_price %>" type="text"  Require="true" size="15" maxB="20" dataType="Money" onPropertyChange="machine_change();"><span class="biTian">*</span></td>
  	<th>是否安装GPS</th>
    <td><select name="gps_flag" onChange="gps_change();">
        <script>w(mSetOpt('<%=gps_flag %>',"否|是"));</script>
        </select>
	</td>
    
  	
  </tr>
  <tr>
  	<th>GPS费用</th>
    <td><input name="gps_cost" value="<%=gps_cost %>" type="text"   size="15" maxB="20" dataType="Money" disabled onPropertyChange="machine_change();"></td>
    <th>保险公司</th>
    <td><select name="insurer" onChange="insur_change();">
        <script>w(mSetOpt('<%=insurer %>',"<%=insurer_str%>","<%=insurer_value%>"));</script>
        </select>
	</td>
	<th>保险费</th>
    <td><input name="insurance" value="<%=insurance %>" type="text" onPropertyChange="insurance_change();"  size="15" maxB="20" dataType="Money"></td>
    
  </tr>
  <tr>
  	<th>保险费是否融资</th>
    <td><select name="insurance_flag" onChange="insurFlag_change();">
        <script>w(mSetOpt('<%=insurance_flag %>',"否|是"));</script>
        </select>
	</td>
	<th>利星行支付的保险费</th>
    <td><input name="lsh_insurance" value="<%=lsh_insurance %>" type="text"   size="15" maxB="20" dataType="Money"></td>
	<th>客户承担的保险费</th>
    <td><input name="cust_insurance" value="<%=cust_insurance %>" type="text"   size="15" maxB="20" dataType="Money"></td>
    
  </tr>
  <tr>
  	<th>是否购买CSA</th>
    <td><select name="csa_flag" onChange="csaFlag_change();">
        <script>w(mSetOpt('<%=csa_flag %>',"否|是"));</script>
        </select>
	</td>
    <th>CSA是否融资</th>
    <td><select name="csa_financing" disabled onChange="insurFlag_change();">
        <script>w(mSetOpt('<%=csa_financing %>',"否|是"));</script>
        </select>
	</td>
	<th>CSA客户服务协议</th>
    <td>
    <input type="text" name="csa_hours" value="<%=csa_hours %>" size="6" maxB="20" readonly Require="ture" onPropertyChange="insurFlag_change();">小时
    <input name="csa_cost" value="<%=csa_cost %>" type="text"   size="10" maxB="20" dataType="Money" readonly>元
    
    <img src="../../images/sbtn_more.gif" name="csa_image" disabled alt="选" width="19" height="19" align="absmiddle"  style="cursor:pointer" 
    onClick="OpenDataWindow('form1.model','csa型号','model_id','Integer','服务时间','csa_fees','csa_hours','csa_fees','csa_hours','csa_hours','asc','form1.csa_hours','form1.csa_cost');">
    </td>
	
  </tr>
  
  <tr>
  	<th>租赁物总价</th>
    <td><input name="equip_amt" type="text" size="15" maxB="20" dataType="Money" readonly value="<%=equip_amt %>"></td>
	<th>融资总额</th>
    <td><input name="lease_amt" value="<%=lease_amt %>" type="text" size="15" maxB="20" dataType="Money" readonly onPropertyChange="spr_change();"></td>
    <th>首付比例</th>
    <td><input name="first_payment_ratio" value="<%=first_payment_ratio %>" type="text"   size="10" maxB="20" dataType="Rate" onPropertyChange="spr_change();" Require="true">%<span class="biTian">*</span></td>
	
    
  </tr>
  <tr>
  	<th>首付款</th>
    <td><input name="first_payment" value="<%=first_payment %>" type="text"   size="15" maxB="20" dataType="Money" readonly onPropertyChange="sfk_change();"></td>
  	<th>净融资额</th>
    <td><input name="lease_money" value="<%=lease_money %>" type="text"   size="15" maxB="20" dataType="Money" readonly></td>
	<th>预计起租日期</th>
    <td><input name="start_date" value="<%=start_date %>" type="text" dataType="Date" size="10" maxlength="10" maxB="10"  Require="true"><img  onClick="openCalendar(start_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span></td>
    
  </tr>
  <tr>
    <th>租金支付日期</th>
    <td><input name="income_day" value="<%=income_day %>" type="text"   size="10" maxB="20" dataType="Integer" Require="true"><span class="biTian">*</span></td>
    <th>名义利率</th>
    <td><select name="year_rate">
        <script>w(mSetOpt('<%=year_rate %>',"7.95|7.80|8.00|9.00"));</script>
        </select>%
	</td>
    <th>每期租金</th>
    <td><input name="per_rent" value="<%=per_rent %>" type="text"   size="15" maxB="20" dataType="Money" readonly></td>
  </tr>
  <tr>
    <th>管理费</th>
    <td><input name="supervision_fee" value="<%=supervision_fee %>" type="text"   size="15" maxB="20" dataType="Money" onPropertyChange="sfk_change();"></td>
    <th>手续费</th>
    <td><input name="handling_charge" value="<%=handling_charge %>" type="text"   size="15" maxB="20" dataType="Money"></td>
    <th>租赁保证金</th>
    <td><input name="caution_money" value="<%=caution_money %>" type="text"   size="15" maxB="20" dataType="Money"></td>
  </tr>
  <tr>
    <th>厂商返利</th>
    <td><input name="return_amt" value="<%=return_amt %>" type="text"   size="15" maxB="20" dataType="Money"></td>
    <th>税金</th>
    <td><input name="tax" value="<%=tax %>" type="text"   size="15" maxB="20" dataType="Money"></td>
    <th>佣金</th>
    <td><input name="commision" value="<%=commision %>" type="text"   size="15" maxB="20" dataType="Money"></td>
  </tr>
  <tr>
    <th>押金（名义货价）</th>
    <td><input name="nominalprice" value="<%=nominalprice %>" type="text"   size="15" maxB="20" dataType="Money" onPropertyChange="sfk_change();"></td>
    <th>逾期罚息率</th>
    <td><input name="pena_rate" value="<%=pena_rate %>" type="text"   size="10" maxB="20" dataType="Rate" Require="true">%%<span class="biTian">*</span></td>
    <th>实际利率</th>
    <td><input name="irr" value="<%=irr %>" type="text"   size="15" maxB="20" dataType="Rate" readonly>%</td>
  </tr>
  <tr>
    <th>向融资公司支付的期初付款</th>
    <td><input name="peroid_payment" value="<%=peroid_payment %>" type="text"   size="15" maxB="20" dataType="Money" readonly></td>
    <th>应收期初付款</th>
    <td><input name="begin_payment" value="<%=begin_payment %>" type="text"   size="15" maxB="20" dataType="Money" readonly></td>
    <th>期末起初</th>
    <td><select name="period_type">
        <script>w(mSetOpt('<%=period_type %>',"期末|期初","0|1"));</script>
        </select>
	</td>
  </tr>
  <tr>
	  
  	  <td colspan="6" align="right">
		<BUTTON class="btn_2" name="btnSave" value="租金测算"  type="submit">
		<img src="../../images/save.gif" align="absmiddle" border="0">租金测算</button>
	</td>
  </tr>
  
</table>



</div>
</div>
</form>


</body>
</html>
<script language="javascript"> 
function GetXmlHttpObject(){
	var objXMLHttp = null;
	if(window.XMLHttpRequest)	{
		objXMLHttp = new XMLHttpRequest();
	}else if(window.ActiveXObject)	{
		objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return objXMLHttp;
}

function insur_change(){
	var insurer=document.form1.insurer.value;
	var lease_term=document.form1.lease_term.value;
	var equip_amt=document.form1.equip_amt.value;
	
	
	if(lease_term!=""&&equip_amt!=""){
		var xmlHttp = GetXmlHttpObject();
		var url = "condition_check.jsp?flag=1&czid="+insurer+"&lease_term="+lease_term+"&equip_amt="+equip_amt;
	  	//xmlHttp.onreadystatechange = stateChanged;	
	  	xmlHttp.open("POST",url,false);
	  	xmlHttp.send(null);
	  	var vDiv = document.createElement("DIV");
	   	vDiv.innerHTML = xmlHttp.responseText 
		var returnvalue=vDiv.innerText;
		document.form1.insurance.value=returnvalue;
		
	}
	
}
function insurance_change(){
	var insurance_flag=document.form1.insurance_flag.value;
	var csa_financing=document.form1.csa_financing.value;
	var csa_flag=document.form1.csa_flag.value;
	var f1=0;
	var f2=0;
	if(insurance_flag=="是"){
		f1=1;
	}
	if(csa_financing=="是"&&csa_flag=="是"){
		f2=1;
	}
	document.form1.lease_amt.value=forcepos(document.form1.insurance.value*f1+document.form1.csa_cost.value*f2+
		document.form1.equip_amt.value*1,2);
}
function spr_change(){
	var lease_amt=document.form1.lease_amt.value;
	var first_payment_ratio=document.form1.first_payment_ratio.value;
	document.form1.first_payment.value=forcepos(lease_amt*first_payment_ratio/100,2);
	document.form1.lease_money.value=forcepos(lease_amt-lease_amt*first_payment_ratio/100,2);
	
}
function insurFlag_change(){
	var insurance_flag=document.form1.insurance_flag.value;
	var csa_financing=document.form1.csa_financing.value;
	var csa_flag=document.form1.csa_flag.value;
	var f1=0;
	var f2=0;
	if(insurance_flag=="是"){
		f1=1;
	}
	if(csa_financing=="是"&&csa_flag=="是"){
		f2=1;
	}
	document.form1.lease_amt.value=forcepos(document.form1.insurance.value*f1+document.form1.csa_cost.value*f2+
		document.form1.equip_amt.value*1,2);
	sfk_change();
}

function csaFlag_change(){
	var csa_flag=document.form1.csa_flag.value;
	
	if(csa_flag=="否"){
		document.form1.csa_financing.value="否";
		document.form1.csa_cost.value=0;
		document.form1.csa_financing.disabled=true;
		document.form1.csa_image.disabled=true;
		document.form1.csa_hours.value=0;
		insurFlag_change();
	}else{
		document.form1.csa_financing.disabled=false;
		document.form1.csa_image.disabled=false;
		//document.form1.csa_cost.value=document.form1.h_csa_fees.value;
		insurFlag_change();
	}
	sfk_change();
	
}
function gps_change(){
	var gps_flag=document.form1.gps_flag.value;
	
	if(gps_flag=="否"){
		document.form1.gps_cost.value=0;
		document.form1.gps_cost.disabled=true;
		insurFlag_change();
	}else{
		document.form1.gps_cost.disabled=false;
	}
}
function machine_change(){
	document.form1.equip_amt.value=forcepos(document.form1.machine_price.value*1+document.form1.gps_cost.value*1,2);
	insurFlag_change();
	insur_change();
}
function iny_change(){
	var income_number_year=document.form1.income_number_year.value;
	var income_number=document.form1.income_number.value;
	document.form1.lease_term.value=income_number_year*income_number;
}
function sfk_change(){
	var csa_flag=document.form1.csa_flag.value;
	var csa_financing=document.form1.csa_financing.value;
	var insurance_flag=document.form1.insurance_flag.value;
	
	var first_payment=document.form1.first_payment.value;
	var supervision_fee=document.form1.supervision_fee.value;
	var nominalprice=document.form1.nominalprice.value;
	var csa_cost=document.form1.csa_cost.value;
	var insurance=document.form1.insurance.value;
	
	document.form1.peroid_payment.value=forcepos(first_payment*1+supervision_fee*1+nominalprice*1,2);
	var f1=0;
	var f2=0;
	if(insurance_flag=="否"){
		f1=1;
	}
	if(csa_financing=="否"&&csa_flag=="是"){
		f2=1;
	}
	document.form1.begin_payment.value=forcepos(first_payment*1+supervision_fee*1+nominalprice*1+insurance*f1+csa_cost*f2,2);
}
function init(){
	var csa_flag=document.form1.csa_flag.value;
	var gps_flag=document.form1.gps_flag.value;
	if(csa_flag=="是"){
		document.form1.csa_financing.disabled=false;
		document.form1.csa_image.disabled=false;
	}
	if(gps_flag=="是"){
		document.form1.gps_cost.disabled=false;
	}
}
init();
</script>