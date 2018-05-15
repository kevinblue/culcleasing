<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<%@ include file="../../func/common.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>租金测算 - 租金回笼计划</title>
<link href="../../css/global.css" rel="stylesheet" type="text/css">
<script src="../../js/comm.js"></script>
</head>
<%String rent = getStr(request.getParameter("rent"));
	String edit_rent =  getStr(request.getParameter("edit_rent"));
 %>
<body style="overflow:auto;" >
<form method="post" action="">
<table  class="title_top" width=100% align=center cellspacing=0 border="0" cellpadding="0">
	<tr valign="top">
		<td  align=center width=100%>
			<table align=center width=96%  border="0" cellspacing="0" cellpadding="0" style="margin-top:0px">
				<tr>
					<td>
						<table border="0" cellspacing="0" cellpadding="0">    
							<tr class="maintab_dh">
								<td nowrap >
									修改预计租金 <input type="text" name="edit_rent" size="10" value="<%=edit_rent!=null&&!edit_rent.equals("")?edit_rent:rent %>"> <BUTTON class="btn_2" name="btnSave" value="租金调整"  type="button" onclick="fun_hl()">
									<img src="../../images/save.gif" align="absmiddle" border="0">租金调整</button>	
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
<%
	ArrayList alTemp = null;
	ArrayList alput = null;
	ArrayList alEx = null;
	String getIrr="";
	String allRent = "";
	String getEx = "";
	ArrayList aladjust = new ArrayList();
	String []rent_list = request.getParameterValues("rent_list");
	if(rent_list!=null){
		for(int i=0;i<rent_list.length;i++){
			String adjust_amount = getStr(request.getParameter("adjust_amount_"+rent_list[i]));
			aladjust.add(adjust_amount);
		}
	}
	String charge_first_date = getStr(request.getParameter("charge_first_date"));
	String rent_first_date = getStr(request.getParameter("rent_first_date"));
	String start_date = getStr(request.getParameter("start_date"));
	String lease_term = getStr(request.getParameter("lease_term"));
	String period_type = getStr(request.getParameter("period_type"));
	String year_rate = getStr(request.getParameter("year_rate"));
	String lease_money = getStr(request.getParameter("lease_money"));
	
	String caution_deduction_money = getStr(request.getParameter("caution_deduction_money"));
	String equip_amt = getStr(request.getParameter("equip_amt"));
	String first_payment =  getStr(request.getParameter("first_payment"));
	String caution_money = getStr(request.getParameter("caution_money"));
	String handling_charge =  getStr(request.getParameter("handling_charge"));
	String return_amt = getStr(request.getParameter("return_amt"));
	String supervision_fee =  getStr(request.getParameter("supervision_fee"));
	String consulting_fee = getStr(request.getParameter("consulting_fee"));
	String other_fee =  getStr(request.getParameter("other_fee"));
	String nominalprice = getStr(request.getParameter("nominalprice"));
	String insurance_lessor =  getStr(request.getParameter("insurance_lessor"));
	//总期次
	String strincome_number = getStr(request.getParameter("income_number"));
	int income_number = 0;
	if(strincome_number!=null&&!strincome_number.equals("")){
		income_number = Integer.parseInt(strincome_number);
	}
	//年还租次数
	String strincome_number_year = getStr(request.getParameter("income_number_year"));
	int income_number_year = 0;
	if(strincome_number_year!=null&&!strincome_number_year.equals("")){
		income_number_year = Integer.parseInt(strincome_number_year);
	}
	//所有租金
	double dallRent = 0;
	//所有本金
	double dallprincipal = 0;
	//合同交易结构中租赁本金
	double dlease_money = 0;
	if(lease_money!=null&&!lease_money.equals("")){
		dlease_money = Double.parseDouble(lease_money);
	}
	double drent = 0;
	int ilease_term = 0;
	if(rent!=null&&!rent.equals("")){
		drent = Double.parseDouble(rent);
	}
	if(lease_term!=null&&!lease_term.equals("")){
		ilease_term = Integer.parseInt(lease_term);
	}
	dallRent = drent*income_number;
	dallprincipal = dlease_money;
	
	
	double dequip_amt = 0;
	if(equip_amt!=null&&!equip_amt.equals("")){
	dequip_amt = Double.parseDouble(equip_amt);   //-
	}
	double dfirst_payment = 0;
	if(first_payment!=null&&!first_payment.equals("")){
	dfirst_payment = Double.parseDouble(first_payment); //+
	}
	double dcaution_money = 0;
	if(caution_money!=null&&!caution_money.equals("")){
	dcaution_money =Double.parseDouble(caution_money);   //+
	}
	double dhandling_charge = 0;
	if(handling_charge!=null&&!handling_charge.equals("")){
	dhandling_charge = Double.parseDouble(handling_charge);   //+
	}
	double dreturn_amt = 0;
	if(return_amt!=null&&!return_amt.equals("")){
	dreturn_amt = Double.parseDouble(return_amt);           //-
	}
	double dsupervision_fee = 0;
	if(supervision_fee!=null&&!supervision_fee.equals("")){
	dsupervision_fee = Double.parseDouble(supervision_fee);   //-
	}
	double dconsulting_fee = 0;
	if(consulting_fee!=null&&!consulting_fee.equals("")){
	dconsulting_fee = Double.parseDouble(consulting_fee);     //-
	}
	double dother_fee = 0;
	if(other_fee!=null&&!other_fee.equals("")){
	dother_fee = Double.parseDouble(other_fee);              //-
	}
	double dnominalprice = 0;
	if(nominalprice!=null&&!nominalprice.equals("")){
	dnominalprice = Double.parseDouble(nominalprice);         //+
	}
	double dinsurance_lessor = 0;
	if(insurance_lessor!=null&&!insurance_lessor.equals("")){
	dinsurance_lessor = Double.parseDouble(insurance_lessor);  //-
	}
	double dcaution_deduction_money = 0;
	if(caution_deduction_money!=null&&!caution_deduction_money.equals("")){
		dcaution_deduction_money = Double.parseDouble(caution_deduction_money); 
	}
	
	double dinput=dfirst_payment+dcaution_money+dhandling_charge+dreturn_amt+dsupervision_fee;
	double doutput = dequip_amt+dconsulting_fee+dother_fee+dinsurance_lessor;
	double dendinput = dnominalprice;
	double dendoutput = dcaution_money-dcaution_deduction_money;
	//计算年利率 [start]
	alEx = new ArrayList();
	int k=0;
	if(period_type!=null){
		if(period_type.equals("0")){
			HashMap hm = new HashMap();
			hm.put("input","0");
			hm.put("output",lease_money);
			hm.put("caution_deduction","0");
			alEx.add(hm);
		}else{
		 	HashMap hm = new HashMap();
			hm.put("input","0");
			hm.put("output",lease_money);
			hm.put("caution_deduction","0");
		 	alEx.add(hm);
		 	k=1;
		}
		for(int i=k;i<income_number;i++){
			HashMap hm = new HashMap();
			hm.put("input","0");
			hm.put("output","0");
			hm.put("caution_deduction","0");
		 	alEx.add(hm);
		}
	}
	//计算年利率 [end]
	year_rate = getRateByFlow(getRentCashArray(getAdjustRent(getExpectRent(String.valueOf(income_number),edit_rent!=null&&!edit_rent.equals("")?edit_rent:rent),aladjust),alEx,period_type),String.valueOf(income_number_year));
	
	
	//整理租金阶段信息
	ArrayList al = null;
	ArrayList alstage = new ArrayList();
	if(strincome_number!=null&&!strincome_number.equals("")&&year_rate!=null&&!year_rate.equals("")&&((rent!=null&&!rent.equals(""))||(edit_rent!=null&&!edit_rent.equals("")))){
	HashMap hmStage = new HashMap();
	hmStage.put("stage_list","1");
	hmStage.put("rent_number",String.valueOf(income_number));
	hmStage.put("return_ratio","100");
	hmStage.put("return_amt",lease_money);
	hmStage.put("year_rate",year_rate);
	hmStage.put("stage_rent",edit_rent!=null&&!edit_rent.equals("")?edit_rent:rent);
	alstage.add(hmStage);
	}
	if(alstage!=null&&alstage.size()>0){
		//income 不能为0
		al = getRentPlan(alstage,dallRent,dallprincipal,income_number_year,charge_first_date,rent_first_date,0,12/income_number_year,true,aladjust,period_type);
	}
	
	
	
	
	ArrayList alCash = null;
	if(al!=null&&al.size()>0){
		alput = new ArrayList();
		//保证金抵扣计算
		int dedu = 0;
		if(dedu==0){
			//抵扣
			double dsubCaution = -1;
			if(dcaution_deduction_money>=0){
				dsubCaution = dcaution_deduction_money;
			}
			//根据租金计划从后向前计算保证金抵扣情况
			for(int i=(al.size()-1);i>=0;i--){
				HashMap hmGetRent = (HashMap)al.get(i);
				String strGetRent = (String)hmGetRent.get("rent");
				double dGetRent = 0;
				if(strGetRent!=null&&!strGetRent.equals("")){
					dGetRent = Double.parseDouble(strGetRent);
				}
				//如果没有保证金抵扣放入合同结束时收入支出
				if(i==(al.size()-1)&&dsubCaution==-1){
					HashMap hmRentput = new HashMap();
					hmRentput.put("input",String.valueOf(dendinput));
					hmRentput.put("output",String.valueOf(dendoutput));
					hmRentput.put("caution_deduction","30");
					alput.add(hmRentput);
				}
				//如果有保证金抵扣
				if(dsubCaution >= 0){
					//如果保证金返还〉租金
					if(dsubCaution>=dGetRent){
						//加入租金抵扣，不保存合同结束时收入支出
						HashMap hmRentput = new HashMap();
						hmRentput.put("input","0");
						hmRentput.put("output","0");
						hmRentput.put("caution_deduction",String.valueOf(dGetRent));
						alput.add(hmRentput);
						dsubCaution-=dGetRent;
					}else if(dsubCaution<dGetRent&&dsubCaution>0){
						//如果保证金返还<租金 加入剩余保证金返还,当期标示最为最后一期，保存合同结束时收入支出
						HashMap hmRentput = new HashMap();
						hmRentput.put("input",String.valueOf(dendinput));
						hmRentput.put("output",String.valueOf(dendoutput));
						hmRentput.put("caution_deduction",String.valueOf(dsubCaution));
						alput.add(hmRentput);
						dsubCaution = -1;
					}else if(dsubCaution==0){
						//如果保证金返还==上一期租金  （全部抵完） 当期标示最为最后一期，保存合同结束时收入支出
						HashMap hmRentput = new HashMap();
						hmRentput.put("input",String.valueOf(dendinput));
						hmRentput.put("output",String.valueOf(dendoutput));
						hmRentput.put("caution_deduction","0");
						alput.add(hmRentput);
						dsubCaution = -1;
					}
				}else{
					HashMap hmRentput = new HashMap();
					hmRentput.put("input","0");
					hmRentput.put("output","0");
					hmRentput.put("caution_deduction","0");
					alput.add(hmRentput);
				}
			}
			if(period_type.equals("0")){
				HashMap hmput = new HashMap();
				hmput.put("input",String.valueOf(dinput));
				hmput.put("output",String.valueOf(doutput));
				hmput.put("caution_deduction","0");
				alput.add(hmput);
			}else{
				HashMap hmput = new HashMap();
				hmput.put("input",String.valueOf(dinput));
				hmput.put("output",String.valueOf(doutput));
				hmput.put("caution_deduction","0");
				alput.set((alput.size()-1),hmput);
			}
			alput = invertList(alput);
		}else{
			//非抵扣
			int j=1;
			HashMap hmput = new HashMap();
			hmput.put("input",String.valueOf(dinput));
			hmput.put("output",String.valueOf(doutput));
			hmput.put("caution_deduction","0");
			alput.add(hmput);
			if(period_type.equals("0")){
				//期末
				j=0;
			}
			for(int i=j;i<(al.size()-1);i++){
				HashMap hmRentput = new HashMap();
				hmRentput.put("input","0");
				hmRentput.put("output","0");
				hmRentput.put("caution_deduction","0");
				alput.add(hmRentput);
			}
			HashMap hmEndput = new HashMap();
			hmEndput.put("input",String.valueOf(dendinput));
			hmEndput.put("output",String.valueOf(dendoutput));
			hmput.put("caution_deduction","0");
			alput.add(hmEndput); 
		}
		
		
	}
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
<!-- end cwCellTop -->
<input type="hidden" name="cs" value="1">
<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
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
	double dActualRent = 0;
	if(al!=null&&al.size()>0){
		for(int i=0;i<al.size();i++){
			HashMap hm = (HashMap)al.get(i);
			String return_volume = (String)hm.get("volume");
			String return_rent_date = (String)hm.get("rent_date");
			String return_corpus  = (String)hm.get("corpus");
			String return_year_rate = (String)hm.get("year_rate");
			String return_interest = (String)hm.get("interest");
			String return_rent = (String)hm.get("rent");
			String eptd_rent = (String)hm.get("eptd_rent");
			String return_adjust_amount = (String)hm.get("adjust_amount");
			dActualRent+=Double.parseDouble(return_rent);
		 %>
		<tr class="maintab_content_table_title">
			<td><input type="hidden" name="rent_date_<%=return_volume %>" value="<%=return_rent_date %>"><%=return_rent_date %></td>
			<td><input type="hidden" name="rent_list" value="<%=return_volume %>"><%=return_volume %></td>
			<td><input type="hidden" name="corpus_<%=return_volume %>" value="<%=return_corpus %>"><%=formatNumberStr(return_corpus,"#,##0.00") %></td>
			<td><input type="hidden" name="year_rate_<%=return_volume %>" value="<%=return_year_rate %>"><%=formatNumberDoubleSix(return_year_rate) %></td>
			<td><input type="hidden" name="interest_<%=return_volume %>" value="<%=return_interest %>"><%=formatNumberStr(return_interest,"#,##0.00") %></td>
			<td><input type="hidden" name="old_rent_<%=return_volume %>" value="<%=rent %>"><%=formatNumberStr(eptd_rent,"#,##0.00") %></td>
			<td><input type="hidden" name="rent_<%=return_volume %>" value="<%=return_rent %>"><%=formatNumberStr(return_rent,"#,##0.00") %></td>
			<td><input type="hidden" name="old_adjust_amount_<%=return_volume %>" value="<%=return_adjust_amount!=null&&!return_adjust_amount.equals("")?formatNumberStr(return_adjust_amount,"###0.00"):"0" %>"><input type="text" name="adjust_amount_<%=return_volume %>" value="<%=return_adjust_amount!=null&&!return_adjust_amount.equals("")?formatNumberStr(return_adjust_amount,"###0.00"):"0" %>"></td>
		</tr>
	<%}} %>
	<%if(dallRent!=0&&dallprincipal!=0){ %>
	<tr class="maintab_content_table_title">
		<td></td>
		<td></td>
		<td><%=formatNumberDouble(dallprincipal) %></td>
		<td></td>
		<td><%=formatNumberDouble(dallRent-dallprincipal) %></td>
		<td><%=formatNumberDouble(dallRent) %></td>
		<td><%=formatNumberDouble(dActualRent) %></td>
		<td></td>
		<td></td>
      </tr>
      <%} %>
    </table>


</div>
</div>
</form>
</body>
</html>
<script language="javascript">
function fun_hl(){
	
	document.forms[0].action="zjcsbg_rent.jsp";
	document.forms[0].target="rentplan";
	document.forms[0].submit();
}

function fun_xj(){
	document.forms[0].action="zjcsbg_cash.jsp";
	document.forms[0].target="cashplan";
	document.forms[0].submit();
}
</script>
 <%     
 if(al!=null&&al.size()>0){
	alCash = getRentCashArray(al,alput,period_type,start_date,"1");
	getIrr = getIRRByFlow(alCash);
	allRent = getAllRent(al);
	//getEx = getRateByFlowArray(alTemp,alEx,period_type,start_date,"0",strincome_number_year);
	getEx = year_rate;
	  %>
<script language="javascript">
<%if(getIrr!=null&&!getIrr.equals("")){%>
parent.con.form1.irr.value=<%=getIrr%>;
<%}%>
<%if(allRent!=null&&!allRent.equals("")){%>
parent.con.form1.allRent.value=<%=allRent%>;
<%}%>
<%if(getEx!=null&&!getEx.equals("")){%>
parent.con.form1.year_rate.value=<%=getEx%>;
<%}%>
<%if(edit_rent!=null&&!edit_rent.equals("")){
	if(!edit_rent.equals(rent)){%>
parent.con.form1.rent.value=<%=edit_rent%>;
<%}}%>
</script>
<%}%>