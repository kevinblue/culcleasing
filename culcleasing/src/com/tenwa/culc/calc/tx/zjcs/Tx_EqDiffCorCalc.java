package com.tenwa.culc.calc.tx.zjcs;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import com.Tools;

public class Tx_EqDiffCorCalc {
		
	public Tx_EqDiffCorCalc(){
		
	}
	
	public Tx_EqDiffCorCalc(String year_rate, String income_number, String lease_money,
			String future_money, String period_type, String lease_interval,
			String plan_date,String ratio_param){
		this.year_rate = year_rate;
		this.income_number = income_number;
		this.lease_money = lease_money;
		this.future_money = future_money;
		this.period_type = period_type;
		this.lease_interval = lease_interval;
		this.ratio_param = ratio_param;
		
	}
	
	private String year_rate;// 租赁年利率

	private String income_number;// 租期

	private String lease_money;// 本金现值

	private String future_money;// 本金未来值

	private String period_type;// 期前/期后
	
	private String lease_interval;// 租赁间隔

	private String scale;// 精确到几位小数,irr
	
	private String rentScale = "2";// 精确到几位小数,租金的
	
	private String ratio_param;//本金公比/差
	
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


	public String getPeriod_type() {
		return period_type;
	}


	public void setPeriod_type(String period_type) {
		this.period_type = period_type;
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
	public Hashtable getNewRentPlan(Map<String, List<String>> rentInfo_Map)
	  {
	    Hashtable hs_plan = new Hashtable();
	    List l_rent = new ArrayList();
	    List l_inter = new ArrayList();
	    String c_rate = Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(this.year_rate) / 12.0D / 
	      100.0D * 
	      Integer.parseInt(this.lease_interval)), 10);
	    System.out.println("c_rate=="+c_rate+"year_rate="+this.year_rate);
	    List l_old_corpus = new ArrayList();
	    List l_old_corpus_overage = new ArrayList();
	    l_old_corpus = (List)rentInfo_Map.get("l_corpus");
	    l_old_corpus_overage = (List)rentInfo_Map.get("corpus_overage");
	    String rent_tmp = "";
	    String inte_tmp = "";
	    String cor_tmp = "";
	    String cor_ovg_tmp = "";

	    for (int i = 0; i < l_old_corpus.size(); ++i) {
	      cor_tmp = (String)l_old_corpus.get(i);
	      cor_ovg_tmp = (String)l_old_corpus_overage.get(i);
	      inte_tmp = Tools.formatNumberDoubleTwo(String.valueOf((Double.parseDouble(
	        cor_ovg_tmp) + 
	        Double.parseDouble(cor_tmp)) * 
	        Double.parseDouble(c_rate)));
	      rent_tmp = Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(cor_tmp) + 
	        Double.parseDouble(inte_tmp)));
System.out.println("cor_tmp="+cor_tmp+",cor_ovg_tmp="+cor_ovg_tmp+",inte_tmp="+inte_tmp+",rent_tmp="+rent_tmp);
	      l_rent.add(rent_tmp);
	      l_inter.add(inte_tmp);
	    }

	    hs_plan.put("rent", l_rent);
	    hs_plan.put("corpus", l_old_corpus);
	    hs_plan.put("interest", l_inter);
	    hs_plan.put("corpus_overage", l_old_corpus_overage);
	    return hs_plan;
	  }
	/**
	 * @author toybaby	2011-07-21
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
		String first_corpus = getFirstCorpus();//第一期本金
		System.out.println("第一期本金="+first_corpus+"c_rate="+c_rate+"year_rate="+year_rate);
		String total="0.00";//本金和相加
		for(int i=0;i<Integer.parseInt(income_number);i++){
			String rent_tmp="";
			String inte_tmp="";
			String cor_tmp="";
			String cor_ovg_tmp="";
			if(i==0){//第一期单独处理
					inte_tmp=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble
								(this.lease_money)*Double.parseDouble(c_rate)),rent_scale);
					cor_tmp=first_corpus;
					rent_tmp=Tools.formatNumberDoubleScale(String.valueOf(
							Double.parseDouble(cor_tmp)+Double.parseDouble(inte_tmp)),rent_scale);
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
				
				cor_tmp=getCorpus(first_corpus, ratio_param, i, rent_scale);
				rent_tmp=Tools.formatNumberDoubleScale(String.valueOf(
						Double.parseDouble(cor_tmp)+Double.parseDouble(inte_tmp)),rent_scale);
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
				
				cor_tmp=getCorpus(first_corpus, ratio_param, i, rent_scale);//公试计算出来的最后一期本金
				rent_tmp=Tools.formatNumberDoubleScale(String.valueOf( //得到租金
						Double.parseDouble(cor_tmp)+Double.parseDouble(inte_tmp)),rent_scale);
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
	 * 计算第一期的本金
	 * @return
	 */
	public  String getFirstCorpus(){
		String first_cor="";
		
		first_cor=Tools.formatNumberDoubleScale(String.valueOf((Double.parseDouble(this.lease_money)-Double.parseDouble(this.future_money))/
				Integer.parseInt(this.income_number)-(Integer.parseInt(this.income_number)-1)*
				Double.parseDouble(this.ratio_param)/2),Integer.parseInt(this.scale));
		return first_cor;
		
	}
	
	/**
	 * 计算除第一期以外的每期本金
	 * @param firsrCorpus 首期本金
	 * @param ratio_param 公比
	 * @param N次方
	 * @param 本金小数位数
	 * @return
	 */
	public String getCorpus(String firsrCorpus,String ratio_param, int paw,int rent_scale){
		String corpus="";
		
//		corpus=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(firsrCorpus)*
//				Math.pow(Double.parseDouble(ratio_param), 
//						Double.parseDouble(String.valueOf(paw)))),rent_scale);
		corpus = Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(firsrCorpus)+
				Double.parseDouble(ratio_param)*paw),rent_scale);
		return corpus;
		
	}
	
}
