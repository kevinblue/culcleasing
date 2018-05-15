<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%
	ArrayList alEx = new ArrayList();
	ArrayList alTemp = new ArrayList();
	double dallrent = 0;
	String fund_id = getStr(request.getParameter("fund_id"));
	String volume = getStr(request.getParameter("volume"));
	String zq = getStr(request.getParameter("zq"));
	String doc_id = getStr(request.getParameter("doc_id"));
	String cs = getStr(request.getParameter("cs"));
	String readonly = getStr(request.getParameter("readonly"));
	String getIrr = "";
	String getEx = "";
	
	String charge_first_date = getStr(request.getParameter("charge_first_date"));
	String rent_first_date = getStr(request.getParameter("rent_first_date"));
	String start_date = getStr(request.getParameter("start_date"));
	String period_type = getStr(request.getParameter("period_type"));
	String lease_term = getStr(request.getParameter("lease_term"));
	String income_number =  getStr(request.getParameter("income_number"));
	String income_number_year = getStr(request.getParameter("income_number_year"));
	String year_rate = getStr(request.getParameter("year_rate"));
	String lease_money = getStr(request.getParameter("lease_money"));
	String caution_deduction_money = getStr(request.getParameter("caution_deduction_money"));
	
	String rent = getStr(request.getParameter("rent"));
	String edit_rent =  getStr(request.getParameter("edit_rent"));
	
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
	String stype = getStr(request.getParameter("savetype"));
	System.out.println("savetype:"+stype);
if(stype.equals("add")||stype.equals("add_deal")||stype.equals("rentdate")){
	ResultSet rsCount = null;
	if(contract_id!=null&&!contract_id.equals("")){
	String sql = "select count(*) from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	System.out.println(sql);
	rsCount = db.executeQuery(sql);
	if(rsCount.next()){
		if(rsCount.getInt(1)>0){
			
		}else{
			flag = true;
		}
	}
	
	StringBuffer strSql = new StringBuffer();
	if(flag){
		strSql.append("insert into contract_condition_temp (contract_id,equip_amt,lease_money,lease_term,income_number,income_number_year,year_rate,rate_float_type,period_type,settle_method,income_day,first_payment_ratio,first_payment,caution_money_ratio,caution_money,lessee_caution_ratio,lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio,sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio,handling_charge,return_ratio,return_amt,supervision_fee_ratio,supervision_fee,consulting_fee,other_fee,nominalprice,insurance_method,insurance_lessor,insurance_lessee,redressalk,pena_rate,total_amt,actual_fund,rough_earn,year_earn,irr,plan_irr,creator,create_date,modificator,modify_date,first_date,second_date,start_date,measure_id) values (");
		strSql.append("'").append(contract_id).append("'")
		.append(",").append(equip_amt)
		.append(",").append(lease_money)
		.append(",").append(lease_term)
		.append(",").append(income_number)
		.append(",").append(income_number_year)
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
		.append(",").append(redressalk!=null&&!redressalk.equals("")?redressalk:"0")
		.append(",").append(pena_rate)
		.append(",").append(total_amt)
		.append(",").append(actual_fund)
		.append(",").append(rough_earn)
		.append(",").append(year_earn)
		.append(",").append(irr)
		.append(",").append(plan_irr!=null&&!plan_irr.equals("")?plan_irr:"0")
		.append(",'").append(czyid).append("'")
		.append(",'").append(systemDate).append("'")
		.append(",'").append(czyid).append("'")
		.append(",'").append(systemDate).append("'")
		.append(",'").append(charge_first_date).append("'")
		.append(",'").append(rent_first_date).append("'")
		.append(",'").append(start_date).append("'")
		.append(",'").append(doc_id).append("'")
		.append(")");
		
	}else{
		strSql.append(" update contract_condition_temp set ")
		.append(" equip_amt=").append(equip_amt)
		.append(", lease_money=").append(lease_money)
		.append(", lease_term=").append(lease_term)
		.append(", income_number=").append(income_number)
		.append(", income_number_year=").append(income_number_year)
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
		.append(", redressalk=").append(redressalk!=null&&!redressalk.equals("")?redressalk:"0")
		.append(", pena_rate=").append(pena_rate)
		.append(", total_amt=").append(total_amt)
		.append(", actual_fund=").append(actual_fund)
		.append(", rough_earn=").append(rough_earn)
		.append(", year_earn=").append(year_earn)
		.append(", irr=").append(irr)
		.append(", plan_irr=").append(plan_irr!=null&&!plan_irr.equals("")?plan_irr:"0")
		.append(", modificator='").append(czyid).append("'")
		.append(", modify_date='").append(systemDate).append("'")
		.append(", first_date='").append(charge_first_date).append("'")
		.append(", second_date='").append(rent_first_date).append("'")
		.append(", start_date='").append(start_date).append("'")
		.append(", measure_id='").append(doc_id).append("'")
		.append(" where contract_id='").append(contract_id).append("'")
		.append(" and  measure_id='").append(doc_id).append("'");
	}
	System.out.println(strSql.toString());
	db.executeUpdate(strSql.toString());
	}
	
}
if(stype.equals("add_deal")||stype.equals("rentplan")){
	ArrayList aladjust = new ArrayList();
	String []rent_list = request.getParameterValues("rent_list");
	if(rent_list!=null){
		for(int i=0;i<rent_list.length;i++){
			String adjust_amount = getStr(request.getParameter("adjust_amount_"+rent_list[i]));
			aladjust.add(adjust_amount);
		}
	}
	//年还租次数
	String strincome_number = getStr(request.getParameter("income_number"));
	int int_income_number = 0;
	if(strincome_number!=null&&!strincome_number.equals("")){
		int_income_number = Integer.parseInt(strincome_number);
	}
	String strincome_number_year = getStr(request.getParameter("income_number_year"));
	int int_income_number_year = 0;
	if(strincome_number_year!=null&&!strincome_number_year.equals("")){
		int_income_number_year = Integer.parseInt(strincome_number_year);
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
	double dlease_term = 0;
	if(rent!=null&&!rent.equals("")){
		drent = Double.parseDouble(rent);
	}
	if(lease_term!=null&&!lease_term.equals("")){
		dlease_term = Double.parseDouble(lease_term);
	}
	dallRent = drent*int_income_number;
	dallprincipal = dlease_money;
	
    
     //添加现金流量
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
		for(int i=k;i<int_income_number;i++){
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
	ResultSet rsPlan = null;
	ResultSet rsCdt = null;
	String sql = "";
	ArrayList al = new ArrayList();
	ArrayList alstage = new ArrayList();
	if(lease_term!=null&&!lease_term.equals("")&&lease_money!=null&&!lease_money.equals("")&&year_rate!=null&&!year_rate.equals("")&&rent!=null&&!rent.equals("")){
		HashMap hmStage = new HashMap();
		hmStage.put("stage_list","1");
		hmStage.put("rent_number",String.valueOf(strincome_number));
		hmStage.put("return_ratio","100");
		hmStage.put("return_amt",lease_money);
		hmStage.put("year_rate",year_rate);
		hmStage.put("stage_rent",edit_rent!=null&&!edit_rent.equals("")?edit_rent:rent);
		alstage.add(hmStage);
		if(alstage!=null&&alstage.size()>0){
		//income 不能为0
			al = getRentPlan(alstage,dallRent,dallprincipal,int_income_number_year,charge_first_date,rent_first_date,0,12/int_income_number_year,true,aladjust,period_type);
		}
		
	}
	
	
	sql = "insert into contract_rent_stage_temp values (";
	sql+="'"+doc_id+"'";
	sql+=",getdate()";
	sql+=",'"+contract_id+"'";
	sql+=",1";
	sql+=","+(String.valueOf(strincome_number)!=null&&!strincome_number.equals("")?strincome_number:"0");
	sql+=",100";
	sql+=","+(lease_money!=null&&!lease_money.equals("")?lease_money:"0");
	sql+=","+(year_rate!=null&&!year_rate.equals("")?year_rate:"0");
	sql+=","+(rent!=null&&!rent.equals("")?rent:edit_rent);
	sql+=")";
	System.out.println(sql);
	db.executeUpdate(sql);
	
	double dallInterest = dallRent-dallprincipal;
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
	    	sql+=",'"+systemDate+"')";
	    	System.out.println(sql);
	    	db.executeUpdate(sql);
	    }

    }
	
	ArrayList alxj = new ArrayList();
    if(contract_id!=null&&!contract_id.equals("")){
    	if(lease_term!=null&&!lease_term.equals("")&&lease_money!=null&&!lease_money.equals("")&&year_rate!=null&&!year_rate.equals("")&&rent!=null&&!rent.equals("")){
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
				alxj = getRentCashArray(al,alput,period_type,start_date,"1");
			}
		}
		getIrr = getIRRByFlow(alxj);
		sql = "update contract_condition_temp set irr="+getIrr+" where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);
	   	if(alxj!=null){
   			sql="delete from fund_contract_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			System.out.println(sql);
			db.executeUpdate(sql);
	   		for(int i=0;i<alxj.size();i++){
	   			HashMap hm = (HashMap)alxj.get(i);	
				double showinput = 0;showinput =(i==0?dinput:i==(al.size()-1)?dendinput:Double.parseDouble(String.valueOf(hm.get("otherinput"))));
				double showoutput = 0;showoutput=(i==0?doutput:i==(al.size()-1)?dendoutput:Double.parseDouble(String.valueOf(hm.get("otheroutput"))));
				sql = "insert into fund_contract_plan_temp (contract_id,plan_list,plan_date,rent,corpus,year_rate,interest,caution_deduction,fund_in,fund_out,net_flow,creator,create_date,measure_id) values (";
				sql+="'"+contract_id+"'";
				sql+=","+hm.get("volume");
				sql+=",'"+hm.get("rent_date")+"'";
				sql+=","+hm.get("rent");
				sql+=","+hm.get("corpus");
				sql+=","+hm.get("year_rate");
				sql+=","+hm.get("interest");
				sql+=","+hm.get("caution_deduction");
				sql+=","+hm.get("otherinput");
				sql+=","+hm.get("otheroutput");
				sql+=","+hm.get("net_flow");
				sql+=",'"+czyid+"'";
				sql+=",getdate()";
				sql+=",'"+doc_id+"'";
				sql+=")";
				System.out.println(sql);
				db.executeUpdate(sql);
	   		}
	   	}
	   	
	   	
		getEx = year_rate;
		
		String allrent = "";
		if(al!=null&&al.size()>0){
			 allrent = getAllRent(al);
		}
	   	if(allrent!=null&&!allrent.equals("")){
	   		dallrent = Double.parseDouble(allrent);
	   	}
	   	if(getIrr!=null&&!getIrr.equals("")&&getEx!=null&&!getEx.equals("")&&dallrent!=0){
		   	sql = " update contract_condition_temp set irr="+getIrr+",year_rate="+getEx+",total_amt="+dallrent+"+first_payment+handling_charge+supervision_fee+insurance_lessee+nominalprice where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		   	System.out.println(sql);
			db.executeUpdate(sql);
		}
    }
}
if(stype.equals("rentdate")){
	ArrayList aladjust = new ArrayList();
	String []rent_list = request.getParameterValues("rent_list");
	if(rent_list!=null){
		for(int i=0;i<rent_list.length;i++){
			String adjust_amount = getStr(request.getParameter("adjust_amount_"+rent_list[i]));
			aladjust.add(adjust_amount);
		}
	}
	//年还租次数
	String strincome_number = getStr(request.getParameter("income_number"));
	int int_income_number = 0;
	if(strincome_number!=null&&!strincome_number.equals("")){
		int_income_number = Integer.parseInt(strincome_number);
	}
	String strincome_number_year = getStr(request.getParameter("income_number_year"));
	int int_income_number_year = 0;
	if(strincome_number_year!=null&&!strincome_number_year.equals("")){
		int_income_number_year = Integer.parseInt(strincome_number_year);
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
	double dlease_term = 0;
	if(rent!=null&&!rent.equals("")){
		drent = Double.parseDouble(rent);
	}
	if(lease_term!=null&&!lease_term.equals("")){
		dlease_term = Double.parseDouble(lease_term);
	}
	dallRent = drent*int_income_number;
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
	double dendoutput =  dcaution_money-dcaution_deduction_money;
	
	
	
	
	
	
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
		for(int i=k;i<int_income_number;i++){
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
	ResultSet rsPlan = null;
	ResultSet rsCdt = null;
	String sql = "";
	ArrayList al = null;
	ArrayList alstage = new ArrayList();
	if(lease_term!=null&&!lease_term.equals("")&&lease_money!=null&&!lease_money.equals("")&&year_rate!=null&&!year_rate.equals("")&&rent!=null&&!rent.equals("")){
		HashMap hmStage = new HashMap();
		hmStage.put("stage_list","1");
		hmStage.put("rent_number",String.valueOf(strincome_number));
		hmStage.put("return_ratio","100");
		hmStage.put("return_amt",lease_money);
		hmStage.put("year_rate",year_rate);
		hmStage.put("stage_rent",edit_rent!=null&&!edit_rent.equals("")?edit_rent:rent);
		alstage.add(hmStage);
		if(alstage!=null&&alstage.size()>0){
		//income 不能为0
			al = getRentPlan(alstage,dallRent,dallprincipal,int_income_number_year,charge_first_date,rent_first_date,0,12/int_income_number_year,true,aladjust,period_type);
		}
		
	}
	if(al!=null){
		for(int i=0;i<al.size();i++){
			HashMap hm = (HashMap)al.get(i);
			sql = "update fund_rent_plan_temp set plan_date='"+hm.get("rent_date")+"' where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' and rent_list="+hm.get("volume");
			System.out.println(sql);
			db.executeUpdate(sql);
		}
	}
	
	
	
	//插入合同日程表(临时)
	ResultSet rsOld = null;
	ArrayList alOld = new ArrayList();
	sql = "select * from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	System.out.println(sql);
	rsOld = db.executeQuery(sql);
	while(rsOld.next()){
		HashMap hm = new HashMap();
		double deptd_rent = 0;
		if(getDBStr(rsOld.getString("eptd_rent"))!=null&&!getDBStr(rsOld.getString("eptd_rent")).equals("")){
			deptd_rent = Double.parseDouble(getDBStr(rsOld.getString("eptd_rent")));
		}
		double dnowrent = 0;
		if(getDBStr(rsOld.getString("rent"))!=null&&!getDBStr(rsOld.getString("rent")).equals("")){
			dnowrent = Double.parseDouble(getDBStr(rsOld.getString("rent")));
		}
		hm.put("rent_date",getDBDateStr(rsOld.getString("plan_date")));
		hm.put("volume",getDBStr(rsOld.getString("rent_list")));
		hm.put("eptd_rent",String.valueOf(deptd_rent));
		hm.put("rent",String.valueOf(dnowrent));
		hm.put("corpus",getDBStr(rsOld.getString("corpus")));
		hm.put("year_rate",getDBStr(rsOld.getString("year_rate")));
		hm.put("interest",getDBStr(rsOld.getString("interest")));
		hm.put("otherinput","0");
		hm.put("otheroutput","0");
		hm.put("adjust_amount",String.valueOf(dnowrent-deptd_rent));
		alOld.add(hm);
	}
	ArrayList alCash = new ArrayList();
	if(alOld!=null&&alOld.size()>0){
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
			for(int i=(alOld.size()-1);i>=0;i--){
				HashMap hmGetRent = (HashMap)alOld.get(i);
				String strGetRent = (String)hmGetRent.get("rent");
				double dGetRent = 0;
				if(strGetRent!=null&&!strGetRent.equals("")){
					dGetRent = Double.parseDouble(strGetRent);
				}
				//如果没有保证金抵扣放入合同结束时收入支出
				if(i==(alOld.size()-1)&&dsubCaution==-1){
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
			for(int i=j;i<(alOld.size()-1);i++){
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
		for(int i=0;i<alput.size();i++){
			HashMap hm = (HashMap)alput.get(i);
			System.out.println("input:"+hm.get("input"));
			System.out.println("output:"+hm.get("output"));
			System.out.println("caution_deduction:"+hm.get("caution_deduction"));
		}
		alCash = getRentCashArray(alOld,alput,period_type,start_date,"1");
		sql="delete from fund_contract_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);
   		for(int i=0;i<alCash.size();i++){
   			HashMap hm = (HashMap)alCash.get(i);
			double showinput = 0;showinput =(i==0?dinput:i==(al.size()-1)?dendinput:Double.parseDouble(String.valueOf(hm.get("otherinput"))));
			double showoutput = 0;showoutput=(i==0?doutput:i==(al.size()-1)?dendoutput:Double.parseDouble(String.valueOf(hm.get("otheroutput"))));
			sql = "insert into fund_contract_plan_temp (contract_id,plan_list,plan_date,rent,corpus,year_rate,interest,caution_deduction,fund_in,fund_out,net_flow,creator,create_date,measure_id) values (";
			sql+="'"+contract_id+"'";
			sql+=","+hm.get("volume");
			sql+=",'"+hm.get("rent_date")+"'";
			sql+=","+hm.get("rent");
			sql+=","+hm.get("corpus");
			sql+=","+hm.get("year_rate");
			sql+=","+hm.get("interest");
			sql+=","+hm.get("caution_deduction");
			sql+=","+hm.get("otherinput");
			sql+=","+hm.get("otheroutput");
			sql+=","+hm.get("net_flow");
			sql+=",'"+czyid+"'";
			sql+=",getdate()";
			sql+=",'"+doc_id+"'";
			sql+=")";
			System.out.println(sql);
			db.executeUpdate(sql);
   		}
	   	getIrr = getIRRByFlow(alCash);
		sql = "update contract_condition_temp set irr="+getIrr+" where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);	
	}
}

if(stype.equals("add")){
	%>
	<script>
			window.location.href = "zjcsbght_dealview.jsp?contract_id=<%=contract_id%>&cs=<%=cs%>&rent=<%=rent%>&doc_id=<%=doc_id%>&readonly=<%=readonly%>&edit_rent=<%=edit_rent%>";
	</script>
	<%
	}else if(stype.equals("add_deal")){
	%>
	<script>
			window.location.href = "zjcsbght_rent.jsp?contract_id=<%=contract_id%>&cs=<%=cs%>&rent=<%=rent%>&doc_id=<%=doc_id%>&irr=<%=getIrr%>&allrent=<%=dallrent%>&ex=<%=getEx%>&readonly=<%=readonly%>&edit_rent=<%=edit_rent%>";
	</script>
	<%
	}else if(stype.equals("rentplan")){
	%>
	<script>
			window.location.href = "zjcsbght_rent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>&irr=<%=getIrr%>&allrent=<%=dallrent%>&ex=<%=getEx%>&readonly=<%=readonly%>&edit_rent=<%=edit_rent%>";
	</script>
	<%}else if(stype.equals("rentdate")){
	%>
	<script>
			window.location.href = "zjcsbght_rent.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>&irr=<%=getIrr%>&readonly=<%=readonly%>&edit_rent=<%=edit_rent%>&rent=<%=rent%>";
	</script>
	<%}
	db.close();
	db1.close();
%>

