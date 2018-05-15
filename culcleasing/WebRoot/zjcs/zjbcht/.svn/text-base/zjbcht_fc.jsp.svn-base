<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />  
<%@ include file="../../func/common.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 租金期次</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>

<body>
<form name="list" target="xj" action="zjbcht_zj.jsp" method="post">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap >
									<BUTTON class="btn_2" name="btnSave" value="计算回笼计划"  type="button" onclick="fun_hl()">
									<img src="../../images/save.gif" align="absmiddle" border="0">计算回笼计划</button>	
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
	String fund_id = getStr(request.getParameter("fund_id"));
	String volume = getStr(request.getParameter("volume"));
	String zq = getStr(request.getParameter("zq"));
	String doc_id = getStr(request.getParameter("doc_id"));

	String charge_first_date = getStr(request.getParameter("charge_first_date"));
	String rent_first_date = getStr(request.getParameter("rent_first_date"));
	String lease_term = getStr(request.getParameter("lease_term"));
	String income_number =  getStr(request.getParameter("income_number"));
	String year_rate = getStr(request.getParameter("year_rate"));
	String lease_money = getStr(request.getParameter("lease_money"));
	String caution_deduction_money = getStr(request.getParameter("caution_deduction_money"));
	String period_type = getStr(request.getParameter("period_type"));
	
	String equip_amt = getStr(request.getParameter("equip_amt"));
	String first_payment = getStr(request.getParameter("first_payment"));
	String caution_money = getStr(request.getParameter("caution_money"));
	String handling_charge = getStr(request.getParameter("handling_charge"));
	String return_amt = getStr(request.getParameter("return_amt"));
	String supervision_fee =  getStr(request.getParameter("supervision_fee"));
	String consulting_fee =  getStr(request.getParameter("consulting_fee"));
	String other_fee = getStr(request.getParameter("other_fee"));
	String nominalprice = getStr(request.getParameter("nominalprice"));
	String insurance_lessor = getStr(request.getParameter("insurance_lessor"));
	
	String contract_id = getStr(request.getParameter("contract_id"));
	String rate_float_type = getStr(request.getParameter("rate_float_type"));
	String settle_method = getStr(request.getParameter("settle_method"));
	String first_payment_ratio = getStr(request.getParameter("first_payment_ratio"));
	String caution_money_ratio = getStr(request.getParameter("caution_money_ratio"));
	String lessee_caution_ratio = getStr(request.getParameter("lessee_caution_ratio"));
	String lessee_caution_money = getStr(request.getParameter("lessee_caution_money"));
	String vndr_caution_ratio = getStr(request.getParameter("vndr_caution_ratio"));
	String vndr_caution_money = getStr(request.getParameter("vndr_caution_money"));
	String sale_caution_ratio = getStr(request.getParameter("sale_caution_ratio"));
	String sale_caution_money = getStr(request.getParameter("sale_caution_money"));
	String caution_deduction_ratio = getStr(request.getParameter("caution_deduction_ratio"));
	String handling_charge_ratio = getStr(request.getParameter("handling_charge_ratio"));
	String return_ratio = getStr(request.getParameter("return_ratio"));
	String supervision_fee_ratio = getStr(request.getParameter("supervision_fee_ratio"));
	String insurance_method = getStr(request.getParameter("insurance_method"));
	String insurance_lessee = getStr(request.getParameter("insurance_lessee"));
	String redressalk = getStr(request.getParameter("redressalk"));
	String pena_rate = getStr(request.getParameter("pena_rate"));
	String total_amt = getStr(request.getParameter("total_amt"));
	String actual_fund = getStr(request.getParameter("actual_fund"));
	String rough_earn = getStr(request.getParameter("rough_earn"));
	String year_earn = getStr(request.getParameter("year_earn"));
	String irr = getStr(request.getParameter("irr"));
	String plan_irr = getStr(request.getParameter("plan_irr"));
	String income_day = getStr(request.getParameter("income_day"));
	
	String czyid = (String)session.getAttribute("czyid");
	String systemDate = getSystemDate(0);
	boolean flag = false;
	ResultSet rsCount = null;
	if(contract_id!=null&&!contract_id.equals("")){
	String sql = "select count(*) from contract_condition where contract_id='"+contract_id+"'";
	System.out.println(sql);
	rsCount = db.executeQuery(sql);
	if(rsCount.next()){
		if(rsCount.getInt(1)>0){
			
		}else{
			flag = true;
		}
	}
	
	if(!zq.equals("1")){
	StringBuffer strSql = new StringBuffer();
	if(flag){
		strSql.append("insert into contract_condition (contract_id,equip_amt,lease_money,lease_term,income_number,year_rate,rate_float_type,period_type,settle_method,income_day,first_payment_ratio,first_payment,caution_money_ratio,caution_money,lessee_caution_ratio,lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio,sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio,handling_charge,return_ratio,return_amt,supervision_fee_ratio,supervision_fee,consulting_fee,other_fee,nominalprice,insurance_method,insurance_lessor,insurance_lessee,redressalk,pena_rate,total_amt,actual_fund,rough_earn,year_earn,irr,plan_irr,creator,create_date,modificator,modify_date,first_date,second_date) values (");
		strSql.append("'").append(contract_id).append("'")
		.append(",").append(equip_amt)
		.append(",").append(lease_money)
		.append(",").append(lease_term)
		.append(",").append(income_number)
		.append(",").append(year_rate)
		.append(",'").append(rate_float_type).append("'")
		.append(",'").append(period_type).append("'")
		.append(",'").append(settle_method).append("'")
		.append(",").append(income_day)
		.append(",").append(first_payment_ratio)
		.append(",").append(first_payment)
		.append(",").append(caution_money_ratio)
		.append(",").append(caution_money)
		.append(",").append(lessee_caution_ratio)
		.append(",").append(lessee_caution_money)
		.append(",").append(vndr_caution_ratio)
		.append(",").append(vndr_caution_money)
		.append(",").append(sale_caution_ratio)
		.append(",").append(sale_caution_money)
		.append(",").append(caution_deduction_ratio)
		.append(",").append(caution_deduction_money)
		.append(",").append(handling_charge_ratio)
		.append(",").append(handling_charge)
		.append(",").append(return_ratio)
		.append(",").append(return_amt)
		.append(",").append(supervision_fee_ratio)
		.append(",").append(supervision_fee)
		.append(",").append(consulting_fee)
		.append(",").append(other_fee)
		.append(",").append(nominalprice)
		.append(",'").append(insurance_method).append("'")
		.append(",").append(insurance_lessor)
		.append(",").append(insurance_lessee)
		.append(",").append(redressalk)
		.append(",").append(pena_rate)
		.append(",").append(total_amt)
		.append(",").append(actual_fund)
		.append(",").append(rough_earn)
		.append(",").append(year_earn)
		.append(",").append(irr)
		.append(",").append(plan_irr)
		.append(",'").append(czyid).append("'")
		.append(",'").append(systemDate).append("'")
		.append(",'").append(czyid).append("'")
		.append(",'").append(systemDate).append("'")
		.append(",'").append(charge_first_date).append("'")
		.append(",'").append(rent_first_date).append("'")
		.append(")");
		
	}else{
		strSql.append(" update contract_condition set ")
		.append(" equip_amt=").append(equip_amt)
		.append(", lease_money=").append(lease_money)
		.append(", lease_term=").append(lease_term)
		.append(", income_number=").append(income_number)
		.append(", year_rate=").append(year_rate)
		.append(", rate_float_type='").append(rate_float_type).append("'")
		.append(", period_type='").append(period_type).append("'")
		.append(", settle_method='").append(settle_method).append("'")
		.append(", income_day=").append(income_day)
		.append(", first_payment_ratio=").append(first_payment_ratio)
		.append(", first_payment=").append(first_payment)
		.append(", caution_money_ratio=").append(caution_money_ratio)
		.append(", caution_money=").append(caution_money)
		.append(", lessee_caution_ratio=").append(lessee_caution_ratio)
		.append(", lessee_caution_money=").append(lessee_caution_money)
		.append(", vndr_caution_ratio=").append(vndr_caution_ratio)
		.append(", vndr_caution_money=").append(vndr_caution_money)
		.append(", sale_caution_ratio=").append(sale_caution_ratio)
		.append(", sale_caution_money=").append(sale_caution_money)
		.append(", caution_deduction_ratio=").append(caution_deduction_ratio)
		.append(", caution_deduction_money=").append(caution_deduction_money)
		.append(", handling_charge_ratio=").append(handling_charge_ratio)
		.append(", handling_charge=").append(handling_charge)
		.append(", return_ratio=").append(return_ratio)
		.append(", return_amt=").append(return_amt)
		.append(", supervision_fee_ratio=").append(supervision_fee_ratio)
		.append(", supervision_fee=").append(supervision_fee)
		.append(", consulting_fee=").append(consulting_fee)
		.append(", other_fee=").append(other_fee)
		.append(", nominalprice=").append(nominalprice)
		.append(", insurance_method='").append(insurance_method).append("'")
		.append(", insurance_lessor=").append(insurance_lessor)
		.append(", insurance_lessee=").append(insurance_lessee)
		.append(", redressalk=").append(redressalk)
		.append(", pena_rate=").append(pena_rate)
		.append(", total_amt=").append(total_amt)
		.append(", actual_fund=").append(actual_fund)
		.append(", rough_earn=").append(rough_earn)
		.append(", year_earn=").append(year_earn)
		.append(", irr=").append(irr)
		.append(", plan_irr=").append(plan_irr)
		.append(", modificator='").append(czyid).append("'")
		.append(", modify_date='").append(systemDate).append("'")
		.append(", first_date='").append(charge_first_date).append("'")
		.append(", second_date='").append(rent_first_date).append("'")
		.append(" where contract_id='").append(contract_id).append("'");
	}
	System.out.println(strSql.toString());
	db.executeUpdate(strSql.toString());
	}
	}
 %>
<input type="hidden" name="charge_first_date" value="<%=charge_first_date %>">
<input type="hidden" name="rent_first_date" value="<%=rent_first_date %>">
<input type="hidden" name="lease_term" value="<%= lease_term%>">
<input type="hidden" name="income_number" value="<%=income_number %>">
<input type="hidden" name="year_rate" value="<%=year_rate %>">
<input type="hidden" name="lease_money" value="<%=lease_money %>">
<input type="hidden" name="caution_deduction_money" value="<%=caution_deduction_money %>">
<input type="hidden" name="period_type" value="<%=period_type %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">

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
<input type="hidden" name="rate_float_type" value="<%=rate_float_type %>">
<input type="hidden" name="settle_method" value="<%=settle_method %>">
<input type="hidden" name="first_payment_ratio" value="<%=first_payment_ratio %>">
<input type="hidden" name="caution_money_ratio" value="<%=caution_money_ratio %>">
<input type="hidden" name="lessee_caution_ratio" value="<%=lessee_caution_ratio %>">
<input type="hidden" name="lessee_caution_money" value="<%=lessee_caution_money %>">
<input type="hidden" name="vndr_caution_ratio" value="<%=vndr_caution_ratio %>">
<input type="hidden" name="vndr_caution_money" value="<%=vndr_caution_money %>">
<input type="hidden" name="sale_caution_ratio" value="<%=sale_caution_ratio %>">
<input type="hidden" name="sale_caution_money" value="<%=sale_caution_money %>">
<input type="hidden" name="caution_deduction_ratio" value="<%=caution_deduction_ratio %>">
<input type="hidden" name="handling_charge_ratio" value="<%=handling_charge_ratio %>">
<input type="hidden" name="return_ratio" value="<%=return_ratio %>">
<input type="hidden" name="supervision_fee_ratio" value="<%=supervision_fee_ratio %>">
<input type="hidden" name="insurance_lessee" value="<%=insurance_lessee %>">
<input type="hidden" name="redressalk" value="<%=redressalk %>">
<input type="hidden" name="pena_rate" value="<%=pena_rate %>">
<input type="hidden" name="total_amt" value="<%=total_amt %>">
<input type="hidden" name="actual_fund" value="<%=actual_fund %>">
<input type="hidden" name="rough_earn" value="<%=rough_earn %>">
<input type="hidden" name="year_earn" value="<%=year_earn %>">
<input type="hidden" name="irr" value="<%=irr %>">
<input type="hidden" name="plan_irr" value="<%=plan_irr %>">
<input type="hidden" name="insurance_method" value="<%=insurance_method %>">
<input type="hidden" name="fund_id" value="<%=fund_id %>">
<input type="hidden" name="volume" value="<%=volume %>">
<input type="hidden" name="zq" value="<%=zq %>">

<div id="divH" class="tabBody" style="background:#ffffff;width:100%;overflow:auto;">
<div id="TD_tab_0">
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
		<td align="center"><input type="text" name="rate1" size="10" onPropertychange="fun_rent(document.forms[0].principal_money1.value,document.forms[0].rate1.value,document.forms[0].rent1,document.forms[0].lease_money.value,document.forms[0].volume1.value);"> %</td>
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
	document.forms[0].action="zjbcht_zjhl.jsp";
	document.forms[0].target="hl";
	document.forms[0].submit();
}
function fun_xj(){
	document.forms[0].action="zjbcht_zj.jsp";
	document.forms[0].target="xj";
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
	alert("../zjcs/zjcs_save.jsp?Nper="+varvol+"&Pv="+parseFloat(varOtherValue)+"&Fv="+(parseFloat(varOtherValue)-parseFloat(varPcpl))+"&Type="+period_type+"&Pmt="+parseFloat(varObject)+"&lease_term="+returnNo);
	var url = "../zjcs/zjcs_save.jsp?Nper="+varvol+"&Pv="+parseFloat(varOtherValue)+"&Fv="+(parseFloat(varOtherValue)-parseFloat(varPcpl))+"&Type="+period_type+"&Pmt="+parseFloat(varObject)+"&lease_term="+returnNo;
  	xmlHttp.onreadystatechange = function(){stateChanged(varRate)};	
  	xmlHttp.open("POST",url,true);
  	xmlHttp.send(null);	  
	//varRate.value = getPmtYearRate(varvol,parseFloat(varOtherValue),(parseFloat(varOtherValue)-parseFloat(varPcpl)),period_type,parseFloat(varObject),returnNo);
}
</script>
<%db.close();%>