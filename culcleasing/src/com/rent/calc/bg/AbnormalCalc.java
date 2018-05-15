package com.rent.calc.bg;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

import com.rent.calc.tx.CalcUtil;
import com.rent.calc.tx.bg.CommonUtil;

import com.rent.calc.tx.bg.ToolUtil;

/**
 * ������������
 * 
 * @author shf
 * 
 */

public class AbnormalCalc {

	private String ctbName = ""; // ���׽ṹ��

	private String ftbName = "";// ���ƻ���

	private String contractColum = ""; // ��ͬ������

	private String contractId = "";// ��ͬ��

	private String docId = "";// ���̺�

	private String docColumn = "";// ���̺�����

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
	 * @param markIrrValue  �г��ֽ������׽ṹֵ
	 * @param finIrrValue�������ֽ������׽ṹֵ
	 * @param finCalcValue�������ƻ�����ֵ��
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings( { "static-access", "unchecked" })
	public Hashtable getPlanInfo(String markIrrValue, String finIrrValue,
			String finCalcValue) throws Exception {

		markIrrValue = Tools.formatNumberDoubleTwo(markIrrValue);
		finIrrValue = Tools.formatNumberDoubleTwo(finIrrValue);
		finCalcValue = Tools.formatNumberDoubleTwo(finCalcValue);
		// ��ѯ���׽ṹ�� �жϱ仯�Ĳ��� ���ݱ仯�Ĳ���������Ӧ�Ĵ���
		ConditionTemp ct = new ConditionTemp();
		Hashtable ht_cond = ct.getProj_ConditionInfoByProj_id(contractId,
				contractColum, docId, docColumn, ctbName);
		// �õ��г������ƻ�
		FundRentTemp frt = new FundRentTemp();
		Hashtable ht = frt.getMarketPlanInfo(contractId, contractColum, docId,
				docColumn, ftbName);
		List rent_list = (List) ht.get("rent_list");

		String period_type = ht_cond.get("period_type").toString();

		String newScale = "2";
		String income_number_year = ht_cond.get("income_number_year")
				.toString();
		String caution_money = ht_cond.get("caution_money").toString();

		// �г�irr����
		abMarketIrr(markIrrValue, ct, rent_list, period_type,
				income_number_year, caution_money);

		// ������Ϣ����
		abFinacePlan(finIrrValue, finCalcValue, ct, ht, rent_list, period_type,
				newScale, income_number_year);

		return ht;

	}

	/**
	 * �г��ֽ�������
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
		// ����������������
		List newRentList = new ArrayList();
		newRentList = CalcUtil.getNewList(rent_list);
		// ��֤��ֿ�
		RentCalc rc = new RentCalc();
		newRentList = rc.getRentCautNew(newRentList, caution_money);

		List cash_list = new ArrayList();
		if ("1".equals(period_type)) {// �ڳ�ʱ
			cash_list.add(
					 Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble("-"+markIrrValue)
							+ Double.parseDouble(newRentList.get(0).toString()))));
			// �������б�
			for (int i = 1; i < rent_list.size(); i++) {
				cash_list.add(newRentList.get(i));
			}
		} else {

			cash_list.add("-" + markIrrValue);
			cash_list.addAll(1, newRentList);
		}

		IrrCal ic = new IrrCal();
		// ��������irr
		String market_irr = ic.getIRR(cash_list, income_number_year,
				income_number_year, String.valueOf(12 / Integer
						.parseInt(income_number_year)));

		market_irr = Tools.formatNumberDoubleScale(market_irr, 12);
		System.out.println("�г�irr:" + market_irr);
		// �����г�irr
		ct.updateMarkerIrr(contractId, contractColum, docId, docColumn,
				ctbName, market_irr);
	}

	/**
	 * �������ƻ����ֽ�������
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
		if ("1".equals(period_type)) {// �ڳ�ʱ
			cash_list.add(
					Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble("-"+finIrrValue)
							+ Double.parseDouble(rent_list.get(0).toString()))));
			// �������б�
			for (int i = 1; i < rent_list.size(); i++) {
				cash_list.add(rent_list.get(i));
			}
		} else {
			cash_list.add("-" + finIrrValue);
			cash_list.addAll(1, rent_list);
		}

		IrrCal ic = new IrrCal();
		// ��������irr
		String finac_irr = ic.getIRR(cash_list, income_number_year,
				income_number_year, String.valueOf(12 / Integer
						.parseInt(income_number_year)));
		// �޸� irr ��ȷ��12λ:2010-12-15
		finac_irr = Tools.formatNumberDoubleScale(finac_irr, 12);
		System.out.println("����irr:" + finac_irr);

		// ����Ϣ
		ToolUtil tu = new ToolUtil();
		String preRate = Tools.formatNumberDoubleScale(tu.getPreRate(String
				.valueOf(Double.parseDouble(finac_irr) * 100),
				income_number_year), 12);

		List inter_fina_list = CommonUtil.getInterestList(rent_list,
				finCalcValue, preRate, period_type, newScale);

		// �±���
		List corpus_fina_list = CommonUtil.getCorpusList(rent_list,
				inter_fina_list, newScale);
		// �±������
		List corpusOverge_market_list = CommonUtil.getCorpusOvergeList(
				finCalcValue, corpus_fina_list, newScale);

		ht.put("inter_fina_list", inter_fina_list);// ������Ϣ
		ht.put("corpus_fina_list", corpus_fina_list);// ���񱾽�
		ht.put("corpusOverage_fina_list", corpusOverge_market_list);// ���񱾽����
		// ���²���irr
		ct.updateFinaIrr(contractId, contractColum, docId, docColumn, ctbName,
				finac_irr);
		// ���� �������ƻ�
		FundRentTemp ft = new FundRentTemp();
		ft.updateFinacPlan(contractId, contractColum, docId, docColumn,
				ftbName, inter_fina_list, corpus_fina_list,
				corpusOverge_market_list);
	}

}
