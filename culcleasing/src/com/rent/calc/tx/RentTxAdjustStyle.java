package com.rent.calc.tx;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.Tools;

import dbconn.Conn;

/**
 * 按租金变更的方式来调息时
 * 
 * @author shf
 * 
 */
public class RentTxAdjustStyle {

	/**
	 * 
	 * @param mp
	 *            调息合同的包含的调息信息
	 * @throws Exception
	 * 
	 */
	public void calRentByAdjustStyle(HashMap mp) throws Exception {
		// // 按次日,按次月,按次期,按次年,平息法 0,1,2,3,4
		String contract_id = mp.get("proj_id").toString();
		String ajdustStyle = mp.get("ajdustStyle").toString(); // 调整方式

		String start_date = mp.get("start_date").toString();

		// 得到新的租金
		RentTx rtx = new RentTx();
		String rent = "";

		List retn_list = new ArrayList(); // 租金list
		List retn_list_new = new ArrayList(); // 租金list
		List cash_list = new ArrayList(); // 现金流list
		List interest_list = new ArrayList(); // 利息list
		List interest_list_new = new ArrayList(); // 利息list

		List l_inte_mark = new ArrayList(); // 市场利息list
		List l_inte_mark_new = new ArrayList(); // 市场利息list

		String nextTerm = mp.get("nextTerm").toString();
		String qzOrqm = mp.get("period_type").toString();
		String income_number_year = mp.get("income_number_year").toString();
		// 判断是不是第一期
		if (!"1".equals(nextTerm)) {// 不是从第一期,开始调
			qzOrqm = "-1";
		}
		System.out.println("剩余本金：" + mp.get("rem_corpus").toString());

		// 得到第一期利息计算本金 次年时
		// hmp.put("corpus_market_first", rs.getString("corpus_market_first"));
		// hmp.put("rem_corpus_first", rs.getString("rem_corpus_first"));

		HashMap hmp_first = getFirstCalcCorps(start_date, contract_id,nextTerm);
		String corpus_market_first = hmp_first.get("corpus_market_first")
				.toString();
		String rem_corpus_first = hmp_first.get("rem_corpus_first").toString();

		// irr
		String irr = "";
		rent = CalcUtil.getRentByPmt(mp);

		// 计算市场的【市场本金，市场利息，市场本金余额】

		String retu_vale = mp.get("retu_vale").toString();
		// 得到每一期租金的利率
		retu_vale = CalcUtil.getPreRate(retu_vale, income_number_year);

		// 市场的利息列表,注意市场的测算本金与财务的不一样
		System.out.println("市场的剩余本金是：" + mp.get("corpus_market").toString());

		if ("2".equals(ajdustStyle)) {// 如果是次期时

			// 得到租金List,有宽限期则包含宽限期,如果是其他的rem_rent_list要减一，租金添加当前期
			retn_list = rtx.eqRentList(rent,
					mp.get("rem_rent_list").toString(), mp);

			// 因为现金流是算出所有的现金流,///添加所有的前期款
			cash_list = CalcUtil.getCashList(contract_id, nextTerm, mp.get(
					"period_type").toString(), retn_list, mp);

			// irr
			irr = IrrCalc.getIRR(cash_list, income_number_year,
					income_number_year, String.valueOf(12 / Integer
							.parseInt(income_number_year)));
			irr = Tools.formatNumberDoubleScale(irr, 8);

			System.out.println("财务的irr：" + irr);
			String srate = Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(irr)
					/ (12 / Integer.parseInt(income_number_year))), 8);

			// //
			// 得到利息列表,财务,如果是其他的租金 调整 方法 不妨在这里手动添加一期的利息
			interest_list = rtx.getInterestList(retn_list, mp.get("rem_corpus")
					.toString(), srate, qzOrqm, mp);

			// 市场利息
			l_inte_mark = rtx.getInterestList(retn_list, mp
					.get("corpus_market").toString(), retu_vale, qzOrqm, mp);

		} else if ("4".equals(ajdustStyle)) {// ajdustStyle 为4 平息法时

		} else { // // 按次日,按次月,按次年 0,1,3

			// 得到租金List
			// 租金添加当前期getDqZj
			retn_list.add(getDqZj(contract_id, nextTerm));
			retn_list_new = rtx.eqRentList(rent, String.valueOf(Integer
					.parseInt(mp.get("rem_rent_list").toString())), mp);

			// 因为现金流是算出所有的现金流,///添加所有的前期款
			cash_list = CalcUtil.getCashList(contract_id, String
					.valueOf(Integer.parseInt(nextTerm) + 1), mp.get(
					"period_type").toString(), retn_list_new, mp);

			// irr
			irr = IrrCalc.getIRR(cash_list, income_number_year,
					income_number_year, String.valueOf(12 / Integer
							.parseInt(income_number_year)));
			irr = Tools.formatNumberDoubleScale(irr, 8);

			System.out.println("财务的irr：" + irr);

			// //
			// 得到利息列表,财务,如果是其他的租金 调整 方法 不妨在这里手动添加一期的利息
			// 添加第一期的利息
			// 得到前一 期的日期
			
		
			String preDate = getPreDate(contract_id, nextTerm);
			String interest_firest = "0";
			String interest_firest_mark = "0";

			String dqDate = mp.get("plan_date_first").toString();

			if ("0".equals(ajdustStyle)) {// 次日时

				interest_firest = getFirstInterest(irr, start_date, preDate,
						dqDate, rem_corpus_first);

				String srate = Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(mp.get("retu_vale")
								.toString()) / 100), 8);

				interest_firest_mark = getFirstInterest(srate, start_date,
						preDate, dqDate, corpus_market_first);

			} else if ("1".equals(ajdustStyle)) {// 次月时

				// 根据起租日得到下一个月时
				start_date = getFirstDayByDate(start_date);

				interest_firest = getFirstInterest(irr, start_date, preDate,
						dqDate,rem_corpus_first);

				String srate = Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(mp.get("retu_vale")
								.toString()) / 100), 8);

				interest_firest_mark = getFirstInterest(srate, start_date,
						preDate, dqDate, corpus_market_first);

			} else if ("3".equals(ajdustStyle)) {// 次年时

				// 根据起租日得到下一个月时
				start_date = getYearFirstDate(start_date);

				String srate = Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(mp.get("retu_vale")
								.toString()) / 100), 8);

				interest_firest = getFirstInterest(irr, start_date, preDate,
						dqDate, rem_corpus_first);
				interest_firest_mark = getFirstInterest(srate, start_date,
						preDate, dqDate, corpus_market_first);

			}
			interest_list.add(interest_firest);
			l_inte_mark.add(interest_firest_mark);

			interest_list_new = rtx.getInterestList(retn_list_new, mp.get(
					"rem_corpus").toString(), String.valueOf(Double
					.parseDouble(irr)
					/ (12 / Integer.parseInt(income_number_year))), qzOrqm, mp);

			// 市场利息
			l_inte_mark_new = rtx.getInterestList(retn_list_new, mp.get(
					"corpus_market").toString(), retu_vale, qzOrqm, mp);

			// 添加真实的list信息
			for (int i = 0; i < retn_list_new.size(); i++) {
				retn_list.add(retn_list_new.get(i));
				interest_list.add(interest_list_new.get(i));
				l_inte_mark.add(l_inte_mark_new.get(i));
			}
		}

		// ////////////////////////////////////
		// 财务
		// 得到每一期的本金
		List corp_list = RentTx.getCorpusList(retn_list, interest_list, mp.get(
				"rentScale").toString());

		// 得到每一期的本金余额
		List corp__overage_list = RentTx.getCorpusOvergeList(mp.get(
				"rem_corpus").toString(), corp_list, mp.get("rentScale")
				.toString());

		// /////////////////////////////////////////////

		// 市场
		// 市场本金
		List l_corpus_market = RentTx.getCorpusList(retn_list, l_inte_mark, mp
				.get("rentScale").toString());
		// 市场本金余额
		List l_corpus_overage_market = RentTx.getCorpusOvergeList(mp.get(
				"corpus_market").toString(), l_corpus_market, mp.get(
				"rentScale").toString());

		// 公共，最后
		// 打印调息结果信息
		CalcUtil.printRentInfo(retn_list, interest_list, corp_list,
				corp__overage_list, l_inte_mark, l_corpus_market,
				l_corpus_overage_market);

		// 更新租金表
		CalcUtil.updateRentPlan(retn_list, interest_list, corp_list,
				corp__overage_list, l_inte_mark, l_corpus_market,
				l_corpus_overage_market, mp.get("proj_id").toString(), mp.get(
						"nextTerm").toString());

	}

	/**
	 * 算出第一期的利息
	 * 
	 * @param rate
	 *            利率或irr值
	 * @param txrq
	 *            调息日
	 * @param preDate
	 *            小于调息日的前一期时间
	 * @param dqDate
	 *            大于调息日的后一期时间即调息开始期的时间
	 * @param leaseMoney
	 *            测算的剩余本金
	 * @return
	 */
	public String getFirstInterest(String rate, String txrq, String preDate,
			String dqDate, String leaseMoney) {

		// 得到天数,调息日到调息前一期的天数
		long preDays = CalcUtil.getDateDiff(txrq, preDate);

		long afterDays = CalcUtil.getDateDiff(dqDate, txrq);

		// 几个日期值得到第一期相应的利息
		// (G19*$E$10/360*(B11-B19))+(G19*$E$11/360)*(B20-B11)
		double dtotalInter = Double.parseDouble(leaseMoney)
				* Double.parseDouble(rate) / 360 * preDays
				+ Double.parseDouble(leaseMoney) * Double.parseDouble(rate)
				/ 360 * afterDays;

		return Tools.formatNumberDoubleScale(String.valueOf(dtotalInter), 4);
	}

	/**
	 * 得到一个月的第一天
	 * 
	 * @return
	 */
	public String getFirstDayByDate(String date) {
		String rdate = CalcUtil.getDateAdd(date, 1, "mm");
		rdate = rdate.substring(0, rdate.length() - 2) + "01";
		return rdate;
	}

	/**
	 * 根据调息日期取得下一期日期的次年的第一天
	 * 
	 * @param txrq
	 *            调息日期
	 * @return
	 */
	public String getYearFirstDate(String txrq) {

		String rdate = CalcUtil.getDateAdd(txrq, 1, "yy");
		rdate = rdate.substring(0, 4) + "-01-01";
		return rdate;

	}

	/**
	 * 查询当前期的租金
	 * 
	 * @param contract_id
	 * @param nextTerm
	 * @return
	 * @throws Exception
	 */
	public String getDqZj(String contract_id, String nextTerm) throws Exception {
		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;

		// 查出交易结构表中的流入流出数据
		String sql = "select rent from fund_rent_plan where contract_id='"
				+ contract_id + "' and rent_list ='" + nextTerm + "'";
		rs = conn.executeQuery(sql);
		String rent = "0";
		if (rs.next()) {
			rent = rs.getString(1);
		}
		rs.close();
		conn.close();
		return rent;
	}

	/**
	 * 查询当前期的前一期的日期
	 * 
	 * @param contract_id
	 * @param nextTerm
	 * @return
	 * @throws Exception
	 */
	public String getPreDate(String contract_id, String nextTerm)
			throws Exception {
		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;

		// 查出交易结构表中的流入流出数据
		String sql = "select convert(varchar(120),plan_date,120) plan_date from fund_rent_plan where contract_id='"
				+ contract_id
				+ "' and rent_list ='"
				+ (Integer.parseInt(nextTerm) - 1) + "'";
		rs = conn.executeQuery(sql);
		String preDate = "0";
		if (rs.next()) {
			preDate = rs.getString(1);
		}
		rs.close();
		conn.close();
		return preDate;
	}

	/**
	 * 次年时得到第一期利息计算的本金
	 * 
	 * @param startDate
	 * @param contract_id
	 * @return
	 * @throws Exception
	 */

	public HashMap getFirstCalcCorps(String startDate, String contract_id,String nextTerm)
			throws Exception {

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;

		// 查出交易结构表中的流入流出数据
		String sql = "select isnull(sum(corpus_market),0) corpus_market_first, isnull(sum(corpus),0) rem_corpus_first from fund_rent_plan where contract_id='"
				+ contract_id
				+ "' and rent_list >='"
				+ nextTerm + "' and plan_status='未回笼' ";
		rs = conn.executeQuery(sql);
		HashMap hmp = new HashMap();

		if (rs.next()) {
			hmp.put("corpus_market_first", rs.getString("corpus_market_first"));
			hmp.put("rem_corpus_first", rs.getString("rem_corpus_first"));
		}

		rs.close();
		conn.close();
		return hmp;

	}

}
