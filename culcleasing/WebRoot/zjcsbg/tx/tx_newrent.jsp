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
	String doc_id = getStr(request.getParameter("doc_id"));
	String contract_id = getStr(request.getParameter("contract_id"));
	String readonly = getStr(request.getParameter("readonly"));
	String irr = getStr(request.getParameter("irr"));
	//开始调息的期数
	String volume_id = getStr(request.getParameter("volume"));
	//开始调息的租金计划id
	String fund_id = getStr(request.getParameter("fund_id"));
	//开始调息日期
	String rate_date = getStr(request.getParameter("rate_date"));
	String new_rent = "";
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
    int ilease_term = 0;
    int int_volume_id=0;
    String year_rate ="";
    String lease_money = "0";
    String period_type = "";
    double dlease_money = 0;
    double ointerest = 0;
    //调息时央行利率C
	double linterest = 0;
	//A
	double stagerate = 0;
	//D
	double nstagerate = 0;
	double nrent = 0;
	double dotherlease_money = 0;
	//所有租金
	double dallRent = 0;
	double dallprincipal = 0;
    String sign_date = null;
    int remain_list = 0;
    String exceedhandling_charge = "";
    String oldIrr = "";
    String preDate = "";
    String strAjDate = "";
    String sql = "";
    sql = "select * from contract_condition where contract_id='"+contract_id+"'";
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
		oldIrr =getDBStr(rsCdt.getString("irr"));
	}
	rsCdt.close();
//	sql="select year_rate from fund_rent_plan where contract_id='"+contract_id+"' and rent_list='"+volume_id+"'";
//	System.out.println(sql);
//	ResultSet rsRate = db.executeQuery(sql);
//	if(rsRate.next()){
//		year_rate = getDBStr(rsRate.getString("year_rate"));
//	}
//	rsRate.close();
	//[start] [zhanghf] [2009-7-20]
	if(volume_id!=null&&!volume_id.equals("")){
		sql = "select sum(corpus) as sum_corpus from fund_rent_plan where contract_id='"+contract_id+"' and rent_list>="+volume_id;
		System.out.println(sql);
		ResultSet rssumRe = db.executeQuery(sql);
		if(rssumRe.next()){
			lease_money = getDBStr(rssumRe.getString("sum_corpus"));
		}
		rssumRe.close();
		if(lease_money!=null&&!lease_money.equals("")){
			dlease_money = Double.parseDouble(lease_money);
		}
		ArrayList alCashTemp = new ArrayList();
		HashMap hmCashTemp = new HashMap();
		hmCashTemp.put("net_flow","-"+String.valueOf(dlease_money));
		alCashTemp.add(hmCashTemp);
		//
		ResultSet rsTempRe = null;
		sql = "select * from fund_rent_plan where contract_id='" + contract_id + "' and rent_list>="+volume_id;
		System.out.println(sql);
		rsTempRe = db.executeQuery(sql);
		while(rsTempRe.next()){
			String rsrent = "";
			rsrent = getDBStr(rsTempRe.getString("rent"));
			HashMap hmCashRentTemp = new HashMap();
			hmCashRentTemp.put("net_flow",rsrent);
			alCashTemp.add(hmCashRentTemp);
		}
		rsTempRe.close();	
		year_rate = getRateByFlow(alCashTemp,String.valueOf(income_number_year));
	}
	//[end] [zhanghf] 
	
	int iAjCount = 0;
	sql = "select count(*)  as count from fund_adjust_interest_his where contract_id='"+contract_id+"' ";
	System.out.println(sql);
	ResultSet rsAjCount = db.executeQuery(sql);
	if(rsAjCount.next()){
		iAjCount = Integer.parseInt(getDBStr(rsAjCount.getString("count")));
	}
	rsAjCount.close();
	if(iAjCount>0){
		sql = "select * from fund_adjust_interest_his where contract_id='"+contract_id+"' order by start_date desc";
		System.out.println(sql);
		ResultSet rsAjIt = db.executeQuery(sql);
		if(rsAjIt.next()){
			strAjDate = getDBDateStr(rsAjIt.getString("start_date"));
		}
		rsAjIt.close();
	}else{
		strAjDate = start_date;
	}
	
	
	//如果调息情况表中有相应信息，取调息表中的数据，否则生成默认信息
	int iCount = 0;
	sql = "select count(*) as count from fund_adjust_interest_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	System.out.println(sql);
	ResultSet rsCount = db.executeQuery(sql);
	if(rsCount.next()){
		if(Integer.parseInt(rsCount.getString("count"))>0){
			iCount = 1;
		}
	}
	rsCount.close();
	if(iCount>0&&volume_id.equals("")){
		sql = "select * from fund_adjust_interest_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		ResultSet rsTemp = db.executeQuery(sql);
		if(rsTemp.next()){
			volume_id = getDBStr(rsTemp.getString("start_list"));
			dlease_money = Double.parseDouble(getDBStr(rsTemp.getString("remain_corpus")));
			year_rate = getDBStr(rsTemp.getString("rate_original"));
			nstagerate = Double.parseDouble(getDBStr(rsTemp.getString("rate_adjust")));
			new_rent = getDBStr(rsTemp.getString("adjust_rent"));
			exceedhandling_charge = getDBStr(rsTemp.getString("exceedhandling_charge"));
			rate_date = getDBDateStr(rsTemp.getString("start_date"));
		}
		rsTemp.close();
		if(volume_id!=null&&!volume_id.equals("")){
			int_volume_id = Integer.parseInt(volume_id);
		}
		remain_list = income_number-int_volume_id+1;
	}else{
		if(contract_id!=null&&!contract_id.equals("")){
			if(lease_term!=null&&!lease_term.equals("")){
				ilease_term = Integer.parseInt(lease_term);
			}
			if(volume_id!=null&&!volume_id.equals("")){
				int_volume_id = Integer.parseInt(volume_id);
			}
			if(fund_id!=null&&!fund_id.equals("")){
				sql = "select sum(corpus) as sum_corpus from fund_rent_plan where contract_id='"+contract_id+"' and rent_list>="+volume_id;
				System.out.println(sql);
				ResultSet rssum = db.executeQuery(sql);
				if(rssum.next()){
					lease_money = getDBStr(rssum.getString("sum_corpus"));
				}
				rssum.close();
			}
			if(lease_money!=null&&!lease_money.equals("")){
				dlease_money = Double.parseDouble(lease_money);
			}
			//合同签约时的时间
			sql = "select sign_date from contract_info where contract_id='"+contract_id+"'";
			System.out.println(sql);
			ResultSet rsDate = db.executeQuery(sql);
			if(rsDate.next()){
				sign_date = getDBDateStr(rsDate.getString("sign_date"));
			}
			
			
			
			//旧的央行利率B
			sql = "select * from fund_standard_interest where start_date<'";
			if(strAjDate==null||strAjDate.equals("")){
				sql+=sign_date;
			}else{
				sql+=strAjDate;
			}
			sql+="' order by start_date desc";
			System.out.println(sql);
			ResultSet rsIn = db.executeQuery(sql);
			if(rsIn.next()){
				if(ilease_term>60){
					ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_abovefive")));
				}else if(ilease_term>36){
					ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_five")));
				}
				else if(ilease_term>12){
					ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_three")));
				}
				else if(ilease_term>=6){
					ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_one")));
				}else if (ilease_term<6){
					ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_half")));
				}
			}
			
			//调息时央行利率C
			sql = "select * from fund_standard_interest where start_date<'"+rate_date+"' order by start_date desc";
			System.out.println(sql);
			ResultSet rsInl = db.executeQuery(sql);
			if(rsInl.next()){
				if(ilease_term>60){
					linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_abovefive")));
				}else if(ilease_term>36){
					linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_five")));
				}
				else if(ilease_term>12){
					linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_three")));
				}
				else if(ilease_term>=6){
					linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_one")));
				}else if (ilease_term<6){
					linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_half")));
				}
			}
			if(year_rate!=null&&!year_rate.equals("")){
				stagerate = Double.parseDouble(year_rate);
			}
			System.out.println("stagerate:"+stagerate);
			System.out.println("ointerest:"+ointerest);
			System.out.println("linterest:"+linterest);
			//新利率计算公式 [START]
			nstagerate = stagerate - (ointerest - linterest);
			
			//新利率计算公式 [END]
			//计算新租金
			if(income_number_year!=0&&dlease_money!=0&&(income_number-int_volume_id+1)!=0){
				new_rent = getPMT(String.valueOf(nstagerate/(100*income_number_year)),String.valueOf(income_number-int_volume_id+1),String.valueOf(-dlease_money),"0",period_type);
			}
			if(int_volume_id!=0){
				remain_list = income_number-int_volume_id+1;
			}
		}
	}
	
	System.out.println("strAjDate:"+strAjDate);
	System.out.println("rate_date:"+rate_date);
	long diffdate = getDateDiff(rate_date,strAjDate);
 %>
<%String strSql = "";
ResultSet rsCash = null;
ArrayList alCash = new ArrayList();
strSql = "select * from fund_contract_plan_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"' order by plan_list";
System.out.println(strSql);
rsCash = db.executeQuery(strSql);
while(rsCash.next()){
	alCash.add(new BigDecimal(formatNumberStr(getDBStr(rsCash.getString("net_flow")),"###0.00")));
}
rsCash.close();
 %>

<form method="post" action="" target="new_plan">
<table border="0" width="100%" id="table8" cellspacing="0" cellpadding="0" style="margin-top:2px;">
	<tr class="maintab">
		<td align="left" width="100%">
			<table border="0" cellspacing="0" cellpadding="0" >
			    <tr class="maintab">
			    	<td nowrap>
						调息开始期项:<input type="text" size="5" name="start_list" value="<%=volume_id %>" readonly> 
						剩余期项:<input type="text" size="5" name="ets_number" value="<%=remain_list %>" readonly> 
						剩余本金:<input type="text" size="10" name="remain_corpus" value="<%=dlease_money %>" readonly> 
						<input type="hidden" size="10" name="rate_date" value="<%=rate_date %>">
						调息前IRR:<%=formatNumberDoubleSix(oldIrr) %> 调息后IRR:<%=formatNumberDoubleSix(Double.parseDouble(getIRR(alCash,"1","1","12"))*100) %>
						距上次调息天数：<%=diffdate %> 上次调息日起：<%=strAjDate %>
					</td>
			    <tr>
			    <tr class="maintab">
					<td nowrap>
						利率由<input type="text" size="10" name="oldyear_rate" value="<%=year_rate %>" readonly>调整至<input type="text" size="10" name="newyear_rate" value="<%=formatNumberDoubleSix(nstagerate<0?0:nstagerate) %>" onblur="fun_txRent()"> 
						调息手续费<input type="text" size="10" name="exceedhandling_charge" value="<%=exceedhandling_charge %>"> 
						<%if(readonly!=null&&readonly.equals("1")){}else{ %><BUTTON class="btn_2" name="btnSave" value="租金调整"  type="button" onclick="fun_save()">
						<img src="../../images/save.gif" align="absmiddle" border="0">租金调整</button>	
						<BUTTON class="btn_2" name="btnSave" value="察看现金流"  type="button" onclick="fun_xj()">
						<img src="../../images/save.gif" align="absmiddle" border="0">察看现金流</button><%} %>
					</td>
			    </tr>
			</table>
		</td>
	</tr>
</table>
<!-- end cwCellTop -->
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
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="volume" value="<%=volume_id %>">
<input type="hidden" name="fund_id" value="<%=fund_id %>">
<input type="hidden" name="readonly" value="<%=readonly %>">
<input type="hidden" name="savetype" value="tx">
<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">
    <%
    ResultSet rsPlan = null;
	ArrayList al = null;
    strSql = "select * from ";
    strSql += "fund_rent_plan_temp";
    strSql +=" where contract_id='" + contract_id + "'";
    strSql +=" and measure_id='"+doc_id+"' ";
    strSql+=" order by rent_list";
    System.out.println(strSql);
    rsPlan = db.executeQuery(strSql);
     %>
    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>请款日</th>
		<th>期数</th>
		<th>本金</th>
		<th>利率(%)</th>
		<th>利息</th>
		<th>预计租金</th>
		<th>实际租金</th>
      </tr>
   
	<%
		double dAllCorpus = 0;
		double dAllInsteret = 0;
		double dAllRent = 0;
		double dAlleptdRent = 0;
		while(rsPlan.next()){
		 %>
		<tr>
		<td><%=getDBDateStr(rsPlan.getString("plan_date"))%></td>
		<%int ivolume_id = 0;
		if(volume_id!=null&&!volume_id.equals("")){
			ivolume_id = Integer.parseInt(volume_id);
		}
		 %>
		<td><%if(Integer.parseInt(getDBStr(rsPlan.getString("rent_list")))>=ivolume_id){ %><input type="hidden" name="rent_list" value="<%=getDBStr(rsPlan.getString("rent_list")) %>"><%}%><%=getDBStr(rsPlan.getString("rent_list"))%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("corpus")),"#,##0.00")%></td>
		<td><%=formatNumberDoubleSix(getDBStr(rsPlan.getString("year_rate")))%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("interest")),"#,##0.00")%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("eptd_rent")),"#,##0.00")%></td>
		<td><%=formatNumberStr(getDBStr(rsPlan.getString("rent")),"#,##0.00")%></td>
		<%
		if(!getDBStr(rsPlan.getString("corpus")).equals("")){
		dAllCorpus += Double.parseDouble(getDBStr(rsPlan.getString("corpus")));
		}
		if(!getDBStr(rsPlan.getString("interest")).equals("")){
		dAllInsteret += Double.parseDouble(getDBStr(rsPlan.getString("interest")));
		}
		if(!getDBStr(rsPlan.getString("rent")).equals("")){
		dAllRent += Double.parseDouble(getDBStr(rsPlan.getString("rent")));
		}
		if(getDBStr(rsPlan.getString("eptd_rent"))!=null&&!getDBStr(rsPlan.getString("eptd_rent")).equals("")){
		dAlleptdRent += Double.parseDouble(getDBStr(rsPlan.getString("eptd_rent")));
		}
		double dadjust = 0;
		if(rsPlan.getBigDecimal("rent")!=null&&rsPlan.getBigDecimal("eptd_rent")!=null)
		dadjust = rsPlan.getBigDecimal("rent").doubleValue()-rsPlan.getBigDecimal("eptd_rent").doubleValue(); %>
      </tr>
	<%} %>
	
	<tr>
		<td></td>
		<td></td>
		<td><%=formatNumberDouble(dAllCorpus) %></td>
		<td></td>
		<td><%=formatNumberDouble(dAllInsteret) %></td>
		<td><%=formatNumberDouble(dAlleptdRent) %></td>
		<td><%=formatNumberDouble(dAllRent) %></td>
      </tr>
    </table>


</div>
</div>
</form>
</body>

</html>
<script language="javascript">
function fun_save(){
	document.forms[0].action="tx_save.jsp";
	document.forms[0].target="new_plan";
	document.forms[0].submit();
}
function fun_xj(){
	document.forms[0].action="tx_cash.jsp";
	document.forms[0].target="_black";
	document.forms[0].submit();
}
function fun_tx_interest_rent(){
	fun_all_interest_rent("tx_check.jsp",document.forms[0].remain_corpus.value,document.forms[0].ets_number.value,document.forms[0].newRent.value);
}
function fun_txRent(){
	fun_allRent(document.forms[0].newyear_rate.value,document.forms[0].ets_number.value,document.forms[0].remain_corpus.value);
}
</script>
<%db.close();%>