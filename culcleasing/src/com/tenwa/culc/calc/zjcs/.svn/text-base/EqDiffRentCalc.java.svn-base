package com.tenwa.culc.calc.zjcs;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;
import com.tenwa.culc.calc.zjcs.IrrCal;
import com.tenwa.culc.bean.ConditionBean;

public class EqDiffRentCalc {
		
	public EqDiffRentCalc(){
		
	}
	
	public EqDiffRentCalc(String year_rate, String income_number, String lease_money,
			String future_money, String period_type, String lease_interval,
			String plan_date,String ratio_param){
		this.year_rate = year_rate;
		this.income_number = income_number;
		this.lease_money = lease_money;
		this.future_money = future_money;
		this.period_type = period_type;
		this.lease_interval = lease_interval;
		this.plan_date = plan_date;
		this.ratio_param = ratio_param;
		
	}
	
	private String year_rate;// 租赁年利率

	private String income_number;// 租期

	private String lease_money;// 本金现值

	private String future_money;// 本金未来值

	private String period_type;// 期前/期后
	
	private String irr_type;// irr测算类型1,为按月份的处;2,为按租金间隔的处理

	private String lease_interval;// 租赁间隔

	private String plan_date;// 放款日期

	private String scale;// 精确到几位小数,irr
	
	private String rentScale = "2";// 精确到几位小数,租金的
	
	private String contract_id;// 合同号,用于现金流的统计

	private String start_date;// 起租日期
	
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


	public String getPeriod_type() {
		return period_type;
	}


	public void setPeriod_type(String period_type) {
		this.period_type = period_type;
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


	public String getPlan_date() {
		return plan_date;
	}


	public void setPlan_date(String plan_date) {
		this.plan_date = plan_date;
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


	public String getContract_id() {
		return contract_id;
	}


	public void setContract_id(String contract_id) {
		this.contract_id = contract_id;
	}


	public String getStart_date() {
		return start_date;
	}


	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	
	
	
	/**
	 * @author toybaby	2011-07-21
	 * @param conditionBean
	 * @param rentScale 租金小数位数
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public  Hashtable getRentPlan(ConditionBean conditionBean,String rentScale){
		Hashtable hs_plan = new Hashtable();
		String period_type = this.period_type;//付款类型
		int rent_scale=Integer.parseInt(this.scale);//租金小数位数
		List l_plan_date = new ArrayList();
		List l_rent = new ArrayList();//租金
		List l_corpus = new ArrayList();//本金
		List l_inter = new ArrayList();//利息
		List l_corpus_overage = new ArrayList();//剩余本金
		String c_rate = String.valueOf(Double.parseDouble(year_rate) / 12
				/ 100 * Integer.parseInt(lease_interval));// 利率
		String first_rent = getFirstRent(c_rate);//第一期租金
//		System.out.println("第一期租金=="+first_rent);
		String total="0.00";//本金和相加
		for(int i=0;i<Integer.parseInt(income_number);i++){
			String rent_tmp="";
			String inte_tmp="";
			String cor_tmp="";
			String cor_ovg_tmp="";
			if(i==0){//第一期单独处理
					if("1".equals(period_type)){//先付第一期利息为0
						inte_tmp="0.00";
					}else{
						inte_tmp=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble
								(this.lease_money)*Double.parseDouble(c_rate)),rent_scale);
					}
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
				
				rent_tmp=getRent(first_rent, ratio_param, i, rent_scale);
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
				rent_tmp=getRent(first_rent, ratio_param, i, rent_scale);
				
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
		
		l_plan_date = getPlanDateList(l_rent, this.period_type);
		
		
		//hs_plan封装租金计划
		hs_plan.put("plan_date", l_plan_date);
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
		String temp_pmt = "";
		BigDecimal temp_A = new BigDecimal("-1"); 
		BigDecimal temp_B = new BigDecimal("-1");
		String temp_C = "";
		String temp_D = "";
		temp_pmt=Tools.formatNumberDoubleScale(getPMT(crate, this.income_number, "-"+this.lease_money, 
				this.future_money, this.period_type),Integer.parseInt(this.scale)+2);
		System.out.println("temp_pmt=="+temp_pmt);
		temp_A=new BigDecimal(String.valueOf(Math.pow((Double.parseDouble("1")+Double.parseDouble(crate)),
				Integer.parseInt(this.income_number))*Double.parseDouble(crate)
				));
//		System.out.println("temp_A=="+temp_A);
		temp_B=new BigDecimal(String.valueOf(
				(Math.pow(Double.parseDouble("1")+Double.parseDouble(crate), 
						Integer.parseInt(this.income_number))-Double.parseDouble("1"))
		));
		
//		System.out.println("temp_B=="+temp_B);
		
		temp_C = Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(
				temp_A.divide(temp_B,20,BigDecimal.ROUND_HALF_UP).toString())*
					(Double.parseDouble(this.ratio_param)*Double.parseDouble(this.income_number))/
					Double.parseDouble(crate)),Integer.parseInt(this.scale)+2);
//		System.out.println("temp_C=="+temp_C);			
		temp_D = String.valueOf(Double.parseDouble(temp_pmt)+Double.parseDouble(temp_C)-
			 Double.parseDouble(this.ratio_param)/Double.parseDouble(crate)-
				(Double.parseDouble(this.ratio_param)*Double.parseDouble(this.income_number)));
		first_rent=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(temp_D)
				),Integer.parseInt(this.scale));
		return first_rent;
		
	}
	
	
	/**
	 * PMT公式计算租金
	 * 
	 * @param Rate
	 * @param Nper
	 * @param Pv
	 * @param Fv
	 * @param Type
	 * @return
	 */
	public String getPMT(String Rate, String Nper, String Pv, String Fv,
			String Type) {

		// 参数说明：Pv=现值，Nper=期数，Rate=利率(注意同期数周期一致，且要求已经包括百分号的数值！如0.05)
		// Fv=未来值，Type=数字 1或 0，用以指定各期的付款时间是在期初还是期末
		Rate = Rate.equals("") ? "0" : Rate;
		Nper = Nper.equals("") ? "0" : Nper;
		Pv = Pv.equals("") ? "0" : Pv;
		Fv = Fv.equals("") ? "0" : Fv;
		Type = Type.equals("") ? "0" : Type;

		if (Double.parseDouble(Nper) == 0) {
			return "0";
		}
		if (Double.parseDouble(Rate) == 0) {
			// divide(xxxxx,2, BigDecimal.ROUND_HALF_EVEN)
			return ((new BigDecimal(Pv).add(new BigDecimal(Fv)).multiply(
					new BigDecimal("-1")).divide(new BigDecimal(Nper), 20,
					BigDecimal.ROUND_HALF_UP))).toString();
		}

		BigDecimal Pv_B = new BigDecimal(Pv);
		BigDecimal Rate_B = new BigDecimal(Rate);
		BigDecimal Fv_B = new BigDecimal(Fv);
		BigDecimal Type_B = new BigDecimal(Type);
		BigDecimal pmt_B = new BigDecimal("0");
		BigDecimal num1_B = new BigDecimal("1");
		BigDecimal numfu1_B = new BigDecimal("-1");
		int Nper_i = Integer.valueOf(Nper).intValue();
		try {
			pmt_B = numfu1_B.multiply(Rate_B).multiply(
					Pv_B.multiply((num1_B.add(Rate_B)).pow(Nper_i)).add(Fv_B))
					.divide(
							(num1_B.add(Rate_B.multiply(Type_B)))
									.multiply((num1_B.add(Rate_B)).pow(Nper_i)
											.subtract(num1_B)), 20,
							BigDecimal.ROUND_HALF_UP);
			return pmt_B.toString().equals("") ? "0" : pmt_B.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "0";
	}
	
	
	/**
	 * 计算除第一期以外的每期租金
	 * @param firsrCorpus 首期本金
	 * @param ratio_param 公比
	 * @param N次方
	 * @param 本金小数位数
	 * @return
	 */
	public String getRent(String firsrRent,String ratio_param, int paw,int rent_scale){
		String rent="";
		
		rent=Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(firsrRent)+
				Double.parseDouble(ratio_param)*paw),rent_scale);
		
		return rent;
		
	}
	
	
	
	
	/**
	 * 
	 * @param rentList
	 *            租金 list
	 * @param perType
	 *            期初还是期未
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getPlanDateList(List rentList, String perType) {
		// 如果是期末则第一期租金日期=放款日期+间隔月数
		String start_date = this.getFirstDate(perType);
		String day = "";
		if (start_date.indexOf("-") > -1) {// 得到日
			day = this.getPlan_date().substring(
					this.getPlan_date().lastIndexOf("-") + 1,
					this.getPlan_date().length());
		}
		List l_date = new ArrayList();
		for (int i = 0; i < rentList.size(); i++) {
			String addDate = Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), start_date);
			addDate = getNewDate(addDate, day);

			l_date.add(addDate);
		}

		return l_date;
	}
	
	
	
	/**
	 * 得到第一期的日期
	 * 
	 */
	public String getFirstDate(String type) {
		// 如果是期末则第一期租金日期=放款日期+间隔月数
		String start_date = plan_date;
		String day = "";
		if (start_date.indexOf("-") > -1) {// 得到日
			day = start_date.substring(start_date.lastIndexOf("-") + 1,
					start_date.length());
		}

		if (type.equals("0")) {
			start_date = getNewDate(start_date, day);
			start_date = Tools.dateAdd("month", Integer
					.parseInt(lease_interval), start_date);
		}

		System.out.println("第一期时间:" + start_date);
		return start_date;
	}

	public String getNewDate(String start_date, String day) {

		// 根据年月得到他的最后一天
		String year = start_date.substring(0, start_date.indexOf("-"));
		String month = start_date.substring(start_date.indexOf("-") + 1,
				start_date.lastIndexOf("-"));
		String lastDay = Tools.getLastDayOfMonth(year, month);
		String u_day = "";

		u_day = day;
		if (Integer.parseInt(lastDay) <= Integer.parseInt(day)) {
			u_day = lastDay;
		}

		return year + "-" + month + "-" + u_day;
	}
	
	
	/**
	 * 得到irr
	 * 
	 * @param firstMoney   净融资额
	 * @param rent_list		租金计划
	 * @param lease_interval	租金间隔
	 * @param caution_money 保证金
	 * @param assets_value 资产余值
	 * @param Other_expenditure 其它支出
	 * @param type 付款类型
	 * @return  irr
	 */

	@SuppressWarnings("unchecked")
	public String getIrr(String firstMoney, List rent_list,String caution_money,String assets_value,
			String Other_expenditure,String lease_interval, String type) {
		
		//2011-05-11延迟期改延迟月修改
		
		List new_list = new ArrayList();
		int i = 0;
		if ("1".equals(type)) {// 先付时
			i++;
			new_list.add(Tools.formatNumberDoubleTwo(String.valueOf(Double
					.parseDouble(firstMoney)
					+ Double.parseDouble(rent_list.get(0).toString()))));
		} else {
			new_list.add(Tools.formatNumberDoubleTwo(firstMoney));
		}
		for (; i < rent_list.size(); i++) {
			if(i<(rent_list.size()-1)){
				new_list.add(rent_list.get(i));
			}else{//最后一期现金流考虑资产余值
				new_list.add(Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(rent_list.get(i).toString())-
						Double.parseDouble(caution_money)+Double.parseDouble(assets_value)+
						Double.parseDouble(Other_expenditure))));
			}
		}
//		for(int j=0;j<new_list.size();j++){
//			System.out.println("new_list="+new_list.get(j));
//		}
		IrrCal ic = new IrrCal();
		String irr = Tools.formatNumberDoubleScale(ic.getIRR(new_list,
				lease_interval, lease_interval, String.valueOf(12 / Integer
						.parseInt(lease_interval))), 4);
		return irr;
	}
	
}
