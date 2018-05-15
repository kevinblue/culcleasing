<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<jsp:useBean id="gcns" scope="page" class="com.service.GeneContractNetFlowService" />
<%@ include file="../../func/common.jsp"%>
<%
	String czyid = (String)session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	String stype = getStr(request.getParameter("savetype"));
	String readonly = getStr(request.getParameter("readonly"));
	String getIrr = "";
	if(stype.equals("add")){
		//文档id
		String doc_id = getStr(request.getParameter("doc_id"));
		//年还租次数
		String strincome_number = getStr(request.getParameter("income_number"));
		int income_number = 0;
		if(strincome_number!=null&&!strincome_number.equals("")){
			income_number = Integer.parseInt(strincome_number);
		}
		String strincome_number_year = getStr(request.getParameter("income_number_year"));
		int income_number_year = 0;
		if(strincome_number_year!=null&&!strincome_number_year.equals("")){
			income_number_year = Integer.parseInt(strincome_number_year);
		}
		//还租间隔
		int Interval = 12/income_number_year;
		//合同id
		String contract_id = getStr(request.getParameter("contract_id"));
		//剩余本金
		String lease_money = getStr(request.getParameter("lease_money"));
		//展期后期数
		String ets_number = getStr(request.getParameter("ets_number"));
		//开始展期的期数
		String volume_id = getStr(request.getParameter("volume"));
		//开始展期的租金计划id
		String fund_id = getStr(request.getParameter("fund_id"));
		
		String new_rent = getStr(request.getParameter("new_rent"));
		
		String edit_rent = getStr(request.getParameter("edit_rent"));
		//展期手续费
		String exceedhandling_charge = getStr(request.getParameter("exceedhandling_charge"));
		//int 开始展期的期数
		int int_volume = Integer.parseInt(volume_id);
		
		int int_ets_number = Integer.parseInt(ets_number);
		//展期后总期数
		int int_all_volume = (int_volume-1)+int_ets_number;
		
		String equip_amt = getStr(request.getParameter("equip_amt"));
		String start_date = getStr(request.getParameter("start_date"));
		String first_payment =  getStr(request.getParameter("first_payment"));
		String caution_money = getStr(request.getParameter("caution_money"));
		String handling_charge =  getStr(request.getParameter("handling_charge"));
		String return_amt = getStr(request.getParameter("return_amt"));
		String supervision_fee =  getStr(request.getParameter("supervision_fee"));
		String consulting_fee = getStr(request.getParameter("consulting_fee"));
		String other_fee =  getStr(request.getParameter("other_fee"));
		String nominalprice = getStr(request.getParameter("nominalprice"));
		String insurance_lessor =  getStr(request.getParameter("insurance_lessor"));
		String caution_deduction_money = getStr(request.getParameter("caution_deduction_money"));
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
		double dendoutput =  dcaution_money-dcaution_deduction_money;
		
		
		//整理租金阶段信息
		double dallprincipal = 0;
		double dallRent = 0;
		String eachRent = "";
		double drent = 0;
		String year_rate = getStr(request.getParameter("new_year_rate"));
		String period_type = getStr(request.getParameter("period_type"));
		double dyear_rate = 0;
		dyear_rate = Double.parseDouble(year_rate);
		//eachRent = getPMT(String.valueOf(dyear_rate/100/income_number_year),ets_number,"-"+lease_money,"0",volume_id!="1"?period_type:"0");
		eachRent = getStr(request.getParameter("new_rent"));
		if(lease_money!=null&&!lease_money.equals("")){
			dallprincipal = Double.parseDouble(lease_money);
		}
		if(eachRent!=null&&!eachRent.equals("")){
			drent = Double.parseDouble(eachRent);
		}
		dallRent = drent*int_ets_number;
		
		String plan_date = "";
		String old_year_rate = "";
		//计算租金列表
		String sql = "";
		sql = "select plan_date,year_rate from fund_rent_plan where id="+fund_id;
		System.out.println(sql);
		ResultSet rsDate = db.executeQuery(sql);
		if(rsDate.next()){
			plan_date = getDBDateStr(rsDate.getString("plan_date"));
			old_year_rate = getDBStr(rsDate.getString("year_rate"));
		}
		rsDate.close();
		
		
		ArrayList aladjust = new ArrayList();
		String []rent_list = request.getParameterValues("rent_list");
		if(rent_list!=null){
			for(int i=0;i<rent_list.length;i++){
				String adjust_amount = getStr(request.getParameter("adjust_amount_"+rent_list[i]));
				System.out.println("adjust_amount:"+adjust_amount);
				aladjust.add(adjust_amount);
			}
		}
		
		//计算年利率 [start]
		ArrayList alEx = new ArrayList();
		int k=0;
		if(period_type!=null){
		
			HashMap hmf = new HashMap();
			hmf.put("input","0");
			hmf.put("output",lease_money);
			hmf.put("caution_deduction","0");
			alEx.add(hmf);
			
			for(int i=k;i<int_ets_number;i++){
				HashMap hm = new HashMap();
				hm.put("input","0");
				hm.put("output","0");
				hm.put("caution_deduction","0");
			 	alEx.add(hm);
			}
		}
		year_rate = getRateByFlow(getRentCashArray(getAdjustRent(getExpectRent(String.valueOf(int_ets_number),edit_rent!=null&&!edit_rent.equals("")?edit_rent:new_rent),aladjust),alEx,"0"),String.valueOf(income_number_year));
		
		//整理租金阶段信息
		ArrayList alstage = new ArrayList();
		HashMap hmStage = new HashMap();
		hmStage.put("stage_list","2");
		hmStage.put("rent_number",ets_number);
		hmStage.put("return_ratio","100");
		hmStage.put("return_amt",lease_money);
		hmStage.put("year_rate",year_rate);
		hmStage.put("stage_rent",edit_rent!=null&&!edit_rent.equals("")?edit_rent:eachRent);
		alstage.add(hmStage);
		ArrayList al = null;
		if(alstage!=null&&alstage.size()>0){
			al = getRentPlan(alstage,dallRent,dallprincipal,income_number_year,plan_date,"",volume_id!=null&&!volume_id.equals("")?Integer.parseInt(volume_id):0,12/income_number_year,true,aladjust,"0");
		}
		if(contract_id!=null&&!contract_id.equals("")){
			sql="delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			System.out.println(sql);
			db.executeUpdate(sql);
			sql="insert into fund_rent_plan_temp (measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date) select '"+doc_id+"',getdate(),contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date from fund_rent_plan where contract_id='"+contract_id+"' and rent_list<"+volume_id;
			System.out.println(sql);
			db.executeUpdate(sql);
			double dallInterest = dallRent-dallprincipal;
			for(int i=0;i<al.size();i++){
		    	HashMap hm = (HashMap)al.get(i);
		    	sql="insert into fund_rent_plan_temp (measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date) values(";
		    	sql+="'"+doc_id+"'";
		    	sql+=",getdate()";
		    	sql+=",'"+contract_id+"'";
		    	sql+=","+hm.get("volume");
		    	sql+=",'未回笼'";
		    	sql+=",'"+hm.get("rent_date")+"'";
		    	sql+=","+hm.get("eptd_rent");
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
		
		   	sql = "delete from fund_rent_adjust where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		   	System.out.println(sql);
			db.executeUpdate(sql);
		   	sql = "insert into fund_rent_adjust (measure_id,contract_id,adjust_type,start_list,payday_adjust,payday_delay,exceeding_date,handling_charge,adjust_list,epdt_rent,year_rate,apply_flag) values (";
		   	sql += "'"+doc_id+"'";
		   	sql += ",'"+contract_id+"'";
		   	sql +=",'展期'";
		   	sql +=","+volume_id;
		   	sql +=",null,null";
		   	sql +=",'"+plan_date+"'";
		   	sql +=","+exceedhandling_charge;
		   	sql +=","+ets_number;
		   	sql +=","+new_rent;
		   	sql +=","+year_rate;
		   	sql += ",'0'";
		   	sql += ")";
		   	System.out.println(sql);
			db.executeUpdate(sql);
			gcns.GeneContractNetFlow(contract_id,doc_id,czyid);
		}
		%>
		<script>
			window.location.href = "zq_newrent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>&lease_money=<%=lease_money%>&ets_number=<%=ets_number%>&volume=<%=volume_id%>&fund_id=<%=fund_id%>&exceedhandling_charge=<%=exceedhandling_charge%>&new_year_rate=<%=year_rate%>&rent=<%=eachRent%>&readonly=<%=readonly%>&edit_rent=<%=edit_rent%>&irr=<%=getIrr%>";
		</script>
		<% 
	}
	db1.close();
	db.close();
	db2.close();
	
%>
