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
</head>

<body>
<form name="list" target="xj" action="zjzq_zj.jsp" method="post" onSubmit="Validator.Validate(this,3)">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap >
									<BUTTON class="btn_2" name="btnSave" value="计算回笼计划"  type="button" onclick="fun_save()">
									<img src="../../images/save.gif" align="absmiddle" border="0">调整回笼计划</button>
									<BUTTON class="btn_2" name="btnSave" value="计算回笼计划"  type="button" onclick="fun_hl()">
									<img src="../../images/save.gif" align="absmiddle" border="0">察看回笼计划</button>	
									<BUTTON class="btn_2" name="btnSave" value="计算现金流量"  type="button" onclick="fun_xj()">
									<img src="../../images/save.gif" align="absmiddle" border="0">计算现金流量</button>
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
	ResultSet rs = null;
	ResultSet rsContract = null;
	String charge_first_date = "";
	String rent_first_date = "";
	String lease_term = "";
	String income_number =  "";
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
	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String fund_id = getStr(request.getParameter("fund_id"));
	String volume_id = getStr(request.getParameter("volume"));
	int ivolume_id=0;
	if(volume_id!=null&&!volume_id.equals("")){
		ivolume_id = Integer.parseInt(volume_id);
	}
	int iAllTerm = 0;
	String strSql = "select * from contract_condition where contract_id='" + contract_id + "'"; 
	rsContract = db.executeQuery(strSql);
	if(rsContract.next()){
		//charge_first_date = getDBStr(rsContract.getString("charge_first_date"));
		//rent_first_date = getDBStr(rsContract.getString("rent_first_date"));
		lease_term = getDBStr(rsContract.getString("lease_term"));
		income_number = getDBStr(rsContract.getString("income_number"));
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
		iAllTerm = (Integer.parseInt(lease_term)*Integer.parseInt(income_number))/12;
	}
	rsContract.close();
	
	String sql = "";
	double dlease_money = 0;
	if(fund_id!=null&&!fund_id.equals("")){
		sql = "select sum(corpus) as sum_corpus from fund_rent_plan where contract_id='"+contract_id+"' and id>="+fund_id;
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
 %>
<input type="hidden" name="charge_first_date" value="<%=charge_first_date %>">
<input type="hidden" name="rent_first_date" value="<%=rent_first_date %>">
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

<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="fund_id" value=<%=fund_id %>>
<input type="hidden" name="volume" value="<%=volume_id %>">
<div id="divH" class="tabBody" style="background:#ffffff;width:100%;overflow:auto;">
<div id="TD_tab_0">
	<table>
	<tr>
		<th scope="row">租赁期限（月）</th>
	    <td><input name="lease_term" type="text" value="<%=lease_term %>"  dataType="Number" size="20" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span>
		</td>
		<th  scope="row">每年还租期数</th>
		<td><input name="income_number" type="text" value="<%=income_number %>"  size="20" maxlength="250" maxB="250"  Require="true"><span class="biTian">*</span></td>
	 	<th  scope="row">展期开始期数</th>
		<td><%=ivolume_id%></td>
		<th  scope="row"></th>
		<td></td>
	  </tr>	
	  <tr>
		<th scope="row">还租开始日期</th>
	    <td><input name="begin_date" type="text" value="<%=strDate %>"  dataType="date" size="20" maxlength="4" maxB="4"  Require="true"><img  onClick="openCalendar(begin_date);return false" style="cursor:pointer; " src="../../images/tbtn_overtime.gif" width="20" height="19" border="0" align="absmiddle"><span class="biTian">*</span><span class="biTian">*</span></td>
		<th  scope="row">剩余本金</th>
		<td><%=lease_money %></td>
	  	<th  scope="row">展期前剩余租金期数</th>
		<td><%=iAllTerm-ivolume_id+1<=0?"":String.valueOf(iAllTerm-ivolume_id+1) %></td>
	  	<th  scope="row">展期手续费</th>
		<td><input name="exceedhandling_charge" type="text" value="0"  dataType="money" size="20" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span></td>
	  </tr>	
	</table>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
      	<th>期数</th>
		<th>本金占用比率</th>
		<th>本金占用额</th>
		<th>利率</th>
		<th>租金</th>
      </tr>
      <tr class="cwDLRow" >
        <td align="center"><input type="hidden" name="stage_list" value="1"><input type="text" name="volume1" size="5"> 期</td>
        <td align="center"><input type="text" name="principal_rate1" maxlength="3" size="10" onPropertychange="fun_pcpl(document.forms[0].principal_rate1,document.forms[0].principal_money1,document.forms[0].other_rent1,document.forms[0].lease_money.value)"> %</td>
		<td align="center"><input type="text" name="principal_money1" size="10"> 元<input type="hidden" name="other_rent1"></td>
		<td align="center"><input type="text" name="rate1" id="rate1" size="10" onPropertychange="fun_rent(document.forms[0].principal_money1.value,document.forms[0].rate1.value,document.forms[0].rent1,document.forms[0].lease_money.value,document.forms[0].volume1.value);"> %</td>
		<td align="center"><input type="text" name="rent1" size="10" > 元<input type="button" value="修改" onclick="fun_interest(document.forms[0].principal_money1.value,'rate1',document.forms[0].rent1.value,document.forms[0].lease_money.value,document.forms[0].volume1.value)"></td>
		
      </tr>
	  <tr class="cwDLRow" >
        <td align="center"><input type="hidden" name="stage_list" value="2"><input type="text" name="volume2" size="5"> 期</td>
        <td align="center"><input type="text" name="principal_rate2"  maxlength="3" size="10" onPropertychange="fun_pcpl(document.forms[0].principal_rate2,document.forms[0].principal_money2,document.forms[0].other_rent2,document.forms[0].other_rent1.value);"> %</td>
		<td align="center"><input type="text" name="principal_money2" size="10"> 元<input type="hidden" name="other_rent2"></td>
		<td align="center"><input type="text" name="rate2" size="10"  onPropertychange="fun_rent(document.forms[0].principal_money2.value,document.forms[0].rate2.value,document.forms[0].rent2,document.forms[0].other_rent1.value,document.forms[0].volume2.value);"> %</td>
		<td align="center"><input type="text" name="rent2" size="10"> 元<input type="button" value="修改" onclick="fun_interest(document.forms[0].principal_money2.value,'rate2',document.forms[0].rent2.value,document.forms[0].other_rent1.value,document.forms[0].volume2.value)"></td>
      </tr>
      <tr class="cwDLRow" >
        <td align="center"><input type="hidden" name="stage_list" value="3"><input type="text" name="volume3" size="5"> 期</td>
        <td align="center"><input type="text" name="principal_rate3"  maxlength="3" size="10" onPropertychange="fun_pcpl(document.forms[0].principal_rate3,document.forms[0].principal_money3,document.forms[0].other_rent3,document.forms[0].other_rent2.value);"> %</td>
		<td align="center"><input type="text" name="principal_money3" size="10"> 元<input type="hidden" name="other_rent3"></td>
		<td align="center"><input type="text" name="rate3" size="10" onPropertychange="fun_rent(document.forms[0].principal_money3.value,document.forms[0].rate3.value,document.forms[0].rent3,document.forms[0].other_rent2.value,document.forms[0].volume3.value);"> %</td>
		<td align="center"><input type="text" name="rent3" size="10"> 元<input type="button" value="修改" onclick="fun_interest(document.forms[0].principal_money3.value,'rate3',document.forms[0].rent3.value,document.forms[0].other_rent2.value,document.forms[0].volume3.value)"></td>
      </tr>
      <tr class="cwDLRow" >
        <td align="center"><input type="hidden" name="stage_list" value="4"><input type="text" name="volume4" size="5"> 期</td>
        <td align="center"><input type="text" name="principal_rate4"  maxlength="3" size="10" onPropertychange="fun_pcpl(document.forms[0].principal_rate4,document.forms[0].principal_money4,document.forms[0].other_rent4,document.forms[0].other_rent3.value);"> %</td>
		<td align="center"><input type="text" name="principal_money4" size="10"> 元<input type="hidden" name="other_rent4"></td>
		<td align="center"><input type="text" name="rate4" size="10" onPropertychange="fun_rent(document.forms[0].principal_money4.value,document.forms[0].rate4.value,document.forms[0].rent4,document.forms[0].other_rent3.value,document.forms[0].volume4.value);"> %</td>
		<td align="center"><input type="text" name="rent4" size="10"> 元<input type="button" value="修改" onclick="fun_interest(document.forms[0].principal_money4.value,'rate4',document.forms[0].rent4.value,document.forms[0].other_rent3.value,document.forms[0].volume4.value)"></td>
      </tr>
      <tr>
  	
    </table>
</div>
</div>
</form>
</body>
</html>
<script language="javascript">
function fun_pcpl(varValue,varObject,varOtherObj,varPreValue){
	if(varValue.value>100){
		alert("本金占用比率应小于100%");
		varValue.value=100;
		return false;
	}
	var pcpl = parseFloat(document.forms[0].lease_money.value);
	var pcplRate = parseFloat(varValue.value);
	varObject.value = (pcpl*pcplRate)/100;
	varOtherObj.value = parseFloat(varPreValue)-pcpl*pcplRate/100;
}

function fun_rent(varPcpl,varRate,varObject,varOtherValue,varvol){
	var pcpl = parseFloat(document.forms[0].lease_money.value);
	var leng = parseFloat(document.forms[0].lease_term.value);
	var volume = parseInt(document.forms[0].income_number.value);
	var period_type = document.forms[0].period_type.value;
	var rent_volume = (leng/12)*volume;
	var ivarvol = parseInt(varvol);
	var rent_rate = (parseFloat(varRate)/100/volume);
	if(period_type=="0"){
		varObject.value = ForDight(fun_pmtStart(rent_rate,varvol,parseFloat(varOtherValue),(parseFloat(varOtherValue)-parseFloat(varPcpl))),2);
	}else{
		varObject.value = ForDight(fun_pmtEnd(rent_rate,varvol,parseFloat(varOtherValue),(parseFloat(varOtherValue)-parseFloat(varPcpl))),2);
	}
}

function fun_interest(varPcpl,varRate,varObject,varOtherValue,varvol){
	var pcpl = parseFloat(document.forms[0].lease_money.value);
	var leng = parseFloat(document.forms[0].lease_term.value);
	var volume = parseInt(document.forms[0].income_number.value);
	var period_type = document.forms[0].period_type.value;
	var rent_volume = (leng/12)*volume;
	var ivarvol = parseInt(varvol); 
	var returnNo= 12/leng;
	varRate.value = getPmtYearRate(varvol,parseFloat(varOtherValue),(parseFloat(varOtherValue)-parseFloat(varPcpl)),period_type,parseFloat(varObject),returnNo);

}
function getPmtYearRate(Nper,Pv,Fv,Type,Pmt,lease_term){
	var min_rate = 0;
	var max_rate = 100;
	var rent = Pmt;
	var tmp_pmt=0;
	var j=0;
	var tmp=1;
	var tmp_rate=10;
	
	while(j<=1000 && tmp.abs()>0.000001){
		if(Type==0){
			tmp_pmt = fun_pmtStart(tmp_rate,Nper,Pv,Fv);
		}else{
			tmp_pmt = fun_pmtEnd(tmp_rate,Nper,Pv,Fv);
		}
		
		tmp=tmp_pmt-rent;
		if(tmp>0 && tmp.abs()>0.000001){
			max_rate=tmp_rate;
			tmp_rate=(tmp_rate+min_rate)/2;
		}
		if(tmp<0 && tmp.abs()>0.000001){
			min_rate=tmp_rate;
			tmp_rate=(tmp_rate+max_rate)/2;
		}
		j++;
	}
	return Math.pow(1+tmp_rate,1/lease_term)-1;
}
function fun_pmtStart(rate,volume,rent,futureValue){
	return (rate*Math.pow((1+rate),volume))/(Math.pow((1+rate),volume)-1)*(rent-futureValue)+(futureValue*rate);
}

function fun_pmtEnd(rate,volume,rent,futureValue){
	return (rate*Math.pow((1+rate),(volume-1)))/(Math.pow((1+rate),volume)-1)*(rent-futureValue)+(futureValue*rate);
}

function     ForDight(Dight,How)       
  {       
                        Dight     =     Math.round     (Dight*Math.pow(10,How))/Math.pow(10,How);       
                        return     Dight;       
  }  

function fun_change1(){
fun_clear("rate1");
fun_clear("rent1");
fun_clear("volume2");
fun_clear("principal_rate2");
fun_clear("principal_money2");
fun_clear("rate2");
fun_clear("rent2");
fun_clear("volume3");
fun_clear("principal_rate3");
fun_clear("principal_money3");
fun_clear("rate3");
fun_clear("rent3");
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change2(){
fun_clear("volume2");
fun_clear("principal_rate2");
fun_clear("principal_money2");
fun_clear("rate2");
fun_clear("rent2");
fun_clear("volume3");
fun_clear("principal_rate3");
fun_clear("principal_money3");
fun_clear("rate3");
fun_clear("rent3");
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change3(){
fun_clear("rate2");
fun_clear("rent2");
fun_clear("volume3");
fun_clear("principal_rate3");
fun_clear("principal_money3");
fun_clear("rate3");
fun_clear("rent3");
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change4(){
fun_clear("volume3");
fun_clear("principal_rate3");
fun_clear("principal_money3");
fun_clear("rate3");
fun_clear("rent3");
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change5(){
fun_clear("rate3");
fun_clear("rent3");
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change6(){
fun_clear("volume4");
fun_clear("principal_rate4");
fun_clear("principal_money4");
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change7(){
fun_clear("rate4");
fun_clear("rent4");
}
function fun_change8(){}
function fun_clear(varName){
eval("document.forms[0]."+varName+".value=''");
}

function fun_hl(){
	document.forms[0].action="zjzq_zjhl.jsp";
	document.forms[0].target="hl";
			document.forms[0].submit();
}
function fun_xj(){
	document.forms[0].action="zjzq_zj.jsp";
	document.forms[0].target="xj";
			document.forms[0].submit();
}
function fun_save(){
	document.forms[0].action="zjzq_save.jsp";
	document.forms[0].target="save";
			document.forms[0].submit();
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
function stateChanged(varRate){	
	if(xmlHttp.readyState == 4)	{
		var returnvalue = xmlHttp.responseText;
		eval("document.forms[0]."+varRate+".value = returnvalue");
	}	
}
function fun_interest(varPcpl,varRate,varObject,varOtherValue,varvol){
	var pcpl = parseFloat(document.forms[0].lease_money.value);
	var leng = parseFloat(document.forms[0].lease_term.value);
	var volume = parseInt(document.forms[0].income_number.value);
	var period_type = document.forms[0].period_type.value;
	var rent_volume = (leng/12)*volume;
	var ivarvol = parseInt(varvol); 
	var returnNo= 12/volume;
	document.forms[0].onSubmit="return Validator.Validate(this,3)";
	xmlHttp = GetXmlHttpObject();
	var url = "../zjcs/zjcs_save.jsp?Nper="+varvol+"&Pv="+parseFloat(varOtherValue)+"&Fv="+(parseFloat(varOtherValue)-parseFloat(varPcpl))+"&Type="+period_type+"&Pmt="+parseFloat(varObject)+"&lease_term="+returnNo;
  	xmlHttp.onreadystatechange = function(){stateChanged(varRate)};	
  	xmlHttp.open("POST",url,true);
  	xmlHttp.send(null);	  
	//varRate.value = getPmtYearRate(varvol,parseFloat(varOtherValue),(parseFloat(varOtherValue)-parseFloat(varPcpl)),period_type,parseFloat(varObject),returnNo);
}
function fun_IRR(){
	document.forms[0].onSubmit="return Validator.Validate(this,3)";
	xmlHttp = GetXmlHttpObject();
	var url = "zjzq_save.jsp?equip_amt="+document.forms[0].equip_amt.value;
  	xmlHttp.onreadystatechange = stateChanged;	
  	xmlHttp.open("POST",url,true);
  	xmlHttp.send(null);	  	
}
</script>
<%db.close();%>