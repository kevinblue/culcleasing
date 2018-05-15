package com.tenwa.culc.calc.tx.zjcs;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

public class Tx_EqRatioRentCalc {
		
	public Tx_EqRatioRentCalc(){
		
	}
	
	public Tx_EqRatioRentCalc(String year_rate, String income_number, String lease_money,
			String future_money, String period_type, String lease_interval,
			String plan_date,String ratio_param){
		this.year_rate = year_rate;
		this.income_number = income_number;
		this.lease_money = lease_money;
		this.future_money = future_money;
		this.lease_interval = lease_interval;
		this.ratio_param = ratio_param;
		
	}
	
	private String year_rate;// 租赁年利率

	private String income_number;// 租期

	private String lease_money;// 本金现值

	private String future_money;// 本金未来值

	private String irr_type;// irr测算类型1,为按月份的处;2,为按租金间隔的处理

	private String lease_interval;// 租赁间隔

	private String scale;// 精确到几位小数,irr
	
	private String rentScale = "2";// 精确到几位小数,租金的
	
	private String ratio_param;//本金公比
	
	public String getRatio_param() {
		return ratio_param;
	}

	public void setRatio_param(String ratio_param) {
		this.ratio_param = ratio_param;
	}

	public String getYear_rate() {
		return year_rate;
	}


	public void setYear_rate(String year_rate) {
		this.year_rate = year_rate;
	}


	public String getIncome_number() {
		return income_number;
	}


	public void setIncome_number(String income_number) {
		this.income_number = income_number;
	}


	public String getLease_money() {
		return lease_money;
	}


	public void setLease_money(String lease_money) {
		this.lease_money = lease_money;
	}


	public String getFuture_money() {
		return future_money;
	}


	public void setFuture_money(String future_money) {
		this.future_money = future_money;
	}


	public String getIrr_type() {
		return irr_type;
	}

	public void setIrr_type(String irr_type) {
		this.irr_type = irr_type;
	}

	public String getLease_interval() {
		return lease_interval;
	}


	public void setLease_interval(String lease_interval) {
		this.lease_interval = lease_interval;
	}


	public String getScale() {
		return scale;
	}


	public void setScale(String scale) {
		this.scale = scale;
	}


	public String getRentScale() {
		return rentScale;
	}


	public void setRentScale(String rentScale) {
		this.rentScale = rentScale;
	}

	
	/**
	 * @author toybaby	2011-07-21
	 * @param conditionBean
	 * @param rentScale 租金小数位数
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public  Hashtable getRentPlan(){
		Hashtable hs_plan = new Hashtable();
		int rent_scale=Integer.parseInt(this.scale);//租金小数位数
		List l_rent = new ArrayList();//租金
		List l_corpus = new ArrayList();//本金
		List l_inter = new ArrayList();//利息
		List l_corpus_overage = new ArrayList();//剩余本金
		String c_rate = String.valueOf(Double.parseDouble(year_rate) / 12
				/ 100 * Integer.parseInt(lease_interval));// 利率
		String first_rent = getFirstRent(c_rate);//第一期租金
		//System.out.println("第一期租金=="+first_rent);
		String total="0.00";//本金和相加
		for(int i=0;i<Integer.parseInt(income_number);i++){
			String rent_tmp="";
			String inte_tmp="";
			String cor_tmp="";
			String cor_ovg_tmp="";
			if(i==0){//第一期单独处理
					inte_tmp=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble
								(this.lease_money)*Double.parseDouble(c_rate)),rent_scale);
					rent_tmp=first_rent;
					cor_tmp=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble
							(rent_tmp)-Double.parseDouble(inte_tmp)),rent_scale);
					cor_ovg_tmp=Tools.formatNumberDoubleScale(String.valueOf(
							Double.parseDouble(this.lease_money)-Double.parseDouble(cor_tmp)),rent_scale);
					total=Tools.formatNumberDoubleScale(String.valueOf(
							Double.parseDouble(total)+Double.parseDouble(cor_tmp)),rent_scale);
					l_rent.add(rent_tmp);
					l_corpus.add(cor_tmp);
					l_inter.add(inte_tmp);
					l_corpus_overage.add(cor_ovg_tmp);
					
					
			}else if(i<Integer.parseInt(income_number)-1){//第一期和最后一期之间的处理 
				inte_tmp=Tools.formatNumberDoubleScale(String.valueOf((Double.parseDouble
						(this.lease_money)-Double.parseDouble(total))*Double.parseDouble(c_rate)),rent_scale);
				
				rent_tmp=getRent(first_rent, ratio_param,c_rate, i, rent_scale);
				cor_tmp=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble
						(rent_tmp)-Double.parseDouble(inte_tmp)),rent_scale);
				total=Tools.formatNumberDoubleScale(String.valueOf(
						Double.parseDouble(total)+Double.parseDouble(cor_tmp)),rent_scale);
				cor_ovg_tmp=Tools.formatNumberDoubleScale(String.valueOf(
						Double.parseDouble(this.lease_money)-Double.parseDouble(total)),rent_scale);
				l_rent.add(rent_tmp);
				l_corpus.add(cor_tmp);
				l_inter.add(inte_tmp);
				l_corpus_overage.add(cor_ovg_tmp);
				
			}else{//最后一期进行单独处理
				inte_tmp=Tools.formatNumberDoubleScale(String.valueOf((Double.parseDouble
						(this.lease_money)-Double.parseDouble(total))*
						Double.parseDouble(c_rate)),rent_scale);//公式计算出来最后一期利息值
				rent_tmp=getRent(first_rent, ratio_param,c_rate, i, rent_scale);
				
				cor_tmp=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble
						(rent_tmp)-Double.parseDouble(inte_tmp)),rent_scale);//公试计算出来的最后一期本金
				total=Tools.formatNumberDoubleScale(String.valueOf(
						Double.parseDouble(total)+Double.parseDouble(cor_tmp)),rent_scale);
				cor_ovg_tmp=Tools.formatNumberDoubleScale(String.valueOf(//公式算出来的剩余本金
						Double.parseDouble(this.lease_money)-Double.parseDouble(total)),rent_scale);
				cor_tmp=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(cor_tmp)
						+Double.parseDouble(cor_ovg_tmp)-Double.parseDouble(future_money)),rent_scale);//把因精度产生误差值划到本金上
				inte_tmp=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble
						(rent_tmp)-Double.parseDouble(cor_tmp)),rent_scale);//租金不变，利息相应减少
				cor_ovg_tmp=future_money;//强行等于资产余值
				
				l_rent.add(rent_tmp);
				l_corpus.add(cor_tmp);
				l_inter.add(inte_tmp);
				l_corpus_overage.add(cor_ovg_tmp);
				
			}
					
			
		}
		
		//hs_plan封装租金计划
		hs_plan.put("rent", l_rent);
		hs_plan.put("corpus", l_corpus);
		hs_plan.put("interest", l_inter);
		hs_plan.put("corpus_overage", l_corpus_overage);
		return hs_plan;
	}
	
	/**
	 * 计算第一期的租金
	 * @return
	 */
	public  String getFirstRent(String crate){
		String first_rent="";
		BigDecimal temp_A = new BigDecimal("-1"); 
		BigDecimal temp_B = new BigDecimal("-1");
		temp_A=new BigDecimal(String.valueOf((Double.parseDouble(this.lease_money)-Double.parseDouble(this.future_money))*
				(Double.parseDouble("1")+Double.parseDouble(crate)-Double.parseDouble(this.ratio_param) )*
				Math.pow((Double.parseDouble("1")+Double.parseDouble(crate)), 
						Integer.parseInt(this.income_number))));
		//System.out.println("temp_A=="+temp_A);
		temp_B=new BigDecimal(String.valueOf(
				Math.pow(Double.parseDouble("1")+Double.parseDouble(crate), 
						Integer.parseInt(this.income_number))-Math.pow(Double.parseDouble(this.ratio_param),
								Integer.parseInt(this.income_number))));
		//System.out.println("temp_B=="+temp_B);
		first_rent=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(
				temp_A.divide(temp_B,20,BigDecimal.ROUND_HALF_UP).toString())+
				Double.parseDouble(this.future_money)*Double.parseDouble(crate)),
				Integer.parseInt(this.scale));
		return first_rent;
		
	}
	
	/**
	 * 计算除第一期以外的每期租金
	 * @param firsrCorpus 首期本金
	 * @param ratio_param 公比
	 * @param N次方
	 * @param 本金小数位数
	 * @return
	 */
	public String getRent(String firsrRent,String ratio_param,String c_rate, int paw,int rent_scale){
		String rent="";
		
		rent=Tools.formatNumberDoubleScale(String.valueOf((Double.parseDouble(firsrRent)-
				Double.parseDouble(this.future_money)*Double.parseDouble(c_rate))*
				Math.pow(Double.parseDouble(ratio_param), 
						Double.parseDouble(String.valueOf(paw)))+
						Double.parseDouble(this.future_money)*Double.parseDouble(c_rate)),rent_scale);
		
		
		return rent;
		
	}
	
	
	
}
