/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.calc.tx.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.calc.tx.Tx_RentInfoBox;
import com.tenwa.culc.calc.tx.zjcs.RentCalc;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.bean.RentPlanBean;
import com.Tools;
/**
 * 等额租金测算(调息)
 * @author toybaby
 * Date:Aug 9, 201112:01:23 PM       Email: toybaby@mail2.tenwa.com.cn
 */
public class EqualPaymentUtil {

	/**
	 * 测算
	 * 
	 * @param conditionBean
	 * 
	 * @return
	 */
	public static List<RentPlanBean> calc(ConditionBean conditionBean) {
		return null;
	}

	/**
	 * 获得调息后的租金计划RentInfoBox
	 * 
	 * @param conditionBean
	 */
	@SuppressWarnings("unchecked")
	public static Tx_RentInfoBox getRentInfoBox(Map<String,String> RentPlan_Map) {
		Tx_RentInfoBox rentInfoBox = new Tx_RentInfoBox();
		
		/**
		 * =======================================================
		 * 
		 * <pre>
		 * 先测算出相关的List数据
		 * </pre>
		 * 
		 * =======================================================
		 */
		
		// 租金测算商务条件
		String lease_money = RentPlan_Map.get("lease_money");//剩余本金
		String year_rate = RentPlan_Map.get("year_rate");//调息后年利率
		String lease_interval = RentPlan_Map.get("income_number_year");//租金间隔
		String lease_term = RentPlan_Map.get("income_number");//剩余期数
		String assets_value = RentPlan_Map.get("assets_value");//资产余值
		String period_type = RentPlan_Map.get("period_type");//付租类型
		//根据先付后付进行判断剩作本金是否加上下一期的利息，先付时需加上
		String rate = String.valueOf(Double.parseDouble(year_rate) / 12 / 100
				* Integer.parseInt(lease_interval));
		if("1".equals(period_type)){
			lease_money = Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(lease_money)
					+Double.parseDouble(lease_money)*Double.parseDouble(rate)));
		}
		
		// 租金测算程序
		List l_rent = new ArrayList();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_corpus_overage = new ArrayList();

		// *** 等额租金 租金测算 ****
		// 租金测算之封装租金测算条件 
		RentCalc rent = new RentCalc();
		rent.setYear_rate(year_rate); // 年利率
		rent.setIncome_number(lease_term);// 期数
		rent.setLease_money(lease_money);// 租赁本金 
		rent.setPeriod_type(period_type);// 1,期初 0,期未的值
		rent.setFuture_money(assets_value);// 资产余值
		rent.setLease_interval(lease_interval);// 租金间隔
		rent.setRentScale("2");// 圆整到
		rent.setScale("8");

		// ‘规则’情况下，租金具体测算如下： 租金Rent的List
		List rent_list = rent.eqRentList(rent.getYear_rate());// 得到租金list,注意不规则时的租金list
		System.out.println("rent_list长度===="+rent_list.size());
		// 封装HashMap
		HashMap hm = null;
		try {
			hm = rent.getHashRentPlan("1", rent_list);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 取值
		l_rent = (List) hm.get("rent");// 租金
		l_corpus = (List) hm.get("corpus");// 本金
		l_interest = (List) hm.get("interest");// 利息
		l_corpus_overage = (List) hm.get("corpus_overage");// 剩余本金
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
