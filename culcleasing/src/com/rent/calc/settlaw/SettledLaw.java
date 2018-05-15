package com.rent.calc.settlaw;

import java.util.Hashtable;
import java.util.List;

import com.rent.calc.tx.bg.ToolUtil;

/**
 * 平息法调用类
 * 
 * @author shf
 * 
 */
public class SettledLaw {

	/**
	 * 平息法租金测算
	 * 
	 * @param leaseMoney
	 *            市场的测算本金
	 * @param income_number
	 *            总期数
	 * @param yearRate
	 *            年利率
	 * @param lease_interval
	 *            租金间隔
	 * @param firstMoneyMarket
	 *            市场的现金流的第一期的值
	 * @param firstMoneyFinac
	 *            财务的现金流的第一期的值
	 * @param type
	 *            期初还是期末
	 * @param plan_date
	 *            起租日期
	 * @param rentScale
	 *            小数位数
	 * @param grace
	 *            宽限期
	 * @param delay
	 *            延迟期
	 * @return 租金计划信息
	 */
	@SuppressWarnings("unchecked")
	public Hashtable getPlanInfo(String leaseMoneyByMarket,
			String leaseMoneyByFianc, String income_number, String yearRate,
			String lease_interval, String firstMoneyMarket,
			String firstMoneyFinac, String type, String plan_date,
			String rentScale, String grace, String delay) {
		
		//2011-05-11延迟期改延迟月修改
		delay="0";

		Hashtable ht_plan = new Hashtable();
		// /市场租金计划处理
		getMarketPlan(leaseMoneyByMarket, income_number, yearRate,
				lease_interval, firstMoneyMarket, type, plan_date, rentScale,
				grace, delay, ht_plan);
		// /财务租金计划处理
		getFinacPlan(leaseMoneyByFianc, lease_interval, firstMoneyFinac,
				rentScale, type, grace, delay, ht_plan);

		return ht_plan;

	}


	/**
	 * 财务租金计划处理
	 * 
	 * @param lease_interval
	 * @param firstMoneyFinac
	 * @param ht_plan
	 */
	@SuppressWarnings("unchecked")
	private void getFinacPlan(String leaseMoneyByFianc, String lease_interval,
			String firstMoneyFinac, String rentScale, String type,
			String grace, String delay, Hashtable ht_plan) {
		
		//2011-05-11延迟期改延迟月修改
		delay="0";
		
		// 财务租金计划处理
		List rent_list = (List) ht_plan.get("rent_list");
		// 财务irr
		SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
		String finac_irr = slrcu.getIrr(firstMoneyFinac, rent_list,
				lease_interval, type, delay,grace);

		// /每期计算的利率
		String pre_fina_irr = ToolUtil.getPreRate(String.valueOf(Double
				.parseDouble(finac_irr) * 100), lease_interval);
		// String leaseMoneyFinac = "0";
		// if (firstMoneyFinac.indexOf("-") > -1) {
		// leaseMoneyFinac = Tools.formatNumberDoubleTwo(firstMoneyFinac
		// .substring(1));
		// }

		// 财务的利息值
		// 2010-12-08 rentScale-->newScale 除了租金之外的
		String newScale = "2";
		if (Integer.parseInt(grace) > 0) {// 如果有宽限期时第一期不做特别处理
			type = "-1";

		}
		List inter_fina_list = slrcu.getInterestList(rent_list,
				leaseMoneyByFianc, pre_fina_irr, type, newScale, grace, delay);
		// 财务本金
		List corpus_fina_list = slrcu.getCorpusList(rent_list, inter_fina_list,
				newScale, grace, delay);
		// 财务本金余额
		List corpusOverage_fina_list = slrcu.getCorpusOvergeList(
				leaseMoneyByFianc, corpus_fina_list, newScale);

		ht_plan.put("finac_irr", finac_irr);// 财务irr未乘以100
		ht_plan.put("inter_fina_list", inter_fina_list);// 财务的利息值
		ht_plan.put("corpus_fina_list", corpus_fina_list);// 财务本金
		ht_plan.put("corpusOverage_fina_list", corpusOverage_fina_list); // 财务本金余额
	}


	/**
	 * 市场租金计划处理
	 * 
	 * @param leaseMoney
	 * @param income_number
	 * @param yearRate
	 * @param lease_interval
	 * @param firstMoney
	 * @param ht_plan
	 */
	@SuppressWarnings("unchecked")
	private void getMarketPlan(String leaseMoney, String income_number,
			String yearRate, String lease_interval, String firstMoney,
			String type, String plan_date, String rentScale, String grace,
			String delay, Hashtable ht_plan) {
		
		
		//2011-05-11延迟期改延迟月修改
		delay="0";
		
		SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();

		// 2010-12-08 rentScale-->newScale 除了租金之外的
		String newScale = "2";
		// 得到本金list
		List corpus_market = slrcu.getCorpusList(leaseMoney, income_number,
				newScale, grace, delay);
		// 得到本金余额

		List corpusOverge_market = slrcu.getCorpusOvergeList(leaseMoney,
				corpus_market, newScale);
		// 租金列表
		List rent_list = slrcu.getRentList(leaseMoney, income_number, yearRate,
				lease_interval, rentScale, grace, delay);
		// 利息列表
		List inter_list = slrcu.getInterMarket(rent_list, corpus_market,
				newScale);
		// 计划日期
		List date_list = slrcu.getPlanDateList(rent_list, type, lease_interval,
				plan_date, grace, delay);

		// 市场的irr
		String market_irr = slrcu.getIrr(firstMoney, rent_list, lease_interval,
				type, delay,grace);

		ht_plan.put("date_list", date_list); // 计划日期
		ht_plan.put("rent_list", rent_list);// 得到本金list
		ht_plan.put("corpus_market", corpus_market); // 得到本金list
		ht_plan.put("inter_list", inter_list); // 利息列表
		ht_plan.put("corpusOverge_market", corpusOverge_market); // 得到本金余额
		ht_plan.put("market_irr", market_irr);// 市场irr未乘以100
	}


	public static void main(String[] args) {
		SettledLaw sl = new SettledLaw();
		Hashtable ht = sl.getPlanInfo("15000000", "15000000", "18", "6.0", "1",
				"-15000000", "-15000000", "1", "2010-6-25", "0", "3", "2");

		System.out.println("市场irr:" + ht.get("market_irr").toString());
		System.out.println("财务irr:" + ht.get("finac_irr").toString());
		List date_list = (List) ht.get("date_list");

		List rent_list = (List) ht.get("rent_list");
		List corpus_market = (List) ht.get("corpus_market");
		List inter_list = (List) ht.get("inter_list");
		List corpusOverge_market = (List) ht.get("corpusOverge_market");

		List inter_fina_list = (List) ht.get("inter_fina_list");
		List corpus_fina_list = (List) ht.get("corpus_fina_list");
		List corpusOverage_fina_list = (List) ht.get("corpusOverage_fina_list");

		System.out.println("------------------市场租金计划-------------");
		System.out.println("时间\t\t租金\t本金\t利息\t本金余额");
		for (int i = 0; i < rent_list.size(); i++) {
			System.out.println(date_list.get(i).toString() + "\t"
					+ rent_list.get(i).toString() + "\t"
					+ corpus_market.get(i).toString() + "\t"
					+ inter_list.get(i).toString() + "\t"
					+ corpusOverge_market.get(i).toString() + "\t");
		}
		System.out.println("------------------财务租金计划-------------");
		System.out.println("时间\t\t租金\t本金\t利息\t本金余额");
		for (int i = 0; i < rent_list.size(); i++) {
			System.out.println(date_list.get(i).toString() + "\t"
					+ rent_list.get(i).toString() + "\t"
					+ corpus_fina_list.get(i).toString() + "\t"
					+ inter_fina_list.get(i).toString() + "\t"
					+ corpusOverage_fina_list.get(i).toString() + "\t");
		}

	}
}
