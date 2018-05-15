package com.rent.calc.settlaw;

import java.util.Hashtable;
import java.util.List;

import com.rent.calc.tx.bg.ToolUtil;

/**
 * ƽϢ��������
 * 
 * @author shf
 * 
 */
public class SettledLaw {

	/**
	 * ƽϢ��������
	 * 
	 * @param leaseMoney
	 *            �г��Ĳ��㱾��
	 * @param income_number
	 *            ������
	 * @param yearRate
	 *            ������
	 * @param lease_interval
	 *            �����
	 * @param firstMoneyMarket
	 *            �г����ֽ����ĵ�һ�ڵ�ֵ
	 * @param firstMoneyFinac
	 *            ������ֽ����ĵ�һ�ڵ�ֵ
	 * @param type
	 *            �ڳ�������ĩ
	 * @param plan_date
	 *            ��������
	 * @param rentScale
	 *            С��λ��
	 * @param grace
	 *            ������
	 * @param delay
	 *            �ӳ���
	 * @return ���ƻ���Ϣ
	 */
	@SuppressWarnings("unchecked")
	public Hashtable getPlanInfo(String leaseMoneyByMarket,
			String leaseMoneyByFianc, String income_number, String yearRate,
			String lease_interval, String firstMoneyMarket,
			String firstMoneyFinac, String type, String plan_date,
			String rentScale, String grace, String delay) {
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";

		Hashtable ht_plan = new Hashtable();
		// /�г����ƻ�����
		getMarketPlan(leaseMoneyByMarket, income_number, yearRate,
				lease_interval, firstMoneyMarket, type, plan_date, rentScale,
				grace, delay, ht_plan);
		// /�������ƻ�����
		getFinacPlan(leaseMoneyByFianc, lease_interval, firstMoneyFinac,
				rentScale, type, grace, delay, ht_plan);

		return ht_plan;

	}


	/**
	 * �������ƻ�����
	 * 
	 * @param lease_interval
	 * @param firstMoneyFinac
	 * @param ht_plan
	 */
	@SuppressWarnings("unchecked")
	private void getFinacPlan(String leaseMoneyByFianc, String lease_interval,
			String firstMoneyFinac, String rentScale, String type,
			String grace, String delay, Hashtable ht_plan) {
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";
		
		// �������ƻ�����
		List rent_list = (List) ht_plan.get("rent_list");
		// ����irr
		SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
		String finac_irr = slrcu.getIrr(firstMoneyFinac, rent_list,
				lease_interval, type, delay,grace);

		// /ÿ�ڼ��������
		String pre_fina_irr = ToolUtil.getPreRate(String.valueOf(Double
				.parseDouble(finac_irr) * 100), lease_interval);
		// String leaseMoneyFinac = "0";
		// if (firstMoneyFinac.indexOf("-") > -1) {
		// leaseMoneyFinac = Tools.formatNumberDoubleTwo(firstMoneyFinac
		// .substring(1));
		// }

		// �������Ϣֵ
		// 2010-12-08 rentScale-->newScale �������֮���
		String newScale = "2";
		if (Integer.parseInt(grace) > 0) {// ����п�����ʱ��һ�ڲ����ر���
			type = "-1";

		}
		List inter_fina_list = slrcu.getInterestList(rent_list,
				leaseMoneyByFianc, pre_fina_irr, type, newScale, grace, delay);
		// ���񱾽�
		List corpus_fina_list = slrcu.getCorpusList(rent_list, inter_fina_list,
				newScale, grace, delay);
		// ���񱾽����
		List corpusOverage_fina_list = slrcu.getCorpusOvergeList(
				leaseMoneyByFianc, corpus_fina_list, newScale);

		ht_plan.put("finac_irr", finac_irr);// ����irrδ����100
		ht_plan.put("inter_fina_list", inter_fina_list);// �������Ϣֵ
		ht_plan.put("corpus_fina_list", corpus_fina_list);// ���񱾽�
		ht_plan.put("corpusOverage_fina_list", corpusOverage_fina_list); // ���񱾽����
	}


	/**
	 * �г����ƻ�����
	 * 
	 * @param leaseMoney
	 * @param income_number
	 * @param yearRate
	 * @param lease_interval
	 * @param firstMoney
	 * @param ht_plan
	 */
	@SuppressWarnings("unchecked")
	private void getMarketPlan(String leaseMoney, String income_number,
			String yearRate, String lease_interval, String firstMoney,
			String type, String plan_date, String rentScale, String grace,
			String delay, Hashtable ht_plan) {
		
		
		//2011-05-11�ӳ��ڸ��ӳ����޸�
		delay="0";
		
		SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();

		// 2010-12-08 rentScale-->newScale �������֮���
		String newScale = "2";
		// �õ�����list
		List corpus_market = slrcu.getCorpusList(leaseMoney, income_number,
				newScale, grace, delay);
		// �õ��������

		List corpusOverge_market = slrcu.getCorpusOvergeList(leaseMoney,
				corpus_market, newScale);
		// ����б�
		List rent_list = slrcu.getRentList(leaseMoney, income_number, yearRate,
				lease_interval, rentScale, grace, delay);
		// ��Ϣ�б�
		List inter_list = slrcu.getInterMarket(rent_list, corpus_market,
				newScale);
		// �ƻ�����
		List date_list = slrcu.getPlanDateList(rent_list, type, lease_interval,
				plan_date, grace, delay);

		// �г���irr
		String market_irr = slrcu.getIrr(firstMoney, rent_list, lease_interval,
				type, delay,grace);

		ht_plan.put("date_list", date_list); // �ƻ�����
		ht_plan.put("rent_list", rent_list);// �õ�����list
		ht_plan.put("corpus_market", corpus_market); // �õ�����list
		ht_plan.put("inter_list", inter_list); // ��Ϣ�б�
		ht_plan.put("corpusOverge_market", corpusOverge_market); // �õ��������
		ht_plan.put("market_irr", market_irr);// �г�irrδ����100
	}


	public static void main(String[] args) {
		SettledLaw sl = new SettledLaw();
		Hashtable ht = sl.getPlanInfo("15000000", "15000000", "18", "6.0", "1",
				"-15000000", "-15000000", "1", "2010-6-25", "0", "3", "2");

		System.out.println("�г�irr:" + ht.get("market_irr").toString());
		System.out.println("����irr:" + ht.get("finac_irr").toString());
		List date_list = (List) ht.get("date_list");

		List rent_list = (List) ht.get("rent_list");
		List corpus_market = (List) ht.get("corpus_market");
		List inter_list = (List) ht.get("inter_list");
		List corpusOverge_market = (List) ht.get("corpusOverge_market");

		List inter_fina_list = (List) ht.get("inter_fina_list");
		List corpus_fina_list = (List) ht.get("corpus_fina_list");
		List corpusOverage_fina_list = (List) ht.get("corpusOverage_fina_list");

		System.out.println("------------------�г����ƻ�-------------");
		System.out.println("ʱ��\t\t���\t����\t��Ϣ\t�������");
		for (int i = 0; i < rent_list.size(); i++) {
			System.out.println(date_list.get(i).toString() + "\t"
					+ rent_list.get(i).toString() + "\t"
					+ corpus_market.get(i).toString() + "\t"
					+ inter_list.get(i).toString() + "\t"
					+ corpusOverge_market.get(i).toString() + "\t");
		}
		System.out.println("------------------�������ƻ�-------------");
		System.out.println("ʱ��\t\t���\t����\t��Ϣ\t�������");
		for (int i = 0; i < rent_list.size(); i++) {
			System.out.println(date_list.get(i).toString() + "\t"
					+ rent_list.get(i).toString() + "\t"
					+ corpus_fina_list.get(i).toString() + "\t"
					+ inter_fina_list.get(i).toString() + "\t"
					+ corpusOverage_fina_list.get(i).toString() + "\t");
		}

	}
}
