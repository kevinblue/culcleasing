package com.tenwa.culc.calc.tx.util;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.tenwa.culc.bean.RentInfoBox;
import com.tenwa.culc.calc.zjcs.EqDiffCorCalc;
import com.tenwa.culc.calc.zjcs.RentCaleCommonTools;

public class EqualDiffCorUtil {
	
	/**
	 * @author toybaby 2011-07-21
	 * 
	 * @param conditionBean
	 */
	@SuppressWarnings("unchecked")
	public static RentInfoBox  getRentInfoBox(com.tenwa.culc.bean.ConditionBean conditionBean){
		RentInfoBox rentInfoBox = new RentInfoBox();
		String contract_id = conditionBean.getContract_id();
		String lease_interval = conditionBean.getIncome_number_year();//租金间隔
		String assets_value = conditionBean.getAssets_value();//资产余值
		String caution_money=conditionBean.getCaution_money();//保证金
		String Other_expenditure = conditionBean.getOther_expenditure();//其它支出
		String rentScale="2";//租金精确度
		String type=conditionBean.getPeriod_type();//
		String firstMoney= String.valueOf("-"+conditionBean.getActual_fund());
		
		//现金流部分调用
		//装租金测算条件 9个
		EqDiffCorCalc calc =new EqDiffCorCalc();
		calc.setYear_rate(conditionBean.getYear_rate()); // 年利率
		calc.setIncome_number(conditionBean.getIncome_number());// 期数
		calc.setLease_money(conditionBean.getLease_money());// 租赁本金 （租赁本金 = 设备金额
		// - 首付款）
		calc.setFuture_money(conditionBean.getAssets_value());// 留购价
		calc.setPeriod_type(conditionBean.getPeriod_type());// 1,期初 0,期未的值
		calc.setIrr_type("2");// 1,为按月份的处; 2,为按租金间隔的处理 暂时是2
		calc.setScale("2");// irr的小数位数 暂时就是8位
		calc.setLease_interval(conditionBean.getIncome_number_year());// 租金间隔
		// (付租方式)
		calc.setPlan_date(conditionBean.getStart_date());// 每月偿付日 替换 起租日的具体日期
		calc.setRatio_param(conditionBean.getRatio_param());//本金公比
		if ("".equals(contract_id) || contract_id == null) {
			calc.setContract_id(conditionBean.getProj_id());// 计算具体项目现金流的KEY
		} else {
			calc.setContract_id(conditionBean.getContract_id());// 计算具体项目现金流的KEY
		}
		calc.setRentScale("4");// 圆整到
		
		List l_plan_date = new ArrayList();
		List l_rent = new ArrayList();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_corpus_overage = new ArrayList();
		Hashtable ht_plan = new Hashtable();
		try {
			
			ht_plan=calc.getRentPlan(conditionBean, rentScale);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 取值
		l_plan_date = (List) ht_plan.get("plan_date");// 租金偿还日期
		l_rent = (List) ht_plan.get("rent");// 租金
		l_corpus = (List) ht_plan.get("corpus");// 本金
		l_interest = (List) ht_plan.get("interest");// 利息
		l_corpus_overage = (List) ht_plan.get("corpus_overage");// 剩余本金

		for(int i=0;i<l_rent.size();i++){
		System.out.println(l_plan_date.get(i)+"rent="+l_rent.get(i)+"  corpus= "+l_corpus.get(i)+"  " +
				"inter="+l_interest.get(i)+"   cor_overge="+l_corpus_overage.get(i));

	}
		
		
		/*/////////////////
		 * 现金流及IRR测算
		 */////////////////
		RentCaleCommonTools  calcTools = new RentCaleCommonTools();
		// irr
		String irr = calcTools.getIrr(firstMoney, l_rent, caution_money, assets_value, Other_expenditure, lease_interval, type);
		// 得到保证金抵扣租金List rent_list 租金List,caut_money 保证金
		List l_RentDetails = calcTools.getRentDetails(firstMoney,l_rent,l_plan_date,conditionBean);
		/*
		 * 
		 * RentInfoBox 封装测算List
		 * 
		 */
		rentInfoBox.setL_Plan_date(l_plan_date);
		rentInfoBox.setL_Rent(l_rent);
		rentInfoBox.setL_Corpus(l_corpus);
		rentInfoBox.setL_Inter(l_interest);
		rentInfoBox.setL_CorpusOverge(l_corpus_overage);
		rentInfoBox.setL_RentDetails(l_RentDetails);
		rentInfoBox.setIrr(irr);//irr未乘以100

		return rentInfoBox;
		
		
		
		
		
		
		
	}
	
	
}
