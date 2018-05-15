package com.rent.calc.rentcharge;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;
import com.rent.calc.bg.IrrCal;
import com.rent.calc.bg.RentCalc;
import com.rent.calc.settlaw.SetLawRentCaleUtil;
import com.rent.calc.tx.bg.CoditionInfo;
import com.rent.calc.tx.bg.CommonUtil;
import com.rent.calc.tx.bg.FundRentPlan;
import com.rent.calc.tx.bg.ToolUtil;

/**
 * 租金变更 偿付时间修改 新的利率 调整的期数 调整开始期 调整开始时间
 * 
 * @author shf
 * 
 */
public class RentChange {
	/**
	 * 租金变更得到变更后的租金计划信息
	 * 
	 * @param contractId
	 *            合同号
	 * @param startStages
	 *            开始变更期次
	 * @param newRate
	 *            新的利率
	 * @param newPhases
	 *            新的租金变更期次
	 * @param newDate
	 *            新的偿还日
	 * @return 变更后的租金计划信息
	 * @throws Exception
	 */

	@SuppressWarnings( { "static-access", "unchecked" })
	public Hashtable getRentChargePlan(String contractId, String startStages,
			String newRate, String newPhases, String newDate) throws Exception {

		// 合同号 查出他的测算方式（平息法，pmt算法）

		// 查询交易结构表 判断变化的参数 根据变化的参数进行相应的处理
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht_cond = ci.getProj_ConditionInfoByProj_id(contractId);
		String measure_type = ht_cond.get("measure_type").toString();

		// 不同的测算方式调用不同的测算方法
		if ("1".equals(measure_type)) {// 等额租金

			// return getEqRentPlan(contractId, startStages, newRate, newPhases,
			// newDate);
			return getNewPlanByNewYearRatePmt(contractId, startStages, newRate,
					newPhases, newDate);

		} else if ("5".equals(measure_type)) {
			return getNewPlanBySettlaw(contractId, startStages, newRate,
					newPhases, newDate, ht_cond);

		}

		return null;
	}

	/**
	 * 平息法测算
	 * 
	 * @param contractId
	 *            合同号
	 * @param startStages
	 *            开始期项
	 * @param newRate
	 *            新的利率
	 * @param newPhases
	 *            新的期数
	 * @param newDate
	 *            新的偿还日
	 * @param ht_cond
	 *            合同交易结构信息
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	private Hashtable getNewPlanBySettlaw(String contractId,
			String startStages, String newRate, String newPhases,
			String newDate, Hashtable ht_cond) throws Exception, SQLException {
		// 平息法时
		SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
		// 得到总期数
		FundRentPlan frp = new FundRentPlan();
		int totalCount = Integer.parseInt(frp.getTotalCount(contractId));

		Hashtable ht = new Hashtable();
		// 得到新的偿还日
		ht = getNewPlanDate(contractId, startStages, newDate, newPhases);

		if ((totalCount - Integer.parseInt(startStages) + 1) != Integer
				.parseInt(newPhases)) { // 期数变

			String rentScale = ht_cond.get("rentScale").toString();
			String income_number_year = ht_cond.get("income_number_year")
					.toString();

			// 2010-12-08 除了租金
			String newScale = "2";

			String corpus_market = frp.getFisrtSumCorpMarket(contractId,
					startStages);
			corpus_market = Tools.formatNumberDoubleScale(corpus_market,
					Integer.parseInt(newScale));

			System.out.println("corpus_market:" + corpus_market);
			// 求出后面的延期期数中每一期的平均本金
			String pre_corpus = Tools.formatNumberDoubleScale(String
					.valueOf(Double.parseDouble(corpus_market)
							/ Integer.parseInt(newPhases)), Integer
					.parseInt(newScale));

			// 用于保存本金
			List corpus_market_list = new ArrayList();
			String total = "0";
			for (int i = 0; i < Integer.parseInt(newPhases); i++) {
				// 最后一期是要作特别的处理

				if (i == Integer.parseInt(newPhases) - 1) {
					double d = Double.parseDouble(corpus_market)
							- Double.parseDouble(total);
					corpus_market_list.add(Tools.formatNumberDoubleScale(String
							.valueOf(d), Integer.parseInt(newScale)));
				} else {
					corpus_market_list.add(pre_corpus);
					total = String.valueOf(Double.parseDouble(total)
							+ Double.parseDouble(pre_corpus));
					total = Tools.formatNumberDoubleScale(total, Integer
							.parseInt(newScale));
				}
			}

			// 租金list
			// 求出后面的延期期数中每一期的平均租金
			String pre_rent = slrcu.getRent(corpus_market, newPhases, newRate,
					income_number_year, rentScale);

			// String pre_rent = Tools.formatNumberDoubleScale(String
			// .valueOf(Double.parseDouble(corpus_market)
			// * (1 + Double.parseDouble(newRate)*0.01)
			// / Integer.parseInt(newPhases)), Integer
			// .parseInt(rentScale));

			List rent_list = new ArrayList();
			for (int i = 0; i < Integer.parseInt(newPhases); i++) {
				rent_list.add(pre_rent);
			}

			// 利息列表
			// SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
			List inter_list = slrcu.getInterMarket(rent_list,
					corpus_market_list, newScale);

			// 得到本金余额
			List corpusOverge_market_list = slrcu.getCorpusOvergeList(
					corpus_market, corpus_market_list, newScale);

			List cash_list = new ArrayList();
			cash_list.add("-" + corpus_market);
			// 添加租金列表
			cash_list.addAll(1, rent_list);
			IrrCal ic = new IrrCal();
			// 新算他的irr
			String market_irr = ic.getIRR(cash_list, income_number_year,
					income_number_year, String.valueOf(12 / Integer
							.parseInt(income_number_year)));
			market_irr = Tools.formatNumberDoubleScale(market_irr, 12);
			System.out.println("市场irr:" + market_irr);

			putValue(ht, corpus_market_list, rent_list, inter_list,
					corpusOverge_market_list, market_irr);

		} else {// 期数不变

			String rentScale = ht_cond.get("rentScale").toString();
			String income_number_year = ht_cond.get("income_number_year")
					.toString();

			String newScale = "2";
			// 期数不变时求的是总的本金 总的期数来测试的
			String corpus_market = frp.getFisrtSumCorpMarket(contractId, "0");
			corpus_market = Tools.formatNumberDoubleScale(corpus_market,
					Integer.parseInt(newScale));

			System.out.println("corpus_market:" + corpus_market);
			// 本金是不变的，所以只查询调整期的所有的本金值
			List corpus_market_list = new ArrayList();
			corpus_market_list = frp.getStartCorpus(contractId, startStages);

			// 租金list 租金值测算 是用总期数
			// 求出后面的延期期数中每一期的平均租金
			// String pre_rent = Tools.formatNumberDoubleScale(String
			// .valueOf(Double.parseDouble(corpus_market)
			// * (1 + Double.parseDouble(newRate)*0.01) / totalCount),
			// Integer.parseInt(rentScale));

			String pre_rent = slrcu.getRent(corpus_market, String
					.valueOf(totalCount), newRate, income_number_year,
					rentScale);

			List rent_list = new ArrayList();
			for (int i = 0; i < Integer.parseInt(newPhases); i++) {
				rent_list.add(pre_rent);
			}

			// 利息列表
			// SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
			List inter_list = slrcu.getInterMarket(rent_list,
					corpus_market_list, newScale);

			// 得到本金余额
			List corpusOverge_market_list = slrcu.getCorpusOvergeList(
					corpus_market, corpus_market_list, newScale);

			// 现金流处理时的第一期值
			corpus_market = frp.getFisrtSumCorpMarket(contractId, startStages);

			List cash_list = new ArrayList();
			cash_list.add("-" + corpus_market);
			// 添加租金列表
			cash_list.addAll(1, rent_list);
			IrrCal ic = new IrrCal();
			// 新算他的irr
			String market_irr = ic.getIRR(cash_list, income_number_year,
					income_number_year, String.valueOf(12 / Integer
							.parseInt(income_number_year)));
			market_irr = Tools.formatNumberDoubleScale(market_irr, 12);
			System.out.println("市场irr:" + market_irr);

			putValue(ht, corpus_market_list, rent_list, inter_list,
					corpusOverge_market_list, market_irr);

		}
		// 会计
		getPmtFinacPlan(contractId, startStages, ht);
		return ht;
	}

	/**
	 * 赋返回值
	 * 
	 * @param ht
	 * @param corpus_market_list
	 * @param rent_list
	 * @param inter_list
	 * @param corpusOverge_market_list
	 * @param market_irr
	 */
	@SuppressWarnings("unchecked")
	private void putValue(Hashtable ht, List corpus_market_list,
			List rent_list, List inter_list, List corpusOverge_market_list,
			String market_irr) {
		ht.put("rent_list", rent_list);// 租金
		ht.put("corpus_market_list", corpus_market_list);// 市场本金
		ht.put("inter_list", inter_list);// 市场利息
		ht.put("corpusOverge_market_list", corpusOverge_market_list);// 市场本金余额
		ht.put("market_irr", market_irr);// 市场irr
		System.out.println("market_irr:" + market_irr);
	}

	/**
	 * 等额租金的租金计划变更信息
	 * 
	 * @param contractId
	 * @param startStages
	 * @param newRate
	 * @param newPhases
	 * @param newDate
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings( { "static-access", "unchecked" })
	public Hashtable getNewPlanByNewYearRatePmt(String contractId,
			String startStages, String newRate, String newPhases, String newDate)
			throws Exception {
		Hashtable ht = new Hashtable();
		// 得到新的偿还日
		ht = getNewPlanDate(contractId, startStages, newDate, newPhases);
		// 市场
		getPmtMarketPlan(contractId, startStages, newRate, newPhases, ht);
		// 会计
		getPmtFinacPlan(contractId, startStages, ht);

		return ht;
	}

	/**
	 * 会计租金计划处理
	 * 
	 * @param contractId
	 * @param startStages
	 * @param ht
	 * @throws Exception
	 */

	@SuppressWarnings( { "static-access", "unchecked" })
	private void getPmtFinacPlan(String contractId, String startStages,
			Hashtable ht) throws Exception {
		List rent_list = (List) ht.get("rent_list");
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht_cond = ci.getProj_ConditionInfoByProj_id(contractId);
		// String rentScale = ht_cond.get("rentScale").toString();
		// String period_type = ht_cond.get("period_type").toString();

		// 2010-12-08 除了租金
		String newScale = "2";

		String income_number_year = ht_cond.get("income_number_year")
				.toString();
		// 得到测算的财务本金总和
		FundRentPlan frp = new FundRentPlan();
		String corpus_finace = frp.getTotalCorpusFinac(contractId, startStages);
		corpus_finace = Tools.formatNumberDoubleScale(corpus_finace, Integer
				.parseInt(newScale));
		List cash_list = new ArrayList();
		cash_list.add("-" + corpus_finace);
		// 添加租金列表
		cash_list.addAll(1, rent_list);
		IrrCal ic = new IrrCal();
		// 新算他的irr
		String finac_irr = ic.getIRR(cash_list, income_number_year,
				income_number_year, String.valueOf(12 / Integer
						.parseInt(income_number_year)));
		// 修改 irr 精确到12位:2010-12-15
		finac_irr = Tools.formatNumberDoubleScale(finac_irr, 12);
		System.out.println("财务irr:" + finac_irr);

		// 新利息
		ToolUtil tu = new ToolUtil();
		String preRate = Tools.formatNumberDoubleScale(tu.getPreRate(String
				.valueOf(Double.parseDouble(finac_irr) * 100),
				income_number_year), 12);

		List inter_fina_list = CommonUtil.getInterestList(rent_list,
				corpus_finace, preRate, "0", newScale);

		// 新本金
		List corpus_fina_list = CommonUtil.getCorpusList(rent_list,
				inter_fina_list, newScale);
		// 新本金余额
		List corpusOverge_market_list = CommonUtil.getCorpusOvergeList(
				corpus_finace, corpus_fina_list, newScale);

		ht.put("inter_fina_list", inter_fina_list);// 财务利息
		ht.put("corpus_fina_list", corpus_fina_list);// 财务本金
		ht.put("corpusOverage_fina_list", corpusOverge_market_list);// 财务本金余额
		ht.put("finac_irr", finac_irr);// 财务irr
	}

	/**
	 * 市场租金计划处理
	 * 
	 * @param contractId
	 * @param startStages
	 * @param newRate
	 * @param newPhases
	 * @param ht
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	private void getPmtMarketPlan(String contractId, String startStages,
			String newRate, String newPhases, Hashtable ht) throws Exception,
			SQLException {
		// 市场
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht_cond = ci.getProj_ConditionInfoByProj_id(contractId);
		String rentScale = ht_cond.get("rentScale").toString();
		String period_type = ht_cond.get("period_type").toString();
		String nominalprice = ht_cond.get("nominalprice").toString();
		period_type = "0";
		String income_number_year = ht_cond.get("income_number_year")
				.toString();

		// 2010-12-08 除了租金
		String newScale = "2";

		// 租金值 得到本金余额
		FundRentPlan frp = new FundRentPlan();
		String corpus_market = frp.getFisrtSumCorpMarket(contractId,
				startStages);

		corpus_market = Tools.formatNumberDoubleScale(corpus_market, Integer
				.parseInt(newScale));

		System.out.println("corpus_market:" + corpus_market);
		RentCalc rc = new RentCalc();
		ToolUtil tu = new ToolUtil();
		//
		String preRate = Tools.formatNumberDoubleScale(tu.getPreRate(newRate,
				income_number_year), 12);
		String rent = Tools.formatNumberDoubleScale(rc.getPMT(preRate,
				newPhases, "-" + corpus_market, nominalprice, period_type),
				Integer.parseInt(rentScale));

		RentChargCalcTool rcct = new RentChargCalcTool();

		// 新租金列表
		List rent_list = rcct.getRentListByRentAndPhase(rent, newPhases);
		// 新利息
		List inter_list = CommonUtil.getInterestList(rent_list, corpus_market,
				preRate, "0", newScale);
		// 新本金
		List corpus_market_list = CommonUtil.getCorpusList(rent_list,
				inter_list, newScale);
		// 新本金余额
		List corpusOverge_market_list = CommonUtil.getCorpusOvergeList(
				corpus_market, corpus_market_list, newScale);

		List cash_list = new ArrayList();
		cash_list.add("-" + corpus_market);
		// 添加租金列表
		cash_list.addAll(1, rent_list);
		IrrCal ic = new IrrCal();
		// 新算他的irr
		String market_irr = ic.getIRR(cash_list, income_number_year,
				income_number_year, String.valueOf(12 / Integer
						.parseInt(income_number_year)));
		market_irr = Tools.formatNumberDoubleScale(market_irr, 12);
		System.out.println("市场irr:" + market_irr);

		ht.put("rent_list", rent_list);// 租金
		ht.put("corpus_market_list", corpus_market_list);// 市场本金
		ht.put("inter_list", inter_list);// 市场利息
		ht.put("corpusOverge_market_list", corpusOverge_market_list);// 市场本金余额
		ht.put("market_irr", market_irr);// 市场irr
		System.out.println("market_irr:" + market_irr);
	}

	/**
	 * 租金偿还日变更
	 * 
	 * @param contractId
	 * @param startStages
	 * @param newDate
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public Hashtable getNewPlanDate(String contractId, String startStages,
			String newDate, String newPhases) throws Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable ht_cond = ci.getProj_ConditionInfoByProj_id(contractId);

		String income_number_year = ht_cond.get("income_number_year")
				.toString();
		List l_date = new ArrayList();
		RentChargCalcTool rcct = new RentChargCalcTool();
		rcct.getChargeDate(contractId, startStages, newDate, newPhases,
				income_number_year, l_date);

		Hashtable ht = new Hashtable();
		ht.put("l_date", l_date);// 计划日期
		return ht;
	}
	

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		// ht.put("rent_list", null);// 租金
		// ht.put("corpus_market_list", null);// 市场本金
		// ht.put("inter_list", null);// 市场利息
		// ht.put("corpusOverge_market_list", null);// 市场本金余额

		// ht.put("inter_fina_list", null);// 财务利息
		// ht.put("corpus_fina_list", null);// 财务本金
		// ht.put("corpusOverage_fina_list", null);// 财务本金余额

		List li = new ArrayList();
		li.add("-100");
		List li1 = new ArrayList();
		li1.add("-11");
		li1.add("-12");
		li1.add("-13");

		li.addAll(1, li1);
		

		for (int i = 0; i < li.size(); i++) {
			//System.out.println("==" + li.get(i).toString());
		}
		
		String s = "1";
		String s1 = new String (s) ;
		s1 = String.valueOf(Integer.parseInt(s1)+1);
		System.out.println(s1);
		System.out.println("========="+s);
		
	} 
}
