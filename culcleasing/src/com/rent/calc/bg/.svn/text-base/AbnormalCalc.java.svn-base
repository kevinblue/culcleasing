package com.rent.calc.bg;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

import com.rent.calc.tx.CalcUtil;
import com.rent.calc.tx.bg.CommonUtil;

import com.rent.calc.tx.bg.ToolUtil;

/**
 * 不规则租金测算
 * 
 * @author shf
 * 
 */

public class AbnormalCalc {

	private String ctbName = ""; // 交易结构表

	private String ftbName = "";// 租金计划表

	private String contractColum = ""; // 合同号列名

	private String contractId = "";// 合同号

	private String docId = "";// 流程号

	private String docColumn = "";// 流程号列名

	public AbnormalCalc() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AbnormalCalc(String ctbName, String ftbName, String contractColum,
			String contractId, String docId, String docColumn) {
		super();
		this.ctbName = ctbName;
		this.ftbName = ftbName;
		this.contractColum = contractColum;
		this.contractId = contractId;
		this.docId = docId;
		this.docColumn = docColumn;
	}

	public String getContractColum() {
		return contractColum;
	}

	public void setContractColum(String contractColum) {
		this.contractColum = contractColum;
	}

	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

	public String getCtbName() {
		return ctbName;
	}

	public void setCtbName(String ctbName) {
		this.ctbName = ctbName;
	}

	public String getDocColumn() {
		return docColumn;
	}

	public void setDocColumn(String docColumn) {
		this.docColumn = docColumn;
	}

	public String getDocId() {
		return docId;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}

	public String getFtbName() {
		return ftbName;
	}

	public void setFtbName(String ftbName) {
		this.ftbName = ftbName;
	}

	/**
	 * 
	 * @param markIrrValue  市场现金流交易结构值
	 * @param finIrrValue　财务现金流交易结构值
	 * @param finCalcValue财务租金计划测算值　
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings( { "static-access", "unchecked" })
	public Hashtable getPlanInfo(String markIrrValue, String finIrrValue,
			String finCalcValue) throws Exception {

		markIrrValue = Tools.formatNumberDoubleTwo(markIrrValue);
		finIrrValue = Tools.formatNumberDoubleTwo(finIrrValue);
		finCalcValue = Tools.formatNumberDoubleTwo(finCalcValue);
		// 查询交易结构表 判断变化的参数 根据变化的参数进行相应的处理
		ConditionTemp ct = new ConditionTemp();
		Hashtable ht_cond = ct.getProj_ConditionInfoByProj_id(contractId,
				contractColum, docId, docColumn, ctbName);
		// 得到市场的租金计划
		FundRentTemp frt = new FundRentTemp();
		Hashtable ht = frt.getMarketPlanInfo(contractId, contractColum, docId,
				docColumn, ftbName);
		List rent_list = (List) ht.get("rent_list");

		String period_type = ht_cond.get("period_type").toString();

		String newScale = "2";
		String income_number_year = ht_cond.get("income_number_year")
				.toString();
		String caution_money = ht_cond.get("caution_money").toString();

		// 市场irr处理
		abMarketIrr(markIrrValue, ct, rent_list, period_type,
				income_number_year, caution_money);

		// 财务信息处理
		abFinacePlan(finIrrValue, finCalcValue, ct, ht, rent_list, period_type,
				newScale, income_number_year);

		return ht;

	}

	/**
	 * 市场现金流处理
	 * 
	 * @param markIrrValue
	 * @param ct
	 * @param rent_list
	 * @param period_type
	 * @param income_number_year
	 * @throws Exception
	 */

	@SuppressWarnings("unchecked")
	private void abMarketIrr(String markIrrValue, ConditionTemp ct,
			List rent_list, String period_type, String income_number_year,
			String caution_money) throws Exception {
		
		markIrrValue = Tools.formatNumberDoubleTwo(markIrrValue);
		// 用于算租金流的租金
		List newRentList = new ArrayList();
		newRentList = CalcUtil.getNewList(rent_list);
		// 保证金抵扣
		RentCalc rc = new RentCalc();
		newRentList = rc.getRentCautNew(newRentList, caution_money);

		List cash_list = new ArrayList();
		if ("1".equals(period_type)) {// 期初时
			cash_list.add(
					 Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble("-"+markIrrValue)
							+ Double.parseDouble(newRentList.get(0).toString()))));
			// 添加租金列表
			for (int i = 1; i < rent_list.size(); i++) {
				cash_list.add(newRentList.get(i));
			}
		} else {

			cash_list.add("-" + markIrrValue);
			cash_list.addAll(1, newRentList);
		}

		IrrCal ic = new IrrCal();
		// 新算他的irr
		String market_irr = ic.getIRR(cash_list, income_number_year,
				income_number_year, String.valueOf(12 / Integer
						.parseInt(income_number_year)));

		market_irr = Tools.formatNumberDoubleScale(market_irr, 12);
		System.out.println("市场irr:" + market_irr);
		// 更新市场irr
		ct.updateMarkerIrr(contractId, contractColum, docId, docColumn,
				ctbName, market_irr);
	}

	/**
	 * 财务租金计划，现金流处理
	 * 
	 * @param finIrrValue
	 * @param finCalcValue
	 * @param ct
	 * @param ht
	 * @param rent_list
	 * @param period_type
	 * @param newScale
	 * @param income_number_year
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private void abFinacePlan(String finIrrValue, String finCalcValue,
			ConditionTemp ct, Hashtable ht, List rent_list, String period_type,
			String newScale, String income_number_year) throws Exception {
		
		finIrrValue = Tools.formatNumberDoubleTwo(finIrrValue);
		finCalcValue = Tools.formatNumberDoubleTwo(finCalcValue);
		List cash_list = new ArrayList();
		if ("1".equals(period_type)) {// 期初时
			cash_list.add(
					Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble("-"+finIrrValue)
							+ Double.parseDouble(rent_list.get(0).toString()))));
			// 添加租金列表
			for (int i = 1; i < rent_list.size(); i++) {
				cash_list.add(rent_list.get(i));
			}
		} else {
			cash_list.add("-" + finIrrValue);
			cash_list.addAll(1, rent_list);
		}

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
				finCalcValue, preRate, period_type, newScale);

		// 新本金
		List corpus_fina_list = CommonUtil.getCorpusList(rent_list,
				inter_fina_list, newScale);
		// 新本金余额
		List corpusOverge_market_list = CommonUtil.getCorpusOvergeList(
				finCalcValue, corpus_fina_list, newScale);

		ht.put("inter_fina_list", inter_fina_list);// 财务利息
		ht.put("corpus_fina_list", corpus_fina_list);// 财务本金
		ht.put("corpusOverage_fina_list", corpusOverge_market_list);// 财务本金余额
		// 更新财务irr
		ct.updateFinaIrr(contractId, contractColum, docId, docColumn, ctbName,
				finac_irr);
		// 更新 财务租金计划
		FundRentTemp ft = new FundRentTemp();
		ft.updateFinacPlan(contractId, contractColum, docId, docColumn,
				ftbName, inter_fina_list, corpus_fina_list,
				corpusOverge_market_list);
	}

}
