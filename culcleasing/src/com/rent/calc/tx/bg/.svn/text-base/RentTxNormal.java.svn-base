package com.rent.calc.tx.bg;



/**
 * 正常情况下的调息时
 * 
 * @author shf
 * 
 */
public class RentTxNormal {

	/**
	 * 重新计算租金,年利率变化时
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param txrq
	 * @throws Exception
	 */
	public void calRentByNew(String contract_id, String start_term,
			String txrq, String rateValue) throws Exception {

		// 市场租金信息 处理
		MarkerRentPlan mrp = new MarkerRentPlan();
		mrp.proceMarketRentInfo(contract_id, start_term, txrq, rateValue);

		// 财务租金信息 处理
		// 更新财务的
		FinacRentPlan frp = new FinacRentPlan();
		frp.proceFinaceInfo(contract_id, start_term,txrq);

	}

	


}
