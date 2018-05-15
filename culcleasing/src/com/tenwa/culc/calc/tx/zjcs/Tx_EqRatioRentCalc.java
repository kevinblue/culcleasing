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
	
	private String year_rate;// ����������

	private String income_number;// ����

	private String lease_money;// ������ֵ

	private String future_money;// ����δ��ֵ

	private String irr_type;// irr��������1,Ϊ���·ݵĴ�;2,Ϊ��������Ĵ���

	private String lease_interval;// ���޼��

	private String scale;// ��ȷ����λС��,irr
	
	private String rentScale = "2";// ��ȷ����λС��,����
	
	private String ratio_param;//���𹫱�
	
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
	 * @param rentScale ���С��λ��
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public  Hashtable getRentPlan(){
		Hashtable hs_plan = new Hashtable();
		int rent_scale=Integer.parseInt(this.scale);//���С��λ��
		List l_rent = new ArrayList();//���
		List l_corpus = new ArrayList();//����
		List l_inter = new ArrayList();//��Ϣ
		List l_corpus_overage = new ArrayList();//ʣ�౾��
		String c_rate = String.valueOf(Double.parseDouble(year_rate) / 12
				/ 100 * Integer.parseInt(lease_interval));// ����
		String first_rent = getFirstRent(c_rate);//��һ�����
		//System.out.println("��һ�����=="+first_rent);
		String total="0.00";//��������
		for(int i=0;i<Integer.parseInt(income_number);i++){
			String rent_tmp="";
			String inte_tmp="";
			String cor_tmp="";
			String cor_ovg_tmp="";
			if(i==0){//��һ�ڵ�������
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
					
					
			}else if(i<Integer.parseInt(income_number)-1){//��һ�ں����һ��֮��Ĵ��� 
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
				
			}else{//���һ�ڽ��е�������
				inte_tmp=Tools.formatNumberDoubleScale(String.valueOf((Double.parseDouble
						(this.lease_money)-Double.parseDouble(total))*
						Double.parseDouble(c_rate)),rent_scale);//��ʽ����������һ����Ϣֵ
				rent_tmp=getRent(first_rent, ratio_param,c_rate, i, rent_scale);
				
				cor_tmp=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble
						(rent_tmp)-Double.parseDouble(inte_tmp)),rent_scale);//���Լ�����������һ�ڱ���
				total=Tools.formatNumberDoubleScale(String.valueOf(
						Double.parseDouble(total)+Double.parseDouble(cor_tmp)),rent_scale);
				cor_ovg_tmp=Tools.formatNumberDoubleScale(String.valueOf(//��ʽ�������ʣ�౾��
						Double.parseDouble(this.lease_money)-Double.parseDouble(total)),rent_scale);
				cor_tmp=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(cor_tmp)
						+Double.parseDouble(cor_ovg_tmp)-Double.parseDouble(future_money)),rent_scale);//���򾫶Ȳ������ֵ����������
				inte_tmp=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble
						(rent_tmp)-Double.parseDouble(cor_tmp)),rent_scale);//��𲻱䣬��Ϣ��Ӧ����
				cor_ovg_tmp=future_money;//ǿ�е����ʲ���ֵ
				
				l_rent.add(rent_tmp);
				l_corpus.add(cor_tmp);
				l_inter.add(inte_tmp);
				l_corpus_overage.add(cor_ovg_tmp);
				
			}
					
			
		}
		
		//hs_plan��װ���ƻ�
		hs_plan.put("rent", l_rent);
		hs_plan.put("corpus", l_corpus);
		hs_plan.put("interest", l_inter);
		hs_plan.put("corpus_overage", l_corpus_overage);
		return hs_plan;
	}
	
	/**
	 * �����һ�ڵ����
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
	 * �������һ�������ÿ�����
	 * @param firsrCorpus ���ڱ���
	 * @param ratio_param ����
	 * @param N�η�
	 * @param ����С��λ��
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
