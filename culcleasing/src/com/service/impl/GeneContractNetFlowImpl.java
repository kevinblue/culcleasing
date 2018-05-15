package com.service.impl;

import java.util.ArrayList;
import java.util.Date;

import com.Tools;  
import com.container.ResultValue;
import com.object.ContractCondition;
import com.object.FundContractPlan;
import com.object.FundRentPlan;
import com.service.InterEvidence;

public class GeneContractNetFlowImpl {
	
	public GeneContractNetFlowImpl(){
		
	}
	   
	public ArrayList getRentPlan(String contract_id,String doc_id){
		System.out.println("********************getRentPlan start*******************");
		ArrayList al = new ArrayList();
		String sql = "select * from fund_rent_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		InterEvidence ie = new InterEvidence();
		ResultValue rv = ie.getInterEvidence(sql);
		while(rv.next()){
			FundRentPlan frp = new FundRentPlan();
			String return_contract_id = Tools.getDBStr(rv.getValue("contract_id"));
			frp.setContract_id(return_contract_id);
			String return_corpus = Tools.getDBStr(rv.getValue("corpus"));
			double d_return_corpus = 0;
			if(return_corpus!=null&&!return_corpus.equals("")){
				d_return_corpus = Double.parseDouble(return_corpus);
			}
			frp.setCorpus(d_return_corpus);
			String return_interest = Tools.getDBStr(rv.getValue("interest"));
			double d_return_interest = 0;
			if(return_interest!=null&&!return_interest.equals("")){
				d_return_interest = Double.parseDouble(return_interest);
			}
			frp.setInterest(d_return_interest);
			String return_year_rate = Tools.getDBStr(rv.getValue("year_rate"));
			double d_return_year_rate = 0;
			if(return_year_rate!=null&&!return_year_rate.equals("")){
				d_return_year_rate = Double.parseDouble(return_year_rate);
			}
			frp.setYear_rate(d_return_year_rate);
			String return_rent = Tools.getDBStr(rv.getValue("rent"));
			double d_return_rent = 0;
			if(return_rent!=null&&!return_rent.equals("")){
				d_return_rent = Double.parseDouble(return_rent);
			}
			frp.setRent(d_return_rent);
			String return_eptd_rent = Tools.getDBStr(rv.getValue("eptd_rent"));
			double d_return_eptd_rent = 0;
			if(return_eptd_rent!=null&&!return_eptd_rent.equals("")){
				d_return_eptd_rent = Double.parseDouble(return_eptd_rent);
			}
			frp.setEptd_rent(d_return_eptd_rent);
			String return_rent_list = Tools.getDBStr(rv.getValue("rent_list"));
			int i_return_rent_list = 0;
			if(return_rent_list!=null&&!return_rent_list.equals("")){
				i_return_rent_list = Integer.parseInt(return_rent_list);
			}
			frp.setRent_list(i_return_rent_list);
			String return_setPlan_status = Tools.getDBStr(rv.getValue("plan_status"));
			frp.setPlan_status(return_setPlan_status);
			String plan_date = Tools.getDBDateStr(rv.getValue("plan_date"));
			frp.setPlan_date(plan_date);
			al.add(frp);
		}
		return al;
	}
	
	public ContractCondition getContractCondition(String contract_id,String doc_id){
		ContractCondition ctcd = new ContractCondition();
		String sql = "select * from contract_condition_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		InterEvidence ie = new InterEvidence();
		ResultValue rv = ie.getInterEvidence(sql);
		if(rv.next()){
			String equip_amt = Tools.getDBStr(rv.getValue("equip_amt"));
			String first_payment = Tools.getDBStr(rv.getValue("first_payment"));
			String caution_money = Tools.getDBStr(rv.getValue("caution_money"));
			String handling_charge = Tools.getDBStr(rv.getValue("handling_charge"));
			String return_amt = Tools.getDBStr(rv.getValue("return_amt"));
			String supervision_fee = Tools.getDBStr(rv.getValue("supervision_fee"));
			String consulting_fee = Tools.getDBStr(rv.getValue("consulting_fee"));
			String other_fee =  Tools.getDBStr(rv.getValue("other_fee"));
			String nominalprice = Tools.getDBStr(rv.getValue("nominalprice"));
			String insurance_lessor = Tools.getDBStr(rv.getValue("insurance_lessor"));
			String caution_deduction_money = Tools.getDBStr(rv.getValue("caution_deduction_money"));
			String start_date  = Tools.getDBStr(rv.getValue("start_date"));
			String period_type = Tools.getDBStr(rv.getValue("period_type"));
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
			ctcd.setDequip_amt(dequip_amt);
			ctcd.setDfirst_payment(dfirst_payment);
			ctcd.setDcaution_money(dcaution_money);
			ctcd.setDhandling_charge(dhandling_charge);
			ctcd.setDreturn_amt(dreturn_amt);
			ctcd.setDsupervision_fee(dsupervision_fee);
			ctcd.setDconsulting_fee(dconsulting_fee);
			ctcd.setDother_fee(dother_fee);
			ctcd.setDnominalprice(dnominalprice);
			ctcd.setDinsurance_lessor(dinsurance_lessor);
			ctcd.setDcaution_deduction_money(dcaution_deduction_money);
			ctcd.setStart_date(start_date);
			ctcd.setPeriod_type(period_type);
		}
		return ctcd;
	}

	public void addCashPlan(FundContractPlan fcp,String contract_id,String doc_id,String user_id) {
		// TODO Auto-generated method stub
		String sql = "";
		sql = "insert into fund_contract_plan_temp (contract_id,plan_list,plan_date,rent,corpus,year_rate,interest,caution_deduction,fund_in,fund_out,net_flow,creator,create_date,measure_id) values (";
		sql+="'"+contract_id+"'";
		sql+=","+fcp.getPlan_list();
		sql+=",'"+fcp.getPlan_date()+"'";
		sql+=","+fcp.getRent();
		sql+=","+fcp.getCorpus();
		sql+=","+fcp.getYear_rate();
		sql+=","+fcp.getInterest();
		sql+=","+fcp.getCaution_deduction();
		sql+=","+fcp.getFund_in();
		sql+=","+fcp.getFund_out();
		sql+=","+fcp.getNet_flow();
		sql+=",'"+user_id+"'";
		sql+=",getdate()";
		sql+=",'"+doc_id+"'";
		sql+=")";
		System.out.println(sql);
		InterEvidence ie = new InterEvidence();
		ie.update(sql);
	}
	
	public void deleteCash(String contract_id,String doc_id){
		String sql = "";
		sql = "delete from fund_contract_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		InterEvidence ie = new InterEvidence();
		ie.update(sql);
		
	}

	public void updateIRR(String contract_id, String doc_id, String irr) {
		// TODO Auto-generated method stub
		String sql = "";
		sql = "update contract_condition_temp set irr="+irr+" where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		InterEvidence ie = new InterEvidence();
		ie.update(sql);
	}

	public ResultValue getHandlingFee(String contract_id, String doc_id) {
		// TODO Auto-generated method stub
		String sql = "";
		sql = "select interest_handling_charge,interest_handling_date from fund_rent_adjust where contract_id='"+contract_id+"' and apply_flag='1' union select interest_handling_charge,interest_handling_date from fund_rent_adjust where contract_id='"+contract_id+"' and measure_id='"+doc_id+"' and apply_flag='0'";
		System.out.println(sql);
		InterEvidence ie = new InterEvidence();
		ResultValue rvTemp = ie.getInterEvidence(sql);
		return rvTemp;
	}

	public void updateHandling(String contract_id, String doc_id, String interest_handling_date, String interest_handling_charge) {
		// TODO Auto-generated method stub
		String sql = "";
		sql = "update fund_contract_plan_temp set net_flow=net_flow+"+interest_handling_charge+" where measure_id='"+doc_id+"' and substring(convert(varchar(10),plan_date,21),0,8)='"+interest_handling_date.substring(0,7)+"' and contract_id='"+contract_id+"'";
		System.out.println(sql);
		InterEvidence ie = new InterEvidence();
		ie.update(sql);
	}

	public ArrayList getCashPlan(String contract_id, String doc_id) {
		// TODO Auto-generated method stub
		ArrayList alTemp = new ArrayList();
		String sql = "select * from fund_contract_plan_temp where contract_id='"+contract_id+"' and measure_id='"+doc_id+"'";
		System.out.println(sql);
		InterEvidence ie = new InterEvidence();
		ResultValue rv = ie.getInterEvidence(sql);
		while(rv.next()){
			FundContractPlan fcp = new FundContractPlan();
			
			String rv_net_flow = rv.getValue("net_flow");
			double d_rv_net_flow = 0;
			if(rv_net_flow!=null&&!rv_net_flow.equals("")){
				d_rv_net_flow = Double.parseDouble(rv_net_flow);
			}
			fcp.setNet_flow(d_rv_net_flow);
			alTemp.add(fcp);
		}
		return alTemp;
	}

}
