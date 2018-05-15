package com.rent.calc.settlaw;

import java.util.Hashtable;

import com.rent.calc.tx.bg.CoditionInfo;
import com.rent.calc.tx.bg.FinacRentPlan;
import com.rent.calc.tx.bg.MarkerRentPlan;
import com.rent.calc.tx.bg.ToolUtil;

/**
 * 平息法调息类
 * 
 * @author shf
 * 
 */
public class SettlawTranRate {
	/**
	 * 
	 * @param mp
	 *            调息合同的包含的调息信息
	 * @throws Exception
	 * 
	 */
	public void calRentBySettled(String contract_id, String txrq,
			String start_term, String rateValue, String adjust_style)
			throws Exception {

		// 电信项目变为次期调息
		// 按次日,按次月,按次期,按次年 0,1,2,3
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
	 * 次期处理 单体项目，电信项目
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws Exception
	 */
	public void proceCQ(String contract_id, String txrq, String start_term,
			String rateValue) throws Exception {

		// 市场租金信息 处理
		MarkerRentPlan mrp = new MarkerRentPlan();

		String start_date_temp = new String(start_term);
		// /////////////////////////
		mrp.proceMarketRentInfoBySett(contract_id, start_term, txrq, rateValue);

		// 财务租金信息 处理 更新财务的
		FinacRentPlan frp = new FinacRentPlan();
		frp.proceFinaceInfo(contract_id, start_date_temp, txrq);
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

		// 由于平息法变更日期与计划日期产生的差额加在了下一期是从下一期开始调，则start_term要算加1
		start_term = String.valueOf(Integer.parseInt(start_term) + 1);

		// 第一期的利息，本金，本金余额的特别处理 市场
		MarkerRentPlan mrp = new MarkerRentPlan();
		mrp.proceFirstRentPlanBySet(contract_id, txrq, start_term, rateValue);
		// 其他期次市场的租金处理

		// 根据合同号得到延迟期 数
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);

		// 如果是宽限期开始调息，则期 他调息开始期是从宽限期的后一期开始，如果是正常的则取正常租金起始期
		String o_start = ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term) ? String.valueOf(Integer
				.parseInt(ht.get("grace").toString()) + 1) : start_term;

		mrp.proceCROhterMarketBySet(contract_id, o_start, rateValue);
		// 财务的租金处理
		FinacRentPlan frp = new FinacRentPlan();
		frp.proceFinaceInfo(contract_id, start_term, txrq);

	}


	/**
	 * 次月处理 次年
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

		// 由于平息法变更日期与计划日期产生的差额加在了下一期是从下一期开始调，则start_term要算加1
		start_term = String.valueOf(Integer.parseInt(start_term) + 1);

		// 第一期的利息，本金，本金余额的特别处理 市场
		MarkerRentPlan mrp = new MarkerRentPlan();
		String startDate = ToolUtil.getFirstDayByDate(txrq);

		// 2011-03-28修改
		// mrp.proceFirstRentPlanBySetCYAndCN(contract_id, startDate,
		// start_term,
		// rateValue);

		mrp.proceFirstRentPlanBySet(contract_id, startDate, start_term,
				rateValue);
		// 根据合同号得到延迟期 数
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);

		// 如果是宽限期开始调息，则期 他调息开始期是从宽限期的后一期开始，如果是正常的则取正常租金起始期
		String o_start = ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term) ? String.valueOf(Integer
				.parseInt(ht.get("grace").toString())) : start_term;

		// 其他期次市场的租金处理
		mrp.proceCROhterMarketBySet(contract_id, o_start, rateValue);
		// 财务的租金处理
		FinacRentPlan frp = new FinacRentPlan();
		frp.proceFinaceInfo(contract_id, start_term, txrq);
	}


	/**
	 * 次年处理
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

		// 由于平息法变更日期与计划日期产生的差额加在了下一期是从下一期开始调，则start_term要算加1
		start_term = String.valueOf(Integer.parseInt(start_term) + 1);

		// 第一期的利息，本金，本金余额的特别处理 市场
		MarkerRentPlan mrp = new MarkerRentPlan();
		String startDate = ToolUtil.getYearFirstDate(txrq);

		// 2011-03-28修改
		// mrp.proceFirstRentPlanBySetCYAndCN(contract_id, startDate,
		// start_term,
		// rateValue);

		mrp.proceFirstRentPlanBySet(contract_id, startDate, start_term,
				rateValue);

		// 根据合同号得到延迟期 数
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);

		// 如果是宽限期开始调息，则期 他调息开始期是从宽限期的后一期开始，如果是正常的则取正常租金起始期
		String o_start = ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term) ? String.valueOf(Integer
				.parseInt(ht.get("grace").toString()) + 1) : start_term;

		// 其他期次市场的租金处理
		mrp.proceCROhterMarketBySet(contract_id, o_start, rateValue);
		// 财务的租金处理
		FinacRentPlan frp = new FinacRentPlan();
		frp.proceFinaceInfo(contract_id, start_term, txrq);

	}

}
