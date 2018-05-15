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
									<BUTTON class="btn_2" name="btnSave" value="计算回笼计划"  type="button" onclick="fun_save()">
									<img src="../../images/save.gif" align="absmiddle" border="0">调整回笼计划</button>
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

<input type="hidden" name="income_number" value="<%=income_number %>">
<input type="hidden" name="contract_id" value="<%=contract_id %>">
<input type="hidden" name="doc_id" value="<%=doc_id %>">
<input type="hidden" name="fund_id" value=<%=fund_id %>>
<input type="hidden" name="volume" value="<%=volume_id %>">
<input type="hidden" name="savetype" value="add">
<div id="divH" class="tabBody" style="background:#ffffff;width:100%;overflow:auto;">
<div id="TD_tab_0">
	<table>
	
	  <tr>
		<td align="right" width="15%">剩余本金</td>
		<td width="15%"><%=lease_money %></td>
	  	<td align="right">展期前剩余租金期数</td>
		<td width="15%"><%=iAllTerm-ivolume_id+1<=0?"":String.valueOf(iAllTerm-ivolume_id+1) %></td>
	  	<td align="right">展期手续费</td>
		<td width="15%"><input name="exceedhandling_charge" type="text" value="0"  dataType="money" size="10" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span></td>
	  </tr>	
	  <tr>
		<td align="right">调息期数</td>
		<td><%=ivolume_id%></td>
		<td align="right">调息前利息</td>
	    <td><input name="interestFront" type="text" value=""  dataType="Number" size="2" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span></td>	 	
		<td align="right">调息后利息</td>
		<td><input name="interestAfter" type="text" value=""  dataType="Number" size="2" maxlength="4" maxB="4"  Require="true"><span class="biTian">*</span></td>
	  </tr>	
	</table>
</div>
</div>
</form>
</body>
</html>
<script language="javascript">

function fun_save(){
	document.forms[0].action="tx_newrent.jsp";
	document.forms[0].target="new_plan";
	document.forms[0].submit();
}

</script>
<%db.close();%>