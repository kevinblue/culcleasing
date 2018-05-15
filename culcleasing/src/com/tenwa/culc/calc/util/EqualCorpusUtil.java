package com.tenwa.culc.calc.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.tenwa.culc.calc.zjcs.RentCalc;
import com.tenwa.culc.calc.zjcs.RentCaleCommonTools;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.bean.RentInfoBox;
import com.tenwa.culc.bean.RentPlanBean;
/**
 * 
 * 
 * @author toybaby
 * Date: Jul 13, 2011 
 */
public class EqualCorpusUtil {

	/**
	 * ����
	 * 
	 * @param conditionBean
	 * @return
	 */
	public static List<RentPlanBean> calc(ConditionBean conditionBean){
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public static RentInfoBox  getRentInfoBox(ConditionBean conditionBean) {
		/**
		 * =======================================================
		 * 
		 * <pre>
		 * �Ȳ������ص�List����
		 * </pre>
		 * 
		 * =======================================================
		 */
		RentInfoBox rentInfoBox = new RentInfoBox();
		String contract_id = conditionBean.getContract_id();
		List l_RentDetails = new ArrayList();
		List l_plan_date = new ArrayList();
		//Irr��������
		String firstMoney= String.valueOf("-"+conditionBean.getActual_fund());//�ֽ�����һ������
		String lease_interval = conditionBean.getIncome_number_year();//�����
		String caution_money=conditionBean.getCaution_money();//��֤��
//		String Other_expenditure = conditionBean.getOther_expenditure();//����֧��
		String Other_expenditure = conditionBean.getNominalprice();//��ֵ����
		String assets_value = conditionBean.getAssets_value();//�ʲ���ֵ
		String type = conditionBean.getPeriod_type();
		// ���������
		List l_rent = new ArrayList();
		List l_corpus = new ArrayList();
		List l_interest = new ArrayList();
		List l_corpus_overage = new ArrayList();

		// *****************************************************************************************************
		// *** �ȶ�� ������ ****
		// *****************************************************************************************************
		// ���һ ���������
		// ������֮��װ���������� 9��
		RentCalc rent = new RentCalc();
		rent.setYear_rate(conditionBean.getYear_rate()); // ������
		rent.setIncome_number(conditionBean.getIncome_number());// ����
		rent.setLease_money(conditionBean.getLease_money());// ���ޱ��� �����ޱ��� = �豸���
		// - �׸��
		rent.setFuture_money(conditionBean.getAssets_value());// ������
		rent.setPeriod_type(conditionBean.getPeriod_type());// 1,�ڳ� 0,��δ��ֵ
		rent.setIrr_type("2");// 1,Ϊ���·ݵĴ�; 2,Ϊ��������Ĵ��� ��ʱ��2
		rent.setScale("8");// irr��С��λ�� ��ʱ����8λ
		rent.setLease_interval(conditionBean.getIncome_number_year());// �����
		// (���ⷽʽ)
		rent.setPlan_date(conditionBean.getStart_date());// ÿ�³����� �滻 �����յľ�������
		if ("".equals(contract_id) || contract_id == null) {
			rent.setContract_id(conditionBean.getProj_id());// ���������Ŀ�ֽ�����KEY
		} else {
			rent.setContract_id(conditionBean.getContract_id());// ���������Ŀ�ֽ�����KEY
		}
		rent.setRentScale("4");// Բ����

		// �����ĸ��ֶ� ��**************** �����г�IRR����ĸ�������
		// *****************�����޸�ʱ��2011-07-13��
		Double mon = Double.parseDouble(conditionBean.getLease_money())
				- Double.parseDouble(conditionBean.getAssets_value());
		//System.out.println("ʵ�ʱ���Cle_cau_Money="+mon);
		rent.setCle_cau_Money(mon.toString());// ��ƾ���� lease_money- �ʲ���ֵNominalprice
		// caution_money
		rent.setCauti_Money(conditionBean.getCaution_money());// ��֤��
		rent.setFuture_money(conditionBean.getNominalprice());// ��ĩ��ֵ
		rent.setStart_date(conditionBean.getStart_date());// ��֤�������ʱ��

		// ��������ֽ�����װ ��Ҫ�� ���ޱ��������ѣ���ѯ�� ��
		List<String> llist_case = new ArrayList<String>();//
		List<String> list_date = new ArrayList<String>();//
		// �޸ģ�-�����ʶ� net_lease_money-��֤�� caution_money �����IRR
		Double list_mon = (Double.parseDouble(conditionBean.getActual_fund()) + Double
				.parseDouble(conditionBean.getCaution_money()))
				* -1;
		llist_case.add(list_mon.toString());
		list_date.add(conditionBean.getStart_date());

		//rent.setPreCash(llist_case);//
		//rent.setPreDate(list_date);//

		System.out.println("�����ʶ�Ϊ==>" + conditionBean.getActual_fund());
		System.out.println("��֤��==>" + conditionBean.getCaution_money());
		System.out.println("�豸��==>" + conditionBean.getEquip_amt());
		System.out.println("ֵΪ==>" + list_mon);
		System.out.println("����==>" + conditionBean.getStart_date());

		// ==============����������===============

		// ��װHashMap ����������ƻ�
		HashMap hm = null;
		try {
			hm = rent.getPlanByEqCorpus();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// ȡֵ
		l_plan_date = (List) hm.get("plan_date");// ��𳥻�����
		l_rent = (List) hm.get("rent");// ���
		l_corpus = (List) hm.get("corpus");// ����
		l_interest = (List) hm.get("interest");// ��Ϣ
		l_corpus_overage = (List) hm.get("corpus_overage");// ʣ�౾��
		for(int i=0;i<l_rent.size();i++){
			System.out.println("rent="+l_rent.get(i)+"  corpus= "+l_corpus.get(i)+"  " +
					"inter="+l_interest.get(i)+"   cor_overge="+l_corpus_overage.get(i));

		}

		
		/*/////////////////
		 * �ֽ�����IRR����
		 */////////////////
		RentCaleCommonTools  calcTools = new RentCaleCommonTools();
		// irr
		String irr = calcTools.getIrr(firstMoney, l_rent, caution_money, assets_value, Other_expenditure, lease_interval, type);
		System.out.println("Irr==="+irr);
		// �õ���֤��ֿ����List rent_list ���List,caut_money ��֤��
		 l_RentDetails = calcTools.getRentDetails(firstMoney,l_rent,l_plan_date,conditionBean);
		/*
		 * 
		 * RentInfoBox ��װ����List
		 * 
		 */
		rentInfoBox.setL_Plan_date(l_plan_date);
		rentInfoBox.setL_Rent(l_rent);
		rentInfoBox.setL_Corpus(l_corpus);
		rentInfoBox.setL_Inter(l_interest);
		rentInfoBox.setL_CorpusOverge(l_corpus_overage);
		rentInfoBox.setL_RentDetails(l_RentDetails);
		rentInfoBox.setIrr(irr);//irrδ����100


	
		/**
		 * =======================================================
		 * ��ʼ�������ݿ�����ݣ����׽ṹ��ʱ����Ŀ���ƻ���ʱ����Ŀ����ֽ�����ʱ��
		 * =======================================================
		 */
		System.out.println("���ݿ������ʼ(�ȶ�����)================================");
//		RentDBOperation.execDBOperation(contract_id, conditionBean, irr,
//				l_plan_date, l_rent, l_corpus, l_interest, l_corpus_overage,
//				l_RentDetails, rent, new_rent);
		return rentInfoBox;

		
	}		
	
}
