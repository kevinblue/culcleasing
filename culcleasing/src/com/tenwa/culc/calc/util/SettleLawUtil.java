package com.tenwa.culc.calc.util;

import java.util.List;

import com.tenwa.culc.calc.zjcs.RentCalc;
import com.tenwa.culc.calc.zjcs.RentCaleCommonTools;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.bean.RentCashBean;
import com.tenwa.culc.bean.RentInfoBox;

import com.tenwa.culc.calc.zjcs.SetLawRentCaleUtil;

public class SettleLawUtil {

	/**
	 * @author toybaby 2011-07-20
	 * @param conditionBean
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static RentInfoBox getRentInfoBox(ConditionBean conditionBean) {

		RentInfoBox rentInfoBox = new RentInfoBox();
		String contract_id = conditionBean.getContract_id();
		String leaseMoney = String.valueOf(conditionBean.getLease_money());// ���ޱ���
		String income_number = String.valueOf(conditionBean.getIncome_number());// �������
		String yearRate = String.valueOf(conditionBean.getYear_rate());// ������
		String lease_interval = conditionBean.getIncome_number_year();// �����
		String caution_money = conditionBean.getCaution_money();// ��֤��
//		String Other_expenditure = conditionBean.getOther_expenditure();// ����֧��
		String Other_expenditure = conditionBean.getNominalprice();// ��ֵ����
		String assets_value = conditionBean.getAssets_value();// �ʲ���ֵ
		String rentScale = "0";// ���ȷ��
		String newScale = "2";
		String grace = "0";
		String delay = "0";
		String type = "0";// ��ĩ
		conditionBean.setPeriod_type("0");
		String plan_date = conditionBean.getStart_date();// ��������
		String firstMoney = String
				.valueOf("-" + conditionBean.getActual_fund());// �ֽ�����һ������
		// �ֽ������ֵ���
		// װ���������� 9��
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

		SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
		// 2010-12-08 rentScale-->newScale �������֮���
		// ����б�
		List rent_list = slrcu.getRentList(leaseMoney, assets_value,
				income_number, yearRate, lease_interval, rentScale, grace,
				delay);
		System.out.println("���������");
		// ��Ϣ�б�
		List inter_list = slrcu.getInterMarket(rent_list, leaseMoney, yearRate,
				lease_interval, rentScale);
		System.out.println("��Ϣ�������");
		// �õ�����list
		List corpus_market = slrcu.getCorpusList(rent_list, inter_list,
				leaseMoney, assets_value, newScale);
		// ���¼�����Ϣ Ŀ��Ϊ�˴������һ��ʣ�౾��Ϊ0�����
		inter_list = slrcu.getNewInterList(rent_list, corpus_market,
				inter_list, rentScale);
		// �õ��������
		List corpusOverge_market = slrcu.getCorpusOvergeList(String
				.valueOf(conditionBean.getLease_money()), corpus_market,
				newScale);
		// �ƻ�����
		List date_list = slrcu.getPlanDateList(rent_list, type, lease_interval,
				plan_date, grace, delay);

		/*
		 * ///////////////// �ֽ�����IRR����
		 */// //////////////
		RentCaleCommonTools calcTools = new RentCaleCommonTools();
		// irr
		String irr = calcTools.getIrr(firstMoney, rent_list, caution_money,
				assets_value, Other_expenditure, lease_interval, type);
		// �õ���֤��ֿ����List rent_list ���List,caut_money ��֤��
		List l_RentDetails = calcTools.getRentDetails(firstMoney, rent_list,
				date_list, conditionBean);
		/*
		 * 
		 * RentInfoBox ��װ����List
		 * 
		 */
		rentInfoBox.setL_Plan_date(date_list);
		rentInfoBox.setL_Rent(rent_list);
		rentInfoBox.setL_Corpus(corpus_market);
		rentInfoBox.setL_Inter(inter_list);
		rentInfoBox.setL_CorpusOverge(corpusOverge_market);
		rentInfoBox.setL_RentDetails(l_RentDetails);
		rentInfoBox.setIrr(irr);// irrδ����100

		System.out.println("irr==" + irr);
		for (int i = 0; i < l_RentDetails.size(); i++) {
			RentCashBean a = (RentCashBean) l_RentDetails.get(i);
			System.out.println(
			// date_list.get(i)+" rent="+rent_list.get(i)+"
					// cor="+corpus_market.get(i)
					// +" inte="+inter_list.get(i)+"
					// cor_ovg="+corpusOverge_market.get(i));
					// " Details="+l_RentDetails.get(i)
					a.getPlan_date() + "  " + a.getFollow_in() + "  "
							+ a.getFollow_in_detail() + "  "
							+ a.getFollow_out() + "  "
							+ a.getFollow_out_detail() + "  "
							+ a.getNet_follow()

					);

		}

		/**
		 * =======================================================
		 * ��ʼ�������ݿ�����ݣ����׽ṹ��ʱ����Ŀ���ƻ���ʱ����Ŀ����ֽ�����ʱ��
		 * =======================================================
		 */
		System.out.println("���ݿ������ʼ(��Ϣ������)================================");
		// RentDBOperation.execDBOperation(contract_id, conditionBean, irr,
		// date_list, rent_list, corpus_market, inter_list, corpusOverge_market,
		// l_RentDetails, rent, new_rent);

		return rentInfoBox;

	}

}
