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

<body style="overflow:auto;" >
<%
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
	String year_rate = getStr(request.getParameter("year_rate"));
	String lease_money = getStr(request.getParameter("lease_money"));
	String caution_deduction_money = getStr(request.getParameter("caution_deduction_money"));
	String rent =  getStr(request.getParameter("rent"));
	String period_type =  getStr(request.getParameter("period_type"));
	
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
	
	//阶段
	String[] stage_listarray = request.getParameterValues("stage_list");
	//期数
	String volume = null;
	//本金所占比率
	String principal_rate = null;
	//本金所占金额
	String principal_money = null;
	//年利率
	String rate = null;
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
	
	ArrayList al = null;
	ArrayList alstage = new ArrayList();
	if(strincome_number!=null&&!strincome_number.equals("")&&year_rate!=null&&!year_rate.equals("")&&rent!=null&&!rent.equals("")){
	HashMap hmStage = new HashMap();
	hmStage.put("stage_list","1");
	hmStage.put("rent_number",String.valueOf(income_number));
	hmStage.put("return_ratio","100");
	hmStage.put("return_amt",lease_money);
	hmStage.put("year_rate",year_rate);
	hmStage.put("stage_rent",rent);
	alstage.add(hmStage);
	}
	if(alstage!=null&&alstage.size()>0){
		al = getRentPlan(alstage,dallRent,dallprincipal,income_number_year,charge_first_date,rent_first_date,0,12/income_number_year,false,aladjust,period_type);
	}
	ArrayList alCash = null;
	if(al!=null&&al.size()>0){
		ArrayList alput = new ArrayList();
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
					hmRentput.put("caution_deduction","0");
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
		alCash = getRentCashArray(al,alput,period_type,start_date,"1");
		
	}
 %>


	

<!-- end cwCellTop -->

<div id="divH" class="tabBody" style="background:#ffffff;width:100%;overflow:auto;">
<div id="TD_tab_0">

    <form name="list">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>请款日</th>
		<th>序号</th>
		<th>本金</th>
		<th>利率(%)</th>
		<th>利息</th>
		<th>租金</th>
		<th>保证金抵扣租金</th>
		<th>其他收入</th>
		<th>其他支出</th>
		<th>净流量</th>
      </tr>
   
	<%
     ArrayList alirr = new ArrayList();
     
		for(int i=0;i<alCash.size();i++){
		HashMap hm = (HashMap)alCash.get(i);
		 %>
		<tr>
		<td><%=hm.get("rent_date")%></td>
		<td><%=hm.get("volume")%></td>
		<td><%=formatNumberDoubleTwo(hm.get("corpus").toString())%></td>
		<td><%=formatNumberInterest(hm.get("year_rate").toString())%></td>
		<td><%=formatNumberDoubleTwo(hm.get("interest").toString())%></td>
		<td><%=formatNumberDoubleTwo(hm.get("rent").toString())%></td>
		<td><%=formatNumberDoubleTwo(hm.get("caution_deduction").toString()) %></td>
		<td><%=formatNumberDoubleTwo(hm.get("otherinput").toString()) %></td>
		<td><%=formatNumberDoubleTwo(hm.get("otheroutput").toString()) %></td>
		<td><%=formatNumberDoubleTwo(hm.get("net_flow").toString()) %></td>
		<%
		alirr.add(new BigDecimal((String)hm.get("net_flow"))); %>
      </tr>
      
	<%}
	 %>
	<%if(dallRent!=0&&dallprincipal!=0){ %>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td>IRR:<%=formatNumberDouble(Double.parseDouble(getIRR(alirr,"1","1","12"))*100) %></td>

      </tr>
      <%} %>
    </table>
</form>

</div>
</div>

</body>
</html>

