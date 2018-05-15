<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" /> 
<jsp:useBean id="db1" scope="page" class="dbconn.Conn" />
<jsp:useBean id="db2" scope="page" class="dbconn.Conn" />
<%@ include file="../../func/common.jsp"%>
<%
//调息方式
//A合同签约时的租赁年利率
//B合同签约时的基准利率
//C调息时得基准利率
//D调整后的租金
//A>=B D=A-(B-C)
//A<B D = A*C/B
String czyid = (String)session.getAttribute("czyid");
	String datestr = getSystemDate(0);
String sql="";
ResultSet rs = null;
ResultSet rsStage = null;
//String adjust_type =  getStr(request.getParameter("adjust_type"));
//String adjust_style =  getStr(request.getParameter("adjust_style"));
//String rate_limit =  getStr(request.getParameter("rate_limit"));
String savetype =  getStr(request.getParameter("savetype"));
String fund_id =  getStr(request.getParameter("fund_id"));
String contract_id =  getStr(request.getParameter("contract_id"));
String lease_money =  getStr(request.getParameter("lease_money"));
String volume_id =  getStr(request.getParameter("volume"));
String doc_id =  getStr(request.getParameter("doc_id"));
//String rate_date = getStr(request.getParameter("rate_date"));
double dotherprincipal=0;
int ivolume_id=0;
if(volume_id!=null&&!volume_id.equals("")){
ivolume_id= Integer.parseInt(volume_id);
}
//总期数
int ihave = 0;
//当前阶段
int stage=0;
//阶段的期数
int inow = 0;
//之前阶段的总期数
int ifront= 0 ;
//当前阶段修改后的期数 
int iedit = 0;
//租金列表
ArrayList alrent = new ArrayList(); 
//年还租次数
int income_number = 0;
int ivolume = 0;
if(savetype.equals("tx")){
	if(volume_id!=null&&!volume_id.equals("")){
		
		//
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
	String old_rate = "";
	//String lease_money = getStr(request.getParameter("lease_money"));
	//年还租次数
	String strincome_number = getStr(request.getParameter("income_number"));
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
			old_rate = getStr(request.getParameter("old_year_rate"+stage_listarray[i]));
			if(isNotNull(volume)&&isNotNull(principal_rate)&&isNotNull(principal_money)&&isNotNull(rate)&&isNotNull(rent)){
				HashMap hm = new HashMap();
				hm.put("stage_list","2");
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
	
	
	//获取合同首期、二期回笼日期
	String first_date = "";
	String second_date = "";
	double dallPrin = 0;
	sql="select first_date,second_date,lease_money from contract_condition where contract_id='"+contract_id+"'";
	ResultSet rsdate = null;
	System.out.println(sql);
	rsdate = db2.executeQuery(sql);
	if(rsdate.next()){
		first_date = getDBDateStr(rsdate.getString("first_date"));
		second_date = getDBDateStr(rsdate.getString("second_date"));
		dallPrin = Double.parseDouble(getDBDateStr(rsdate.getString("lease_money")));
	}
	 //查询不需要修改的合同阶段
	sql="select * from contract_rent_stage where contract_id='"+contract_id+"'";
	System.out.println(sql);
	rs = db.executeQuery(sql);
	while(rs.next()){
		ihave += Integer.parseInt(getDBStr(rs.getString("rent_number")));
		stage = Integer.parseInt(getDBStr(rs.getString("stage_list")));
		System.out.println("ivolume_id:"+ivolume_id);
		if(ivolume_id<ihave){
			iedit = ivolume_id-ifront-1;
			break;
		}
		ifront=ihave;
	}
	rs.close();
	ArrayList alsave = new ArrayList();
	sql = "select * from contract_rent_stage where contract_id='"+contract_id+"' and stage_list<="+stage;
	ResultSet rssave = null;
	System.out.println(sql);
	rssave = db1.executeQuery(sql);
	
	while(rssave.next()){
		HashMap hm = new HashMap ();
		hm.put("stage_list",getDBStr(rssave.getString("stage_list")));
		hm.put("rent_number",getDBStr(rssave.getString("rent_number")));
		hm.put("return_ratio",getDBStr(rssave.getString("return_ratio")));
		hm.put("return_amt",getDBStr(rssave.getString("return_amt")));
		hm.put("year_rate",getDBStr(rssave.getString("year_rate")));
		hm.put("stage_rent",getDBStr(rssave.getString("stage_rent")));
		alsave.add(hm);
		if(!getDBStr(rssave.getString("stage_list")).equals(String.valueOf(stage))){
			dotherprincipal += Double.parseDouble(getDBStr(rssave.getString("return_amt")));
		}
	}
	rssave.close();
	System.out.println(alsave.size());
	if(iedit==0){
		//当前及之后阶段的租金计划直接取消，重新计算
		alsave.remove(alsave.size()-1);
	}else{
		System.out.println("dotherprincipal:"+dotherprincipal);
		System.out.println("dlease_money:"+dlease_money);
		double oldamt = dallPrin-dotherprincipal-dlease_money;
		double oldratio = oldamt/dallPrin*100;
		//当前阶段部分记录需要进行修改，之后阶段全部重新计算
		HashMap hm = (HashMap)alsave.get(alsave.size()-1);
		hm.put("return_ratio",String.valueOf(oldratio));
		hm.put("return_amt",String.valueOf(oldamt));
		hm.put("rent_number",String.valueOf(iedit));
		alsave.set(alsave.size()-1,hm);
		double doldRent = iedit*Double.parseDouble(String.valueOf(hm.get("stage_rent")));
		dallRent+=doldRent;
	}
	//原有合同阶段加新阶段
	alsave.addAll(alstage);
	for(int i=0;i<alsave.size();i++){
		HashMap hm = (HashMap)alsave.get(i);
		System.out.println("stage_list:"+hm.get("stage_list"));
		System.out.println("rent_number:"+hm.get("rent_number"));
		System.out.println("return_ratio:"+hm.get("return_ratio"));
		System.out.println("return_amt:"+hm.get("return_amt"));
		System.out.println("year_rate:"+hm.get("year_rate"));
		System.out.println("stage_rent:"+hm.get("stage_rent"));
	}
	
	//计算租金计划
	ArrayList alzj = null;
	if(alsave!=null&&alsave.size()>0){
		alzj = getRentPlan(alsave,dallRent,dallPrin,income_number,first_date,second_date,0,12/income_number,true);
	}
	//添加租金计划
	sql="delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
	System.out.println(sql);
	db.executeUpdate(sql);
    for(int i=0;i<alzj.size();i++){
    	HashMap hm = (HashMap)alzj.get(i);
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
		 
		
		ArrayList alxj = getRentPlan(alsave,dallRent,dallPrin,income_number,first_date,second_date,0,12/income_number,false);
		
    	if(alxj!=null){
    		sql = "select * from contract_condition where contract_id='"+contract_id+"'";
    		System.out.println(sql);
    		ResultSet rsCon = db.executeQuery(sql);
    		String equip_amt = "";
			String first_payment =  "";
			String caution_money = "";
			String handling_charge =  "";
			String return_amt = "";
			String supervision_fee =  "";
			String consulting_fee = "";
			String other_fee = "";
			String nominalprice = "";
			String insurance_lessor = "";
			String caution_deduction_money = "";
    		if(rsCon.next()){
    			equip_amt = getDBStr(rsCon.getString("equip_amt"));
    			first_payment = getDBStr(rsCon.getString("first_payment"));
    			caution_money = getDBStr(rsCon.getString("caution_money"));
    			handling_charge = getDBStr(rsCon.getString("handling_charge"));
    			return_amt = getDBStr(rsCon.getString("return_amt"));
    			supervision_fee = getDBStr(rsCon.getString("supervision_fee"));
    			consulting_fee = getDBStr(rsCon.getString("consulting_fee"));
    			other_fee = getDBStr(rsCon.getString("other_fee"));
    			nominalprice = getDBStr(rsCon.getString("nominalprice"));
    			insurance_lessor = getDBStr(rsCon.getString("insurance_lessor"));
    			caution_deduction_money = getDBStr(rsCon.getString("caution_deduction_money"));
    		}
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
			
			sql="delete from fund_contract_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			System.out.println(sql);
			db.executeUpdate(sql);
    		for(int i=0;i<alxj.size();i++){
    			HashMap hm = (HashMap)alxj.get(i);
    			double showinput = 0;showinput =(i==0?dinput:i==(alxj.size()-1)?dendinput:Double.parseDouble(String.valueOf(hm.get("otherinput"))));
				double showoutput = 0;showoutput=(i==0?doutput:i==(alxj.size()-1)?dendoutput:Double.parseDouble(String.valueOf(hm.get("otheroutput"))));
	    		sql = "insert into fund_contract_plan_temp (contract_id,plan_list,plan_date,rent,corpus,year_rate,interest,fund_in,fund_out,net_flow,creator,create_date,modificator,modify_date,mod_reason,mod_date,mod_stuff,measure_id) values (";
	    		sql+=" '"+contract_id+"'";
	    		sql+=" ,"+hm.get("volume");
	    		sql+=" ,'"+hm.get("rent_date")+"'";
	    		sql+=" ,"+hm.get("rent");
	    		sql+=" ,"+hm.get("corpus");
	    		sql+=" ,"+hm.get("year_rate");
	    		sql+=" ,"+hm.get("interest");
				sql+=" ,"+String.valueOf(Double.parseDouble(String.valueOf(hm.get("otherinput")))-showinput);
				sql+=","+String.valueOf(Double.parseDouble(String.valueOf(hm.get("otheroutput")))-showoutput);
				sql+=","+String.valueOf(Double.parseDouble(String.valueOf(hm.get("rent")))+showinput-showoutput);
				sql+=",'"+czyid+"'";
				sql+=",getdate()";
				sql+=",'"+czyid+"'";
				sql+=",getdate()";
				sql+=",'调息'";
				sql+=",getdate()";
				sql+=",'"+czyid+"'";
				sql+=",'"+doc_id+"'";
				sql+=")";
				System.out.println(sql);
				db.executeUpdate(sql);
    		}
    	}
    	String plan_date = "";
    	String year_rate = "";
    	sql = "select plan_date,year_rate from fund_rent_plan where id="+fund_id;
    	ResultSet rsDate = db.executeQuery(sql);
    	if(rsDate.next()){
    		plan_date = getDBStr(rsDate.getString("plan_date"));
    		year_rate = getDBStr(rsDate.getString("year_rate"));
    	}
    	sql="insert into fund_adjust_interest_his (contract_id,start_date,start_list,fee_type,rate_original,rate_adjust,fee_list,status) values (";
    	sql+="'"+contract_id+"'";
    	sql+=",'"+plan_date+"'";
    	sql+=","+volume_id;
    	sql+=",'利息'";
    	sql+=","+year_rate;
    	sql+=","+old_rate;
    	sql+=",null,null)";
	} 
}
db.close();
db1.close();
db2.close();

%>
<script>

			window.location.href = "tx_zjhl.jsp?contract_id=<%=contract_id%>&doc_id=<%=doc_id%>";
	</script>
