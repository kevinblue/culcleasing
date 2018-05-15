package com.rent.calc.rentcharge;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;
import com.rent.calc.bg.IrrCal;
import com.rent.calc.bg.RentCalc;
import com.rent.calc.settlaw.SetLawRentCaleUtil;
import com.rent.calc.tx.bg.CoditionInfo;
import com.rent.calc.tx.bg.CommonUtil;
import com.rent.calc.tx.bg.FundRentPlan;
import com.rent.calc.tx.bg.ToolUtil;

/**
 * ����� ����ʱ���޸� �µ����� ���������� ������ʼ�� ������ʼʱ��
 * 
 * @author shf
 * 
 */
public class RentChange {
	/**
	 * ������õ����������ƻ���Ϣ
	 * 
	 * @param contractId
	 *            ��ͬ��
	 * @param startStages
	 *            ��ʼ����ڴ�
	 * @param newRate
	 *            �µ�����
	 * @param newPhases
	 *            �µ�������ڴ�
	 * @param newDate
	 *            �µĳ�����
	 * @return ���������ƻ���Ϣ
	 * @throws Exception
	 */

	@SuppressWarnings( { "static-access", "unchecked" })
	public Hashtable getRentChargePlan(String contractId, String startStages,
			String newRate, String newPhases, String newDate) throws Exception {

		// ��ͬ�� ������Ĳ��㷽ʽ��ƽϢ����pmt�㷨��

		// ��ѯ���׽ṹ�� �жϱ仯�Ĳ��� ���ݱ仯�Ĳ���������Ӧ�Ĵ���
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht_cond = ci.getProj_ConditionInfoByProj_id(contractId);
		String measure_type = ht_cond.get("measure_type").toString();

		// ��ͬ�Ĳ��㷽ʽ���ò�ͬ�Ĳ��㷽��
		if ("1".equals(measure_type)) {// �ȶ����

			// return getEqRentPlan(contractId, startStages, newRate, newPhases,
			// newDate);
			return getNewPlanByNewYearRatePmt(contractId, startStages, newRate,
					newPhases, newDate);

		} else if ("5".equals(measure_type)) {
			return getNewPlanBySettlaw(contractId, startStages, newRate,
					newPhases, newDate, ht_cond);

		}

		return null;
	}

	/**
	 * ƽϢ������
	 * 
	 * @param contractId
	 *            ��ͬ��
	 * @param startStages
	 *            ��ʼ����
	 * @param newRate
	 *            �µ�����
	 * @param newPhases
	 *            �µ�����
	 * @param newDate
	 *            �µĳ�����
	 * @param ht_cond
	 *            ��ͬ���׽ṹ��Ϣ
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	private Hashtable getNewPlanBySettlaw(String contractId,
			String startStages, String newRate, String newPhases,
			String newDate, Hashtable ht_cond) throws Exception, SQLException {
		// ƽϢ��ʱ
		SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
		// �õ�������
		FundRentPlan frp = new FundRentPlan();
		int totalCount = Integer.parseInt(frp.getTotalCount(contractId));

		Hashtable ht = new Hashtable();
		// �õ��µĳ�����
		ht = getNewPlanDate(contractId, startStages, newDate, newPhases);

		if ((totalCount - Integer.parseInt(startStages) + 1) != Integer
				.parseInt(newPhases)) { // ������

			String rentScale = ht_cond.get("rentScale").toString();
			String income_number_year = ht_cond.get("income_number_year")
					.toString();

			// 2010-12-08 �������
			String newScale = "2";

			String corpus_market = frp.getFisrtSumCorpMarket(contractId,
					startStages);
			corpus_market = Tools.formatNumberDoubleScale(corpus_market,
					Integer.parseInt(newScale));

			System.out.println("corpus_market:" + corpus_market);
			// ������������������ÿһ�ڵ�ƽ������
			String pre_corpus = Tools.formatNumberDoubleScale(String
					.valueOf(Double.parseDouble(corpus_market)
							/ Integer.parseInt(newPhases)), Integer
					.parseInt(newScale));

			// ���ڱ��汾��
			List corpus_market_list = new ArrayList();
			String total = "0";
			for (int i = 0; i < Integer.parseInt(newPhases); i++) {
				// ���һ����Ҫ���ر�Ĵ���

				if (i == Integer.parseInt(newPhases) - 1) {
					double d = Double.parseDouble(corpus_market)
							- Double.parseDouble(total);
					corpus_market_list.add(Tools.formatNumberDoubleScale(String
							.valueOf(d), Integer.parseInt(newScale)));
				} else {
					corpus_market_list.add(pre_corpus);
					total = String.valueOf(Double.parseDouble(total)
							+ Double.parseDouble(pre_corpus));
					total = Tools.formatNumberDoubleScale(total, Integer
							.parseInt(newScale));
				}
			}

			// ���list
			// ������������������ÿһ�ڵ�ƽ�����
			String pre_rent = slrcu.getRent(corpus_market, newPhases, newRate,
					income_number_year, rentScale);

			// String pre_rent = Tools.formatNumberDoubleScale(String
			// .valueOf(Double.parseDouble(corpus_market)
			// * (1 + Double.parseDouble(newRate)*0.01)
			// / Integer.parseInt(newPhases)), Integer
			// .parseInt(rentScale));

			List rent_list = new ArrayList();
			for (int i = 0; i < Integer.parseInt(newPhases); i++) {
				rent_list.add(pre_rent);
			}

			// ��Ϣ�б�
			// SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
			List inter_list = slrcu.getInterMarket(rent_list,
					corpus_market_list, newScale);

			// �õ��������
			List corpusOverge_market_list = slrcu.getCorpusOvergeList(
					corpus_market, corpus_market_list, newScale);

			List cash_list = new ArrayList();
			cash_list.add("-" + corpus_market);
			// �������б�
			cash_list.addAll(1, rent_list);
			IrrCal ic = new IrrCal();
			// ��������irr
			String market_irr = ic.getIRR(cash_list, income_number_year,
					income_number_year, String.valueOf(12 / Integer
							.parseInt(income_number_year)));
			market_irr = Tools.formatNumberDoubleScale(market_irr, 12);
			System.out.println("�г�irr:" + market_irr);

			putValue(ht, corpus_market_list, rent_list, inter_list,
					corpusOverge_market_list, market_irr);

		} else {// ��������

			String rentScale = ht_cond.get("rentScale").toString();
			String income_number_year = ht_cond.get("income_number_year")
					.toString();

			String newScale = "2";
			// ��������ʱ������ܵı��� �ܵ����������Ե�
			String corpus_market = frp.getFisrtSumCorpMarket(contractId, "0");
			corpus_market = Tools.formatNumberDoubleScale(corpus_market,
					Integer.parseInt(newScale));

			System.out.println("corpus_market:" + corpus_market);
			// �����ǲ���ģ�����ֻ��ѯ�����ڵ����еı���ֵ
			List corpus_market_list = new ArrayList();
			corpus_market_list = frp.getStartCorpus(contractId, startStages);

			// ���list ���ֵ���� ����������
			// ������������������ÿһ�ڵ�ƽ�����
			// String pre_rent = Tools.formatNumberDoubleScale(String
			// .valueOf(Double.parseDouble(corpus_market)
			// * (1 + Double.parseDouble(newRate)*0.01) / totalCount),
			// Integer.parseInt(rentScale));

			String pre_rent = slrcu.getRent(corpus_market, String
					.valueOf(totalCount), newRate, income_number_year,
					rentScale);

			List rent_list = new ArrayList();
			for (int i = 0; i < Integer.parseInt(newPhases); i++) {
				rent_list.add(pre_rent);
			}

			// ��Ϣ�б�
			// SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
			List inter_list = slrcu.getInterMarket(rent_list,
					corpus_market_list, newScale);

			// �õ��������
			List corpusOverge_market_list = slrcu.getCorpusOvergeList(
					corpus_market, corpus_market_list, newScale);

			// �ֽ�������ʱ�ĵ�һ��ֵ
			corpus_market = frp.getFisrtSumCorpMarket(contractId, startStages);

			List cash_list = new ArrayList();
			cash_list.add("-" + corpus_market);
			// �������б�
			cash_list.addAll(1, rent_list);
			IrrCal ic = new IrrCal();
			// ��������irr
			String market_irr = ic.getIRR(cash_list, income_number_year,
					income_number_year, String.valueOf(12 / Integer
							.parseInt(income_number_year)));
			market_irr = Tools.formatNumberDoubleScale(market_irr, 12);
			System.out.println("�г�irr:" + market_irr);

			putValue(ht, corpus_market_list, rent_list, inter_list,
					corpusOverge_market_list, market_irr);

		}
		// ���
		getPmtFinacPlan(contractId, startStages, ht);
		return ht;
	}

	/**
	 * ������ֵ
	 * 
	 * @param ht
	 * @param corpus_market_list
	 * @param rent_list
	 * @param inter_list
	 * @param corpusOverge_market_list
	 * @param market_irr
	 */
	@SuppressWarnings("unchecked")
	private void putValue(Hashtable ht, List corpus_market_list,
			List rent_list, List inter_list, List corpusOverge_market_list,
			String market_irr) {
		ht.put("rent_list", rent_list);// ���
		ht.put("corpus_market_list", corpus_market_list);// �г�����
		ht.put("inter_list", inter_list);// �г���Ϣ
		ht.put("corpusOverge_market_list", corpusOverge_market_list);// �г��������
		ht.put("market_irr", market_irr);// �г�irr
		System.out.println("market_irr:" + market_irr);
	}

	/**
	 * �ȶ��������ƻ������Ϣ
	 * 
	 * @param contractId
	 * @param startStages
	 * @param newRate
	 * @param newPhases
	 * @param newDate
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings( { "static-access", "unchecked" })
	public Hashtable getNewPlanByNewYearRatePmt(String contractId,
			String startStages, String newRate, String newPhases, String newDate)
			throws Exception {
		Hashtable ht = new Hashtable();
		// �õ��µĳ�����
		ht = getNewPlanDate(contractId, startStages, newDate, newPhases);
		// �г�
		getPmtMarketPlan(contractId, startStages, newRate, newPhases, ht);
		// ���
		getPmtFinacPlan(contractId, startStages, ht);

		return ht;
	}

	/**
	 * ������ƻ�����
	 * 
	 * @param contractId
	 * @param startStages
	 * @param ht
	 * @throws Exception
	 */

	@SuppressWarnings( { "static-access", "unchecked" })
	private void getPmtFinacPlan(String contractId, String startStages,
			Hashtable ht) throws Exception {
		List rent_list = (List) ht.get("rent_list");
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht_cond = ci.getProj_ConditionInfoByProj_id(contractId);
		// String rentScale = ht_cond.get("rentScale").toString();
		// String period_type = ht_cond.get("period_type").toString();

		// 2010-12-08 �������
		String newScale = "2";

		String income_number_year = ht_cond.get("income_number_year")
				.toString();
		// �õ�����Ĳ��񱾽��ܺ�
		FundRentPlan frp = new FundRentPlan();
		String corpus_finace = frp.getTotalCorpusFinac(contractId, startStages);
		corpus_finace = Tools.formatNumberDoubleScale(corpus_finace, Integer
				.parseInt(newScale));
		List cash_list = new ArrayList();
		cash_list.add("-" + corpus_finace);
		// �������б�
		cash_list.addAll(1, rent_list);
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
				corpus_finace, preRate, "0", newScale);

		// �±���
		List corpus_fina_list = CommonUtil.getCorpusList(rent_list,
				inter_fina_list, newScale);
		// �±������
		List corpusOverge_market_list = CommonUtil.getCorpusOvergeList(
				corpus_finace, corpus_fina_list, newScale);

		ht.put("inter_fina_list", inter_fina_list);// ������Ϣ
		ht.put("corpus_fina_list", corpus_fina_list);// ���񱾽�
		ht.put("corpusOverage_fina_list", corpusOverge_market_list);// ���񱾽����
		ht.put("finac_irr", finac_irr);// ����irr
	}

	/**
	 * �г����ƻ�����
	 * 
	 * @param contractId
	 * @param startStages
	 * @param newRate
	 * @param newPhases
	 * @param ht
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	private void getPmtMarketPlan(String contractId, String startStages,
			String newRate, String newPhases, Hashtable ht) throws Exception,
			SQLException {
		// �г�
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht_cond = ci.getProj_ConditionInfoByProj_id(contractId);
		String rentScale = ht_cond.get("rentScale").toString();
		String period_type = ht_cond.get("period_type").toString();
		String nominalprice = ht_cond.get("nominalprice").toString();
		period_type = "0";
		String income_number_year = ht_cond.get("income_number_year")
				.toString();

		// 2010-12-08 �������
		String newScale = "2";

		// ���ֵ �õ��������
		FundRentPlan frp = new FundRentPlan();
		String corpus_market = frp.getFisrtSumCorpMarket(contractId,
				startStages);

		corpus_market = Tools.formatNumberDoubleScale(corpus_market, Integer
				.parseInt(newScale));

		System.out.println("corpus_market:" + corpus_market);
		RentCalc rc = new RentCalc();
		ToolUtil tu = new ToolUtil();
		//
		String preRate = Tools.formatNumberDoubleScale(tu.getPreRate(newRate,
				income_number_year), 12);
		String rent = Tools.formatNumberDoubleScale(rc.getPMT(preRate,
				newPhases, "-" + corpus_market, nominalprice, period_type),
				Integer.parseInt(rentScale));

		RentChargCalcTool rcct = new RentChargCalcTool();

		// ������б�
		List rent_list = rcct.getRentListByRentAndPhase(rent, newPhases);
		// ����Ϣ
		List inter_list = CommonUtil.getInterestList(rent_list, corpus_market,
				preRate, "0", newScale);
		// �±���
		List corpus_market_list = CommonUtil.getCorpusList(rent_list,
				inter_list, newScale);
		// �±������
		List corpusOverge_market_list = CommonUtil.getCorpusOvergeList(
				corpus_market, corpus_market_list, newScale);

		List cash_list = new ArrayList();
		cash_list.add("-" + corpus_market);
		// �������б�
		cash_list.addAll(1, rent_list);
		IrrCal ic = new IrrCal();
		// ��������irr
		String market_irr = ic.getIRR(cash_list, income_number_year,
				income_number_year, String.valueOf(12 / Integer
						.parseInt(income_number_year)));
		market_irr = Tools.formatNumberDoubleScale(market_irr, 12);
		System.out.println("�г�irr:" + market_irr);

		ht.put("rent_list", rent_list);// ���
		ht.put("corpus_market_list", corpus_market_list);// �г�����
		ht.put("inter_list", inter_list);// �г���Ϣ
		ht.put("corpusOverge_market_list", corpusOverge_market_list);// �г��������
		ht.put("market_irr", market_irr);// �г�irr
		System.out.println("market_irr:" + market_irr);
	}

	/**
	 * ��𳥻��ձ��
	 * 
	 * @param contractId
	 * @param startStages
	 * @param newDate
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings( { "unchecked", "static-access" })
	public Hashtable getNewPlanDate(String contractId, String startStages,
			String newDate, String newPhases) throws Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable ht_cond = ci.getProj_ConditionInfoByProj_id(contractId);

		String income_number_year = ht_cond.get("income_number_year")
				.toString();
		List l_date = new ArrayList();
		RentChargCalcTool rcct = new RentChargCalcTool();
		rcct.getChargeDate(contractId, startStages, newDate, newPhases,
				income_number_year, l_date);

		Hashtable ht = new Hashtable();
		ht.put("l_date", l_date);// �ƻ�����
		return ht;
	}
	

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		// ht.put("rent_list", null);// ���
		// ht.put("corpus_market_list", null);// �г�����
		// ht.put("inter_list", null);// �г���Ϣ
		// ht.put("corpusOverge_market_list", null);// �г��������

		// ht.put("inter_fina_list", null);// ������Ϣ
		// ht.put("corpus_fina_list", null);// ���񱾽�
		// ht.put("corpusOverage_fina_list", null);// ���񱾽����

		List li = new ArrayList();
		li.add("-100");
		List li1 = new ArrayList();
		li1.add("-11");
		li1.add("-12");
		li1.add("-13");

		li.addAll(1, li1);
		

		for (int i = 0; i < li.size(); i++) {
			//System.out.println("==" + li.get(i).toString());
		}
		
		String s = "1";
		String s1 = new String (s) ;
		s1 = String.valueOf(Integer.parseInt(s1)+1);
		System.out.println(s1);
		System.out.println("========="+s);
		
	} 
}
