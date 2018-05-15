package com.rent.calc.tx.bg;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;
import com.rent.calc.settlaw.SetLawRentCaleUtil;

/**
 * 市场租金计划处理
 * 
 * @author shf
 * 
 */
public class MarkerRentPlan {
	/**
	 * 得到主市场的irr值
	 * 
	 * @param proj_id
	 * @param start_term
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public void processMarketIrr(String proj_id, String start_term)
			throws Exception, SQLException {
		FundRentPlan frp = new FundRentPlan();
		List flow = new ArrayList();

		CoditionInfo ci = new CoditionInfo();
		String getAdjustSty = ci.getAdjustSty(proj_id);
		String fstart = start_term;
		if ("2".equals(getAdjustSty) || "".equals(getAdjustSty)) {// 固定加值 时
			fstart = String.valueOf(Integer.parseInt(fstart) - 1);
		}

		flow.add("-" + frp.getTotalCorpusByQc(proj_id, fstart));

		String slist = String.valueOf(Integer.parseInt(start_term) - 1);

		if ("3".equals(getAdjustSty) || "0".equals(getAdjustSty)
				|| "1".equals(getAdjustSty) || "3".equals(getAdjustSty)) {
			slist = String.valueOf(Integer.parseInt(start_term));
		}
		flow = frp.getOtherFlowRent(proj_id, slist, flow);

		Hashtable ht = ci.getChjg(proj_id);

		String marker_irr = IrrCalc.getIRR(flow, ht.get("chjg").toString(), ht
				.get("zjjg").toString(), ht.get("nhkcs").toString());
		marker_irr = Tools.formatNumberDoubleScale(marker_irr, 12);
		// 更新市场irr的值
		ci.updateMarkerIrr(proj_id, marker_irr);

	}


	/**
	 * 固定添值 市场处理
	 * 
	 * @param proj_id
	 * @param start_term
	 * @param add_value
	 * @throws Exception
	 * @throws SQLException
	 */
	public void processMarketRentPlan(String proj_id, String start_term,
			String add_value) throws SQLException, Exception {
		FundRentPlan frp = new FundRentPlan();
		// 修改租市场租金计划,添加固定值是通过次期来处理的
		frp.proceMarkerInfo(proj_id, String.valueOf(Integer
				.parseInt(start_term) + 1), add_value);
		// 修改市场的irr
		processMarketIrr(proj_id, String
				.valueOf(Integer.parseInt(start_term) + 1));
	}


	/**
	 * 市场租金计划处理
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param txrq
	 * @param rateValue
	 * @throws Exception
	 */

	@SuppressWarnings("static-access")
	public void proceMarketRentInfo(String contract_id, String start_term,
			String txrq, String rateValue) throws Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
		String start_term_temp = new String(start_term);

		if (mp.get("grace") != null
				&& Integer.parseInt(mp.get("grace").toString()) >= Integer
						.parseInt(start_term)) {// 有宽限期时

			// /////
			String dqcorpus = "0";
			String total_corpus = "0";
			for (int i = Integer.parseInt(start_term_temp); i <= Integer
					.parseInt(mp.get("grace").toString()); i++) {// 循环处理宽限期的租金计划

				// 市场
				FundRentPlan frp = new FundRentPlan();
				String first_corpus = frp.getIrrFisrtSumCorpMarker(contract_id,
						start_term_temp).get(0).toString();
				if (first_corpus.indexOf("-") > -1) {
					first_corpus = first_corpus.substring(1);

				}
				String first_inter = "0";
				String income_number_year = mp.get("income_number_year")
						.toString();
				String rentScale = mp.get("rentScale").toString();
				ToolUtil tu = new ToolUtil();
				String preRate = tu.getPreRate(rateValue, income_number_year);
				// 新的利息
				first_inter = Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(preRate)
								* Double.parseDouble(first_corpus)), Integer
						.parseInt(rentScale));

				String dqzj = first_inter;// 宽限本金为0,所以租金＝利息
				dqcorpus = String.valueOf(Double.parseDouble(dqzj)
						- Double.parseDouble(first_inter));
				// 后面用于测算的剩余本金值
				total_corpus = String.valueOf(Double.parseDouble(first_corpus)
						- Double.parseDouble(dqcorpus));
				total_corpus = Tools.formatNumberDoubleTwo(total_corpus);
				// 更新第一期的租金计划信息
				frp.updateSignMarkerPlan(contract_id, start_term_temp,
						first_inter, dqcorpus, total_corpus, rateValue);
				frp.updateMarketRentPlanByGrace(contract_id, start_term_temp);
				start_term_temp = String.valueOf(Integer
						.parseInt(start_term_temp) + 1);
			}

			// //////////////
			RentCalc rc = new RentCalc();
			String rent = rc.getRentByPmt(rateValue, contract_id, txrq);
			// 调息计算期次
			String rem_rent_list = "0";
			String ajdustStyle = mp.get("ajdustStyle").toString();

			rem_rent_list = rc.getRemList(contract_id, txrq);
			String corpus_market = rc.getRemMarketCorps(contract_id, txrq);

			if ("2".equals(ajdustStyle)) { // 次期时
				// 得到开始期次,得到总的期数 剩余期数 测算本金
				FundRentPlan frp = new FundRentPlan();

				String o_start = mp.get("grace") != null
						&& Integer.parseInt(mp.get("grace").toString()) >= Integer
								.parseInt(start_term) ? String.valueOf(Integer
						.parseInt(mp.get("grace").toString())) : start_term;

				String minRent_list = String
						.valueOf(Integer.parseInt(o_start) + 1);

				String totalCount = frp.getTotalCount(contract_id);

				rem_rent_list = String.valueOf(Integer.parseInt(totalCount)
						- Integer.parseInt(minRent_list) + 1);
				corpus_market = frp.getIrrFisrtSumCorpMarker(contract_id,
						minRent_list).get(0).toString();

			}

			// 得到租金List
			List rent_list = rc.eqRentList(rent, rem_rent_list);

			// 市场的利息列表,注意市场的测算本金与财务的不一样
			FundRentPlan frp = new FundRentPlan();

			if (corpus_market.indexOf("-") > -1) {
				corpus_market = corpus_market.substring(1);
			}

			String qzOrqm = ci.getType(contract_id, start_term_temp);
			String rentScale = ci.getRentScale(contract_id);

			// 2010-12-07 除了租金之外其余的保留二位小数
			rentScale = "2";

			String income_number_year = mp.get("income_number_year").toString();

			// 得到每一期租金的利率
			String retu_vale = Tools.formatNumberDoubleScale(ToolUtil
					.getPreRate(rateValue, income_number_year), 12);

			// 市场利息
			List l_inte_mark = CommonUtil.getInterestList(rent_list,
					corpus_market, retu_vale, qzOrqm, rentScale);

			// 市场本金
			List l_corpus_market = CommonUtil.getCorpusList(rent_list,
					l_inte_mark, rentScale);
			// 市场本金余额
			List l_corpus_overage_market = CommonUtil.getCorpusOvergeList(
					corpus_market, l_corpus_market, rentScale);

			// 更新租金计划表
			frp.processMarkerPlan(contract_id, start_term_temp, rent_list,
					l_inte_mark, l_corpus_market, l_corpus_overage_market,
					rateValue);
			// 修改市场的irr
			processMarketIrr(contract_id, start_term_temp);

		} else { // 正常测算时

			RentCalc rc = new RentCalc();
			String rent = rc.getRentByPmt(rateValue, contract_id, txrq);
			// 调息计算期次
			String rem_rent_list = "0";
			String ajdustStyle = mp.get("ajdustStyle").toString();

			rem_rent_list = rc.getRemList(contract_id, txrq);
			String corpus_market = rc.getRemMarketCorps(contract_id, txrq);

			if ("2".equals(ajdustStyle)) { // 次期时
				// 得到开始期次,得到总的期数 剩余期数 测算本金
				FundRentPlan frp = new FundRentPlan();
				String minRent_list = start_term;

				String totalCount = frp.getTotalCount(contract_id);

				rem_rent_list = String.valueOf(Integer.parseInt(totalCount)
						- Integer.parseInt(minRent_list) + 1);
				corpus_market = frp.getIrrFisrtSumCorpMarker(contract_id,
						minRent_list).get(0).toString();

			}

			// 得到租金List
			List rent_list = rc.eqRentList(rent, rem_rent_list);

			// 市场的利息列表,注意市场的测算本金与财务的不一样
			FundRentPlan frp = new FundRentPlan();

			if (corpus_market.indexOf("-") > -1) {
				corpus_market = corpus_market.substring(1);
			}

			String qzOrqm = ci.getType(contract_id, start_term);
			String rentScale = ci.getRentScale(contract_id);

			// 2010-12-07 除了租金之外其余的保留二位小数
			rentScale = "2";

			String income_number_year = mp.get("income_number_year").toString();

			// 得到每一期租金的利率
			String retu_vale = Tools.formatNumberDoubleScale(ToolUtil
					.getPreRate(rateValue, income_number_year), 12);

			// 市场利息
			List l_inte_mark = CommonUtil.getInterestList(rent_list,
					corpus_market, retu_vale, qzOrqm, rentScale);

			// 市场本金
			List l_corpus_market = CommonUtil.getCorpusList(rent_list,
					l_inte_mark, rentScale);
			// 市场本金余额
			List l_corpus_overage_market = CommonUtil.getCorpusOvergeList(
					corpus_market, l_corpus_market, rentScale);

			// 更新租金计划表
			frp.processMarkerPlan(contract_id, start_term, rent_list,
					l_inte_mark, l_corpus_market, l_corpus_overage_market,
					rateValue);
			// 修改市场的irr
			processMarketIrr(contract_id, start_term);

		}

	}


	/**
	 * 其他期次的租金 处理 市场
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param rateValue
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceCROhterMarket(String contract_id, String start_term,
			String rateValue) throws Exception {

		RentCalc rc = new RentCalc();
		String rent = rc.getRentPLeassMoney(rateValue, contract_id, start_term);

		FundRentPlan frp = new FundRentPlan();
		String total = frp.getTotalCount(contract_id);
		String rem_rent_list = String.valueOf(Integer.parseInt(total)
				- Integer.parseInt(start_term));

		// 得到租金List
		List rent_list = rc.eqRentList(rent, rem_rent_list);

		// 市场的利息列表,注意市场的测算本金与财务的不一样

		String corpus_market = frp.getTotalCorpusByQc(contract_id, start_term);
		CoditionInfo ci = new CoditionInfo();
		String qzOrqm = ci.getType(contract_id, start_term);

		String rentScale = ci.getRentScale(contract_id);

		// 2010-12-07 除了租金之外其余的保留二位小数
		rentScale = "2";

		// 市场利息
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
		String income_number_year = mp.get("income_number_year").toString();
		String retu_vale = Tools.formatNumberDoubleScale(ToolUtil.getPreRate(
				rateValue, income_number_year), 12);
		List l_inte_mark = CommonUtil.getInterestList(rent_list, corpus_market,
				retu_vale, qzOrqm, rentScale);

		// 市场本金
		List l_corpus_market = CommonUtil.getCorpusList(rent_list, l_inte_mark,
				rentScale);
		// 市场本金余额
		List l_corpus_overage_market = CommonUtil.getCorpusOvergeList(
				corpus_market, l_corpus_market, rentScale);

		// 更新租金计划表

		frp.processMarkerPlan(contract_id, String.valueOf(Integer
				.parseInt(start_term) + 1), rent_list, l_inte_mark,
				l_corpus_market, l_corpus_overage_market, rateValue);
		// 修改市场的irr
		MarkerRentPlan mrp = new MarkerRentPlan();
		mrp.processMarketIrr(contract_id, start_term);

	}


	/**
	 * 更新市场的第一期租金计划信息
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws SQLException
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceFirstRentPlan(String contract_id, String txrq,
			String start_term, String rateValue) throws SQLException, Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		String start_term_temp = new String(start_term);
		FundRentPlan frp = new FundRentPlan();
		if (ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term_temp)) {// 有宽限期时

			// 有宽限期的租金计划处理
			evalGraceFirst(contract_id, txrq, start_term, rateValue, ht);

		} else {// 正常测算时

			// 市场

			String first_corpus = frp.getIrrFisrtSumCorpMarker(contract_id,
					start_term).get(0).toString();
			if (first_corpus.indexOf("-") > -1) {
				first_corpus = first_corpus.substring(1);

			}
			String first_inter = CommonUtil.getFirstInterest(contract_id, txrq,
					start_term, rateValue, first_corpus);

			// 得到原来本金
			String old_corpus = frp.getDqCorpus(contract_id, start_term);
			String dqzj = frp.getDqZj(contract_id, start_term);
			String dqcorpus = String.valueOf(Double.parseDouble(dqzj)
					- Double.parseDouble(first_inter));

			// 本金差值
			String cha_old_new_corp = String.valueOf(Double
					.parseDouble(dqcorpus)
					- Double.parseDouble(old_corpus));
			// 后面用于测算的剩余本金值
			String total_corpus = String.valueOf(Double
					.parseDouble(first_corpus)
					- Double.parseDouble(cha_old_new_corp));

			// 修改 2010-11-28 剩余本金值 = 上一期的本金和值－这一期本金值
			total_corpus = String.valueOf(Double.parseDouble(first_corpus)
					- Double.parseDouble(dqcorpus));

			total_corpus = Tools.formatNumberDoubleTwo(total_corpus);

			// 更新第一期的租金计划信息
			frp.updateSignMarkerPlan(contract_id, start_term, first_inter,
					dqcorpus, total_corpus, rateValue);

		}

	}


	@SuppressWarnings("static-access")
	private void evalGraceFirst(String contract_id, String txrq,
			String start_term, String rateValue, Hashtable ht)
			throws Exception, SQLException {
		String start_term_temp = new String(start_term);
		int ivalue = Integer.parseInt(start_term);

		// /////
		String dqcorpus = "0";
		String total_corpus = "0";
		for (int i = Integer.parseInt(start_term_temp); i <= Integer
				.parseInt(ht.get("grace").toString()); i++) {// 循环处理宽限期的租金计划

			// 市场
			FundRentPlan frp = new FundRentPlan();
			String first_corpus = frp.getIrrFisrtSumCorpMarker(contract_id,
					start_term_temp).get(0).toString();
			if (first_corpus.indexOf("-") > -1) {
				first_corpus = first_corpus.substring(1);

			}

			String first_inter = "0";

			if (i == ivalue) {// 第一期分段处理
				first_inter = CommonUtil.getFirstInterest(contract_id, txrq,
						start_term_temp, rateValue, first_corpus);

				String dqzj = first_inter;// 宽限本金为0,所以租金＝利息
				dqcorpus = String.valueOf(Double.parseDouble(dqzj)
						- Double.parseDouble(first_inter));
				// 后面用于测算的剩余本金值
				total_corpus = String.valueOf(Double.parseDouble(first_corpus)
						- Double.parseDouble(dqcorpus));

				total_corpus = Tools.formatNumberDoubleTwo(total_corpus);

				// // 更新第一期的租金计划信息
				// frp.updateSignMarkerPlan(contract_id, start_term_temp,
				// first_inter,
				// dqcorpus, total_corpus, rateValue);

			} else {

				String income_number_year = ht.get("income_number_year")
						.toString();
				String rentScale = ht.get("rentScale").toString();
				ToolUtil tu = new ToolUtil();
				String preRate = tu.getPreRate(rateValue, income_number_year);
				// 新的利息
				first_inter = Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(preRate)
								* Double.parseDouble(first_corpus)), Integer
						.parseInt(rentScale));

				String dqzj = first_inter;// 宽限本金为0,所以租金＝利息
				dqcorpus = String.valueOf(Double.parseDouble(dqzj)
						- Double.parseDouble(first_inter));
				// 后面用于测算的剩余本金值
				total_corpus = String.valueOf(Double.parseDouble(first_corpus)
						- Double.parseDouble(dqcorpus));

				total_corpus = Tools.formatNumberDoubleTwo(total_corpus);

			}
			// 更新第一期的租金计划信息
			frp.updateSignMarkerPlan(contract_id, start_term_temp, first_inter,
					dqcorpus, total_corpus, rateValue);
			frp.updateMarketRentPlanByGrace(contract_id, start_term_temp);
			start_term_temp = String
					.valueOf(Integer.parseInt(start_term_temp) + 1);
		}
	}


	// //////////////////////////////////////////////////////

	/**
	 * 市场租金计划处理 平息法调息 2010-12-08
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param txrq
	 * @param rateValue
	 * @throws Exception
	 */

	@SuppressWarnings("static-access")
	public void proceMarketRentInfoBySett(String contract_id,
			String start_term, String txrq, String rateValue) throws Exception {

		// 判断是正常还是从宽限期开始调
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
		String start_term_temp = new String(start_term);
		String rentScale = ci.getRentScale(contract_id);
		String income_number_year = mp.get("income_number_year").toString();

		FundRentPlan frp = new FundRentPlan();

		if (mp.get("grace") != null
				&& Integer.parseInt(mp.get("grace").toString()) >= Integer
						.parseInt(start_term_temp)) {// 有宽限期时

			// /////
			for (int i = 1; i <= Integer.parseInt(mp.get("grace").toString()); i++) {// 循环处理宽限期的租金计划

				// rateValue
				ToolUtil tu = new ToolUtil();
				String preRate = tu.getPreRate(rateValue, income_number_year);
				// 新的租金
				String newRent = Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(preRate)
								* Double.parseDouble(mp.get("equip_amt")
										.toString())), Integer
						.parseInt(rentScale));

				// 得到原来本金
				String old_corpus = frp.getDqCorpus(contract_id,
						start_term_temp);

				// 得到新的利息
				String newInterest = Tools.formatNumberDoubleTwo(String
						.valueOf(Double.parseDouble(newRent)
								- Double.parseDouble(old_corpus)));
				// 更新第一期的租金计划信息
				frp.updateSignMarkerPlan(contract_id, start_term_temp, newRent,
						newInterest, rateValue);

				start_term_temp = String.valueOf(Integer
						.parseInt(start_term_temp) + 1);
			}

			// start_term_temp = String
			// .valueOf(Integer.parseInt(start_term_temp) + 1);

			start_term = start_term_temp;
			RentCalc rc = new RentCalc();
			String rem_rent_list = "0";
			String ajdustStyle = mp.get("ajdustStyle").toString();
			rem_rent_list = rc.getRemList(contract_id, txrq);
			String corpus_market = rc.getRemMarketCorps(contract_id, txrq);
			String totalCount = "1";
			if ("2".equals(ajdustStyle)) { // 次期时
				// 得到开始期次,得到总的期数 剩余期数 测算本金
				String minRent_list = start_term;
				totalCount = frp.getTotalCount(contract_id);
				rem_rent_list = String.valueOf(Integer.parseInt(totalCount)
						- Integer.parseInt(minRent_list) + 1);
				corpus_market = frp.getIrrFisrtSumCorpMarker(contract_id,
						minRent_list).get(0).toString();

			}

			SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();

			// 算出新的租金list
			// 租金列表 新的租金只跟新利率有关 新的租金list
			List rent_list = slrcu.getRentListByCount(mp.get("equip_amt")
					.toString(), totalCount, rateValue, income_number_year,
					rentScale, rem_rent_list);

			// 市场的利息列表,注意市场的测算本金与财务的不一样

			if (corpus_market.indexOf("-") > -1) {
				corpus_market = corpus_market.substring(1);
			}

			// 利息小数位
			String newScale = "2";
			// 得到本金list
			List l_corpus_market = frp.getCorpsMarker(contract_id, start_term);
			// 得到新的利息
			List inter_list = slrcu.getInterMarket(rent_list, l_corpus_market,
					newScale);

			// 更新租金计划表
			frp.updateMarkerPlanBySet(contract_id, start_term, rent_list,
					inter_list, rateValue);
			// 修改市场的irr
			processMarketIrr(contract_id, start_term);

		} else {// 正常测算时

			RentCalc rc = new RentCalc();
			// CoditionInfo ci = new CoditionInfo();
			// 调息计算期次
			// Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);

			// String rentScale = ci.getRentScale(contract_id);
			// String income_number_year =
			// mp.get("income_number_year").toString();

			String rem_rent_list = "0";
			String ajdustStyle = mp.get("ajdustStyle").toString();

			rem_rent_list = rc.getRemList(contract_id, txrq);
			String corpus_market = rc.getRemMarketCorps(contract_id, txrq);
			String totalCount = "1";
			if ("2".equals(ajdustStyle)) { // 次期时
				// 得到开始期次,得到总的期数 剩余期数 测算本金
				// FundRentPlan frp = new FundRentPlan();
				String minRent_list = start_term;

				totalCount = frp.getTotalCount(contract_id);

				rem_rent_list = String.valueOf(Integer.parseInt(totalCount)
						- Integer.parseInt(minRent_list) + 1);
				corpus_market = frp.getIrrFisrtSumCorpMarker(contract_id,
						minRent_list).get(0).toString();

			}

			SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();

			// 算出新的租金list
			// 租金列表 新的租金只跟新利率有关 新的租金list
			List rent_list = slrcu.getRentListByCount(mp.get("equip_amt")
					.toString(), totalCount, rateValue, income_number_year,
					rentScale, rem_rent_list);

			// 市场的利息列表,注意市场的测算本金与财务的不一样
			// FundRentPlan frp = new FundRentPlan();

			if (corpus_market.indexOf("-") > -1) {
				corpus_market = corpus_market.substring(1);
			}

			// 利息小数位
			String newScale = "2";
			// 得到本金list
			List l_corpus_market = frp.getCorpsMarker(contract_id, start_term);
			// 得到新的利息
			List inter_list = slrcu.getInterMarket(rent_list, l_corpus_market,
					newScale);

			// 更新租金计划表
			frp.updateMarkerPlanBySet(contract_id, start_term, rent_list,
					inter_list, rateValue);
			// 修改市场的irr
			processMarketIrr(contract_id, start_term);

		}

	}


	/**
	 * 2010-12-09 更新市场的第一期租金计划信息 平息法时 次日
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws SQLException
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceFirstRentPlanBySet(String contract_id, String txrq,
			String start_term, String rateValue) throws SQLException, Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		String start_term_temp = new String(start_term);
		if (ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term_temp)) {// 有宽限期时

			// 2011-04-15修改注释
			// start_term_temp = evalSetGrace(contract_id, txrq, rateValue, ht,
			// start_term_temp);

			// 有宽限期的租金计划处理
			evalGraceFirst(contract_id, txrq, start_term, rateValue, ht);
			
			
			
			

		} else {// 正常测算第一期利息处理

			getSetFirstInter(contract_id, start_term, rateValue, txrq, ht.get(
					"equip_amt").toString());

		}

	}


	/**
	 * 
	 * TODO (todo-list todo-list 平息法第一期租金计划计算)
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param rateValue
	 * @param txrq
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void getSetFirstInter(String contract_id, String start_term,
			String rateValue, String txrq, String leassMoney) throws Exception {

		// 第一期利息
		FundRentPlan frp = new FundRentPlan();
		String dqdate = frp.getDqDate(contract_id, start_term);
		String predate = frp.getPreDate(contract_id, start_term);

		// 得到原利率
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		String year_rate = frp.getPreRate(contract_id, start_term);

		// 如果是从第一期 开始则前一期的日期为起租日期
		if (predate.equals("0")) {
			predate = ht.get("start_date").toString();

		}

		String first_corpus = frp.getIrrFisrtSumCorpMarker(contract_id,
				start_term).get(0).toString();
		if (first_corpus.indexOf("-") > -1) {
			first_corpus = first_corpus.substring(1);

		}

		String rentScale = ht.get("rentScale").toString();

		// /2010-12-30 修改
		// 查询是在当期是否有调息记录
		FundAdjustInter fai = new FundAdjustInter();
		Hashtable ht_recoder = fai.searcherRecoder(contract_id, start_term, ht
				.get("ajdustStyle").toString());

		// String first_interest = "0";
		List start_dates = (List) ht_recoder.get("start_date");

		// 新的租金
		String newRent = "0";
		// 得到原来本金
		String old_corpus = "0";
		// 得到新的利息
		String newInterest = "0";

		if (!ht_recoder.isEmpty() && start_dates.size() > 0) {// 得到调息记录 分段计息

			// G17*(E11-E10)*(B24-B14)/360+G17*(E12-E11)*(B24-B14)/360+G17*(E14-E12)*(B24-B14)/360
			// 求上下两期的天数,构建被除数
			String income_number_year = ht.get("income_number_year").toString();
			// long days = ToolUtil.getDateDiff(dqdate, predate);
			double dto = Double.parseDouble(leassMoney) / 360;

			// 算间隔利利息值

			List start_days = (List) ht_recoder.get("start_date");
			List before_rates = (List) ht_recoder.get("before_rate");
			List after_rates = (List) ht_recoder.get("after_rate");

			// 刚开始用前一期日期与调息记录中的日期计算
			String temp_pre_date = predate;
			String tem_rate = "0";
			String tem_pre_rate = before_rates.get(0).toString();
			String tem_date = start_dates.get(0).toString();
			String tem_interest = "0";

			for (int i = 0; i < start_days.size(); i++) {
				if (i == 0) {// 第一期时取最原始的利率来算
					tem_pre_rate = before_rates.get(0).toString();
					tem_rate = after_rates.get(0).toString();
					tem_date = start_days.get(0).toString();

				} else {

					tem_rate = after_rates.get(i).toString();
					tem_date = start_days.get(i).toString();
					// temp_pre_date = start_days.get(i - 1).toString();
					temp_pre_date = predate;
					tem_pre_rate = before_rates.get(i).toString();

				}

				if ("3".equals(ht.get("ajdustStyle").toString())) {
					tem_date = ToolUtil.getYearFirstDate(tem_date);
				}

				// G17*(E11-E10)*(B24-B14)/360+G17*(E12-E11)*(B24-B14)/360+G17*(E14-E12)*(B24-B14)/360

				long ds = ToolUtil.getDateDiff(temp_pre_date, tem_date);
				double jgRate = Double.parseDouble(tem_rate)
						- Double.parseDouble(tem_pre_rate);
				double dtotalInter = jgRate / 100 * ds;

				System.out.println(dtotalInter);
				tem_interest = String.valueOf(dtotalInter
						+ Double.parseDouble(tem_interest));
			}
			// tem_interest = Tools.formatNumberDoubleTwo(tem_interest);
			System.out.println("tem_interest" + tem_interest);
			System.out.println(after_rates.get(after_rates.size() - 1)
					.toString()
					+ "==" + tem_date);

			// 当期的间隔利息计算 （当期时间－上次调息的日期）×新的利率

			// long ds_1 = ToolUtil.getDateDiff(txrq, start_days.get(
			// start_days.size() - 1).toString());

			long ds_1 = ToolUtil.getDateDiff(predate, txrq);
			double jgRate = Double.parseDouble(rateValue)
					- Double.parseDouble(after_rates
							.get(after_rates.size() - 1).toString());
			String first_interest = String.valueOf(ds_1 * (jgRate / 100));

			// long ds_d = ToolUtil.getDateDiff(dqdate, txrq);
			// first_interest = String.valueOf(Double
			// .parseDouble(first_interest)
			// + ds_d * Double.parseDouble(rateValue) / 100);

			first_interest = Tools.formatNumberDoubleTwo(String.valueOf((Double
					.parseDouble(first_interest) + Double
					.parseDouble(tem_interest))
					* dto));
			String totalCount = frp.getTotalCount(contract_id);

			// 新的租金
			newRent = Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(first_corpus)
					* (1 + Double.parseDouble(rateValue) / 100
							* Integer.parseInt(totalCount) / 12
							* Integer.parseInt(income_number_year))
					/ (Integer.parseInt(totalCount)
							- Integer.parseInt(start_term) + 1)
					+ Double.parseDouble(first_interest)), Integer
					.parseInt(rentScale));

		} else {// 正常时的一次调息时

			String income_number_year = ht.get("income_number_year").toString();

			String totalCount = frp.getTotalCount(contract_id);

			// 求间隔差额值

			long jgDay = ToolUtil.getDateDiff(predate, txrq);
			String equipAmt = ht.get("equip_amt").toString();
			if (Double.parseDouble(year_rate) < 0.0000000000001) {
				year_rate = ht.get("year_rate").toString();
			}
			double jgInter = Double.parseDouble(equipAmt)
					* (jgDay)
					* (Double.parseDouble(rateValue) - Double
							.parseDouble(year_rate)) / 100 / 360;

			// 新的租金
			newRent = Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(first_corpus)
					* (1 + Double.parseDouble(rateValue) / 100
							* Integer.parseInt(totalCount) / 12
							* Integer.parseInt(income_number_year))
					/ (Integer.parseInt(totalCount)
							- Integer.parseInt(start_term) + 1) + jgInter),
					Integer.parseInt(rentScale));

		}

		// 得到原来本金
		old_corpus = frp.getDqCorpus(contract_id, start_term);

		// 得到新的利息
		newInterest = Tools.formatNumberDoubleTwo(String.valueOf(Double
				.parseDouble(newRent)
				- Double.parseDouble(old_corpus)));

		// 更新第一期的租金计划信息
		frp.updateSignMarkerPlan(contract_id, start_term, newRent, newInterest,
				rateValue);

	}


	@SuppressWarnings("static-access")
	private String evalSetGrace(String contract_id, String txrq,
			String rateValue, Hashtable ht, String start_term_temp)
			throws Exception, SQLException {
		// /////
		for (int i = 1; i <= Integer.parseInt(ht.get("grace").toString()); i++) {// 循环处理宽限期的租金计划

			// 市场
			FundRentPlan frp = new FundRentPlan();
			String dqzj = frp.getDqZj(contract_id, start_term_temp);
			String equip_amt = Tools.formatNumberDoubleTwo(ht.get("equip_amt")
					.toString());
			String oldYearRate = ht.get("year_rate").toString();
			String newRent = "0";

			oldYearRate = frp.getPreRate(contract_id, start_term_temp);
			if ("0".equals(oldYearRate)) {
				oldYearRate = ht.get("year_rate").toString();
			}

			String rentScale = ht.get("rentScale").toString();

			if (i == 1) {// 第一期时,次日是，次年分段计

				String dqdate = frp.getDqDate(contract_id, start_term_temp);
				// 间隔天数
				String days = String
						.valueOf(ToolUtil.getDateDiff(dqdate, txrq));
				String rates = Tools.formatNumberDoubleScale(String
						.valueOf((Double.parseDouble(rateValue) - Double
								.parseDouble(oldYearRate)) / 100 / 360), 12);
				// 新的租金
				newRent = Tools.formatNumberDoubleScale(String.valueOf(Double
						.parseDouble(days)
						* Double.parseDouble(rates)
						* Double.parseDouble(equip_amt)
						+ Double.parseDouble(dqzj)), Integer
						.parseInt(rentScale));
			} else {

				// rateValue
				String income_number_year = ht.get("income_number_year")
						.toString();
				ToolUtil tu = new ToolUtil();
				String preRate = tu.getPreRate(rateValue, income_number_year);
				// 新的租金
				newRent = Tools.formatNumberDoubleScale(String.valueOf(Double
						.parseDouble(preRate)
						* Double.parseDouble(equip_amt)), Integer
						.parseInt(rentScale));

			}

			// 得到原来本金
			String old_corpus = frp.getDqCorpus(contract_id, start_term_temp);

			// 得到新的利息
			String newInterest = Tools.formatNumberDoubleTwo(String
					.valueOf(Double.parseDouble(newRent)
							- Double.parseDouble(old_corpus)));
			// 更新第一期的租金计划信息
			frp.updateSignMarkerPlan(contract_id, start_term_temp, newRent,
					newInterest, rateValue);

			start_term_temp = String
					.valueOf(Integer.parseInt(start_term_temp) + 1);
		}
		return start_term_temp;
	}


	/**
	 * 其他期次的租金 处理 市场 平息法
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param rateValue
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceCROhterMarketBySet(String contract_id, String start_term,
			String rateValue) throws Exception {
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);

		FundRentPlan frp = new FundRentPlan();
		String total = frp.getTotalCount(contract_id);
		String rem_rent_list = String.valueOf(Integer.parseInt(total)
				- Integer.parseInt(start_term));

		String rentScale = ci.getRentScale(contract_id);
		String income_number_year = mp.get("income_number_year").toString();

		SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
		// 算出新的租金list
		// 租金列表 新的租金只跟新利率有关 新的租金list
		List rent_list = slrcu.getRentListByCount(mp.get("equip_amt")
				.toString(), total, rateValue, income_number_year, rentScale,
				rem_rent_list);

		// 市场的利息列表,注意市场的测算本金与财务的不一样

		// 利息小数位
		String newScale = "2";
		// 得到本金list
		List l_corpus_market = frp.getCorpsMarker(contract_id, String
				.valueOf(Integer.parseInt(start_term) + 1));
		// 得到新的利息
		List inter_list = slrcu.getInterMarket(rent_list, l_corpus_market,
				newScale);

		// 更新租金计划表
		frp.updateMarkerPlanBySet(contract_id, String.valueOf(Integer
				.parseInt(start_term) + 1), rent_list, inter_list, rateValue);

		// 修改市场的irr
		MarkerRentPlan mrp = new MarkerRentPlan();
		// 从前一期开始得到现金流
		mrp.processMarketIrr(contract_id, String.valueOf(Integer
				.parseInt(start_term) - 1));

	}


	/**
	 * 2010-12-09 更新市场的第一期租金计划信息 平息法时 次年 次月
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws SQLException
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceFirstRentPlanBySetCYAndCN(String contract_id, String txrq,
			String start_term, String rateValue) throws SQLException, Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		String start_term_temp = new String(start_term);

		if (ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term_temp)) {// 有宽限期时

			// /////
			for (int i = 1; i <= Integer.parseInt(ht.get("grace").toString()); i++) {// 循环处理宽限期的租金计划

				// 市场
				FundRentPlan frp = new FundRentPlan();
				String equip_amt = Tools.formatNumberDoubleTwo(ht.get(
						"equip_amt").toString());

				String oldYearRate = ht.get("year_rate").toString();
				oldYearRate = frp.getPreRate(contract_id, start_term_temp);
				if ("0".equals(oldYearRate)) {
					oldYearRate = ht.get("year_rate").toString();
				}
				String rentScale = ht.get("rentScale").toString();
				String income_number_year = ht.get("income_number_year")
						.toString();
				String newRent = "0";

				if (i == 1) {
					String predate = frp.getPreDate(contract_id,
							start_term_temp);
					String sdate = txrq;
					sdate = txrq;
					// 间隔天数
					String days = String.valueOf(ToolUtil.getDateDiff(sdate,
							predate));
					// 利率差值
					String rates = Tools
							.formatNumberDoubleScale(String.valueOf((Double
									.parseDouble(rateValue) - Double
									.parseDouble(oldYearRate)) / 100 / 360), 12);

					// ///////////
					String total = String.valueOf(Integer.parseInt(frp
							.getTotalCount(contract_id))
							- Integer.parseInt(ht.get("grace").toString()));

					SetLawRentCaleUtil srcu = new SetLawRentCaleUtil();
					newRent = srcu.getRent(equip_amt, total, rateValue,
							income_number_year, rentScale);

					// 新的租金
					newRent = Tools.formatNumberDoubleScale(String
							.valueOf(Double.parseDouble(days)
									* Double.parseDouble(rates)
									* Double.parseDouble(equip_amt) * -1
									+ Double.parseDouble(newRent)), Integer
							.parseInt(rentScale));

				} else {
					ToolUtil tu = new ToolUtil();
					String preRate = tu.getPreRate(rateValue,
							income_number_year);
					// 新的租金
					newRent = Tools.formatNumberDoubleScale(String
							.valueOf(Double.parseDouble(preRate)
									* Double.parseDouble(equip_amt)), Integer
							.parseInt(rentScale));
				}

				// 得到原来本金
				String old_corpus = frp.getDqCorpus(contract_id,
						start_term_temp);

				// 得到新的利息
				String newInterest = Tools.formatNumberDoubleTwo(String
						.valueOf(Double.parseDouble(newRent)
								- Double.parseDouble(old_corpus)));
				// 更新第一期的租金计划信息
				frp.updateSignMarkerPlan(contract_id, start_term_temp, newRent,
						newInterest, rateValue);
				start_term_temp = String.valueOf(Integer
						.parseInt(start_term_temp) + 1);

			}
		} else {// 正常测算时

			getSetFirstInter(contract_id, start_term, rateValue, txrq, ht.get(
					"equip_amt").toString());

			// // 市场
			// FundRentPlan frp = new FundRentPlan();
			// String equip_amt =
			// Tools.formatNumberDoubleTwo(ht.get("equip_amt")
			// .toString());
			//
			// String oldYearRate = ht.get("year_rate").toString();
			// oldYearRate = frp.getPreRate(contract_id, start_term);
			// if ("0".equals(oldYearRate)) {
			// oldYearRate = ht.get("year_rate").toString();
			// }
			//
			// String rentScale = ht.get("rentScale").toString();
			// // String ajdustStyle = ht.get("ajdustStyle").toString();
			// String predate = frp.getPreDate(contract_id, start_term);
			// String sdate = txrq;
			// // if ("3".equals(ajdustStyle)) {
			// // // 根据调息日得到他的下一年
			// // sdate = ToolUtil.getYearFirstDate(txrq);
			// // }
			// // if ("1".equals(ajdustStyle)) {
			// // //月的第一天
			// // sdate = ToolUtil.getFirstDayByDate(txrq);
			// // }
			// sdate = txrq;
			// // 间隔天数
			// String days = String.valueOf(ToolUtil.getDateDiff(sdate,
			// predate));
			// // 利率差值
			// String rates = Tools.formatNumberDoubleScale(String
			// .valueOf((Double.parseDouble(rateValue) - Double
			// .parseDouble(oldYearRate)) / 100 / 360), 12);
			//
			// // ///////////
			// String total = frp.getTotalCount(contract_id);
			//
			// String income_number_year =
			// ht.get("income_number_year").toString();
			// SetLawRentCaleUtil srcu = new SetLawRentCaleUtil();
			// String newRent = srcu.getRent(equip_amt, total, rateValue,
			// income_number_year, rentScale);
			//
			// // 新的租金
			// newRent = Tools.formatNumberDoubleScale(String.valueOf(Double
			// .parseDouble(days)
			// * Double.parseDouble(rates)
			// * Double.parseDouble(equip_amt)
			// * -1 + Double.parseDouble(newRent)), Integer
			// .parseInt(rentScale));
			//
			// // 得到原来本金
			// String old_corpus = frp.getDqCorpus(contract_id, start_term);
			//
			// // 得到新的利息
			// String newInterest = Tools.formatNumberDoubleTwo(String
			// .valueOf(Double.parseDouble(newRent)
			// - Double.parseDouble(old_corpus)));
			// // 更新第一期的租金计划信息
			// frp.updateSignMarkerPlan(contract_id, start_term, newRent,
			// newInterest, rateValue);

		}

	}

}
