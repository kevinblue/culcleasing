package com.tenwa.culc.calc.tx.util;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.calc.tx.Tx_RentInfoBox;
import com.tenwa.culc.calc.tx.zjcs.Tx_EqRatioRentCalc;

public class Tx_EqualRatioRentUtil {

	/**
	 * @author toybaby 2011-07-21
	 * 
	 * @param conditionBean
	 */
	@SuppressWarnings("unchecked")
	public static Tx_RentInfoBox getRentInfoBox(Map<String,String> condition_Map) {
		Tx_RentInfoBox rentInfoBox = new Tx_RentInfoBox();
		// ��������������
		String lease_money = condition_Map.get("lease_money");//ʣ�౾��
		String year_rate = condition_Map.get("year_rate");//��Ϣ��������
		String lease_interval = condition_Map.get("income_number_year");//�����
		String lease_term = condition_Map.get("income_number");//ʣ������
		String assets_value = condition_Map.get("assets_value");//�ʲ���ֵ
		String ratio_param = condition_Map.get("ratio_param");//�����

		// �ֽ������ֵ���
		// װ���������� 9��
		Tx_EqRatioRentCalc calc = new Tx_EqRatioRentCalc();
		calc.setYear_rate(year_rate); // ������
		calc.setIncome_number(lease_term);// ����
		calc.setLease_money(lease_money);// ���ޱ��� 
		calc.setFuture_money(assets_value);// �ʲ���ֵ
		calc.setLease_interval(lease_interval);// �����
		calc.setRatio_param(ratio_param);//����/��
		calc.setRentScale("2");// Բ����
		calc.setScale("8");
		System.out.println("��ʼ�����Ϣ������");

		List l_rent = new ArrayList();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_corpus_overage = new ArrayList();
		Hashtable ht_plan = new Hashtable();
		try {

			ht_plan = calc.getRentPlan();
		} catch (Exception e) {
			e.printStackTrace();
		}

		// ȡֵ
		l_rent = (List) ht_plan.get("rent");// ���
		l_corpus = (List) ht_plan.get("corpus");// ����
		l_interest = (List) ht_plan.get("interest");// ��Ϣ
		l_corpus_overage = (List) ht_plan.get("corpus_overage");// ʣ�౾��

//		for (int i = 0; i < l_rent.size(); i++) {
//			System.out.println(l_plan_date.get(i) + "rent=" + l_rent.get(i)
//					+ "  corpus= " + l_corpus.get(i) + "  " + "inter="
//					+ l_interest.get(i) + "   cor_overge="
//					+ l_corpus_overage.get(i));
//
//		}

		/*
		 * 
		 * RentInfoBox ��װ����List
		 * 
		 */
		rentInfoBox.setL_rent(l_rent);
		rentInfoBox.setL_corpus(l_corpus);
		rentInfoBox.setL_interest(l_interest);
		rentInfoBox.setL_corpus_overage(l_corpus_overage);

		return rentInfoBox;

	}

}
