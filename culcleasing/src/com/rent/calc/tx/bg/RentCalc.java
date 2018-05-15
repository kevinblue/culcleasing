package com.rent.calc.tx.bg;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

/**
 * 租金测算
 * 
 * @author shf
 * 
 */
public class RentCalc {

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
		@SuppressWarnings("unused")
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
	 * 得到剩余的调息期数
	 * 
	 * @param contract_id
	 * @param txrq
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public String getRemList(String contract_id, String txrq) throws Exception {

		FundRentPlan frp = new FundRentPlan();
		String minRent_list = frp.getAdjustMinRentList(contract_id, txrq);

		//

		// 调息计算期次
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);

		String ajdustStyle = mp.get("ajdustStyle").toString();
		if ("2".equals(ajdustStyle)) { // 次期时
			// 如果有宽限期时
			if (mp.get("grace") != null
					&& Integer.parseInt(mp.get("grace").toString()) >= Integer
							.parseInt(minRent_list)) {
				minRent_list = String.valueOf(Integer.parseInt(mp.get("grace")
						.toString()) + 1);

			}
		}

		String total_list = frp.getTotalCount(contract_id);

		String rem_rent_list = String.valueOf(Integer.parseInt(total_list)
				- Integer.parseInt(minRent_list) + 1);

		return rem_rent_list;
	}

	/**
	 * 得到剩余的市场本金
	 * 
	 * @param contract_id
	 * @param txrq
	 * @return
	 * @throws Exception
	 */
	public String getRemMarketCorps(String contract_id, String txrq)
			throws Exception {

		FundRentPlan frp = new FundRentPlan();
		String start_term = frp.getAdjustMinRentList(contract_id, txrq);
		String corpus = frp.getIrrFisrtSumCorpMarker(contract_id, start_term)
				.get(0).toString();
		return corpus;
	}

	/**
	 * 得到每一期的租金
	 * 
	 * @param mp
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public String getRentByPmt(String retu_vale, String contract_id, String txrq)
			throws Exception {

		// 剩本，剩余调息期数
		RentCalc rc = new RentCalc();
		String rem_rent_list = rc.getRemList(contract_id, txrq);
		String rem_corpus = rc.getRemMarketCorps(contract_id, txrq);

		// 调息计算期次
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);

		String ajdustStyle = mp.get("ajdustStyle").toString();
		if ("2".equals(ajdustStyle)) { // 次期时
			// 得到开始期次,得到总的期数 剩余期数 测算本金
			FundRentPlan frp = new FundRentPlan();
			String minRent_list = frp.getAdjustMinRentList(contract_id, txrq);
			minRent_list = String.valueOf(Integer.parseInt(minRent_list) + 1);

			// 如果有宽限期时
			if (mp.get("grace") != null
					&& Integer.parseInt(mp.get("grace").toString()) >= Integer
							.parseInt(minRent_list)) {
				minRent_list = String.valueOf(Integer.parseInt(mp.get("grace")
						.toString()) + 1);

			}
			String totalCount = frp.getTotalCount(contract_id);

			rem_rent_list = String.valueOf(Integer.parseInt(totalCount)
					- Integer.parseInt(minRent_list) + 1);
			rem_corpus = frp
					.getIrrFisrtSumCorpMarker(contract_id, minRent_list).get(0)
					.toString();

		}

		if (rem_corpus.indexOf("-") > -1) {
			rem_corpus = rem_corpus.substring(1);
		}

		String period_type = mp.get("period_type").toString();
		String income_number_year = mp.get("income_number_year").toString();
		String nominalprice = mp.get("nominalprice").toString();
		String rentScale = mp.get("rentScale").toString();
		period_type = "0";// 期末
		// 得到每一期租金的利率
		retu_vale = Tools.formatNumberDoubleScale(ToolUtil.getPreRate(
				retu_vale, income_number_year), 12);
		// 得到租金
		String rent = RentCalc.getPMT(retu_vale, rem_rent_list, "-"
				+ rem_corpus, nominalprice, period_type);
		System.out.println("新的租金 :" + rent);
		return Tools.formatNumberDoubleScale(rent, Integer.parseInt(rentScale));
	}

	/**
	 * 得到每一期的租金
	 * 
	 * @param mp
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public String getRentPLeassMoney(String retu_vale, String contract_id,
			String start_term) throws Exception {

		// 剩本，剩余调息期数

		FundRentPlan frp = new FundRentPlan();
		String total = frp.getTotalCount(contract_id);
		String rem_rent_list = String.valueOf(Integer.parseInt(total)
				- Integer.parseInt(start_term));

		String rem_corpus = frp.getTotalCorpusByQc(contract_id, start_term);

		// 调息计算期次
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);

		String period_type = mp.get("period_type").toString();
		String income_number_year = mp.get("income_number_year").toString();
		String nominalprice = mp.get("nominalprice").toString();
		String rentScale = mp.get("rentScale").toString();

		period_type = "0";// 期末
		// 得到每一期租金的利率
		retu_vale = Tools.formatNumberDoubleScale(ToolUtil.getPreRate(
				retu_vale, income_number_year), 12);
		// 得到租金
		String rent = RentCalc.getPMT(retu_vale, rem_rent_list, "-"
				+ rem_corpus, nominalprice, period_type);
		System.out.println("新的租金 :" + rent);
		return Tools.formatNumberDoubleScale(rent, Integer.parseInt(rentScale));
	}

	/**
	 * 等额租金 添加每一期的租金值在未调整时
	 * 
	 * @param rent
	 * @param income_number
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List eqRentList(String rent, String income_number) {
		List l_rent = new ArrayList();
		// 添加每一期的租金,根据总的期数得到所有的租信息
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			l_rent.add(rent);
		}

		return l_rent;
	}

}
