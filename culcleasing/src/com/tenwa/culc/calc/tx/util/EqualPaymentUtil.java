/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.calc.tx.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.calc.tx.Tx_RentInfoBox;
import com.tenwa.culc.calc.tx.zjcs.RentCalc;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.bean.RentPlanBean;
import com.Tools;
/**
 * �ȶ�������(��Ϣ)
 * @author toybaby
 * Date:Aug 9, 201112:01:23 PM       Email: toybaby@mail2.tenwa.com.cn
 */
public class EqualPaymentUtil {

	/**
	 * ����
	 * 
	 * @param conditionBean
	 * 
	 * @return
	 */
	public static List<RentPlanBean> calc(ConditionBean conditionBean) {
		return null;
	}

	/**
	 * ��õ�Ϣ������ƻ�RentInfoBox
	 * 
	 * @param conditionBean
	 */
	@SuppressWarnings("unchecked")
	public static Tx_RentInfoBox getRentInfoBox(Map<String,String> RentPlan_Map) {
		Tx_RentInfoBox rentInfoBox = new Tx_RentInfoBox();
		
		/**
		 * =======================================================
		 * 
		 * <pre>
		 * �Ȳ������ص�List����
		 * </pre>
		 * 
		 * =======================================================
		 */
		
		// ��������������
		String lease_money = RentPlan_Map.get("lease_money");//ʣ�౾��
		String year_rate = RentPlan_Map.get("year_rate");//��Ϣ��������
		String lease_interval = RentPlan_Map.get("income_number_year");//�����
		String lease_term = RentPlan_Map.get("income_number");//ʣ������
		String assets_value = RentPlan_Map.get("assets_value");//�ʲ���ֵ
		String period_type = RentPlan_Map.get("period_type");//��������
		//�����ȸ��󸶽����ж�ʣ�������Ƿ������һ�ڵ���Ϣ���ȸ�ʱ�����
		String rate = String.valueOf(Double.parseDouble(year_rate) / 12 / 100
				* Integer.parseInt(lease_interval));
		if("1".equals(period_type)){
			lease_money = Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(lease_money)
					+Double.parseDouble(lease_money)*Double.parseDouble(rate)));
		}
		
		// ���������
		List l_rent = new ArrayList();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_corpus_overage = new ArrayList();

		// *** �ȶ���� ������ ****
		// ������֮��װ���������� 
		RentCalc rent = new RentCalc();
		rent.setYear_rate(year_rate); // ������
		rent.setIncome_number(lease_term);// ����
		rent.setLease_money(lease_money);// ���ޱ��� 
		rent.setPeriod_type(period_type);// 1,�ڳ� 0,��δ��ֵ
		rent.setFuture_money(assets_value);// �ʲ���ֵ
		rent.setLease_interval(lease_interval);// �����
		rent.setRentScale("2");// Բ����
		rent.setScale("8");

		// ����������£�������������£� ���Rent��List
		List rent_list = rent.eqRentList(rent.getYear_rate());// �õ����list,ע�ⲻ����ʱ�����list
		System.out.println("rent_list����===="+rent_list.size());
		// ��װHashMap
		HashMap hm = null;
		try {
			hm = rent.getHashRentPlan("1", rent_list);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		// ȡֵ
		l_rent = (List) hm.get("rent");// ���
		l_corpus = (List) hm.get("corpus");// ����
		l_interest = (List) hm.get("interest");// ��Ϣ
		l_corpus_overage = (List) hm.get("corpus_overage");// ʣ�౾��
		for(int i=0;i<l_rent.size();i++){
			System.out.println("rent="+l_rent.get(i)+"  corpus= "+l_corpus.get(i)+"  " +
					"inter="+l_interest.get(i)+"   cor_overge="+l_corpus_overage.get(i));

		}
		
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
