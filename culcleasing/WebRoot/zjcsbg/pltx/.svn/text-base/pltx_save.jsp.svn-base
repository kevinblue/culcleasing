<%@ page contentType="text/html; charset=gbk" language="java" errorPage="" %>
<%@ page import="java.sql.*" %> 
<%@ page import="dbconn.*" %> 
<jsp:useBean id="db" scope="page" class="dbconn.Conn" />
<jsp:useBean id="gcns" scope="page" class="com.service.GeneContractNetFlowService" />
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
String savetype =  getStr(request.getParameter("savetype"));
//String fund_id =  getStr(request.getParameter("fund_id"));
String[] contract_ids =  request.getParameterValues("itemselect");
String lease_money =  getStr(request.getParameter("lease_money"));
//String volume_id =  getStr(request.getParameter("volume"));
String doc_id =  getStr(request.getParameter("doc_id"));
String readonly =  getStr(request.getParameter("readonly"));
System.out.println("contract_ids:"+contract_ids);
System.out.println("doc_id:"+doc_id);
//调息信息 [START]
//String start_list = getStr(request.getParameter("start_list"));
//String ets_number = getStr(request.getParameter("ets_number"));
//String remain_corpus = getStr(request.getParameter("remain_corpus"));
//String oldyear_rate = getStr(request.getParameter("oldyear_rate"));
//String newyear_rate = getStr(request.getParameter("newyear_rate"));
String exceedhandling_charge = getStr(request.getParameter("exceedhandling_charge"));
String rate_date = getStr(request.getParameter("rate_date"));

String getIrr = "";
String getEx = "";
//调息信息 [END]


//double dnewRate = 0;
//double dadjustRate = 0;
//if(newyear_rate!=null&&!newyear_rate.equals("")){
//	dnewRate = Double.parseDouble(newyear_rate);
//}

//dadjustRate = dnewRate-doldRate;
double dotherprincipal=0;

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
if(savetype.equals("pltx")){
	if(contract_ids!=null){
		for(int c=0;c<contract_ids.length;c++){
			String contract_id = contract_ids[c];
			System.out.println(contract_id);
			ArrayList aladjust = new ArrayList();
			String []rent_list = request.getParameterValues("rent_list");
			if(rent_list!=null){
				for(int i=0;i<rent_list.length;i++){
					String adjust_amount = getStr(request.getParameter("adjust_amount_"+rent_list[i]));
					aladjust.add(adjust_amount);
				}
			}
			int iCountcc = 0;
			String sqlstr = "select count(*) as count from contract_condition_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"'"; 
			System.out.println(sqlstr);
			ResultSet rsCountcc = db.executeQuery(sqlstr); 
			if(rsCountcc.next()){
				iCountcc =Integer.parseInt(getDBStr(rsCountcc.getString("count")));
			}
			rsCountcc.close();
			if(iCountcc>0){
				sqlstr = "delete from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
				System.out.println(sqlstr);
				db.executeUpdate(sqlstr);
			}else{
				
			}
			sqlstr = "insert into contract_condition_temp (contract_id,equip_amt,lease_money,lease_term,income_number_year,income_number,year_rate,rate_float_type,period_type,settle_method,income_day,start_date,first_date,second_date,first_payment_ratio,first_payment,caution_money_ratio,caution_money,lessee_caution_ratio,lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio,sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio,handling_charge,return_ratio,return_amt,supervision_fee_ratio,supervision_fee,consulting_fee,other_fee,nominalprice,insurance_method,insurance_lessor,insurance_lessee,redressalk,pena_rate,total_amt,actual_fund,rough_earn,year_earn,irr,plan_irr,creator,create_date,measure_id) select '"+contract_id+"',equip_amt,lease_money,lease_term,income_number_year,income_number,year_rate,rate_float_type,period_type,settle_method,income_day,start_date,first_date,second_date,first_payment_ratio,first_payment,caution_money_ratio,caution_money,lessee_caution_ratio,lessee_caution_money,vndr_caution_ratio,vndr_caution_money,sale_caution_ratio,sale_caution_money,caution_deduction_ratio,caution_deduction_money,handling_charge_ratio,handling_charge,return_ratio,return_amt,supervision_fee_ratio,supervision_fee,consulting_fee,other_fee,nominalprice,insurance_method,insurance_lessor,insurance_lessee,redressalk,pena_rate,total_amt,actual_fund,rough_earn,year_earn,irr,plan_irr,creator,create_date,'"+doc_id+"' from contract_condition  where contract_condition.contract_id='"+contract_id+"'";
			System.out.println(sqlstr);
			db.executeUpdate(sqlstr);
			
			ResultSet rsCount = null;
		    int iCount = 0;
			sqlstr = "select count(*) as count from fund_rent_plan_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"'"; 
			System.out.println(sqlstr);
			rsCount = db.executeQuery(sqlstr); 
			if(rsCount.next()){
				iCount =Integer.parseInt(getDBStr(rsCount.getString("count")));
			}
			rsCount.close();
			if(iCount>0){
				sqlstr = "delete from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
				System.out.println(sqlstr);
				db.executeUpdate(sqlstr);
			}else{
				
			}
			sqlstr = "insert into fund_rent_plan_temp (measure_id,measure_date,contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date) select '"+doc_id+"',getdate(),contract_id,rent_list,plan_status,plan_date,eptd_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,penalty,rent_type,creator,create_date,modificator,modify_date from fund_rent_plan  where fund_rent_plan.contract_id='"+contract_id+"'";
			System.out.println(sqlstr);
			db.executeUpdate(sqlstr);
			sqlstr = "select * from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			System.out.println(sqlstr);
			ResultSet rsCond = null;
			rsCond = db.executeQuery(sqlstr);
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
			String caution_deduction_money = "";
			String period_type = "";
			String income_number_year = "";
			String start_date = "";
			String cond_year_rate = "";
			String cond_lease_term = "";
			if(rsCond.next()){
				equip_amt = getDBStr(rsCond.getString("equip_amt"));
				first_payment = getDBStr(rsCond.getString("first_payment"));
				caution_money = getDBStr(rsCond.getString("caution_money"));
				handling_charge = getDBStr(rsCond.getString("handling_charge"));
				return_amt = getDBStr(rsCond.getString("return_amt"));
				supervision_fee = getDBStr(rsCond.getString("supervision_fee"));
				consulting_fee = getDBStr(rsCond.getString("consulting_fee"));
				other_fee = getDBStr(rsCond.getString("other_fee"));
				nominalprice = getDBStr(rsCond.getString("nominalprice"));
				insurance_lessor = getDBStr(rsCond.getString("insurance_lessor"));
				caution_deduction_money = getDBStr(rsCond.getString("caution_deduction_money"));
				period_type = getDBStr(rsCond.getString("period_type"));
				income_number_year = getDBStr(rsCond.getString("income_number_year"));
				start_date =  getDBStr(rsCond.getString("start_date"));
				//cond_year_rate = getDBStr(rsCond.getString("year_rate"));
				cond_lease_term = getDBStr(rsCond.getString("lease_term"));
			}
			rsCond.close();
			
			
			double doldRate = 0;
			if(cond_year_rate!=null&&!cond_year_rate.equals("")){
				doldRate = Double.parseDouble(cond_year_rate);
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
			int ilease_term = 0;
			if(cond_lease_term!=null&&!cond_lease_term.equals("")){
				ilease_term = Integer.parseInt(cond_lease_term);
			}
			
			double dinput=dfirst_payment+dcaution_money+dhandling_charge+dreturn_amt+dsupervision_fee;
			double doutput = dequip_amt+dconsulting_fee+dother_fee+dinsurance_lessor;
			double dendinput = dnominalprice;
			double dendoutput = dcaution_money-dcaution_deduction_money;
			
			String remain_corpus = "";;
			sqlstr = "select sum(corpus) as remain_corpus from fund_rent_plan_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"' and plan_date>='"+rate_date+"'";
			System.out.println(sqlstr);
			ResultSet rsRc = db.executeQuery(sqlstr);
			if(rsRc.next()){
				remain_corpus = getDBStr(rsRc.getString("remain_corpus"));
			}
			
			ArrayList alCashTemp = new ArrayList();
			HashMap hmCashTemp = new HashMap();
			hmCashTemp.put("net_flow","-"+remain_corpus);
			alCashTemp.add(hmCashTemp);
			//
			ResultSet rsTemp = null;
			sqlstr = "select * from fund_rent_plan_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"' and plan_date>="+rate_date;
			System.out.println(sqlstr);
			rsTemp = db.executeQuery(sqlstr);
			while(rsTemp.next()){
				//HashMap hm = new HashMap();
				String rsrent = "";
				rsrent = getDBStr(rsTemp.getString("rent"));
				HashMap hmCashRentTemp = new HashMap();
				hmCashRentTemp.put("net_flow",rsrent);
				alCashTemp.add(hmCashRentTemp);
			}
			rsTemp.close();
			
			
			
			String sign_date = "";
			//合同签约时的时间
			sql = "select sign_date from contract_info where contract_id='"+contract_id+"'";
			System.out.println(sql);
			ResultSet rsDate = db.executeQuery(sql);
			if(rsDate.next()){
				sign_date = getDBDateStr(rsDate.getString("sign_date"));
			}
			
			//旧的央行利率B
			double ointerest = 0;
			//调息时央行利率C
			double linterest = 0;
			//旧的年利率
			double stagerate = 0;
			//调息后的年利率
			double nstagerate = 0;
			
			//旧的央行利率B
			sql = "select * from fund_standard_interest where start_date<'";
			sql+=sign_date;
			sql+="' order by start_date desc";
			System.out.println(sql);
			ResultSet rsIn = db.executeQuery(sql);
			if(rsIn.next()){
				if(ilease_term>60){
					ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_abovefive")));
				}else if(ilease_term>36){
					ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_five")));
				}
				else if(ilease_term>12){
					ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_three")));
				}
				else if(ilease_term>=6){
					ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_one")));
				}else if (ilease_term<6){
					ointerest = Double.parseDouble(getDBStr(rsIn.getString("base_rate_half")));
				}
			}
			
			//调息时央行利率C
			sql = "select * from fund_standard_interest where start_date<'"+rate_date+"' order by start_date desc";
			System.out.println(sql);
			ResultSet rsInl = db.executeQuery(sql);
			if(rsInl.next()){
				if(ilease_term>60){
					linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_abovefive")));
				}else if(ilease_term>36){
					linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_five")));
				}
				else if(ilease_term>12){
					linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_three")));
				}
				else if(ilease_term>=6){
					linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_one")));
				}else if (ilease_term<6){
					linterest = Double.parseDouble(getDBStr(rsInl.getString("base_rate_half")));
				}
			}
			
			double dlease_money = 0; 
			sql = "select sum(corpus) as sum_corpus from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' and plan_date>='"+rate_date+"'";
			System.out.println(sql);
			ResultSet rssumRe = db.executeQuery(sql);
			if(rssumRe.next()){
				lease_money = getDBStr(rssumRe.getString("sum_corpus"));
			}
			rssumRe.close();
			if(lease_money!=null&&!lease_money.equals("")){
				dlease_money = Double.parseDouble(lease_money);
			}
			ArrayList alCashTempSum = new ArrayList();
			HashMap hmCashTempSum = new HashMap();
			hmCashTempSum.put("net_flow","-"+String.valueOf(dlease_money));
			alCashTempSum.add(hmCashTempSum);
			//
			ResultSet rsTempRe = null;
			sql = "select * from fund_rent_plan_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"' and plan_date>='"+rate_date+"'";
			System.out.println(sql);
			rsTempRe = db.executeQuery(sql);
			while(rsTempRe.next()){
				String rsrent = "";
				rsrent = getDBStr(rsTempRe.getString("rent"));
				HashMap hmCashRentTemp = new HashMap();
				hmCashRentTemp.put("net_flow",rsrent);
				alCashTempSum.add(hmCashRentTemp);
			}
			rsTempRe.close();	
			cond_year_rate = getRateByFlow(alCashTempSum,String.valueOf(income_number_year));
			if(cond_year_rate!=null&&!cond_year_rate.equals("")){
				stagerate = Double.parseDouble(cond_year_rate);
			}
			
			
			//新利率计算公式 [START]
			nstagerate = stagerate - (ointerest - linterest);
			System.out.println("stagerate:"+stagerate);
			System.out.println("-ointerest:"+ointerest);
			System.out.println("+linterest:"+linterest);
			System.out.println("nstagerate:"+nstagerate);
			
			String strAvg = getAdjustRentByCash(alCashTempSum,String.valueOf(nstagerate),String.valueOf(stagerate),income_number_year);
			sqlstr = "update fund_rent_plan_temp set rent = rent";
			if(nstagerate>=stagerate){
				sqlstr+="+";
			}else{
				sqlstr+="-";
			}
			sqlstr+=strAvg;
			sqlstr +=" ,eptd_rent = eptd_rent";
			if(nstagerate>=stagerate){
				sqlstr+="+";
			}else{
				sqlstr+="-";
			}
			sqlstr+=strAvg+",year_rate="+String.valueOf(nstagerate)+" where contract_id='" + contract_id + "' and measure_id='"+doc_id+"' and plan_date>='"+rate_date+"'";
			System.out.println(sqlstr);
			db.executeUpdate(sqlstr);
			double dall_rent = 0;
			ArrayList al = new ArrayList();
			ResultSet rsRentTemp = null;
			sqlstr = "select * from fund_rent_plan_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"' and plan_date>='"+rate_date+"'";
			System.out.println(sqlstr);
			rsRentTemp = db.executeQuery(sqlstr);
			while(rsRentTemp.next()){
				HashMap hm = new HashMap();
				String rsvolume = "";
				String rsrent_date = "";
				String rscorpus = "";
				String rsyear_rate = "";
				String rsinterest = "";
				String rsrent = "";
				String rsadjust_amount = "";
				String rent = "";
				
				rsvolume = getDBStr(rsRentTemp.getString("rent_list"));
				rsrent_date = getDBDateStr(rsRentTemp.getString("plan_date"));
				rscorpus = getDBStr(rsRentTemp.getString("corpus"));
				rsyear_rate = getDBStr(rsRentTemp.getString("year_rate"));
				rsinterest = getDBStr(rsRentTemp.getString("interest"));
				rsrent = getDBStr(rsRentTemp.getString("rent"));
				rent = getDBStr(rsRentTemp.getString("eptd_rent"));
				if(rsrent!=null&&!rsrent.equals("")&&rent!=null&&!rent.equals("")){
					rsadjust_amount = String.valueOf(Double.parseDouble(rsrent)-Double.parseDouble(rent));
				}
				hm.put("volume",rsvolume);
				hm.put("rent_date",rsrent_date);
				hm.put("corpus",rscorpus);
				hm.put("year_rate",rsyear_rate);
				hm.put("interest",rsinterest);
				hm.put("rent",rsrent);
				hm.put("eptd_rent",rent);
				hm.put("adjust_amount",rsadjust_amount);
				al.add(hm);
				if(rsrent!=null&&!rsrent.equals("")){
					dall_rent +=Double.parseDouble(rsrent); 
				}
			}
			rsRentTemp.close();
			double dremain_corpus = 0;
			if(remain_corpus!=null&&!remain_corpus.equals("")){
				dremain_corpus = Double.parseDouble(remain_corpus);
			}
			int int_income_number_year = 0;
			if(income_number_year!=null&&!income_number_year.equals("")){
				int_income_number_year = Integer.parseInt(income_number_year);
			}
			ArrayList alnewRent = getRentPlanInterest(al,dall_rent,dremain_corpus,nstagerate,period_type,int_income_number_year,aladjust);
			if(alnewRent!=null){
				for(int i=0;i<alnewRent.size();i++){
					HashMap hm = (HashMap)alnewRent.get(i);
					String corpus = "";
					String year_rate = "";
					String interest = "";
					String rent = "";
					String volume = "";
					corpus = (String)hm.get("corpus");
					year_rate = (String)hm.get("year_rate");
					interest = (String)hm.get("interest");
					rent = (String)hm.get("rent");
					volume = (String)hm.get("volume");
					sqlstr = "update fund_rent_plan_temp set corpus="+corpus+", year_rate="+year_rate+",interest="+interest+",rent="+rent+" where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' and rent_list="+volume;
					System.out.println(sqlstr);
					db.executeUpdate(sqlstr);
				}
			}
			getEx = String.valueOf(nstagerate);
			gcns.GeneContractNetFlow(contract_id,doc_id,czyid);
			getIrr = gcns.getReturn_irr();
		   	if(getEx!=null&&!getEx.equals("")&&dall_rent!=0){
			   	sql = " update contract_condition_temp set year_rate="+getEx+",total_amt="+dall_rent+"+first_payment+handling_charge+supervision_fee+insurance_lessee+nominalprice where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			   	System.out.println(sql);
				db.executeUpdate(sql);
			}
			ResultSet rsCountTemp= null;
		    int iCountTemp = 0;
			sqlstr = "select count(*) as count from fund_adjust_interest_temp where contract_id='" + contract_id + "' and measure_id='"+doc_id+"'"; 
			System.out.println(sqlstr);
			rsCountTemp = db.executeQuery(sqlstr); 
			if(rsCountTemp.next()){
				iCountTemp =Integer.parseInt(getDBStr(rsCountTemp.getString("count")));
			}
			rsCountTemp.close();
			String volume_id = "";
			ResultSet rsVolume = null;
			sqlstr = "select rent_list from fund_rent_plan_temp where plan_date>='"+rate_date+"'";
			System.out.println(sqlstr);
			rsVolume = db.executeQuery(sqlstr);
			if(rsVolume.next()){
				volume_id = getDBStr(rsVolume.getString("rent_list"));
			}
			if(iCountTemp>0){
				sql = "update fund_adjust_interest_temp set ";
				sql+= " start_date='"+rate_date+"'";
				sql+= ",start_list="+volume_id;
				sql+= ",remain_corpus="+(remain_corpus.equals("")?"0":remain_corpus);
				sql+= ",rate_original="+stagerate;
				sql+= ",rate_adjust="+nstagerate;
				if(exceedhandling_charge!=null&&!exceedhandling_charge.equals("")){
					sql+= ",exceedhandling_charge="+exceedhandling_charge;
				}else{
					sql+= ",exceedhandling_charge=null";
				}
				sql+= " where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
			}else{
				sql = "insert into fund_adjust_interest_temp (contract_id,start_date,start_list,fee_type,remain_corpus,rate_original,rate_adjust,adjust_rent,exceedhandling_charge,fee_list,status,measure_id) values (";
				sql+= "'"+contract_id+"'";
				sql+= ",'"+rate_date+"'";
				sql+= ","+volume_id+"";
				sql+= ",null";
				sql+= ","+(remain_corpus.equals("")?"0":remain_corpus);
				sql+= ","+stagerate;
				sql+= ","+nstagerate;
				sql+= ",null";
				if(exceedhandling_charge!=null&&!exceedhandling_charge.equals("")){
					sql+= ","+exceedhandling_charge;
				}else{
					sql+= ",null";	
				}
				sql+= ",null";
				sql+= ",null";
				sql+= ",'"+doc_id+"'";
				sql+= ")";
			}
			System.out.println(sql);
			db.executeUpdate(sql);
		}
	} 
}
db.close();

%>
<script>

			window.close();
			opener.alert("批量调息成功");
			opener.location.reload();
	</script>
