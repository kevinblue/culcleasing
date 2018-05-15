package com.tenwa.culc.calc.tx.util;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.calc.tx.Tx_DataCtrolUtil;
import com.tenwa.culc.calc.tx.Tx_RentInfoBox;
import com.tenwa.culc.calc.tx.zjcs.Tx_EqDiffCorCalc;

public class Tx_EqualDiffCorUtil {
	
	/**
	 * @author toybaby 2011-07-21
	 * 
	 * @param conditionBean
	 * @throws SQLException 
	 */
	public static Tx_RentInfoBox  getRentInfoBox(String contract_id, String begin_id, Map<String,String> condition_Map) throws SQLException{
		Tx_RentInfoBox rentInfoBox = new Tx_RentInfoBox();
		// 租金测算商务条件
		String lease_money = condition_Map.get("lease_money");//剩余本金
		String year_rate = condition_Map.get("year_rate");//调息后年利率
		String lease_interval = condition_Map.get("income_number_year");//租金间隔
		String lease_term = condition_Map.get("income_number");//剩余期数
		String assets_value = condition_Map.get("assets_value");//资产余值
		String period_type = condition_Map.get("period_type");//付租类型
		String ratio_param = condition_Map.get("ratio_param");//公差公比
		
		// 租金测算程序
		List l_rent = new ArrayList();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_corpus_overage = new ArrayList();

		
		//现金流部分调用
		//装租金测算条件 9个
		Tx_EqDiffCorCalc calc =new Tx_EqDiffCorCalc();
		calc.setYear_rate(year_rate); // 年利率
		calc.setIncome_number(lease_term);// 期数
		calc.setLease_money(lease_money);// 租赁本金 
		calc.setPeriod_type(period_type);// 1,期初 0,期未的值
		calc.setFuture_money(assets_value);// 资产余值
		calc.setLease_interval(lease_interval);// 租金间隔
		calc.setRatio_param(ratio_param);//公差/比
		calc.setRentScale("2");// 圆整到
		calc.setScale("8");
		System.out.println("开始计算调息后的租金");
		Tx_DataCtrolUtil dataCtrolUtil = new Tx_DataCtrolUtil();
	    Map rentInfo_Map = new HashMap();

	    String rent_list_start = (String)condition_Map.get("rent_list_start");
	    rentInfo_Map = dataCtrolUtil.getRentInfoMap(contract_id, begin_id, rent_list_start);
		Hashtable ht_plan = new Hashtable(rentInfo_Map);
		try {
			System.out.println("即将进入方法");
			ht_plan=calc.getNewRentPlan(rentInfo_Map);
			System.out.println("方法执行结束");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 取值
		l_rent = (List) ht_plan.get("rent");// 租金
		l_corpus = (List) ht_plan.get("corpus");// 本金
		l_interest = (List) ht_plan.get("interest");// 利息
		l_corpus_overage = (List) ht_plan.get("corpus_overage");// 剩余本金

		for(int i=0;i<l_rent.size();i++){
		System.out.println("rent="+l_rent.get(i)+"  corpus= "+l_corpus.get(i)+"  " +
				"inter="+l_interest.get(i)+"   cor_overge="+l_corpus_overage.get(i));

	}
		
		/*
		 * 
		 * RentInfoBox 封装测算List
		 * 
		 */
		rentInfoBox.setL_rent(l_rent);
		rentInfoBox.setL_corpus(l_corpus);
		rentInfoBox.setL_interest(l_interest);
		rentInfoBox.setL_corpus_overage(l_corpus_overage);

		return rentInfoBox;
		
	}
	
	
}
