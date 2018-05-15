<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 租金回笼计划</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%String readonly = getStr(request.getParameter("readonly"));
String rent = getStr(request.getParameter("rent"));
String edit_rent =  getStr(request.getParameter("edit_rent"));
 %>
<body style="overflow:auto;" >
<form method="post" action="" target="rentplan">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap >
									<%if(readonly!=null&&readonly.equals("1")){}else{ %>修改预计租金 <input type="text" name="edit_rent" size="10" value="<%=edit_rent!=null&&!edit_rent.equals("")?edit_rent:rent %>"> <BUTTON class="btn_2" name="btnSave" value="租金调整"  type="button" onclick="fun_save()">
									<img src="../../images/save.gif" align="absmiddle" border="0">租金调整</button><%} %>
									<BUTTON class="btn_2" name="btnSave" value="察看现金流"  type="button" onclick="fun_xj()" >
									<img src="../../images/save.gif" align="absmiddle" border="0">察看现金流</button>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%String getIrr = getStr(request.getParameter("irr")); 
	String allrent = getStr(request.getParameter("allrent")); 
	String ex = getStr(request.getParameter("ex")); 
%>
<script language="javascript">
<%if(getIrr!=null&&!getIrr.equals("")){%>
parent.con.form1.irr.value=<%=getIrr%>;
<%}%>
<%if(allrent!=null&&!allrent.equals("")){%>
parent.con.form1.allRent.value=<%=formatNumberDoubleSix(allrent)%>;
<%}%>
<%if(ex!=null&&!ex.equals("")){%>
parent.con.form1.year_rate.value=<%=ex%>;
<%}%>
</script>
<%
	String contract_id = getStr(request.getParameter("contract_id"));
	String doc_id = getStr(request.getParameter("doc_id"));
	
	String charge_first_date = "";
	String rent_first_date = "";
	String start_date = "";
	String lease_term = "";
	//年还租次数
	int income_number = 0;
	String income_number_year = "";
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
	String sql = "";
	ResultSet rsCdt = null;
	sql = "select * from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	System.out.println(sql);
	rsCdt = db.executeQuery(sql);
	if(rsCdt.next()){
		charge_first_date = getDBStr(rsCdt.getString("first_date"));
		rent_first_date = getDBStr(rsCdt.getString("second_date"));
		start_date = getDBStr(rsCdt.getString("start_date"));
		lease_term = getDBStr(rsCdt.getString("lease_term"));
		income_number = rsCdt.getInt("income_number");
		income_number_year = getDBStr(rsCdt.getString("income_number_year"));
		year_rate = getDBStr(rsCdt.getString("year_rate"));
		lease_money = getDBStr(rsCdt.getString("lease_money"));
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
		
	}
	rsCdt.close();
	
	int iCount = 0;
	ResultSet rsCount = null;
	sql = "select count(*) as count from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	System.out.println(sql);
	rsCount = db.executeQuery(sql);
	if(rsCount.next()){
		if(Integer.parseInt(rsCount.getString("count"))>0){
			iCount = 1;
		}
	}
	
	//整理租金阶段信息
	ResultSet rsPlan = null;
	ResultSet rsProj = null;
	String proj_id = "";
	ArrayList al = null;
	ArrayList alstage = new ArrayList();
	if(iCount==0){
		sql = " insert into fund_rent_plan_temp (measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date) select '"+doc_id+"',getdate(),'"+contract_id+"',rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date from fund_rent_plan_before where contract_id='"+contract_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);
		sql = "delete from fund_contract_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);
		sql = "insert into fund_contract_plan_temp (contract_id,plan_list,plan_date,rent,corpus,year_rate,interest,caution_deduction,fund_in,fund_out,net_flow,creator,create_date,measure_id) select '"+contract_id+"',plan_list,plan_date,rent,corpus,year_rate,interest,caution_deduction,fund_in,fund_out,net_flow,creator,create_date,'"+doc_id+"' from fund_contract_plan_before where contract_id='"+contract_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);
	}
	sql = "select * from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	System.out.println(sql);
	rsPlan = db.executeQuery(sql);
	al = new ArrayList();
	while (rsPlan.next()){
		HashMap hm = new HashMap();
		String rsvolume = "";
		String rsrent_date = "";
		String rscorpus = "";
		String rsyear_rate = "";
		String rsinterest = "";
		String rsrent = "";
		String rsadjust_amount = "";
		
		rsvolume = getDBStr(rsPlan.getString("rent_list"));
		rsrent_date = getDBDateStr(rsPlan.getString("plan_date"));
		rscorpus = getDBStr(rsPlan.getString("corpus"));
		rsyear_rate = getDBStr(rsPlan.getString("year_rate"));
		rsinterest = getDBStr(rsPlan.getString("interest"));
		rsrent = getDBStr(rsPlan.getString("rent"));
		rent = getDBStr(rsPlan.getString("eptd_rent"));
		rsadjust_amount = String.valueOf(Double.parseDouble(rsrent)-Double.parseDouble(rent));
		hm.put("volume",rsvolume);
		hm.put("rent_date",rsrent_date);
		hm.put("corpus",rscorpus);
		hm.put("year_rate",rsyear_rate);
		hm.put("interest",rsinterest);
		hm.put("rent",rsrent);
		hm.put("eptd_rent",rent);
		hm.put("adjust_amount",rsadjust_amount);
		al.add(hm);
	}
	rsPlan.close();
	
 %>


<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="charge_first_date" value="<%=charge_first_date %>">
<input type="hidden" name="rent_first_date" value="<%=rent_first_date %>">
<input type="hidden" name="start_date" value="<%=start_date %>">
<input type="hidden" name="lease_term" value="<%= lease_term%>">
<input type="hidden" name="income_number" value="<%=income_number %>">
<input type="hidden" name="income_number_year" value="<%=income_number_year %>">
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
<input type="hidden" name="rent" value="<%=rent %>">
<input type="hidden" name="savetype" value="rentplan">
<!-- end cwCellTop -->
<input type="hidden" name="cs" value="1">
<div id="divH" class="tabBody" style="background:#ffffff;width:100%;height:410px;overflow:auto;">
<div id="TD_tab_0">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>请款日</th>
		<th>期数</th>
		<th>本金</th>
		<th>利率(%)</th>
		<th>利息</th>
		<th>预计租金</th>
		<th>实际租金</th>
		<th>调整额</th>
      </tr>
   
	<%
	double doldRent = 0;
	double doldInterest = 0;
	double doldEptdRent = 0;
	double doldcorpus = 0;
	if(al!=null&&al.size()>0){
		for(int i=0;i<al.size();i++){
			HashMap hm = (HashMap)al.get(i);
			String return_volume = (String)hm.get("volume");
			String return_rent_date = (String)hm.get("rent_date");
			String return_corpus  = (String)hm.get("corpus");
			String return_year_rate = (String)hm.get("year_rate");
			String return_interest = (String)hm.get("interest");
			String return_rent = (String)hm.get("rent");
			String return_adjust_amount = (String)hm.get("adjust_amount");
			String return_eptd_rent = (String)hm.get("eptd_rent");
			doldRent += Double.parseDouble(return_rent);
			doldInterest +=Double.parseDouble(return_interest);
			doldEptdRent +=Double.parseDouble(return_eptd_rent);
			doldcorpus +=Double.parseDouble(return_corpus);
		 %>
		<tr>
			<td><input type="hidden" name="rent_date_<%=return_volume %>" value="<%=return_rent_date %>"><%=return_rent_date %></td>
			<td><input type="hidden" name="rent_list" value="<%=return_volume %>"><%=return_volume %></td>
			<td><input type="hidden" name="corpus_<%=return_volume %>" value="<%=return_corpus %>"><%=formatNumberStr(return_corpus,"#,##0.00") %></td>
			<td><input type="hidden" name="year_rate_<%=return_volume %>" value="<%=return_year_rate %>"><%=formatNumberDoubleSix(return_year_rate) %></td>
			<td><input type="hidden" name="interest_<%=return_volume %>" value="<%=return_interest %>"><%=formatNumberStr(return_interest,"#,##0.00") %></td>
			<td><input type="hidden" name="old_rent_<%=return_volume %>" value="<%=rent %>"><%=formatNumberStr(return_eptd_rent,"#,##0.00") %></td>
			<td><input type="hidden" name="rent_<%=return_volume %>" value="<%=return_rent %>"><%=formatNumberStr(return_rent,"#,##0.00") %></td>
			<td><input type="hidden" name="old_adjust_amount_<%=return_volume %>" value="<%=return_adjust_amount!=null&&!return_adjust_amount.equals("")?formatNumberStr(return_adjust_amount,"###0.00"):"0" %>"><input type="text" name="adjust_amount_<%=return_volume %>" value="<%=return_adjust_amount!=null&&!return_adjust_amount.equals("")?formatNumberStr(return_adjust_amount,"###0.00"):"0" %>"></td>
		</tr>
	<%}} %>
   <tr>
		<td></td>
		<td></td>
		<td><%=formatNumberDouble(doldcorpus) %></td>
		<td></td>
		<td><%=formatNumberDouble(doldInterest) %></td>
		<td><%=formatNumberDouble(doldEptdRent) %></td>
		<td><%=formatNumberDouble(doldRent) %></td>
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
function fun_hl(){
	document.forms[0].action="zjcsbgqz_rent.jsp";
	document.forms[0].target="rentplan";
	document.forms[0].submit();
}
function fun_xj(){
	document.forms[0].action="zjcsbgqz_cash.jsp";
	document.forms[0].target="cashplan";
	document.forms[0].submit();
}
function fun_save(){
	document.forms[0].action="zjcsbgqz_save.jsp";
	document.forms[0].target="rentplan";
	document.forms[0].submit();
}
</script>
<%db.close();%>