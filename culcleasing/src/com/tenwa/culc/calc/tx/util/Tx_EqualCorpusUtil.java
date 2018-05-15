package com.tenwa.culc.calc.tx.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.calc.tx.Tx_RentInfoBox;
import com.tenwa.culc.calc.tx.zjcs.Tx_RentCalc;
/**
 * 
 * @author toybaby
 * Date:Aug 12, 201112:13:04 PM       Email: toybaby@mail2.tenwa.com.cn
 */
public class Tx_EqualCorpusUtil {

	/**
	 * ����
	 * 
	 * @param conditionBean
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Tx_RentInfoBox  getRentInfoBox(Map<String,String> condition_Map) {
		/**
		 * =======================================================
		 * 
		 * <pre>
		 * �Ȳ������ص�List����
		 * </pre>
		 * 
		 * =======================================================
		 */
		Tx_RentInfoBox rentInfoBox = new Tx_RentInfoBox();
		//��������������
		String lease_money = condition_Map.get("lease_money");//ʣ�౾��
		String year_rate = condition_Map.get("year_rate");//��Ϣ��������
		String lease_interval = condition_Map.get("income_number_year");//�����
		String lease_term = condition_Map.get("income_number");//ʣ������
		String assets_value = condition_Map.get("assets_value");//�ʲ���ֵ
		String period_type = condition_Map.get("period_type");//��������	
		//�����ȸ��󸶽����ж�ʣ�������Ƿ������һ�ڵ���Ϣ���ȸ�ʱ�����
		// ���������
		List l_rent = new ArrayList();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_corpus_overage = new ArrayList();

		// *****************************************************************************************************
		// *** �ȶ�� ������ ****
		// *****************************************************************************************************
		// ������֮��װ���������� 
		Tx_RentCalc rent = new Tx_RentCalc();
		rent.setYear_rate(year_rate); // ������
		rent.setIncome_number(lease_term);// ����
		rent.setLease_money(lease_money);// ���ޱ��� 
		rent.setPeriod_type(period_type);// 1,�ڳ� 0,��δ��ֵ
		rent.setFuture_money(assets_value);// �ʲ���ֵ
		rent.setLease_interval(lease_interval);// �����
		rent.setRentScale("2");// Բ����
		rent.setScale("8");
		rent.setRentScale("4");// Բ����

		// ==============����������===============

		// ��װHashMap ����������ƻ�
		HashMap hm = null;
		try {
			hm = rent.getPlanByEqCorpus();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// ȡֵ
		l_rent = (List) hm.get("rent");// ���
		l_corpus = (List) hm.get("corpus");// ����
		l_interest = (List) hm.get("interest");// ��Ϣ
		l_corpus_overage = (List) hm.get("corpus_overage");// ʣ�౾��
//		for(int i=0;i<l_rent.size();i++){
//			System.out.println("rent="+l_rent.get(i)+"  corpus= "+l_corpus.get(i)+"  " +
//					"inter="+l_interest.get(i)+"   cor_overge="+l_corpus_overage.get(i));
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