package com.rent.calc.tx.bg;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

/**
 * 常用计算类
 * 
 * @author shf
 * 
 */
public class CommonUtil {
	/**
	 * 
	 * @param leaseMoney总的本金
	 * @param corpusList
	 *            本金
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getCorpusOvergeList(String leaseMoney, List corpusList,
			String rentScale) {
		String total = "0";// 累积每一期的本金
		List corps = new ArrayList();

		for (int i = 0; i < corpusList.size(); i++) {

			total = String.valueOf(Double.parseDouble(total)
					+ Double.parseDouble(corpusList.get(i).toString()));
			total = Tools.formatNumberDoubleScale(total, Integer
					.parseInt(rentScale));

			double d = Double.parseDouble(leaseMoney)
					- Double.parseDouble(total);
			// 小数位会产生一定的差值
			if (d < 0) {
				d = 0;
			}
			corps.add(Tools.formatNumberDoubleScale(String.valueOf(d), Integer
					.parseInt(rentScale)));

		}
		return corps;
	}

	/**
	 * 添加每一期的本金
	 * 
	 * @param rentList
	 *            租金
	 * @param inteList
	 *            利息
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getCorpusList(List rentList, List inteList,
			String rentScale) {
		List corpus_list = new ArrayList();

		for (int i = 0; i < rentList.size(); i++) {

			corpus_list.add(Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(rentList.get(i).toString())
					- Double.parseDouble(inteList.get(i).toString())), Integer
					.parseInt(rentScale)));
		}
		return corpus_list;
	}

	/**
	 * 计算利息
	 * 
	 * @param rentList
	 * @param leaseMoney
	 * @param calRate
	 * @param qzOrqm
	 * @param rentScale
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getInterestList(List rentList, String leaseMoney,
			String calRate, String qzOrqm, String rentScale) {

		// 用于保留利息
		List interests = new ArrayList();
		String corpus_total = "0";
		// 该期的利息
		String inte = "";
		String corpus = "";
		String corpus_overage = "";
		// 本金余额
		corpus_overage = Tools.formatNumberDoubleScale(leaseMoney, Integer
				.parseInt(rentScale));

		for (int i = 0; i < rentList.size(); i++) {// 循环租金list

			if ("1".equals(qzOrqm) && i == 0) {// 第一期且是期初时
				corpus = rentList.get(i).toString();
				inte = "0";
			} else {
				// 利息
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// 剩余本金*利率
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(rentScale));
				// 本金
				corpus = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(inte));// 租金-利息
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(rentScale));
			}

			// 最后一期的利息=剩余的利息总合,本金仍然=租金-利息
			if (i == rentList.size() - 1) {
				// 本金 --总的本金-以前的本金和
				corpus = String.valueOf(Double.parseDouble(leaseMoney)
						- Double.parseDouble(corpus_total));
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(rentScale));
				inte = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(corpus));
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(rentScale));

			}

			corpus_total = String.valueOf(Double.parseDouble(corpus_total)
					+ Double.parseDouble(corpus));
			corpus_total = Tools.formatNumberDoubleScale(corpus_total, Integer
					.parseInt(rentScale));

			// 本金余额
			corpus_overage = String.valueOf(Double.parseDouble(corpus_overage)
					- Double.parseDouble(corpus));
			corpus_overage = Tools.formatNumberDoubleScale(corpus_overage,
					Integer.parseInt(rentScale));
			// 添加list
			interests.add(inte);

		}

		return interests;
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
	public static String getFirstInterestDetail(String preRate, String rate,
			String txrq, String preDate, String dqDate, String leaseMoney) {

		// 得到天数,调息日到调息前一期的天数
		long preDays = ToolUtil.getDateDiff(txrq, preDate);
		long afterDays = ToolUtil.getDateDiff(dqDate, txrq);

		// 几个日期值得到第一期相应的利息
		// (G19*$E$10/360*(B11-B19))+(G19*$E$11/360)*(B20-B11)
		double dtotalInter = Double.parseDouble(leaseMoney)
				* Double.parseDouble(preRate) / 100 / 360 * preDays
				+ Double.parseDouble(leaseMoney) * Double.parseDouble(rate)
				/ 360 / 100 * afterDays;

		return Tools.formatNumberDoubleScale(String.valueOf(dtotalInter), 4);
	}

	/**
	 * 第一期利息
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @param leassMoney
	 * @return
	 * @throws Exception
	 *             2010-12-30 修改 分段计息
	 */
	@SuppressWarnings("static-access")
	public static String getFirstInterest(String contract_id, String txrq,
			String start_term, String rateValue, String leassMoney)
			throws Exception {

		// 第一期利息
		FundRentPlan frp = new FundRentPlan();
		String dqdate = frp.getDqDate(contract_id, start_term);
		String predate = frp.getPreDate(contract_id, start_term);

		// 得到原利率
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		
		//如果是从第一期 开始则前一期的日期为起租日期
		if (predate.equals("0")) {
			predate=ht.get("start_date").toString();
		}

		// /2010-12-30 修改
		// 查询是在当期是否有调息记录
		FundAdjustInter fai = new FundAdjustInter();
		Hashtable ht_recoder = fai.searcherRecoder(contract_id, start_term, ht
				.get("ajdustStyle").toString());

		String first_interest = "0";
		List start_dates = (List) ht_recoder.get("start_date");

		if (!ht_recoder.isEmpty() && start_dates.size() > 0) {// 得到调息记录 分段计息

			// 如果是次年时
			if (null != ht.get("ajdustStyle").toString()
					&& "3".equals(ht.get("ajdustStyle").toString())) {

//				// 得到调息的最新利率
//				List after_rates = (List) ht_recoder.get("after_rate");
//				String year_rate = after_rates.get(after_rates.size() - 1)
//						.toString();
				
				// 得到调息的最原始利率20110222修改
//				List before_rate = (List) ht_recoder.get("before_rate");
//				String year_rate = before_rate.get(0)
//				.toString();
				
				//得到上一期的利率值来计算
				String year_rate=frp.getPreRateByCN(contract_id, start_term);
				first_interest = getFirstInterestDetail(year_rate, rateValue,
						txrq, predate, dqdate, leassMoney);
				
				

			} else if (ht.get("grace") != null
					&& Integer.parseInt(ht.get("grace").toString()) >= Integer
							.parseInt(start_term)) {// 有宽限期时 // 宽限期多次调息时

				// ((B11-B17)*E10+(B12-B11)*E11+(B18-B12)*E12)/(B18-B17)*G13/12*1
				// 求上下两期的天数,构建被除数
				String income_number_year = ht.get("income_number_year")
						.toString();
				long days = ToolUtil.getDateDiff(dqdate, predate);
				Double dto = Double.parseDouble(leassMoney) / days / 12
						* Integer.parseInt(income_number_year);

				// 算间隔利利息值

				List start_days = (List) ht_recoder.get("start_date");
				List before_rates = (List) ht_recoder.get("before_rate");
				List after_rates = (List) ht_recoder.get("after_rate");

				// 刚开始用前一期日期与调息记录中的日期计算
				String temp_pre_date = predate;
				String tem_rate = "0";
				String tem_date = start_dates.get(0).toString();
				String tem_interest = "0";

				for (int i = 0; i < start_days.size(); i++) {
					if (i == 0) {// 第一期时取最原始的利率来算
						tem_rate = before_rates.get(0).toString();
						tem_date = start_days.get(0).toString();

					} else {

						tem_rate = before_rates.get(i).toString();
						tem_date = start_days.get(i).toString();
						temp_pre_date = start_days.get(i - 1).toString();

					}

					long ds = ToolUtil.getDateDiff(tem_date, temp_pre_date);
					double dtotalInter = Double.parseDouble(tem_rate) * ds
							/ 100;

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

				long ds_1 = ToolUtil.getDateDiff(txrq, start_days.get(
						start_days.size() - 1).toString());
				first_interest = String.valueOf(ds_1
						* Double.parseDouble(after_rates.get(
								after_rates.size() - 1).toString()) / 100);

				long ds_d = ToolUtil.getDateDiff(dqdate, txrq);

				first_interest = String.valueOf(Double
						.parseDouble(first_interest)
						+ ds_d * Double.parseDouble(rateValue) / 100);
				first_interest = Tools.formatNumberDoubleTwo(String
						.valueOf((Double.parseDouble(first_interest) + Double
								.parseDouble(tem_interest))
								* dto));

			} else {

				first_interest = subselection(txrq, rateValue, leassMoney,
						dqdate, predate, ht_recoder);
			}

		} else {
			// /ht.get("year_rate").toString()
			String year_rate = frp.getPreRate(contract_id, start_term);

			if (Double.parseDouble(year_rate) < 0.0000000000001) {
				year_rate = ht.get("year_rate").toString();
			}

			if (ht.get("grace") != null
					&& Integer.parseInt(ht.get("grace").toString()) >= Integer
					.parseInt(start_term) && ("1".equals(ht.get("ajdustStyle").toString())
					|| "0".equals(ht.get("ajdustStyle").toString()))) {// 次月,次日时
				String income_number_year = ht.get("income_number_year")
						.toString();
				long preDays = ToolUtil.getDateDiff(txrq, predate);
				long afterDays = ToolUtil.getDateDiff(dqdate, txrq);
				long preDq = ToolUtil.getDateDiff(dqdate, predate);
				first_interest = Tools.formatNumberDoubleScale(
						String.valueOf((preDays * Double.parseDouble(year_rate)
								/ 100 + afterDays
								* Double.parseDouble(rateValue) / 100)
								/ preDq
								/ 12
								* Integer.parseInt(income_number_year)
								* Double.parseDouble(leassMoney)), 4);

			} else {
			
				first_interest = getFirstInterestDetail(year_rate, rateValue,
						txrq, predate, dqdate, leassMoney);
			}

		}

		return first_interest;

	}

	/**
	 * 分段计算计算
	 * 
	 * @param txrq
	 * @param rateValue
	 * @param leassMoney
	 * @param dqdate
	 * @param predate
	 * @param ht_recoder
	 * @return
	 */
	private static String subselection(String txrq, String rateValue,
			String leassMoney, String dqdate, String predate,
			Hashtable ht_recoder) {
		String first_interest = "0";
		List start_dates = (List) ht_recoder.get("start_date");
		List before_rates = (List) ht_recoder.get("before_rate");
		List after_rates = (List) ht_recoder.get("after_rate");
		// 刚开始用前一期日期与调息记录中的日期计算
		String temp_pre_date = predate;
		String tem_rate = "0";
		String tem_date = start_dates.get(0).toString();
		String tem_interest = "0";
		// String leaseMoney = "100";

		for (int i = 0; i < start_dates.size(); i++) {
			if (i == 0) {// 第一期时取最原始的利率来算
				tem_rate = before_rates.get(0).toString();
				tem_date = start_dates.get(0).toString();

			} else {

				tem_rate = before_rates.get(i).toString();
				tem_date = start_dates.get(i).toString();
				temp_pre_date = start_dates.get(i - 1).toString();

			}

			long days = ToolUtil.getDateDiff(tem_date, temp_pre_date);
			double dtotalInter = Double.parseDouble(leassMoney)
					* Double.parseDouble(tem_rate) / 100 / 360 * days;

			System.out.println(dtotalInter);
			tem_interest = String.valueOf(dtotalInter
					+ Double.parseDouble(Tools
							.formatNumberDoubleTwo(tem_interest)));
		}
		tem_interest = Tools.formatNumberDoubleTwo(tem_interest);
		System.out.println("tem_interest" + tem_interest);

		System.out.println(after_rates.get(after_rates.size() - 1).toString()
				+ "==" + tem_date);

		// 当期的间隔利息计算
		first_interest = getFirstInterestDetail(after_rates.get(
				after_rates.size() - 1).toString(), rateValue, txrq, tem_date,
				dqdate, leassMoney);
		first_interest = Tools.formatNumberDoubleTwo(String.valueOf(Double
				.parseDouble(first_interest)
				+ Double.parseDouble(tem_interest)));
		return first_interest;
	}

	public static void main(String[] args) {
		Hashtable ht_recoder = new Hashtable();

		List start_date = new ArrayList();
		List before_rate = new ArrayList();
		List after_rate = new ArrayList();

		start_date.add("2010-10-20");
		start_date.add("2010-10-25");
		start_date.add("2010-10-30");
		start_date.add("2010-11-05");

		before_rate.add("7.490000");
		before_rate.add("7.500000");
		before_rate.add("7.52000");
		before_rate.add("7.530000");

		after_rate.add("7.50000");
		after_rate.add("7.52000");
		after_rate.add("7.530000");
		after_rate.add("7.550000");

		ht_recoder.put("start_date", start_date);
		ht_recoder.put("before_rate", before_rate);
		ht_recoder.put("after_rate", after_rate);

		List start_dates = (List) ht_recoder.get("start_date");
		List before_rates = (List) ht_recoder.get("before_rate");
		List after_rates = (List) ht_recoder.get("after_rate");
		// 刚开始用前一期日期与调息记录中的日期计算
		String temp_pre_date = "2010-10-15";
		String tem_rate = "0";
		String tem_date = start_dates.get(0).toString();
		String tem_interest = "0";
		String leaseMoney = "100";

		for (int i = 0; i < start_dates.size(); i++) {
			if (i == 0) {// 第一期时取最原始的利率来算
				tem_rate = before_rates.get(0).toString();
				tem_date = start_dates.get(0).toString();

			} else {

				tem_rate = before_rates.get(i).toString();
				tem_date = start_dates.get(i).toString();
				temp_pre_date = start_dates.get(i - 1).toString();

			}

			long days = ToolUtil.getDateDiff(tem_date, temp_pre_date);
			double dtotalInter = Double.parseDouble(leaseMoney)
					* Double.parseDouble(tem_rate) / 100 / 360 * days;

			System.out.println(dtotalInter);
			tem_interest = String.valueOf(dtotalInter
					+ Double.parseDouble(Tools
							.formatNumberDoubleTwo(tem_interest)));
		}
		tem_interest = Tools.formatNumberDoubleTwo(tem_interest);
		System.out.println("tem_interest" + tem_interest);

		System.out.println(after_rates.get(after_rates.size() - 1).toString()
				+ "==" + tem_date);
		// String first_interest =
		// getFirstInterestDetail(after_rates.get(after_rates.size()-1).toString(),
		// rateValue, txrq, tem_date, dqdate, leassMoney);

	}

}
