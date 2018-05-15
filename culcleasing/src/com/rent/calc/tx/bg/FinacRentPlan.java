package com.rent.calc.tx.bg;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

/**
 * �������ƻ�����
 * 
 * @author shf
 * 
 */
public class FinacRentPlan {

	/**
	 * ���������Ϣ�ĸ���
	 * 
	 * @param proj_id
	 * @param start_term
	 * @param add_value
	 * @throws Exception
	 * @throws SQLException
	 */

	@SuppressWarnings("static-access")
	public void proceFinaceInfo(String proj_id, String start_term,String txrq)
			throws Exception, SQLException {

		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(proj_id);
		String ajdustStyle = ht.get("ajdustStyle").toString();
		
		String start_term_temp = new String(start_term);
		if (!"2".equals(ajdustStyle)) {//�Ǵ���ʱ
			  start_term_temp = new String(String.valueOf(Integer
					.parseInt(start_term) - 1));
		}
		
		if (ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term_temp)) {// �п�����ʱ

			// �Ƚ��жԿ����� �����ƻ��Ĵ���
			for (int i = Integer.parseInt(start_term_temp); i <= Integer
					.parseInt(ht.get("grace").toString()); i++) {// ѭ����������ڵ����ƻ�
				FundRentPlan frp = new FundRentPlan();
				frp.proceFinacRentPlan(proj_id, start_term_temp);
				start_term_temp = String.valueOf(Integer
						.parseInt(start_term_temp) + 1);
			}

			//2011-04-15�޸�,�����ڲ���irr����
			start_term_temp=String.valueOf(Integer.parseInt(ht.get("grace").toString())+1);
		
			// ��һ�ڴ��� �õ��µ�irr ���˴��ڵ�Ҫ�����һ���⣬���಻Ҫ����
			String new_irr = proceFirstRentPlanFinac(proj_id, txrq,
					start_term_temp);
			System.out.println("����irr:"+new_irr);
			// �������ڴδ���
			proceCROhterFinace(proj_id, start_term_temp, new_irr);
			

		} else {// ��������ʱ

			// ����ʣ�౾��
			
			if ("0".equals(ajdustStyle) || "1".equals(ajdustStyle) || "3".equals(ajdustStyle)) {//���գ����£�����һ�ε�Ϣʱ
				  start_term_temp = new String(String.valueOf(Integer
						.parseInt(start_term) ));
			}
		
			

			FundRentPlan frp = new FundRentPlan();
			List flow = frp.getIrrFisrtSumCorpFina(proj_id, start_term_temp);
			// ����µ�����б�
			flow = frp.getOtherFlowRent(proj_id, String.valueOf(Integer
					.parseInt(start_term_temp) - 1), flow);
			// ������µĲ���irr��ֵ
			Hashtable ht_jg = ci.getChjg(proj_id);
			String fina_irr = IrrCalc.getIRR(flow, ht_jg.get("chjg").toString(),
					ht_jg.get("zjjg").toString(), ht_jg.get("nhkcs").toString());
			fina_irr = Tools.formatNumberDoubleScale(fina_irr, 14);
			System.out.println("����irr:"+fina_irr);
			// ���²���irr��ֵ
			ci.updateFinaIrr(proj_id, fina_irr);

			// ���²������ƻ�
			updateFinaceRentInfo(proj_id, start_term_temp, frp, flow, ci, ht_jg,
					fina_irr);

		}

	}

	/**
	 * ���²������ƻ�
	 * 
	 * @param proj_id
	 * @param start_term
	 * @param frp
	 * @param flow
	 * @param ci
	 * @param ht
	 * @param fina_irr
	 * @throws Exception
	 * @throws SQLException
	 */
	private void updateFinaceRentInfo(String proj_id, String start_term,
			FundRentPlan frp, List flow, CoditionInfo ci, Hashtable ht,
			String fina_irr) throws Exception, SQLException {
		// ����µ���Ϣ�б�
		String scorps = "0";
		if (flow.size() > 0) {
			scorps = flow.get(0).toString();
		}
		if (scorps.indexOf("-") > -1) {
			scorps = scorps.substring(1);
		}
		// ���������
		// irrֵ / �껹�����
		fina_irr = String.valueOf(Double.parseDouble(fina_irr)
				/ Integer.parseInt(ht.get("nhkcs").toString()));
		// ����б�
		List new_rent = new ArrayList();

		new_rent = frp.getOtherFlowRent(proj_id, String.valueOf(Integer
				.parseInt(start_term) - 1), new_rent);
		String type = ci.getType(proj_id, start_term);
		String rentScale = ci.getRentScale(proj_id);
		// 2010-12-07 �������֮������ı�����λС��
		rentScale = "2";
		List interest = CommonUtil.getInterestList(new_rent, scorps, fina_irr,
				type, rentScale);
		// ����µı����б�
		List corpusList = CommonUtil.getCorpusList(new_rent, interest,
				rentScale);
		// ����±�������б�
		List corpusOvergeList = CommonUtil.getCorpusOvergeList(scorps,
				corpusList, rentScale);
		// ���²���ƻ���Ϣ
		frp.processFinacePlan(proj_id, start_term, interest, corpusList,
				corpusOvergeList);
	}

	/**
	 * �������ƻ��޸�
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("static-access")
	public void proceFinacRentPlan(String contract_id, String txrq,
			String start_term) throws SQLException, Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		String start_term_temp = new String(String.valueOf(Integer
				.parseInt(start_term) - 1));
		if (ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term_temp)) {// �п�����ʱ

			// �Ƚ��жԿ����� �����ƻ��Ĵ���
			for (int i = Integer.parseInt(start_term_temp); i <= Integer
					.parseInt(ht.get("grace").toString()); i++) {// ѭ����������ڵ����ƻ�
				FundRentPlan frp = new FundRentPlan();
				frp.proceFinacRentPlan(contract_id, start_term_temp);
				start_term_temp = String.valueOf(Integer
						.parseInt(start_term_temp) + 1);
			}

			
			//2011-04-15�޸�,�����ڲ���irr����
			start_term_temp=String.valueOf(Integer.parseInt(ht.get("grace").toString())+1);
			
			// ��һ�ڴ��� �õ��µ�irr ���˴��ڵ�Ҫ�����һ���⣬���಻Ҫ����
			String new_irr = proceFirstRentPlanFinac(contract_id, txrq,
					start_term_temp);
			
		System.out.println("����irr:"+new_irr);
			// �������ڴδ���
			proceCROhterFinace(contract_id, start_term_temp, new_irr);

		} else {// ��������ʱ
			// ��һ�ڴ��� �õ��µ�irr ���˴��ڵ�Ҫ�����һ���⣬���಻Ҫ����
			String new_irr = proceFirstRentPlanFinac(contract_id, txrq,
					start_term);
			
			System.out.println("����irr:"+new_irr);
			// �������ڴδ���
			proceCROhterFinace(contract_id, start_term, new_irr);

		}

	}

	/**
	 * ����irr����
	 * 
	 * @param contract_id
	 * @param start_term
	 * @return
	 * @throws SQLException
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public String proceFinacIrrValue(String contract_id, String start_term)
			throws SQLException, Exception {
		// ����ʣ�౾��
		FundRentPlan frp = new FundRentPlan();
		List flow = frp.getIrrFisrtSumCorpFina(contract_id, start_term);

		// �����ڴ����ֵ 2010-12-20�޸�
		// ������µĲ���irr��ֵ
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
		String othere_rent = start_term;
		if ("1".equals(mp.get("measure_type").toString())) {// �ȶ����ʱ
			othere_rent = String.valueOf(Integer.parseInt(start_term) - 1);
		}

		// ����µ�����б�
		flow = frp.getOtherFlowRent(contract_id, othere_rent, flow);

		Hashtable ht = ci.getChjg(contract_id);
		String fina_irr = IrrCalc.getIRR(flow, ht.get("chjg").toString(), ht
				.get("zjjg").toString(), ht.get("nhkcs").toString());

		// ����irr��ֵ
		ci.updateFinaIrr(contract_id, fina_irr);
		return fina_irr;
	}

	/**
	 * ���²���ĵ�һ�����ƻ���Ϣ
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws SQLException
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public String proceFirstRentPlanFinac(String contract_id, String txrq,
			String start_term) throws SQLException, Exception {

		// �ȵõ��µ�irr
		
		String new_irr = proceFinacIrrValue(contract_id, start_term);
		new_irr = String.valueOf(Double.parseDouble(new_irr) * 100);
		System.out.println("����irr:"+new_irr);

		// ///////////////////////////

//		// ��Ϣ�����ڴ�
//		CoditionInfo ci = new CoditionInfo();
//		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
//
//		String ajdustStyle = mp.get("ajdustStyle").toString();
//		if ("2".equals(ajdustStyle)) { // ����ʱ
//			// ����
//			FundRentPlan frp = new FundRentPlan();
//			String o_start = new String( start_term);
//			if(mp.get("grace") != null
//			&& Integer.parseInt(mp.get("grace").toString()) >= Integer
//					.parseInt(start_term)){
//				o_start = String.valueOf(Integer.parseInt(start_term)-1);
//				
//				String first_corpus = frp.getTotalCorpusFinacByQc(contract_id,
//						start_term);
//				String first_inter = CommonUtil.getFirstInterest(contract_id, txrq,
//						start_term, new_irr, first_corpus);
//
//				// �õ�ԭ������
//				String old_corpus = frp.getDqCorpusFinac(contract_id, start_term);
//				String dqzj = frp.getDqZj(contract_id, start_term);
//				String dqcorpus = String.valueOf(Double.parseDouble(dqzj)
//						- Double.parseDouble(first_inter));
//
//				// �����ֵ
//				String cha_old_new_corp = String.valueOf(Double
//						.parseDouble(dqcorpus)
//						- Double.parseDouble(old_corpus));
//				// �������ڲ����ʣ�౾��ֵ
//				String total_corpus = String.valueOf(Double
//						.parseDouble(first_corpus)
//						+ Double.parseDouble(cha_old_new_corp));
//
//				// �޸� 2010-12-07 ʣ�౾��ֵ = ��һ�ڵı����ֵ����һ�ڱ���ֵ
//				total_corpus = String.valueOf(Double.parseDouble(first_corpus)
//						- Double.parseDouble(dqcorpus));
//
//				// ���µ�һ�ڵ����ƻ���Ϣ
//				frp.updateSignFinacPlan(contract_id, start_term, first_inter,
//						dqcorpus, total_corpus);
//				
//			} else {
//				String first_corpus = frp.getTotalCorpusFinacByQc(contract_id,
//						start_term);
//				String first_inter = CommonUtil.getFirstInterest(contract_id, txrq,
//						start_term, new_irr, first_corpus);
//
//				// �õ�ԭ������
//				String old_corpus = frp.getDqCorpusFinac(contract_id, start_term);
//				String dqzj = frp.getDqZj(contract_id, start_term);
//				String dqcorpus = String.valueOf(Double.parseDouble(dqzj)
//						- Double.parseDouble(first_inter));
//
//				// �����ֵ
//				String cha_old_new_corp = String.valueOf(Double
//						.parseDouble(dqcorpus)
//						- Double.parseDouble(old_corpus));
//				// �������ڲ����ʣ�౾��ֵ
//				String total_corpus = String.valueOf(Double
//						.parseDouble(first_corpus)
//						+ Double.parseDouble(cha_old_new_corp));
//
//				// �޸� 2010-12-07 ʣ�౾��ֵ = ��һ�ڵı����ֵ����һ�ڱ���ֵ
//				total_corpus = String.valueOf(Double.parseDouble(first_corpus)
//						- Double.parseDouble(dqcorpus));
//
//				// ���µ�һ�ڵ����ƻ���Ϣ
//				frp.updateSignFinacPlan(contract_id, start_term, first_inter,
//						dqcorpus, total_corpus);
//				
//			}
//					
//			
//		}
		return new_irr;

	}

	/**
	 * �����ڴε���� ���� ����
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param rateValue
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceCROhterFinace(String contract_id, String start_term,
			String rateValue) throws Exception {

		// �������
		FundRentPlan frp = new FundRentPlan();

		// 2010-12-20 �޸�
		// �����ڴ����ֵ 2010-12-20�޸�
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
		String othere_rent = start_term;
		if ("1".equals(mp.get("measure_type").toString())) {// �ȶ����ʱ
			othere_rent = String.valueOf(Integer.parseInt(start_term) - 1);
		}

		String remCorpus = frp
				.getTotalCorpusFinacByQc(contract_id, othere_rent);

		// ������Ϣ�����𣬱������
		List rent_list = new ArrayList();
		rent_list = frp.getOtherFlowRent(contract_id, othere_rent, rent_list);
		String qzOrqm = ci.getType(contract_id, othere_rent);

		String rentScale = ci.getRentScale(contract_id);
		// 2010-12-07 �������֮������ı�����λС��
		rentScale = "2";

		String income_number_year = mp.get("income_number_year").toString();
		String retu_vale = Tools.formatNumberDoubleScale(ToolUtil.getPreRate(
				rateValue, income_number_year), 12);

		List l_inte = CommonUtil.getInterestList(rent_list, remCorpus,
				retu_vale, qzOrqm, rentScale);

		// ����
		List l_corpus = CommonUtil.getCorpusList(rent_list, l_inte, rentScale);
		// �������
		List l_corpus_overage = CommonUtil.getCorpusOvergeList(remCorpus,
				l_corpus, rentScale);

		// �������ƻ���
		frp
				.processFinacePlan(contract_id, String.valueOf(Integer
						.parseInt(othere_rent) + 1), l_inte, l_corpus,
						l_corpus_overage);

	}

}
