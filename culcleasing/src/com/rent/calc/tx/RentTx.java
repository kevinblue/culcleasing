package com.rent.calc.tx;

/**
 * 调息时的租金测算
 */
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.Tools;

public class RentTx {

	
	/**
	 * 等额租金时的每一期的租金测算方法
	 * 
	 * @param Rate
	 * @param Nper
	 * @param Pv
	 * @param Fv
	 * @param Type
	 * @return
	 */
	public static String getPMT(String Rate, String Nper, String Pv, String Fv,
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
					new BigDecimal("-1")).divide(new BigDecimal(Nper), 2,
					BigDecimal.ROUND_HALF_UP))).toString();
		}

		BigDecimal Pv_B = new BigDecimal(Pv);
		BigDecimal Nper_B = new BigDecimal(Nper);
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
	 * 等额租金 添加每一期的租金值在未调整时
	 * 
	 * @param rent
	 * @param income_number
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List eqRentList(String rent, String income_number, HashMap mp) {

		String rem_corpus = mp.get("rem_corpus").toString();// 剩余本金
		String sgrace = mp.get("igrace").toString();// 宽限期数
		String retu_rate = mp.get("retu_vale").toString();// 调息的新利率
		String income_number_year = mp.get("income_number_year").toString();// 年还款次数

		// 得到每一期租金的利率
		String retu_vale = CalcUtil.getPreRate(retu_rate, income_number_year);

		List l_rent = new ArrayList();
		// 有宽限期时的租金
		for (int i = 0; i < Integer.parseInt(sgrace); i++) {
			// 算出新的宽限期租金,剩余本金*新的利率值
			l_rent.add(Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(Tools.formatNumberDoubleScale(rem_corpus, 2))
					* Double.parseDouble(retu_vale)), Integer.parseInt(mp.get(
					"rentScale").toString())));
		}

		// 添加每一期的租金,根据总的期数得到所有的租信息
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			l_rent.add(rent);
		}

		return l_rent;
	}

	/**
	 * 计算利息
	 * 
	 * @param rentList
	 *            租金list
	 * @param leaseMoney
	 *            要测算的本金
	 * @param calRate
	 *            计算的利率 qzOrqm 期初还是期未,调息时（从第一期开始，或者从其他期次开始）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getInterestList(List rentList, String leaseMoney,
			String calRate, String qzOrqm,HashMap mp) {
		
		//宽限期数
		String sgrace = mp.get("igrace").toString();
		
		// 用于保留利息
		List interests = new ArrayList();
		String corpus_total = "0";
		// 该期的利息
		String inte = "";
		String corpus = "";
		String corpus_overage = "";
		// 本金余额
		corpus_overage = Tools.formatNumberDoubleScale(leaseMoney, Integer
				.parseInt(mp.get("rentScale").toString()));
		
		//宽限期利息
		for (int i = 0; i < Integer.parseInt(sgrace); i++) {
			interests.add(Double.parseDouble(leaseMoney) * Double.parseDouble(calRate));
		}
		
		//得到循环的开始日期
		int istart = Integer.parseInt(sgrace)-1;
		if (istart <0) {
			istart = 0;
		}
		

		for (int i = istart; i < rentList.size(); i++) {// 循环租金list

			if ("1".equals(qzOrqm) && i == 0) {// 第一期且是期初时
				corpus = rentList.get(i).toString();
				inte = "0";
			} else {
				// 利息
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// 剩余本金*利率
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(mp.get("rentScale").toString()));
				// 本金
				corpus = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(inte));// 租金-利息
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(mp.get("rentScale").toString()));
			}

			// 最后一期的利息=剩余的利息总合,本金仍然=租金-利息
			if (i == rentList.size() - 1) {
				// 本金 --总的本金-以前的本金和
				corpus = String.valueOf(Double.parseDouble(leaseMoney)
						- Double.parseDouble(corpus_total));
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(mp.get("rentScale").toString()));
				inte = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(corpus));
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(mp.get("rentScale").toString()));

			}

			corpus_total = String.valueOf(Double.parseDouble(corpus_total)
					+ Double.parseDouble(corpus));
			corpus_total = Tools.formatNumberDoubleScale(corpus_total, Integer
					.parseInt(mp.get("rentScale").toString()));

			// 本金余额
			corpus_overage = String.valueOf(Double.parseDouble(corpus_overage)
					- Double.parseDouble(corpus));
			corpus_overage = Tools.formatNumberDoubleScale(corpus_overage,
					Integer.parseInt(mp.get("rentScale").toString()));
			// 添加list
			interests.add(inte);

		}

		return interests;
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
	public static List getCorpusList(List rentList, List inteList,String rentScale) {
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
	 * 
	 * @param leaseMoney总的本金
	 * @param corpusList
	 *            本金
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getCorpusOvergeList(String leaseMoney, List corpusList,String rentScale) {
		String total = "0";// 累积每一期的本金
		List corps = new ArrayList();

		for (int i = 0; i < corpusList.size(); i++) {

			total = String.valueOf(Double.parseDouble(total)
					+ Double.parseDouble(corpusList.get(i).toString()));
			total = Tools.formatNumberDoubleScale(total, Integer
					.parseInt(rentScale));

			double d = Double.parseDouble(leaseMoney)
					- Double.parseDouble(total);
			corps.add(Tools.formatNumberDoubleScale(String.valueOf(d), Integer
					.parseInt(rentScale)));

		}
		return corps;
	}

	/**
	 * 得到租金偿还时间的list
	 * 
	 * @param rentList
	 * @param type
	 * @param lease_interval
	 * @param plan_date
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List getPlanDateList(List rentList, String lease_interval,
			String plan_date) {
		String start_date = plan_date;
		List l_date = new ArrayList();
		for (int i = 0; i < rentList.size(); i++) {
			l_date.add(Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), start_date));
		}

		return l_date;
	}

}
