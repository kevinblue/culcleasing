package com.service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.container.ResultValue;
import com.object.ContractCondition;
import com.object.FundContractPlan;
import com.object.FundRentPlan;
import com.service.impl.GeneContractNetFlowImpl;

/**
 * Desc:生成合同现金流量
 * Author:Zhanghf
 * Date:2009-8-3
 * */   
public class GeneContractNetFlowService {

	private GeneContractNetFlowImpl geneContractNetFlowImpl = null;
	
	private String return_irr;
	
	
	public String getReturn_irr() {
		return return_irr;
	}
	public void setReturn_irr(String return_irr) {
		this.return_irr = return_irr;
	}
	public GeneContractNetFlowService(){
		geneContractNetFlowImpl = new GeneContractNetFlowImpl();
	}
	/**
	 * 生成合同现金流量
	 * 1获取合同回笼计划
	 * 2获取合同交易结构
	 * 3计算现金流量每期的流入流出
	 * 4进行保证金抵扣测算
	 * 5加入利息手续费计算
	 * 6加入现金流量表
	 * 
	 * */
	public void GeneContractNetFlow(String contract_id,String doc_id,String user_id){
		ArrayList alRent = null;
		ArrayList alCash = null;
		ArrayList al = geneContractNetFlowImpl.getRentPlan(contract_id,doc_id);
		System.out.println("al:"+al.size());
		ContractCondition ctcd = geneContractNetFlowImpl.getContractCondition(contract_id,doc_id);
		alRent = getRentDeduction(al,ctcd);
		alCash = getRentCashArray(alRent);
		geneContractNetFlowImpl.deleteCash(contract_id,doc_id);
		addCashPlan(alCash,contract_id,doc_id,user_id);
		ArrayList alAdjust = addHandlingFee(alCash,contract_id,doc_id);
		//添加现金流信息
		String irr = getIRRByFlow(alAdjust);
		setReturn_irr(irr);
		updateIrr(contract_id,doc_id,irr);
	}
	
	/**
	 * 修改合同IRR
	 * */
	public void updateIrr(String contract_id,String doc_id,String irr){
		geneContractNetFlowImpl.updateIRR(contract_id,doc_id,irr);
	}
	
	/**
	 * 添加合同利息手续费
	 * */
	public ArrayList addHandlingFee(ArrayList alCash,String contract_id,String doc_id){
		 ResultValue rvHf =  geneContractNetFlowImpl.getHandlingFee(contract_id,doc_id);
		 while(rvHf.next()){
			 String interest_handling_date = (String)rvHf.getValue("interest_handling_date");
			 String interest_handling_charge = (String)rvHf.getValue("interest_handling_charge");
			 if(interest_handling_date!=null&&!interest_handling_date.equals("")&&interest_handling_charge!=null&&!interest_handling_charge.equals("")){
				 geneContractNetFlowImpl.updateHandling(contract_id,doc_id,interest_handling_date,interest_handling_charge);
			 }
		 }
		 ArrayList alAdjust = geneContractNetFlowImpl.getCashPlan(contract_id,doc_id);
		 return alAdjust;
	}
	
	/**
	 * 添加现金流情况
	 * */
	public void addCashPlan(ArrayList alCash,String contract_id,String doc_id,String user_id){
		if(alCash!=null){
			for(int i=0;i<alCash.size();i++){
				FundContractPlan fcp = (FundContractPlan)alCash.get(i);
				geneContractNetFlowImpl.addCashPlan(fcp,contract_id,doc_id,user_id);
			}
		}
	}
	
	/**
	 * 获取IRR
	 * */
	public String getIRRByFlow(ArrayList alCash){
		//根据现金流获取IRR
		ArrayList alirr = new ArrayList();
		for(int i=0;i<alCash.size();i++){
			FundContractPlan fcp = (FundContractPlan)alCash.get(i);
			alirr.add(new BigDecimal(String.valueOf(fcp.getNet_flow())));
		}
		return formatNumberDoubleSix(Double.parseDouble(getIRR(alirr,"1","1","12"))*100);
	}
	
	/**
	 * 数据类型转换
	 * */
	public String formatNumberDoubleSix(double str){
		try
		{
	        String temp_num=String.valueOf(str);
	            if ((temp_num==null) || (temp_num.equals("")))
	        {
	        temp_num="";
	        }
	        else
	        {
			 java.text.DecimalFormat ft =  new java.text.DecimalFormat("###0.000000");
			 //java.text.DecimalFormat ft =  new java.text.DecimalFormat(style); 
			 BigDecimal bd=new BigDecimal(temp_num);
			 temp_num=ft.format(bd);
	 
	        }
	        return temp_num; 
		}
		catch(Exception e)
		{
		}
		return "";
	}
	
	/**
	 * 计算IRR函数
	 * */
	public String getIRR(List l_inflow_pour,String chjg,String zjjg,String nhkcs) 
	{	
		chjg=chjg.equals("")?"0":chjg;
		zjjg=zjjg.equals("")?"0":zjjg;
		nhkcs=nhkcs.equals("")?"0":nhkcs;
		//参数说明：l_inflow_pour=所有现金流入流出（流入为正，流出为负），chjg=偿还间隔，
			//zjjg=租金间隔,nhkcs=年还款次数
		//BigDecimal year_number = new BigDecimal("3");//偿还间隔
		BigDecimal year_number = new BigDecimal(chjg);//偿还间隔
		//BigDecimal rent_interval = new BigDecimal("3");//每期租金间隔
		BigDecimal rent_interval = new BigDecimal(zjjg);//每期租金间隔
		BigDecimal tmp = new BigDecimal("1");
		BigDecimal irr = new BigDecimal("0");
		BigDecimal tmp1 = new BigDecimal("0");
		BigDecimal tmp2 = new BigDecimal("100");
		BigDecimal bigdec_1 = new BigDecimal("1");
		BigDecimal bigdec_2 = new BigDecimal("2");
		int j = 0;
		try
		{
			while ( tmp.abs().doubleValue() > 0.0000000001 && j < 100) {
				tmp = new BigDecimal(l_inflow_pour.get(0).toString());
				for ( int i = 1;i < l_inflow_pour.size();i++ ) {
					tmp = tmp.add ( new BigDecimal(l_inflow_pour.get(i).toString()).divide( new BigDecimal ( Math.pow( irr.add(bigdec_1).doubleValue() , i ) ) , 20 , BigDecimal.ROUND_HALF_UP ) );
				}
				if ( tmp.doubleValue() > 0 ) {
					tmp1 = irr;
					irr = irr.add(tmp2).divide( bigdec_2 , 20 , BigDecimal.ROUND_HALF_UP );
				}
				if ( tmp.doubleValue() < 0 ) {
					tmp2 = irr;
					irr = irr.add(tmp1).divide( bigdec_2 , 20 , BigDecimal.ROUND_HALF_UP );
				}
		   		j++;
			}
			irr = irr.multiply( year_number ).divide( rent_interval , 20 , BigDecimal.ROUND_HALF_UP );
			//irr = irr.multiply(new BigDecimal("4"));
			irr = irr.multiply(new BigDecimal(nhkcs));
			return irr.toString().equals("")?"0":irr.toString();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return "0";
	}
	
	/**
	 * 保证金抵扣操作
	 * */
	public ArrayList getRentDeduction(ArrayList al,ContractCondition ctcd){
		ArrayList alCash = new ArrayList();
		double dinput=ctcd.getDfirst_payment()+ctcd.getDcaution_money()+ctcd.getDhandling_charge()+ctcd.getDreturn_amt()+ctcd.getDsupervision_fee();
		double doutput = ctcd.getDequip_amt()+ctcd.getDconsulting_fee()+ctcd.getDother_fee()+ctcd.getDinsurance_lessor();
		double dendinput = ctcd.getDnominalprice();
		double dendoutput = ctcd.getDcaution_money()-ctcd.getDcaution_deduction_money();
		String period_type = ctcd.getPeriod_type();
		String start_date = ctcd.getStart_date();
		int dedu = 0;
		if(dedu==0){
			double dsubCaution = -1;
			if(ctcd.getDcaution_deduction_money()>=0){
				dsubCaution = ctcd.getDcaution_deduction_money();
			}
			//根据租金计划从后向前计算保证金抵扣情况
			for(int i=(al.size()-1);i>=0;i--){
				FundRentPlan frp = (FundRentPlan)al.get(i);
				double dGetRent = frp.getRent();
				//如果没有保证金抵扣放入合同结束时收入支出
				if(i==(al.size()-1)&&dsubCaution==-1){
					
					frp.setInput(dendinput);
					frp.setOutput(dendoutput);
					frp.setCaution_deduction(0);
					al.set(i, frp);
				}
				//如果有保证金抵扣
				if(dsubCaution >= 0){
					//如果保证金返还〉租金
					if(dsubCaution>=dGetRent){
						//加入租金抵扣，不保存合同结束时收入支出
						frp.setInput(0);
						frp.setOutput(0);
						frp.setCaution_deduction(dGetRent);
						al.set(i, frp);
						dsubCaution-=dGetRent;
					}else if(dsubCaution<dGetRent&&dsubCaution>0){
						//如果保证金返还<租金 加入剩余保证金返还,当期标示最为最后一期，保存合同结束时收入支出
						frp.setInput(dendinput);
						frp.setOutput(dendoutput);
						frp.setCaution_deduction(dsubCaution);
						al.set(i, frp);
						dsubCaution = -1;
					}else if(dsubCaution==0){
						//如果保证金返还==上一期租金  （全部抵完） 当期标示最为最后一期，保存合同结束时收入支出
						frp.setInput(dendinput);
						frp.setOutput(dendoutput);
						frp.setCaution_deduction(0);
						al.set(i, frp);
						dsubCaution = -1;
					}
				}else{
					frp.setInput(0);
					frp.setOutput(0);
					frp.setCaution_deduction(0);
					al.set(i, frp);
				}
			}
			if(period_type.equals("0")){
				FundRentPlan frp = new FundRentPlan();
				frp.setPlan_date(start_date);
				frp.setInput(dinput);
				frp.setOutput(doutput);
				frp.setCaution_deduction(0);
				alCash.add(frp);
				alCash.addAll(al);
			}else{
				//如果是先付的情况判断起租日与首期回笼计划是否在同一个月，如果是在同一个月，则将现金流合并，否则分为两条现金流记录
				FundRentPlan frp = (FundRentPlan)al.get(0);
				if(compareMonth(frp.getPlan_date(),start_date)){
					
					frp.setInput(dinput);
					frp.setOutput(doutput);
					frp.setCaution_deduction(0);
					al.set(0, frp);
					alCash.addAll(al);
				}else{
					FundRentPlan frp_1 = new FundRentPlan();
					frp_1.setPlan_date(start_date);
					frp_1.setInput(dinput);
					frp_1.setOutput(doutput);
					frp_1.setCaution_deduction(0);
					alCash.add(frp_1);
					alCash.addAll(al);
				}
			}
		}else{
			FundRentPlan frpEnd = (FundRentPlan)al.get(al.size()-1);
			frpEnd.setInput(dendinput);
			frpEnd.setOutput(dendoutput);
			frpEnd.setCaution_deduction(0);
			al.set(al.size()-1, frpEnd);
			if(period_type.equals("0")){
				FundRentPlan frp = new FundRentPlan();
				frp.setRent_list(0);
				frp.setPlan_date(start_date);
				frp.setInput(dinput);
				frp.setOutput(doutput);
				frp.setCaution_deduction(0);
				alCash.add(frp);
				alCash.addAll(al);
			}else{
				FundRentPlan frp = (FundRentPlan)al.get(0);
				frp.setInput(dinput);
				frp.setOutput(doutput);
				frp.setCaution_deduction(0);
				al.set(0, frp);
				alCash.addAll(al);
			}
		}
		return alCash;
	}
	
	/**
	 * 生成现金流
	 * */
	public ArrayList getRentCashArray(ArrayList alRent){
		int ivolume = 0;
		ArrayList alCash = new ArrayList();
		String preDate = "";
		String nextDate = "";
		FundRentPlan frpTemp = (FundRentPlan)alRent.get(0);
		preDate = frpTemp.getPlan_date();
		for(int i=0;i<alRent.size();i++){
			FundRentPlan frpRent = (FundRentPlan)alRent.get(i);
			nextDate = frpRent.getPlan_date();
			
			FundContractPlan fcpTemp = new FundContractPlan();
			fcpTemp.setContract_id(frpRent.getContract_id());
			fcpTemp.setPlan_date(frpRent.getPlan_date());
			fcpTemp.setYear_rate(frpRent.getYear_rate());
			fcpTemp.setCorpus(frpRent.getCorpus());
			fcpTemp.setInterest(frpRent.getInterest());
			fcpTemp.setRent(frpRent.getRent());
			fcpTemp.setEptd_rent(frpRent.getEptd_rent());
			fcpTemp.setFund_in(frpRent.getInput());
			fcpTemp.setFund_out(frpRent.getOutput());
			fcpTemp.setCaution_deduction(frpRent.getCaution_deduction());
			fcpTemp.setNet_flow(frpRent.getRent()+frpRent.getInput()-frpRent.getOutput()-frpRent.getCaution_deduction());
			
			if(getDateDiffMonth(preDate,nextDate)>1){
				for(int k=1;k<getDateDiffMonth(preDate,nextDate);k++){
	     			FundContractPlan fcp = new FundContractPlan();
	     			ivolume++;
	     			fcp.setContract_id(frpRent.getContract_id());
	     			fcp.setPlan_list(ivolume);
	     			fcp.setPlan_date(getDateAddStr(preDate,k,"mm"));
	     			fcp.setYear_rate(0);
	     			fcp.setCorpus(0);
	     			fcp.setInterest(0);
		      		fcp.setRent(0);
		      		fcp.setFund_in(0);
		      		fcp.setFund_out(0);
		      		fcp.setNet_flow(0);
		      		fcp.setEptd_rent(0);
		      		fcp.setCaution_deduction(0);
		      		alCash.add(fcp);
	      		}
			}
			ivolume++;
			fcpTemp.setPlan_list(ivolume);
			alCash.add(fcpTemp);
			preDate = nextDate;
		}
		return alCash;
	}
	
	/**
	 * 两个日期月份数之差
	 * */
	public int getDateDiffMonth(String bdate,String edate){
		try
		{
				String []barray = bdate.split("-");
				String []earray = edate.split("-");
				return (Integer.parseInt(earray[0])-Integer.parseInt(barray[0]))*12+(Integer.parseInt(earray[1])-Integer.parseInt(barray[1]));
		}
		catch(Exception e)
		{
		 
		}
		return 0;
	}
	
	/**
	 * 判断两个日期的月份是否相同
	 * */
	public boolean compareMonth(String bdate,String edate){
		String btemp = bdate.substring(0,7);
		String etemp = edate.substring(0,7);
		return btemp.equals(etemp);
	}
	
	/**
	 * 当前日期向前或向后推算日期
	 * */
	public Date getDateAdd(Date date,int leng,String type){
		Date addDate = null;
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		if(type.equals("yy")){
			cal.add(Calendar.YEAR,leng);
		}else if(type.equals("mm")){
			cal.add(Calendar.MONTH,leng);
		}else if(type.equals("we")){
			cal.add(Calendar.WEEK_OF_YEAR,leng);
		}else if(type.equals("dd")){
			cal.add(Calendar.DAY_OF_YEAR,leng);
		}else if(type.equals("hh")){
			cal.add(Calendar.HOUR_OF_DAY,leng);
		}else if(type.equals("mi")){
			cal.add(Calendar.MINUTE,leng);
		}else if(type.equals("ss")){
			
		}
		addDate = cal.getTime();
		return addDate;
	}
	
	/**
	 * 当前日期向前或向后推算日期
	 * */
	public String getDateAddStr(String str,int leng,String type){
		Date date = null;
		Date returnDate = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try{
			date = formatter.parse(str);
		}catch(Exception e){
			
		}
		returnDate = getDateAdd(date,leng,type);
		return formatter.format(returnDate);
	}
}
