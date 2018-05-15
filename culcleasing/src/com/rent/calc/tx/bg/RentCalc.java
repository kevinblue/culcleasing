package com.rent.calc.tx.bg;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

/**
 * ������
 * 
 * @author shf
 * 
 */
public class RentCalc {

	/**
	 * �ȶ����ʱ��ÿһ�ڵ������㷽��
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

		// ����˵����Pv=��ֵ��Nper=������Rate=����(ע��ͬ��������һ�£���Ҫ���Ѿ������ٷֺŵ���ֵ����0.05)
		// Fv=δ��ֵ��Type=���� 1�� 0������ָ�����ڵĸ���ʱ�������ڳ�������ĩ
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
	 * �õ�ʣ��ĵ�Ϣ����
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

		// ��Ϣ�����ڴ�
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);

		String ajdustStyle = mp.get("ajdustStyle").toString();
		if ("2".equals(ajdustStyle)) { // ����ʱ
			// ����п�����ʱ
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
	 * �õ�ʣ����г�����
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
	 * �õ�ÿһ�ڵ����
	 * 
	 * @param mp
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public String getRentByPmt(String retu_vale, String contract_id, String txrq)
			throws Exception {

		// ʣ����ʣ���Ϣ����
		RentCalc rc = new RentCalc();
		String rem_rent_list = rc.getRemList(contract_id, txrq);
		String rem_corpus = rc.getRemMarketCorps(contract_id, txrq);

		// ��Ϣ�����ڴ�
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);

		String ajdustStyle = mp.get("ajdustStyle").toString();
		if ("2".equals(ajdustStyle)) { // ����ʱ
			// �õ���ʼ�ڴ�,�õ��ܵ����� ʣ������ ���㱾��
			FundRentPlan frp = new FundRentPlan();
			String minRent_list = frp.getAdjustMinRentList(contract_id, txrq);
			minRent_list = String.valueOf(Integer.parseInt(minRent_list) + 1);

			// ����п�����ʱ
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
		period_type = "0";// ��ĩ
		// �õ�ÿһ����������
		retu_vale = Tools.formatNumberDoubleScale(ToolUtil.getPreRate(
				retu_vale, income_number_year), 12);
		// �õ����
		String rent = RentCalc.getPMT(retu_vale, rem_rent_list, "-"
				+ rem_corpus, nominalprice, period_type);
		System.out.println("�µ���� :" + rent);
		return Tools.formatNumberDoubleScale(rent, Integer.parseInt(rentScale));
	}

	/**
	 * �õ�ÿһ�ڵ����
	 * 
	 * @param mp
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public String getRentPLeassMoney(String retu_vale, String contract_id,
			String start_term) throws Exception {

		// ʣ����ʣ���Ϣ����

		FundRentPlan frp = new FundRentPlan();
		String total = frp.getTotalCount(contract_id);
		String rem_rent_list = String.valueOf(Integer.parseInt(total)
				- Integer.parseInt(start_term));

		String rem_corpus = frp.getTotalCorpusByQc(contract_id, start_term);

		// ��Ϣ�����ڴ�
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);

		String period_type = mp.get("period_type").toString();
		String income_number_year = mp.get("income_number_year").toString();
		String nominalprice = mp.get("nominalprice").toString();
		String rentScale = mp.get("rentScale").toString();

		period_type = "0";// ��ĩ
		// �õ�ÿһ����������
		retu_vale = Tools.formatNumberDoubleScale(ToolUtil.getPreRate(
				retu_vale, income_number_year), 12);
		// �õ����
		String rent = RentCalc.getPMT(retu_vale, rem_rent_list, "-"
				+ rem_corpus, nominalprice, period_type);
		System.out.println("�µ���� :" + rent);
		return Tools.formatNumberDoubleScale(rent, Integer.parseInt(rentScale));
	}

	/**
	 * �ȶ���� ���ÿһ�ڵ����ֵ��δ����ʱ
	 * 
	 * @param rent
	 * @param income_number
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List eqRentList(String rent, String income_number) {
		List l_rent = new ArrayList();
		// ���ÿһ�ڵ����,�����ܵ������õ����е�����Ϣ
		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			l_rent.add(rent);
		}

		return l_rent;
	}

}
