
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
<%if(edit_rent!=null&&!edit_rent.equals("")){
	if(!edit_rent.equals(rent)){%>
parent.con.form1.rent.value=<%=edit_rent%>;
<%}}%>
<%if(allrent!=null&&!allrent.equals("")){%>
parent.con.form1.allRent.value=<%=formatNumberDoubleSix(allrent)%>;
<%}%>
<%if(ex!=null&&!ex.equals("")){%>
parent.con.form1.year_rate.value=<%=ex%>;
<%}%>

</script>
<%
	String proj_id = getStr(request.getParameter("proj_id"));
	ArrayList aladjust = new ArrayList();
	String []rent_list = request.getParameterValues("rent_list");
	if(rent_list!=null){
		for(int i=0;i<rent_list.length;i++){
			String adjust_amount = getStr(request.getParameter("adjust_amount_"+rent_list[i]));
			aladjust.add(adjust_amount);
		}
	}
	String charge_first_date = "";
	String rent_first_date = "";
	String start_date = "";
	String lease_term = "";
	String period_type = "";
	String year_rate = "";
	String lease_money = "";
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
	String strincome_number = "";
	String strincome_number_year = "";
	int income_number = 0;
	int income_number_year = 0;
	
	String doc_id = "";
	
	doc_id = getStr(request.getParameter("doc_id"));
	rent = getStr(request.getParameter("rent"));
	
//	charge_first_date = getStr(request.getParameter("charge_first_date"));
//	rent_first_date = getStr(request.getParameter("rent_first_date"));
//	start_date = getStr(request.getParameter("start_date"));
//	lease_term = getStr(request.getParameter("lease_term"));
//	period_type = getStr(request.getParameter("period_type"));
//	year_rate = getStr(request.getParameter("year_rate"));
//	lease_money = getStr(request.getParameter("lease_money"));
//	caution_deduction_money = getStr(request.getParameter("caution_deduction_money"));
//	equip_amt = getStr(request.getParameter("equip_amt"));
//	first_payment = getStr(request.getParameter("first_payment"));
//	caution_money = getStr(request.getParameter("caution_money"));
//	handling_charge = getStr(request.getParameter("handling_charge"));
//	return_amt = getStr(request.getParameter("return_amt"));
//	supervision_fee = getStr(request.getParameter("supervision_fee"));
//	consulting_fee = getStr(request.getParameter("consulting_fee"));
//	other_fee = getStr(request.getParameter("other_fee"));
//	nominalprice = getStr(request.getParameter("nominalprice"));
//	insurance_lessor = getStr(request.getParameter("insurance_lessor"));
//	strincome_number = getStr(request.getParameter("income_number"));
//	if(strincome_number!=null&&!strincome_number.equals("")){
//		income_number = Integer.parseInt(strincome_number);
//	}
	
	ResultSet rsCdt = null;
	String sql = "";
	sql = "select * from proj_condition_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
	System.out.println(sql);
	rsCdt = db.executeQuery(sql);
	if(rsCdt.next()){
		charge_first_date = getDBDateStr(rsCdt.getString("first_date"));
		rent_first_date = getDBDateStr(rsCdt.getString("second_date"));
		start_date = getDBDateStr(rsCdt.getString("start_date"));
		lease_term = getDBStr(rsCdt.getString("lease_term"));
		income_number = rsCdt.getInt("income_number");
		income_number_year = rsCdt.getInt("income_number_year");
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
	
	//整理租金阶段信息
	ResultSet rsPlan = null;
	
	ArrayList al = null;
	ArrayList alstage = new ArrayList();
	sql = "select * from fund_rent_plan_proj_temp where proj_id='"+proj_id+"' and measure_id='"+doc_id+"'";
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
		if(rsrent!=null&&!rsrent.equals("")&&rent!=null&&!rent.equals("")){
		rsadjust_amount = String.valueOf(Double.parseDouble(rsrent)-Double.parseDouble(rent));
		}
		hm.put("volume",rsvolume);
		hm.put("rent_date",rsrent_date);
		hm.put("corpus",rscorpus);
		hm.put("year_rate",rsyear_rate);
		hm.put("interest",rsinterest);
		hm.put("eptd_rent",rent);
		hm.put("rent",rsrent);
		hm.put("adjust_amount",rsadjust_amount);
		al.add(hm);
	}
	rsPlan.close();
 %>


	
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
<input type="hidden" name="proj_id" value="<%=proj_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
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
			if(return_rent!=null&&!return_rent.equals("")){
				doldRent += Double.parseDouble(return_rent);
			}
			if(return_interest!=null&&!return_interest.equals("")){
				doldInterest +=Double.parseDouble(return_interest);
			}
			if(return_eptd_rent!=null&&!return_eptd_rent.equals("")){
				doldEptdRent +=Double.parseDouble(return_eptd_rent);
			}
			if(return_corpus!=null&&!return_corpus.equals("")){
				doldcorpus +=Double.parseDouble(return_corpus);
			}
			
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

   <tr class="maintab_content_table_title">
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
	document.forms[0].action="zjcsbgxm_rent.jsp";
	document.forms[0].target="rentplan";
	document.forms[0].submit();
}
function fun_xj(){
	document.forms[0].action="zjcsbgxm_cash.jsp";
	document.forms[0].target="cashplan";
	document.forms[0].submit();
}
function fun_save(){
	document.forms[0].action="zjcsbgxm_save.jsp";
	document.forms[0].target="rentplan";
	document.forms[0].submit();
}
</script>
<%db.close();%>