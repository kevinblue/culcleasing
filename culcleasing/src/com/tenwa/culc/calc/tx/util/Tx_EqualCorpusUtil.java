package com.tenwa.culc.calc.tx.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.calc.tx.Tx_RentInfoBox;
import com.tenwa.culc.calc.tx.zjcs.Tx_RentCalc;
/**
 * 
 * @author toybaby
 * Date:Aug 12, 201112:13:04 PM       Email: toybaby@mail2.tenwa.com.cn
 */
public class Tx_EqualCorpusUtil {

	/**
	 * 测算
	 * 
	 * @param conditionBean
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Tx_RentInfoBox  getRentInfoBox(Map<String,String> condition_Map) {
		/**
		 * =======================================================
		 * 
		 * <pre>
		 * 先测算出相关的List数据
		 * </pre>
		 * 
		 * =======================================================
		 */
		Tx_RentInfoBox rentInfoBox = new Tx_RentInfoBox();
		//租金测算商务条件
		String lease_money = condition_Map.get("lease_money");//剩余本金
		String year_rate = condition_Map.get("year_rate");//调息后年利率
		String lease_interval = condition_Map.get("income_number_year");//租金间隔
		String lease_term = condition_Map.get("income_number");//剩余期数
		String assets_value = condition_Map.get("assets_value");//资产余值
		String period_type = condition_Map.get("period_type");//付租类型	
		//根据先付后付进行判断剩作本金是否加上下一期的利息，先付时需加上
		// 租金测算程序
		List l_rent = new ArrayList();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_corpus_overage = new ArrayList();

		// *****************************************************************************************************
		// *** 等额本金 租金测算 ****
		// *****************************************************************************************************
		// 租金测算之封装租金测算条件 
		Tx_RentCalc rent = new Tx_RentCalc();
		rent.setYear_rate(year_rate); // 年利率
		rent.setIncome_number(lease_term);// 期数
		rent.setLease_money(lease_money);// 租赁本金 
		rent.setPeriod_type(period_type);// 1,期初 0,期未的值
		rent.setFuture_money(assets_value);// 资产余值
		rent.setLease_interval(lease_interval);// 租金间隔
		rent.setRentScale("2");// 圆整到
		rent.setScale("8");
		rent.setRentScale("4");// 圆整到

		// ==============具体测算租金===============

		// 封装HashMap 获得所有租金计划
		HashMap hm = null;
		try {
			hm = rent.getPlanByEqCorpus();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 取值
		l_rent = (List) hm.get("rent");// 租金
		l_corpus = (List) hm.get("corpus");// 本金
		l_interest = (List) hm.get("interest");// 利息
		l_corpus_overage = (List) hm.get("corpus_overage");// 剩余本金
//		for(int i=0;i<l_rent.size();i++){
//			System.out.println("rent="+l_rent.get(i)+"  corpus= "+l_corpus.get(i)+"  " +
//					"inter="+l_interest.get(i)+"   cor_overge="+l_corpus_overage.get(i));
//		}
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
