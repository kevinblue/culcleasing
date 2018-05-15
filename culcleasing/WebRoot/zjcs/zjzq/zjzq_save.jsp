<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%
	String czyid = (String)session.getAttribute("czyid");
	String datestr = getSystemDate(0);
	String doc_id = getStr(request.getParameter("doc_id"));
	String strincome_number = getStr(request.getParameter("income_number"));
	int income_number = 0;
	if(strincome_number!=null&&!strincome_number.equals("")){
		income_number = Integer.parseInt(strincome_number);
	}
	int Interval = 12/income_number;
	String contract_id = getStr(request.getParameter("contract_id"));
	String lease_money = getStr(request.getParameter("lease_money"));
	String begin_date = getStr(request.getParameter("begin_date"));
	
	String second_date = getDateAddStr(begin_date,Interval,"mm");
	
	String volume_id = getStr(request.getParameter("volume"));
	String fund_id = getStr(request.getParameter("fund_id"));
	
	String exceedhandling_charge = getStr(request.getParameter("exceedhandling_charge"));
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
	
	//所有租金
	double dallRent = 0;
	//所有本金
	double dallprincipal = 0;
	//剩余本金
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

	String sql = "";
	ResultSet rscond = null;
	double prin_money = 0;
	sql = "select lease_money from contract_condition where contract_id='"+contract_id+"'";
	System.out.println(sql);
	rscond = db.executeQuery(sql);
	if(rscond.next()){
		prin_money = Double.parseDouble(getDBStr(rscond.getString("lease_money")));
	}
	rscond.close();
	
	//添加阶段信息
	int ivolume_id = 0;//展期期次
	ivolume_id = Integer.parseInt(volume_id);
	ResultSet rs = null;
	
	if(contract_id!=null&&!contract_id.equals("")){
		
		int ihave = 0;//总期数
		int stage=0;//当前阶段
		int inow = 0;//阶段的期数
		int ifront= 0 ;//之前阶段的总期数
		int iedit = 0;//当前阶段修改后的期数
		sql = "delete from contract_rent_stage_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);
		sql = "insert into contract_rent_stage_temp (measure_id,measure_date,contract_id,stage_list,rent_number,return_ratio,return_amt,year_rate,stage_rent) select '"+doc_id+"',getdate(),contract_id,stage_list,rent_number,return_ratio,return_amt,year_rate,stage_rent from contract_rent_stage where contract_id='"+contract_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);
		if(volume_id!=null&&!volume_id.equals("")){
			ivolume_id= Integer.parseInt(volume_id);
			sql="select * from contract_rent_stage_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			System.out.println(sql);
			rs = db1.executeQuery(sql);
			while(rs.next()){
				ihave += Integer.parseInt(getDBStr(rs.getString("rent_number")));
				stage = Integer.parseInt(getDBStr(rs.getString("stage_list")));
				if(ivolume_id<ihave){
					iedit = ivolume_id-ifront-1;
					break;
				}
				ifront=ihave;
			}
			System.out.println("iedit:"+iedit);
			rs.close();
			if(iedit==0){
				stage--;
				sql="delete from contract_rent_stage_temp where contract_id='"+contract_id+"' and stage_list>"+stage+"  and measure_id='"+doc_id+"'";
				System.out.println(sql);
				db.executeUpdate(sql);
			}else{
				sql = "select sum(return_amt) as return_amt from contract_rent_stage_temp where contract_id='"+contract_id+"' and stage_list>="+stage+"  and measure_id='"+doc_id+"'";
				System.out.println(sql);
				ResultSet rsAmt = db.executeQuery(sql);
				double sumamt = 0;
				if(rsAmt.next()){
					sumamt = Double.parseDouble(getDBStr(rsAmt.getString("return_amt")));
				}
				double oldamt = sumamt-dlease_money;
				double oldratio = oldamt/prin_money*100;
				sql="update contract_rent_stage_temp set return_ratio="+oldratio+",return_amt="+oldamt+", rent_number="+iedit+" where contract_id='"+contract_id+"' and stage_list="+stage+"  and measure_id='"+doc_id+"'";
				System.out.println(sql);
				db.executeUpdate(sql);
				sql="delete from contract_rent_stage_temp where contract_id='"+contract_id+"' and stage_list>"+stage+"  and measure_id='"+doc_id+"'";
				System.out.println(sql);
				db.executeUpdate(sql);
			}
		}else{
			sql="delete from contract_rent_stage_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			System.out.println(sql);
			db.executeUpdate(sql);
		}
		System.out.println(alstage.size());
		for(int i=0;i<alstage.size();i++){
			HashMap hm = (HashMap)alstage.get(i);
			sql="insert into contract_rent_stage_temp (measure_id,measure_date,contract_id,stage_list,rent_number,return_ratio,return_amt,year_rate,stage_rent) values (";
			sql+="'"+doc_id+"',getdate(),'"+contract_id+"',"+(Integer.parseInt(String.valueOf(hm.get("stage_list")))+stage)+","+hm.get("rent_number")+","+Double.parseDouble(String.valueOf(hm.get("return_amt")))*100/prin_money+","+hm.get("return_amt")+","+hm.get("year_rate")+","+hm.get("stage_rent")+")";
			System.out.println(sql);
			db.executeUpdate(sql);
			
		}
	
	}
	//计算租金列表
	
	ArrayList al = null;
	if(alstage!=null&&alstage.size()>0){
		al = getRentPlan(alstage,dallRent,dallprincipal,income_number,begin_date,second_date,volume_id!=null&&!volume_id.equals("")?Integer.parseInt(volume_id):0,12/income_number,true);
	}
	if(contract_id!=null&&!contract_id.equals("")){
		sql="delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);
		sql="insert into fund_rent_plan_temp (measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date) select '"+doc_id+"',getdate(),contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date from fund_rent_plan where contract_id='"+contract_id+"' and rent_list<"+volume_id;
		System.out.println(sql);
		db.executeUpdate(sql);
		double dallInterest = dallRent-dallprincipal;
		for(int i=0;i<al.size();i++){
	    	HashMap hm = (HashMap)al.get(i);
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
		//现金流量统计
		double dsumRent = 0;
		ResultSet rsxj = null;
	    ArrayList aljd = new ArrayList();
	    sql="select * from contract_rent_stage_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
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
			double termRent = Double.parseDouble(getDBStr(rsxj.getString("stage_rent")));
			int rentnumber = Integer.parseInt(getDBStr(rsxj.getString("rent_number")));
			dsumRent+=(termRent*rentnumber);
			aljd.add(hm);
		}
		ArrayList alxj = null;
		if(alstage!=null&&alstage.size()>0){
			alxj = getRentPlan(aljd,dsumRent,prin_money,income_number,begin_date,second_date,0,12/income_number,false);
		}
		
		sql="delete from fund_contract_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		db.executeUpdate(sql);
	   	if(alxj!=null){
	   		for(int i=0;i<alxj.size();i++){
	   			HashMap hm = (HashMap)alxj.get(i);	
				double showinput = 0;showinput =(i==0?dinput:i==(al.size()-1)?dendinput:Double.parseDouble(String.valueOf(hm.get("otherinput"))));
				double showoutput = 0;showoutput=(i==0?doutput:i==(al.size()-1)?dendoutput:Double.parseDouble(String.valueOf(hm.get("otheroutput"))));
				sql = "insert into fund_contract_plan_temp (contract_id,plan_list,plan_date,rent,corpus,year_rate,interest,fund_in,fund_out,net_flow,creator,create_date,modificator,modify_date,mod_reason,mod_date,mod_stuff,measure_id) values (";
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
				sql+=",'"+czyid+"'";
				sql+=",getdate()";
				sql+=",'展期'";
				sql+=",getdate()";
				sql+=",'"+czyid+"'";
				sql+=",'"+doc_id+"'";
				sql+=")";
				System.out.println(sql);
				db.executeUpdate(sql);
	   		}
	   	}
	   	
	   	sql = "insert into fund_rent_adjust (measure_id,contract_id,adjust_type,start_list,payday_adjust,payday_delay,exceeding_date,handling_charge) values (";
	   	sql += "'"+doc_id+"'";
	   	sql += ",'"+contract_id+"'";
	   	sql +=",'展期'";
	   	sql +=","+volume_id;
	   	sql +=",null,null";
	   	sql +=",'"+begin_date+"'";
	   	sql +=","+exceedhandling_charge;
	   	sql += ")";
	   	System.out.println(sql);
		db.executeUpdate(sql);
		rsxj.close();
	}
	db1.close();
	db.close();
	db2.close();
%>
