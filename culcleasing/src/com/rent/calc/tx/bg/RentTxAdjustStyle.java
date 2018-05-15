package com.rent.calc.tx.bg;

import java.util.Hashtable;

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
	public void calRentByAdjustStyle(String contract_id, String txrq,
			String start_term, String rateValue, String adjust_style)
			throws Exception {

		// 按次日,按次月,按次期,按次年,平息法 0,1,2,3,4
		// 不同调息方式调用不同的处理方法

		if ("0".equals(adjust_style)) {// 次日

			proceCR(contract_id, txrq, String.valueOf(Integer
					.parseInt(start_term)), rateValue);

		} else if ("1".equals(adjust_style)) {// 次月

			proceCY(contract_id, txrq, String.valueOf(Integer
					.parseInt(start_term)), rateValue);

		} else if ("2".equals(adjust_style)) { // 次期处理

			proceCQ(contract_id, txrq, String.valueOf(Integer
					.parseInt(start_term) + 1), rateValue);

		} else if ("3".equals(adjust_style)) { // 次年
			proceCN(contract_id, txrq, String.valueOf(Integer
					.parseInt(start_term)), rateValue);

		}
	}

	/**
	 * 次期处理
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceCQ(String contract_id, String txrq, String start_term,
			String rateValue) throws Exception {

		
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		
		// 市场租金信息 处理
		MarkerRentPlan mrp = new MarkerRentPlan();
		mrp.proceMarketRentInfo(contract_id, start_term, txrq, rateValue);

		// 财务租金信息 处理 更新财务的
		FinacRentPlan frp = new FinacRentPlan();
		
		String o_start = ht.get("grace") != null
		&& Integer.parseInt(ht.get("grace").toString()) >= Integer
				.parseInt(start_term) ? String.valueOf(Integer
		.parseInt(ht.get("grace").toString())) : start_term;
				
		frp.proceFinaceInfo(contract_id, String.valueOf(Integer.parseInt(start_term)+1),txrq);
	}

	/**
	 * 次日处理
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceCR(String contract_id, String txrq, String start_term,
			String rateValue) throws Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);

		
		// 第一期的利息，本金，本金余额的特别处理 市场
		MarkerRentPlan mrp = new MarkerRentPlan();
		mrp.proceFirstRentPlan(contract_id, txrq, start_term, rateValue);
		// 如果是宽限期开始调息，则期 他调息开始期是从宽限期的后一期开始，如果是正常的则取正常租金起始期
		String o_start = ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term) ? String.valueOf(Integer
				.parseInt(ht.get("grace").toString())) : start_term;

		// 其他期次市场的租金处理
		mrp.proceCROhterMarket(contract_id, o_start, rateValue);
		// 财务的租金处理,宽限期是不进行现金流测算的
		FinacRentPlan frp = new FinacRentPlan();
		frp.proceFinacRentPlan(contract_id, txrq, String.valueOf(Integer
				.parseInt(start_term) + 1));

	}

	/**
	 * 次月处理
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceCY(String contract_id, String txrq, String start_term,
			String rateValue) throws Exception {

		// 第一期的利息，本金，本金余额的特别处理 市场
		MarkerRentPlan mrp = new MarkerRentPlan();
		String startDate = ToolUtil.getFirstDayByDate(txrq);

		mrp.proceFirstRentPlan(contract_id, startDate, start_term, rateValue);

		// 根据合同号得到延迟期 数
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);

		// 如果是宽限期开始调息，则期 他调息开始期是从宽限期的后一期开始，如果是正常的则取正常租金起始期
		String o_start = ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term) ? String.valueOf(Integer
				.parseInt(ht.get("grace").toString()) ) : start_term;

		// 其他期次市场的租金处理
		mrp.proceCROhterMarket(contract_id, o_start, rateValue);
		// 财务的租金处理
		FinacRentPlan frp = new FinacRentPlan();
		frp.proceFinacRentPlan(contract_id, startDate, String.valueOf(Integer
				.parseInt(start_term) + 1));

	}

	/**
	 *
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceCN(String contract_id, String txrq, String start_term,
			String rateValue) throws Exception {

		// 第一期的利息，本金，本金余额的特别处理 市场
		MarkerRentPlan mrp = new MarkerRentPlan();
		String startDate = ToolUtil.getYearFirstDate(txrq);

		mrp.proceFirstRentPlan(contract_id, startDate, start_term, rateValue);

		// 根据合同号得到延迟期 数
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);

		// 如果是宽限期开始调息，则期 他调息开始期是从宽限期的后一期开始，如果是正常的则取正常租金起始期
		String o_start = ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term) ? String.valueOf(Integer
				.parseInt(ht.get("grace").toString()) + 1) : start_term;

		// 其他期次市场的租金处理
		mrp.proceCROhterMarket(contract_id, o_start, rateValue);
		// 财务的租金处理
		FinacRentPlan frp = new FinacRentPlan();
		frp.proceFinacRentPlan(contract_id, startDate, String.valueOf(Integer
				.parseInt(start_term) + 1));

	}

}
