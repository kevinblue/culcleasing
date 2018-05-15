<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金展期 - 租金期次</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
<script src="../../js/rent.js"></script>
</head>
<%String readonly = getStr(request.getParameter("readonly")); %>
<body>
<form name="list" target="new_plan" action="zq_newrent.jsp" method="post" onSubmit="Validator.Validate(this,3)">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap >
									<%if(readonly!=null&&readonly.equals("1")){}else{ %><BUTTON class="btn_2" name="btnSave" value="计算回笼计划"  type="button" onclick="fun_save()">
									<img src="../../images/save.gif" align="absmiddle" border="0">调整回笼计划</button><%} %>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%
	int ivolume_id=0;
	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String fund_id = getStr(request.getParameter("fund_id"));
	String volume_id = getStr(request.getParameter("volume"));
	
	String start_list = "0";
	String handling_charge_value = "0";
	String adjust_list = "0";
	String epdt_rent = "0";
	String new_year_rate = "0";
	String sql = "";
	if(fund_id==null||fund_id.equals("")){
		sql = "select * from fund_rent_adjust where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		ResultSet rsAdjust = db.executeQuery(sql);
		if(rsAdjust.next()){
			start_list = getDBStr(rsAdjust.getString("start_list"));
			handling_charge_value = getDBStr(rsAdjust.getString("handling_charge"));
			adjust_list = getDBStr(rsAdjust.getString("adjust_list"));
			epdt_rent = formatNumberDoubleTwo(getDBStr(rsAdjust.getString("epdt_rent")));
			new_year_rate = getDBStr(rsAdjust.getString("year_rate"));
		}
		if(start_list!=null&&!start_list.equals("")){
			ivolume_id = Integer.parseInt(start_list);
			volume_id = String.valueOf(ivolume_id);
		}
	}
	ResultSet rs = null;
	ResultSet rsContract = null;
	String charge_first_date = "";
	String rent_first_date = "";
	String lease_term = "";
	String income_number =  "";
	String income_number_year =  "";
	String year_rate = "";
	String lease_money = "";
	
	String caution_deduction_money = "";
	String period_type = "";
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
	String start_date = "";
	
	
	if(volume_id!=null&&!volume_id.equals("")){
		ivolume_id = Integer.parseInt(volume_id);
	}
	int iAllTerm = 0;
	String strSql = "select * from contract_condition_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"'"; 
	rsContract = db.executeQuery(strSql);
	if(rsContract.next()){
		lease_term = getDBStr(rsContract.getString("lease_term"));
		income_number = getDBStr(rsContract.getString("income_number"));
		income_number_year = getDBStr(rsContract.getString("income_number_year"));
		year_rate = getDBStr(rsContract.getString("year_rate"));
		lease_money = getDBStr(rsContract.getString("lease_money"));
		caution_deduction_money = getDBStr(rsContract.getString("caution_deduction_money"));
		period_type = getDBStr(rsContract.getString("period_type"));
		equip_amt = getDBStr(rsContract.getString("equip_amt"));
		first_payment = getDBStr(rsContract.getString("first_payment"));
		caution_money = getDBStr(rsContract.getString("caution_money"));
		handling_charge = getDBStr(rsContract.getString("handling_charge"));
		return_amt = getDBStr(rsContract.getString("return_amt"));
		supervision_fee = getDBStr(rsContract.getString("supervision_fee"));
		consulting_fee = getDBStr(rsContract.getString("consulting_fee"));
		other_fee = getDBStr(rsContract.getString("other_fee"));
		nominalprice = getDBStr(rsContract.getString("nominalprice"));
		insurance_lessor = getDBStr(rsContract.getString("insurance_lessor"));
		start_date = getDBDateStr(rsContract.getString("start_date"));
		iAllTerm = (Integer.parseInt(income_number));
		charge_first_date = getDBDateStr(rsContract.getString("first_date"));
		rent_first_date = getDBDateStr(rsContract.getString("second_date"));
	}
	rsContract.close();
	double dlease_money = 0;
	System.out.println(volume_id);
	if(volume_id!=null&&!volume_id.equals("")){
		sql = "select sum(corpus) as sum_corpus from fund_rent_plan where contract_id='"+contract_id+"' and rent_list>="+volume_id;
		System.out.println(sql);
		ResultSet rssum = db.executeQuery(sql);
		if(rssum.next()){
			lease_money = getDBStr(rssum.getString("sum_corpus"));
		}
		rssum.close();
	}
	String strDate = "";
	if(fund_id!=null&&!fund_id.equals("")){
		ResultSet rsrent= null;
		sql = "select * from fund_rent_plan where id="+fund_id;
		System.out.println(sql);
		rsrent = db.executeQuery(sql);
		if(rsrent.next()){
			strDate = getDBDateStr(rsrent.getString("plan_date"));
		}
	}
	if(volume_id!=null&&!volume_id.equals("")){
		ResultSet rsrent= null;
		sql = "select * from fund_rent_plan where contract_id='"+contract_id+"' and rent_list="+volume_id;
		System.out.println(sql);
		rsrent = db.executeQuery(sql);
		if(rsrent.next()){
			fund_id = getDBStr(rsrent.getString("id"));
		}
	}
	System.out.println(epdt_rent);
 %>
<input type="hidden" name="charge_first_date" value="<%=charge_first_date %>">
<input type="hidden" name="rent_first_date" value="<%=rent_first_date %>">
<input type="hidden" name="start_date" value="<%=start_date %>">
<input type="hidden" name="year_rate" value="<%=year_rate %>">
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

<input type="hidden" name="income_number" value="<%=income_number %>">
<input type="hidden" name="income_number_year" value="<%=income_number_year %>">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="fund_id" value=<%=fund_id %>>
<input type="hidden" name="volume" value="<%=volume_id %>">
<input type="hidden" name="readonly" value="<%=readonly %>">
<input type="hidden" name="savetype" value="add">
<input type="hidden" name="rent_style" value="0">
<div id="divH" class="tabBody" style="background:#ffffff;width:100%;overflow:auto;">
<div id="TD_tab_0">
	<table  border="0" cellspacing="0" cellpadding="0" width="98%" align="center" class="tab_table_title">
	
	  <tr>
		<td align="left" width="15%">剩余本金</td>
		<td width="15%"><%=lease_money %></td>
	  	<td align="left">展期开始期数</td>
		<td><%=ivolume_id%></td>
		<td align="left">展期手续费</td>
		<td width="15%"><input name="exceedhandling_charge" type="text" dataType="money" size="10" maxlength="10" maxB="10" value="<%=handling_charge_value %>" Require="true"><span class="biTian">*</span></td>
	  </tr>	
	  <tr>
		
		<td align="left">展期后期数</td>
	    <td><input name="ets_number" type="text" value="<%=adjust_list %>"  dataType="Number" size="2" maxlength="4" maxB="4"  Require="true" onPropertychange="fun_rent()"><span class="biTian">*</span></td>	 	
		<td align="left">年利率</td>
		<td><input name="new_year_rate" type="text" value="<%=new_year_rate!=null&&!new_year_rate.equals("0")&&!new_year_rate.equals("")?new_year_rate:year_rate %>" size="10" dataType="Rate" onPropertychange="fun_rent()"> % </td>
		<td align="left">租金</td>
		<td><input name="new_rent" type="text" size="10" dataType="Rate"  value="<%=epdt_rent %>" <%if(readonly!=null&&readonly.equals("1")){}else{ %>onblur="fun_prodRent()"<%}  %>></td>
	  </tr>	
	</table>
</div>
</div>
</form>
</body>
</html>
<script language="javascript">

function fun_save(){
	document.forms[0].action="zq_save.jsp";
	document.forms[0].target="new_plan";
	document.forms[0].submit();
}
//租赁期数=租赁期限/12*年还租次数

function fun_rent(){
		var rent_list = document.forms[0].volume.value;
		var pcpl = parseFloat(document.forms[0].lease_money.value);
		var leng = parseFloat(document.forms[0].ets_number.value);
		var volume = parseInt(document.forms[0].income_number_year.value);
		var period_type = document.forms[0].period_type.value;
		var ivarvol = parseInt(document.forms[0].ets_number.value);
		var varRate = document.forms[0].new_year_rate.value;
		var rent_rate = (parseFloat(varRate)/100/volume);
		document.forms[0].new_rent.value = fun_returnRent(rent_rate,leng,pcpl,0,rent_list=="1"?period_type:"0");
}
function fun_prodRent(){
	var rent_value = document.forms[0].new_rent.value;
	if(rent_value!=""){
		fun_interest();
	}else{
		alert("租金不能为空");return false;
	}
}
var xmlHttp;
function GetXmlHttpObject(){
	var objXMLHttp = null;
	if(window.XMLHttpRequest)	{
		objXMLHttp = new XMLHttpRequest();
	}else if(window.ActiveXObject)	{
		objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	return objXMLHttp;
}
function stateChanged(){	
	if(xmlHttp.readyState == 4)	{
		var vDiv = document.createElement("DIV");
	 	vDiv.innerHTML = xmlHttp.responseText;
		var returnvalue = vDiv.innerText;
		document.forms[0].new_year_rate.value = returnvalue;
	}	
}
function fun_interest(){
	var rent_list = document.forms[0].volume.value;
	var pcpl = parseFloat(document.forms[0].lease_money.value);
	var leng = parseFloat(document.forms[0].ets_number.value);
	var volume = parseInt(document.forms[0].income_number_year.value);
	var period_type = document.forms[0].period_type.value;
	var rent_volume = (leng*volume/12);
	var ivarvol = parseInt(leng);
	var returnNo= 12/volume;
	var varObject = document.forms[0].new_rent.value;
	xmlHttp = GetXmlHttpObject();
	var url = "zq_check.jsp?Nper="+leng+"&Pv="+pcpl+"&Fv="+0+"&Type="+(rent_list=="1"?period_type:"0")+"&Pmt="+parseFloat(varObject)+"&lease_term="+returnNo;
  	xmlHttp.onreadystatechange = stateChanged;
  	xmlHttp.open("POST",url,true);
  	xmlHttp.send(null);
}
</script>
<%db.close();%>