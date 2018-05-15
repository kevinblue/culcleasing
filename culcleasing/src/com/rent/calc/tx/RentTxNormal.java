package com.rent.calc.tx;

import java.util.HashMap;
import java.util.List;

import com.Tools;


/**
 * ��������µĵ�Ϣʱ
 * 
 * @author shf
 * 
 */
public class RentTxNormal {

	

	/**
	 * ���¼������,�����ʱ仯ʱ
	 * 
	 * @param mp
	 * @throws Exception
	 */

	public void calRentByNew(HashMap mp, String contract_id) throws Exception {

		// �õ��µ����
		RentTx rtx = new RentTx();
		// ��������µ���𣬳��˿�����
		String rent = CalcUtil.getRentByPmt(mp);

		// �õ����List,�п����������������
		List retn_list = rtx.eqRentList(rent, mp.get("rem_rent_list")
				.toString(), mp);

		String nextTerm = mp.get("nextTerm").toString();
		String qzOrqm = mp.get("period_type").toString();
		String income_number_year = mp.get("income_number_year").toString();
		// �ж��ǲ��ǵ�һ��
		if (!"1".equals(nextTerm)) {// ���Ǵӵ�һ��,��ʼ��
			qzOrqm = "-1";
		}
		System.out.println("ʣ�౾��" + mp.get("rem_corpus").toString());
		
		// ��Ϊ�ֽ�����������е��ֽ���,///������е�ǰ�ڿ�
		List cash_list = CalcUtil.getCashList(contract_id, nextTerm, mp.get(
				"period_type").toString(), retn_list, mp);

		// irr
		String irr = IrrCalc.getIRR(cash_list, income_number_year,
				income_number_year, String.valueOf(12 / Integer
						.parseInt(income_number_year)));
		irr = Tools.formatNumberDoubleScale(irr, 8);
		
	
		System.out.println(Double.parseDouble(irr)+"�����irr��" + irr+"==" );
		String srate = Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(irr)/ (12 / Integer.parseInt(income_number_year))),8);

	
		// �õ���Ϣ�б�,����
		List interest_list = rtx.getInterestList(retn_list, mp
				.get("rem_corpus").toString(),srate, qzOrqm,mp);

		// �õ�ÿһ�ڵı���
		List corp_list = RentTx.getCorpusList(retn_list, interest_list,mp.get("rentScale").toString());

		// �õ�ÿһ�ڵı������
		List corp__overage_list = RentTx.getCorpusOvergeList(mp.get(
				"rem_corpus").toString(), corp_list,mp.get("rentScale").toString());
		
		
		
		

		// �����г��ġ��г������г���Ϣ���г�������

		String retu_vale = mp.get("retu_vale").toString();
		// �õ�ÿһ����������
		retu_vale = CalcUtil.getPreRate(retu_vale, income_number_year);

		// �г�����Ϣ�б�,ע���г��Ĳ��㱾�������Ĳ�һ��
		System.out.println("�г���ʣ�౾���ǣ�" + mp.get("corpus_market").toString());
		// �г���Ϣ
		List l_inte_mark = rtx.getInterestList(retn_list, mp.get(
				"corpus_market").toString(), retu_vale, qzOrqm,mp);
		// �г�����
		List l_corpus_market = RentTx.getCorpusList(retn_list, l_inte_mark,mp.get("rentScale").toString());
		// �г��������
		List l_corpus_overage_market = RentTx.getCorpusOvergeList(mp.get(
				"corpus_market").toString(), l_corpus_market,mp.get("rentScale").toString());

		CalcUtil.printRentInfo(retn_list, interest_list, corp_list, corp__overage_list, l_inte_mark, l_corpus_market, l_corpus_overage_market);

		// ��������
		CalcUtil.updateRentPlan(retn_list, interest_list, corp_list,
				corp__overage_list, l_inte_mark, l_corpus_market,
				l_corpus_overage_market, mp.get("proj_id").toString(), mp.get(
						"nextTerm").toString());

	}

	
}
