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
	String charge_first_date = getStr(request.getParameter("charge_first_date"));
	String rent_first_date = getStr(request.getParameter("rent_first_date"));
	String lease_term = getStr(request.getParameter("lease_term"));
	//String income_number =  getStr(request.getParameter("income_number"));
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
	
	double dinput=0;
	dinput=dfirst_payment+dcaution_money+dhandling_charge;
	double doutput = 0;
	doutput=dequip_amt+dreturn_amt+dsupervision_fee+dconsulting_fee+dother_fee+dinsurance_lessor;
	double dendinput = 0;
	dendinput = dnominalprice;
	double dendoutput = 0;
	

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
	//每期租金
	String rent = null;
	//合同交易结构中租赁本金
	//String lease_money = getStr(request.getParameter("lease_money"));
	//年还租次数
	String strincome_number = getStr(request.getParameter("income_number"));
	int income_number = 0;
	if(strincome_number!=null&&!strincome_number.equals("")){
		income_number = Integer.parseInt(strincome_number);
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
	//整理租金阶段信息
	ArrayList alstage = new ArrayList();
	if(stage_listarray!=null){
		for(int i=0;i<stage_listarray.length;i++){
			
			volume = getStr(request.getParameter("volume"+stage_listarray[i]));
			principal_rate = getStr(request.getParameter("principal_rate"+stage_listarray[i]));
			principal_money = getStr(request.getParameter("principal_money"+stage_listarray[i]));
			rate = getStr(request.getParameter("rate"+stage_listarray[i]));
			rent = getStr(request.getParameter("rent"+stage_listarray[i]));
			if(isNotNull(volume)&&isNotNull(principal_rate)&&isNotNull(principal_money)&&isNotNull(rate)&&isNotNull(rent)){
				HashMap hm = new HashMap();
				hm.put("stage_list",stage_listarray[i]);
				hm.put("rent_number",volume);
				hm.put("return_ratio",principal_rate);
				hm.put("return_amt",principal_money);
				hm.put("year_rate",rate);
				hm.put("stage_rent",rent);
				alstage.add(hm);
				double drent = 0;
				if(rent!=null&&!rent.equals("")){
					drent = Double.parseDouble(rent);
				}
				int ivolume = 0;
				if(volume!=null&&!volume.equals("")){
					ivolume = Integer.parseInt(volume);
				}
				double dprincipal = 0;
				if(principal_money!=null&&!principal_money.equals("")){
					dprincipal = Double.parseDouble(principal_money);
				}
				dallRent+=drent*ivolume;
				dallprincipal+=dprincipal;
			}
		}
	}
	System.out.println(income_number);
	ArrayList al = null;
	if(alstage!=null&&alstage.size()>0){
		al =  getRentPlan(alstage,dallRent,dallprincipal,income_number,charge_first_date,rent_first_date,0,12/income_number,false);
	}
	
 %>


	

<!-- end cwCellTop -->

<div style="vertical-align:top;width:100%; overflow:auto;position: relative; left: 0px; top: 0px"  id="mydiv">
<div id="TD_tab_0">

    <form name="list">

    <table border="0" style="border-collapse:collapse;" align="center" cellpadding="2" height="100%" cellspacing="1" width="100%" class="maintab_content_table">
      <tr class="maintab_content_table_title">
		<th>请款日</th>
		<th>期数</th>
		<th>本金</th>
		<th>利率(%)</th>
		<th>利息</th>
		<th>租金</th>
		<th>其他收入</th>
		<th>其他支出</th>
		<th>净流量</th>
      </tr>
     <%
     ArrayList arrflow = new ArrayList();
     if(al!=null&&al.size()>0){
		for(int i=0;i<al.size();i++){
			HashMap hm = (HashMap)al.get(i);
		 %>
		<tr class="maintab_content_table_title">
		<td><%=hm.get("rent_date") %></td>
		<td><%=hm.get("volume") %></td>
		<td><%=formatNumberStr(String.valueOf(hm.get("corpus")),"#,##0.00") %></td>
		<td><%=formatNumberInterest(String.valueOf(hm.get("year_rate"))) %></td>
		<td><%=formatNumberStr(String.valueOf(hm.get("interest")),"#,##0.00") %></td>
		<td><%=formatNumberStr(String.valueOf(hm.get("rent")),"#,##0.00") %></td>
		<td><%double showinput = 0;showinput =(i==0?dinput:i==(al.size()-1)?dendinput:Double.parseDouble(String.valueOf(hm.get("otherinput")))); %><%=formatNumberDouble(showinput) %></td>
		<td><%double showoutput = 0;showoutput=(i==0?doutput:i==(al.size()-1)?dendoutput:Double.parseDouble(String.valueOf(hm.get("otheroutput"))));%><%=formatNumberDouble(showoutput) %></td>
		<%
		double dxj=0;
		dxj+=Double.parseDouble(String.valueOf(hm.get("rent")));
		System.out.println(dxj);
		dxj+=showinput;
		System.out.println(dxj);
		dxj-=showoutput;
		System.out.println(dxj);
		arrflow.add(new BigDecimal(String.valueOf(dxj)));
		 %>
		 <td><%=formatNumberDouble(dxj) %></td>
      </tr>
	<%}} %>
	<%if(dallRent!=0&&dallprincipal!=0){
	 %>
	<tr class="maintab_content_table_title">
		<td></td>
		<td></td>
		<td><%=formatNumberDouble(dallprincipal) %></td>
		<td></td>
		<td><%=formatNumberDouble(dallRent-dallprincipal) %></td>
		<td><%=formatNumberDouble(dallRent) %></td>
		<td>IRR:<%=formatNumberDouble(Double.parseDouble(getIRR(arrflow,"1","1","12"))*100) %></td>
		<td></td>
		<td></td>
      </tr>
      <%} %>
    </table>
</form>

</div>
</div>

</body>
</html>

