<%@ page contentType="text/html; charset=gbk" language="java"  %>
<%@ page import="dbconn.*" %> 
<%@ page import="java.sql.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />  
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
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
	String czyid = (String)session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	String fund_id = getStr(request.getParameter("fund_id"));
	String volume_id = getStr(request.getParameter("volume"));
	String zq = getStr(request.getParameter("zq"));
	String doc_id = getStr(request.getParameter("doc_id"));

	String charge_first_date = getStr(request.getParameter("charge_first_date"));
	String rent_first_date = getStr(request.getParameter("rent_first_date"));
	String lease_term = getStr(request.getParameter("lease_term"));
	//String income_number =  getStr(request.getParameter("income_number"));
	String year_rate = getStr(request.getParameter("year_rate"));
	String lease_money = getStr(request.getParameter("lease_money"));
	String caution_deduction_money = getStr(request.getParameter("caution_deduction_money"));
	String contract_id = getStr(request.getParameter("contract_id"));
	
	String equip_amt = getStr(request.getParameter("equip_amt"));
	System.out.println("equip_amt:"+equip_amt);
	String first_payment =  getStr(request.getParameter("first_payment"));
	System.out.println("first_payment:"+first_payment);
	String caution_money = getStr(request.getParameter("caution_money"));
	System.out.println("caution_money:"+caution_money); 
	String handling_charge =  getStr(request.getParameter("handling_charge"));
	System.out.println("handling_charge:"+handling_charge);
	String return_amt = getStr(request.getParameter("return_amt"));
	System.out.println("return_amt:"+return_amt);
	String supervision_fee =  getStr(request.getParameter("supervision_fee"));
	System.out.println("supervision_fee:"+supervision_fee);
	String consulting_fee = getStr(request.getParameter("consulting_fee"));
	System.out.println("consulting_fee:"+consulting_fee);
	String other_fee =  getStr(request.getParameter("other_fee"));
	System.out.println("other_fee:"+other_fee);
	String nominalprice = getStr(request.getParameter("nominalprice"));
	System.out.println("nominalprice:"+nominalprice);
	String insurance_lessor =  getStr(request.getParameter("insurance_lessor"));
	System.out.println("insurance_lessor:"+insurance_lessor);
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
	
	double dinput=dfirst_payment+dcaution_money+dhandling_charge;
	double doutput = dequip_amt+dreturn_amt+dsupervision_fee+dconsulting_fee+dother_fee+dinsurance_lessor;
	double dendinput = dnominalprice;
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
			System.out.println(stage_listarray[i]);
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
	ArrayList al = null;
	if(alstage!=null&&alstage.size()>0){
		al = getRentPlan(alstage,dallRent,dallprincipal,income_number,charge_first_date,rent_first_date,volume_id!=null&&!volume_id.equals("")?Integer.parseInt(volume_id):0,12/income_number,true);
	}
	
	//添加阶段信息
	int ivolume = 0;//展期期次
	ResultSet rs = null;
	if(contract_id!=null&&!contract_id.equals("")){
		
		int ihave = 0;//总期数
		int stage=0;//当前阶段
		int inow = 0;//阶段的期数
		int ifront= 0 ;//之前阶段的总期数
		int iedit = 0;//当前阶段修改后的期数
		String sql="";
		sql="delete from contract_rent_stage_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);
		for(int i=0;i<alstage.size();i++){
			HashMap hm = (HashMap)alstage.get(i);
			sql="insert into contract_rent_stage_temp (measure_id,measure_date,contract_id,stage_list,rent_number,return_ratio,return_amt,year_rate,stage_rent) values (";
			sql+="'"+doc_id+"',getdate(),"+"'"+contract_id+"',"+hm.get("stage_list")+","+hm.get("rent_number")+","+hm.get("return_ratio")+","+hm.get("return_amt")+","+hm.get("year_rate")+","+hm.get("stage_rent")+")";
			System.out.println(sql);
			db.executeUpdate(sql);
		
		}
	
	}
    
    //添加计划信息
    double dallInterest = dallRent-dallprincipal;
    String sql=null;
    if(contract_id!=null&&!contract_id.equals("")){
    	sql="delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);
	    for(int i=0;i<al.size();i++){
	    	HashMap hm = (HashMap)al.get(i);
	    	sql="insert into contract_measure_formula (contract_id,rent_list,account_method) values (";
	    	sql+="'"+contract_id+"'";
	    	sql+=","+hm.get("volume");
	    	sql+=",'"+"期次："+(String)hm.get("volume")+"剩余本金："+hm.get("corpus_overage")+"本金:"+hm.get("corpus")+"=租金:"+hm.get("rent")+"-利息:"+hm.get("interest")+"')";
	    	System.out.println(sql);
	    	db.executeUpdate(sql);
	    	ResultSet rsId;
	    	String measure = null;
	    	sql="select @@identity";
	    	System.out.println(sql);
	    	rsId = db.executeQuery(sql);
	    	if(rsId.next()){
	    		measure = rsId.getString(1);
	    	}
	    	
	    	sql="insert into fund_rent_plan_temp (measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date) values(";
	    	sql+="'"+doc_id+"'";
	    	sql+=",getdate()";
	    	sql+=",'"+contract_id+"'";
	    	sql+=","+hm.get("volume");
	    	sql+=",'0'";
	    	sql+=",'"+hm.get("rent_date")+"'";
	    	sql+=","+hm.get("rent");
	    	sql+=","+hm.get("corpus");
	    	sql+=","+hm.get("year_rate");
	    	sql+=","+hm.get("interest");
	    	
	    	sql+=","+hm.get("rent");
	    	sql+=","+hm.get("corpus");
	    	sql+=","+hm.get("interest");
	    	sql+=",null";
	    	sql+=",null";
	    	sql+=",'1'";
	    	sql+=",'"+czyid+"'";
	    	sql+=",'"+datestr+"')";
	    	System.out.println(sql);
	    	db.executeUpdate(sql);
	    }

    }

    //添加现金流量
   
    if(contract_id!=null&&!contract_id.equals("")){
    	ResultSet rsxj = null;
	    ArrayList aljd = new ArrayList();
	    sql="select * from contract_rent_stage_temp where contract_id='"+contract_id+"' and measure_id ='"+doc_id+"'";
		System.out.println(sql);
		rsxj = db2.executeQuery(sql);
		while (rsxj.next()){
			HashMap hm = new HashMap ();
			hm.put("stage_list",getDBStr(rsxj.getString("stage_list")));
			hm.put("rent_number",getDBStr(rsxj.getString("rent_number")));
			hm.put("return_ratio",getDBStr(rsxj.getString("return_ratio")));
			hm.put("return_amt",getDBStr(rsxj.getString("return_amt")));
			hm.put("year_rate",getDBStr(rsxj.getString("year_rate")));
			hm.put("stage_rent",getDBStr(rsxj.getString("stage_rent")));
			aljd.add(hm);
		}
		ArrayList alxj = null;
		if(alstage!=null&&alstage.size()>0){
			alxj = getRentPlan(aljd,dallRent,dallprincipal,income_number,charge_first_date,rent_first_date,volume_id!=null&&!volume_id.equals("")?Integer.parseInt(volume_id):0,12/income_number,false);
		}
		
	   	if(alxj!=null){
   			sql="delete from fund_contract_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			System.out.println(sql);
			db.executeUpdate(sql);
	   		for(int i=0;i<alxj.size();i++){
	   			HashMap hm = (HashMap)alxj.get(i);	
				double showinput = 0;showinput =(i==0?dinput:i==(al.size()-1)?dendinput:Double.parseDouble(String.valueOf(hm.get("otherinput"))));
				double showoutput = 0;showoutput=(i==0?doutput:i==(al.size()-1)?dendoutput:Double.parseDouble(String.valueOf(hm.get("otheroutput"))));
				sql = "insert into fund_contract_plan_temp (contract_id,plan_list,plan_date,rent,corpus,year_rate,interest,fund_in,fund_out,net_flow,creator,create_date,measure_id) values (";
				sql+="'"+contract_id+"'";
				sql+=","+hm.get("volume");
				sql+=",'"+hm.get("rent_date")+"'";
				sql+=","+hm.get("rent");
				sql+=","+hm.get("corpus");
				sql+=","+hm.get("year_rate");
				sql+=","+hm.get("interest");
				sql+=","+String.valueOf(Double.parseDouble(String.valueOf(hm.get("otherinput")))-showinput);
				sql+=","+String.valueOf(Double.parseDouble(String.valueOf(hm.get("otheroutput")))-showoutput);
				sql+=","+String.valueOf(Double.parseDouble(String.valueOf(hm.get("rent")))+showinput-showoutput);
				sql+=",'"+czyid+"'";
				sql+=",getdate()";
				sql+=",'"+doc_id+"'";
				sql+=")";
				System.out.println(sql);
				db.executeUpdate(sql);
	   		}
	   	}
	   	
		rsxj.close();			
    }
	//

	
	db.close();
	db1.close();
	db2.close();

    
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
      </tr>
   
	<%if(al!=null){
		for(int i=0;i<al.size();i++){
			HashMap hm = (HashMap)al.get(i);
		 %>
		<tr class="maintab_content_table_title">
		<td><%=hm.get("rent_date") %></td>
		<td><%=hm.get("volume") %></td>
		<td><%=formatNumberStr(String.valueOf(hm.get("corpus")),"#,##0.00") %></td>
		<td><%=formatNumberInterest(String.valueOf(hm.get("year_rate"))) %></td>
		<td><%=formatNumberStr(String.valueOf(hm.get("interest")),"#,##0.00") %></td>
		<td><%=hm.get("rent") %></td>
      </tr>
	<%}} %>
</form>
<%
	
 %>
</div>
</div>

</body>
</html>

