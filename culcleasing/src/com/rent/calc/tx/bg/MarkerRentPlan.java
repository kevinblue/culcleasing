package com.rent.calc.tx.bg;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;
import com.rent.calc.settlaw.SetLawRentCaleUtil;

/**
 * �г����ƻ�����
 * 
 * @author shf
 * 
 */
public class MarkerRentPlan {
	/**
	 * �õ����г���irrֵ
	 * 
	 * @param proj_id
	 * @param start_term
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public void processMarketIrr(String proj_id, String start_term)
			throws Exception, SQLException {
		FundRentPlan frp = new FundRentPlan();
		List flow = new ArrayList();

		CoditionInfo ci = new CoditionInfo();
		String getAdjustSty = ci.getAdjustSty(proj_id);
		String fstart = start_term;
		if ("2".equals(getAdjustSty) || "".equals(getAdjustSty)) {// �̶���ֵ ʱ
			fstart = String.valueOf(Integer.parseInt(fstart) - 1);
		}

		flow.add("-" + frp.getTotalCorpusByQc(proj_id, fstart));

		String slist = String.valueOf(Integer.parseInt(start_term) - 1);

		if ("3".equals(getAdjustSty) || "0".equals(getAdjustSty)
				|| "1".equals(getAdjustSty) || "3".equals(getAdjustSty)) {
			slist = String.valueOf(Integer.parseInt(start_term));
		}
		flow = frp.getOtherFlowRent(proj_id, slist, flow);

		Hashtable ht = ci.getChjg(proj_id);

		String marker_irr = IrrCalc.getIRR(flow, ht.get("chjg").toString(), ht
				.get("zjjg").toString(), ht.get("nhkcs").toString());
		marker_irr = Tools.formatNumberDoubleScale(marker_irr, 12);
		// �����г�irr��ֵ
		ci.updateMarkerIrr(proj_id, marker_irr);

	}


	/**
	 * �̶���ֵ �г�����
	 * 
	 * @param proj_id
	 * @param start_term
	 * @param add_value
	 * @throws Exception
	 * @throws SQLException
	 */
	public void processMarketRentPlan(String proj_id, String start_term,
			String add_value) throws SQLException, Exception {
		FundRentPlan frp = new FundRentPlan();
		// �޸����г����ƻ�,��ӹ̶�ֵ��ͨ�������������
		frp.proceMarkerInfo(proj_id, String.valueOf(Integer
				.parseInt(start_term) + 1), add_value);
		// �޸��г���irr
		processMarketIrr(proj_id, String
				.valueOf(Integer.parseInt(start_term) + 1));
	}


	/**
	 * �г����ƻ�����
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param txrq
	 * @param rateValue
	 * @throws Exception
	 */

	@SuppressWarnings("static-access")
	public void proceMarketRentInfo(String contract_id, String start_term,
			String txrq, String rateValue) throws Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
		String start_term_temp = new String(start_term);

		if (mp.get("grace") != null
				&& Integer.parseInt(mp.get("grace").toString()) >= Integer
						.parseInt(start_term)) {// �п�����ʱ

			// /////
			String dqcorpus = "0";
			String total_corpus = "0";
			for (int i = Integer.parseInt(start_term_temp); i <= Integer
					.parseInt(mp.get("grace").toString()); i++) {// ѭ����������ڵ����ƻ�

				// �г�
				FundRentPlan frp = new FundRentPlan();
				String first_corpus = frp.getIrrFisrtSumCorpMarker(contract_id,
						start_term_temp).get(0).toString();
				if (first_corpus.indexOf("-") > -1) {
					first_corpus = first_corpus.substring(1);

				}
				String first_inter = "0";
				String income_number_year = mp.get("income_number_year")
						.toString();
				String rentScale = mp.get("rentScale").toString();
				ToolUtil tu = new ToolUtil();
				String preRate = tu.getPreRate(rateValue, income_number_year);
				// �µ���Ϣ
				first_inter = Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(preRate)
								* Double.parseDouble(first_corpus)), Integer
						.parseInt(rentScale));

				String dqzj = first_inter;// ���ޱ���Ϊ0,���������Ϣ
				dqcorpus = String.valueOf(Double.parseDouble(dqzj)
						- Double.parseDouble(first_inter));
				// �������ڲ����ʣ�౾��ֵ
				total_corpus = String.valueOf(Double.parseDouble(first_corpus)
						- Double.parseDouble(dqcorpus));
				total_corpus = Tools.formatNumberDoubleTwo(total_corpus);
				// ���µ�һ�ڵ����ƻ���Ϣ
				frp.updateSignMarkerPlan(contract_id, start_term_temp,
						first_inter, dqcorpus, total_corpus, rateValue);
				frp.updateMarketRentPlanByGrace(contract_id, start_term_temp);
				start_term_temp = String.valueOf(Integer
						.parseInt(start_term_temp) + 1);
			}

			// //////////////
			RentCalc rc = new RentCalc();
			String rent = rc.getRentByPmt(rateValue, contract_id, txrq);
			// ��Ϣ�����ڴ�
			String rem_rent_list = "0";
			String ajdustStyle = mp.get("ajdustStyle").toString();

			rem_rent_list = rc.getRemList(contract_id, txrq);
			String corpus_market = rc.getRemMarketCorps(contract_id, txrq);

			if ("2".equals(ajdustStyle)) { // ����ʱ
				// �õ���ʼ�ڴ�,�õ��ܵ����� ʣ������ ���㱾��
				FundRentPlan frp = new FundRentPlan();

				String o_start = mp.get("grace") != null
						&& Integer.parseInt(mp.get("grace").toString()) >= Integer
								.parseInt(start_term) ? String.valueOf(Integer
						.parseInt(mp.get("grace").toString())) : start_term;

				String minRent_list = String
						.valueOf(Integer.parseInt(o_start) + 1);

				String totalCount = frp.getTotalCount(contract_id);

				rem_rent_list = String.valueOf(Integer.parseInt(totalCount)
						- Integer.parseInt(minRent_list) + 1);
				corpus_market = frp.getIrrFisrtSumCorpMarker(contract_id,
						minRent_list).get(0).toString();

			}

			// �õ����List
			List rent_list = rc.eqRentList(rent, rem_rent_list);

			// �г�����Ϣ�б�,ע���г��Ĳ��㱾�������Ĳ�һ��
			FundRentPlan frp = new FundRentPlan();

			if (corpus_market.indexOf("-") > -1) {
				corpus_market = corpus_market.substring(1);
			}

			String qzOrqm = ci.getType(contract_id, start_term_temp);
			String rentScale = ci.getRentScale(contract_id);

			// 2010-12-07 �������֮������ı�����λС��
			rentScale = "2";

			String income_number_year = mp.get("income_number_year").toString();

			// �õ�ÿһ����������
			String retu_vale = Tools.formatNumberDoubleScale(ToolUtil
					.getPreRate(rateValue, income_number_year), 12);

			// �г���Ϣ
			List l_inte_mark = CommonUtil.getInterestList(rent_list,
					corpus_market, retu_vale, qzOrqm, rentScale);

			// �г�����
			List l_corpus_market = CommonUtil.getCorpusList(rent_list,
					l_inte_mark, rentScale);
			// �г��������
			List l_corpus_overage_market = CommonUtil.getCorpusOvergeList(
					corpus_market, l_corpus_market, rentScale);

			// �������ƻ���
			frp.processMarkerPlan(contract_id, start_term_temp, rent_list,
					l_inte_mark, l_corpus_market, l_corpus_overage_market,
					rateValue);
			// �޸��г���irr
			processMarketIrr(contract_id, start_term_temp);

		} else { // ��������ʱ

			RentCalc rc = new RentCalc();
			String rent = rc.getRentByPmt(rateValue, contract_id, txrq);
			// ��Ϣ�����ڴ�
			String rem_rent_list = "0";
			String ajdustStyle = mp.get("ajdustStyle").toString();

			rem_rent_list = rc.getRemList(contract_id, txrq);
			String corpus_market = rc.getRemMarketCorps(contract_id, txrq);

			if ("2".equals(ajdustStyle)) { // ����ʱ
				// �õ���ʼ�ڴ�,�õ��ܵ����� ʣ������ ���㱾��
				FundRentPlan frp = new FundRentPlan();
				String minRent_list = start_term;

				String totalCount = frp.getTotalCount(contract_id);

				rem_rent_list = String.valueOf(Integer.parseInt(totalCount)
						- Integer.parseInt(minRent_list) + 1);
				corpus_market = frp.getIrrFisrtSumCorpMarker(contract_id,
						minRent_list).get(0).toString();

			}

			// �õ����List
			List rent_list = rc.eqRentList(rent, rem_rent_list);

			// �г�����Ϣ�б�,ע���г��Ĳ��㱾�������Ĳ�һ��
			FundRentPlan frp = new FundRentPlan();

			if (corpus_market.indexOf("-") > -1) {
				corpus_market = corpus_market.substring(1);
			}

			String qzOrqm = ci.getType(contract_id, start_term);
			String rentScale = ci.getRentScale(contract_id);

			// 2010-12-07 �������֮������ı�����λС��
			rentScale = "2";

			String income_number_year = mp.get("income_number_year").toString();

			// �õ�ÿһ����������
			String retu_vale = Tools.formatNumberDoubleScale(ToolUtil
					.getPreRate(rateValue, income_number_year), 12);

			// �г���Ϣ
			List l_inte_mark = CommonUtil.getInterestList(rent_list,
					corpus_market, retu_vale, qzOrqm, rentScale);

			// �г�����
			List l_corpus_market = CommonUtil.getCorpusList(rent_list,
					l_inte_mark, rentScale);
			// �г��������
			List l_corpus_overage_market = CommonUtil.getCorpusOvergeList(
					corpus_market, l_corpus_market, rentScale);

			// �������ƻ���
			frp.processMarkerPlan(contract_id, start_term, rent_list,
					l_inte_mark, l_corpus_market, l_corpus_overage_market,
					rateValue);
			// �޸��г���irr
			processMarketIrr(contract_id, start_term);

		}

	}


	/**
	 * �����ڴε���� ���� �г�
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param rateValue
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceCROhterMarket(String contract_id, String start_term,
			String rateValue) throws Exception {

		RentCalc rc = new RentCalc();
		String rent = rc.getRentPLeassMoney(rateValue, contract_id, start_term);

		FundRentPlan frp = new FundRentPlan();
		String total = frp.getTotalCount(contract_id);
		String rem_rent_list = String.valueOf(Integer.parseInt(total)
				- Integer.parseInt(start_term));

		// �õ����List
		List rent_list = rc.eqRentList(rent, rem_rent_list);

		// �г�����Ϣ�б�,ע���г��Ĳ��㱾�������Ĳ�һ��

		String corpus_market = frp.getTotalCorpusByQc(contract_id, start_term);
		CoditionInfo ci = new CoditionInfo();
		String qzOrqm = ci.getType(contract_id, start_term);

		String rentScale = ci.getRentScale(contract_id);

		// 2010-12-07 �������֮������ı�����λС��
		rentScale = "2";

		// �г���Ϣ
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
		String income_number_year = mp.get("income_number_year").toString();
		String retu_vale = Tools.formatNumberDoubleScale(ToolUtil.getPreRate(
				rateValue, income_number_year), 12);
		List l_inte_mark = CommonUtil.getInterestList(rent_list, corpus_market,
				retu_vale, qzOrqm, rentScale);

		// �г�����
		List l_corpus_market = CommonUtil.getCorpusList(rent_list, l_inte_mark,
				rentScale);
		// �г��������
		List l_corpus_overage_market = CommonUtil.getCorpusOvergeList(
				corpus_market, l_corpus_market, rentScale);

		// �������ƻ���

		frp.processMarkerPlan(contract_id, String.valueOf(Integer
				.parseInt(start_term) + 1), rent_list, l_inte_mark,
				l_corpus_market, l_corpus_overage_market, rateValue);
		// �޸��г���irr
		MarkerRentPlan mrp = new MarkerRentPlan();
		mrp.processMarketIrr(contract_id, start_term);

	}


	/**
	 * �����г��ĵ�һ�����ƻ���Ϣ
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws SQLException
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceFirstRentPlan(String contract_id, String txrq,
			String start_term, String rateValue) throws SQLException, Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		String start_term_temp = new String(start_term);
		FundRentPlan frp = new FundRentPlan();
		if (ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term_temp)) {// �п�����ʱ

			// �п����ڵ����ƻ�����
			evalGraceFirst(contract_id, txrq, start_term, rateValue, ht);

		} else {// ��������ʱ

			// �г�

			String first_corpus = frp.getIrrFisrtSumCorpMarker(contract_id,
					start_term).get(0).toString();
			if (first_corpus.indexOf("-") > -1) {
				first_corpus = first_corpus.substring(1);

			}
			String first_inter = CommonUtil.getFirstInterest(contract_id, txrq,
					start_term, rateValue, first_corpus);

			// �õ�ԭ������
			String old_corpus = frp.getDqCorpus(contract_id, start_term);
			String dqzj = frp.getDqZj(contract_id, start_term);
			String dqcorpus = String.valueOf(Double.parseDouble(dqzj)
					- Double.parseDouble(first_inter));

			// �����ֵ
			String cha_old_new_corp = String.valueOf(Double
					.parseDouble(dqcorpus)
					- Double.parseDouble(old_corpus));
			// �������ڲ����ʣ�౾��ֵ
			String total_corpus = String.valueOf(Double
					.parseDouble(first_corpus)
					- Double.parseDouble(cha_old_new_corp));

			// �޸� 2010-11-28 ʣ�౾��ֵ = ��һ�ڵı����ֵ����һ�ڱ���ֵ
			total_corpus = String.valueOf(Double.parseDouble(first_corpus)
					- Double.parseDouble(dqcorpus));

			total_corpus = Tools.formatNumberDoubleTwo(total_corpus);

			// ���µ�һ�ڵ����ƻ���Ϣ
			frp.updateSignMarkerPlan(contract_id, start_term, first_inter,
					dqcorpus, total_corpus, rateValue);

		}

	}


	@SuppressWarnings("static-access")
	private void evalGraceFirst(String contract_id, String txrq,
			String start_term, String rateValue, Hashtable ht)
			throws Exception, SQLException {
		String start_term_temp = new String(start_term);
		int ivalue = Integer.parseInt(start_term);

		// /////
		String dqcorpus = "0";
		String total_corpus = "0";
		for (int i = Integer.parseInt(start_term_temp); i <= Integer
				.parseInt(ht.get("grace").toString()); i++) {// ѭ����������ڵ����ƻ�

			// �г�
			FundRentPlan frp = new FundRentPlan();
			String first_corpus = frp.getIrrFisrtSumCorpMarker(contract_id,
					start_term_temp).get(0).toString();
			if (first_corpus.indexOf("-") > -1) {
				first_corpus = first_corpus.substring(1);

			}

			String first_inter = "0";

			if (i == ivalue) {// ��һ�ڷֶδ���
				first_inter = CommonUtil.getFirstInterest(contract_id, txrq,
						start_term_temp, rateValue, first_corpus);

				String dqzj = first_inter;// ���ޱ���Ϊ0,���������Ϣ
				dqcorpus = String.valueOf(Double.parseDouble(dqzj)
						- Double.parseDouble(first_inter));
				// �������ڲ����ʣ�౾��ֵ
				total_corpus = String.valueOf(Double.parseDouble(first_corpus)
						- Double.parseDouble(dqcorpus));

				total_corpus = Tools.formatNumberDoubleTwo(total_corpus);

				// // ���µ�һ�ڵ����ƻ���Ϣ
				// frp.updateSignMarkerPlan(contract_id, start_term_temp,
				// first_inter,
				// dqcorpus, total_corpus, rateValue);

			} else {

				String income_number_year = ht.get("income_number_year")
						.toString();
				String rentScale = ht.get("rentScale").toString();
				ToolUtil tu = new ToolUtil();
				String preRate = tu.getPreRate(rateValue, income_number_year);
				// �µ���Ϣ
				first_inter = Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(preRate)
								* Double.parseDouble(first_corpus)), Integer
						.parseInt(rentScale));

				String dqzj = first_inter;// ���ޱ���Ϊ0,���������Ϣ
				dqcorpus = String.valueOf(Double.parseDouble(dqzj)
						- Double.parseDouble(first_inter));
				// �������ڲ����ʣ�౾��ֵ
				total_corpus = String.valueOf(Double.parseDouble(first_corpus)
						- Double.parseDouble(dqcorpus));

				total_corpus = Tools.formatNumberDoubleTwo(total_corpus);

			}
			// ���µ�һ�ڵ����ƻ���Ϣ
			frp.updateSignMarkerPlan(contract_id, start_term_temp, first_inter,
					dqcorpus, total_corpus, rateValue);
			frp.updateMarketRentPlanByGrace(contract_id, start_term_temp);
			start_term_temp = String
					.valueOf(Integer.parseInt(start_term_temp) + 1);
		}
	}


	// //////////////////////////////////////////////////////

	/**
	 * �г����ƻ����� ƽϢ����Ϣ 2010-12-08
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param txrq
	 * @param rateValue
	 * @throws Exception
	 */

	@SuppressWarnings("static-access")
	public void proceMarketRentInfoBySett(String contract_id,
			String start_term, String txrq, String rateValue) throws Exception {

		// �ж����������Ǵӿ����ڿ�ʼ��
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
		String start_term_temp = new String(start_term);
		String rentScale = ci.getRentScale(contract_id);
		String income_number_year = mp.get("income_number_year").toString();

		FundRentPlan frp = new FundRentPlan();

		if (mp.get("grace") != null
				&& Integer.parseInt(mp.get("grace").toString()) >= Integer
						.parseInt(start_term_temp)) {// �п�����ʱ

			// /////
			for (int i = 1; i <= Integer.parseInt(mp.get("grace").toString()); i++) {// ѭ����������ڵ����ƻ�

				// rateValue
				ToolUtil tu = new ToolUtil();
				String preRate = tu.getPreRate(rateValue, income_number_year);
				// �µ����
				String newRent = Tools.formatNumberDoubleScale(String
						.valueOf(Double.parseDouble(preRate)
								* Double.parseDouble(mp.get("equip_amt")
										.toString())), Integer
						.parseInt(rentScale));

				// �õ�ԭ������
				String old_corpus = frp.getDqCorpus(contract_id,
						start_term_temp);

				// �õ��µ���Ϣ
				String newInterest = Tools.formatNumberDoubleTwo(String
						.valueOf(Double.parseDouble(newRent)
								- Double.parseDouble(old_corpus)));
				// ���µ�һ�ڵ����ƻ���Ϣ
				frp.updateSignMarkerPlan(contract_id, start_term_temp, newRent,
						newInterest, rateValue);

				start_term_temp = String.valueOf(Integer
						.parseInt(start_term_temp) + 1);
			}

			// start_term_temp = String
			// .valueOf(Integer.parseInt(start_term_temp) + 1);

			start_term = start_term_temp;
			RentCalc rc = new RentCalc();
			String rem_rent_list = "0";
			String ajdustStyle = mp.get("ajdustStyle").toString();
			rem_rent_list = rc.getRemList(contract_id, txrq);
			String corpus_market = rc.getRemMarketCorps(contract_id, txrq);
			String totalCount = "1";
			if ("2".equals(ajdustStyle)) { // ����ʱ
				// �õ���ʼ�ڴ�,�õ��ܵ����� ʣ������ ���㱾��
				String minRent_list = start_term;
				totalCount = frp.getTotalCount(contract_id);
				rem_rent_list = String.valueOf(Integer.parseInt(totalCount)
						- Integer.parseInt(minRent_list) + 1);
				corpus_market = frp.getIrrFisrtSumCorpMarker(contract_id,
						minRent_list).get(0).toString();

			}

			SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();

			// ����µ����list
			// ����б� �µ����ֻ���������й� �µ����list
			List rent_list = slrcu.getRentListByCount(mp.get("equip_amt")
					.toString(), totalCount, rateValue, income_number_year,
					rentScale, rem_rent_list);

			// �г�����Ϣ�б�,ע���г��Ĳ��㱾�������Ĳ�һ��

			if (corpus_market.indexOf("-") > -1) {
				corpus_market = corpus_market.substring(1);
			}

			// ��ϢС��λ
			String newScale = "2";
			// �õ�����list
			List l_corpus_market = frp.getCorpsMarker(contract_id, start_term);
			// �õ��µ���Ϣ
			List inter_list = slrcu.getInterMarket(rent_list, l_corpus_market,
					newScale);

			// �������ƻ���
			frp.updateMarkerPlanBySet(contract_id, start_term, rent_list,
					inter_list, rateValue);
			// �޸��г���irr
			processMarketIrr(contract_id, start_term);

		} else {// ��������ʱ

			RentCalc rc = new RentCalc();
			// CoditionInfo ci = new CoditionInfo();
			// ��Ϣ�����ڴ�
			// Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);

			// String rentScale = ci.getRentScale(contract_id);
			// String income_number_year =
			// mp.get("income_number_year").toString();

			String rem_rent_list = "0";
			String ajdustStyle = mp.get("ajdustStyle").toString();

			rem_rent_list = rc.getRemList(contract_id, txrq);
			String corpus_market = rc.getRemMarketCorps(contract_id, txrq);
			String totalCount = "1";
			if ("2".equals(ajdustStyle)) { // ����ʱ
				// �õ���ʼ�ڴ�,�õ��ܵ����� ʣ������ ���㱾��
				// FundRentPlan frp = new FundRentPlan();
				String minRent_list = start_term;

				totalCount = frp.getTotalCount(contract_id);

				rem_rent_list = String.valueOf(Integer.parseInt(totalCount)
						- Integer.parseInt(minRent_list) + 1);
				corpus_market = frp.getIrrFisrtSumCorpMarker(contract_id,
						minRent_list).get(0).toString();

			}

			SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();

			// ����µ����list
			// ����б� �µ����ֻ���������й� �µ����list
			List rent_list = slrcu.getRentListByCount(mp.get("equip_amt")
					.toString(), totalCount, rateValue, income_number_year,
					rentScale, rem_rent_list);

			// �г�����Ϣ�б�,ע���г��Ĳ��㱾�������Ĳ�һ��
			// FundRentPlan frp = new FundRentPlan();

			if (corpus_market.indexOf("-") > -1) {
				corpus_market = corpus_market.substring(1);
			}

			// ��ϢС��λ
			String newScale = "2";
			// �õ�����list
			List l_corpus_market = frp.getCorpsMarker(contract_id, start_term);
			// �õ��µ���Ϣ
			List inter_list = slrcu.getInterMarket(rent_list, l_corpus_market,
					newScale);

			// �������ƻ���
			frp.updateMarkerPlanBySet(contract_id, start_term, rent_list,
					inter_list, rateValue);
			// �޸��г���irr
			processMarketIrr(contract_id, start_term);

		}

	}


	/**
	 * 2010-12-09 �����г��ĵ�һ�����ƻ���Ϣ ƽϢ��ʱ ����
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws SQLException
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceFirstRentPlanBySet(String contract_id, String txrq,
			String start_term, String rateValue) throws SQLException, Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		String start_term_temp = new String(start_term);
		if (ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term_temp)) {// �п�����ʱ

			// 2011-04-15�޸�ע��
			// start_term_temp = evalSetGrace(contract_id, txrq, rateValue, ht,
			// start_term_temp);

			// �п����ڵ����ƻ�����
			evalGraceFirst(contract_id, txrq, start_term, rateValue, ht);
			
			
			
			

		} else {// ���������һ����Ϣ����

			getSetFirstInter(contract_id, start_term, rateValue, txrq, ht.get(
					"equip_amt").toString());

		}

	}


	/**
	 * 
	 * TODO (todo-list todo-list ƽϢ����һ�����ƻ�����)
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param rateValue
	 * @param txrq
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void getSetFirstInter(String contract_id, String start_term,
			String rateValue, String txrq, String leassMoney) throws Exception {

		// ��һ����Ϣ
		FundRentPlan frp = new FundRentPlan();
		String dqdate = frp.getDqDate(contract_id, start_term);
		String predate = frp.getPreDate(contract_id, start_term);

		// �õ�ԭ����
		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		String year_rate = frp.getPreRate(contract_id, start_term);

		// ����Ǵӵ�һ�� ��ʼ��ǰһ�ڵ�����Ϊ��������
		if (predate.equals("0")) {
			predate = ht.get("start_date").toString();

		}

		String first_corpus = frp.getIrrFisrtSumCorpMarker(contract_id,
				start_term).get(0).toString();
		if (first_corpus.indexOf("-") > -1) {
			first_corpus = first_corpus.substring(1);

		}

		String rentScale = ht.get("rentScale").toString();

		// /2010-12-30 �޸�
		// ��ѯ���ڵ����Ƿ��е�Ϣ��¼
		FundAdjustInter fai = new FundAdjustInter();
		Hashtable ht_recoder = fai.searcherRecoder(contract_id, start_term, ht
				.get("ajdustStyle").toString());

		// String first_interest = "0";
		List start_dates = (List) ht_recoder.get("start_date");

		// �µ����
		String newRent = "0";
		// �õ�ԭ������
		String old_corpus = "0";
		// �õ��µ���Ϣ
		String newInterest = "0";

		if (!ht_recoder.isEmpty() && start_dates.size() > 0) {// �õ���Ϣ��¼ �ֶμ�Ϣ

			// G17*(E11-E10)*(B24-B14)/360+G17*(E12-E11)*(B24-B14)/360+G17*(E14-E12)*(B24-B14)/360
			// ���������ڵ�����,����������
			String income_number_year = ht.get("income_number_year").toString();
			// long days = ToolUtil.getDateDiff(dqdate, predate);
			double dto = Double.parseDouble(leassMoney) / 360;

			// ��������Ϣֵ

			List start_days = (List) ht_recoder.get("start_date");
			List before_rates = (List) ht_recoder.get("before_rate");
			List after_rates = (List) ht_recoder.get("after_rate");

			// �տ�ʼ��ǰһ���������Ϣ��¼�е����ڼ���
			String temp_pre_date = predate;
			String tem_rate = "0";
			String tem_pre_rate = before_rates.get(0).toString();
			String tem_date = start_dates.get(0).toString();
			String tem_interest = "0";

			for (int i = 0; i < start_days.size(); i++) {
				if (i == 0) {// ��һ��ʱȡ��ԭʼ����������
					tem_pre_rate = before_rates.get(0).toString();
					tem_rate = after_rates.get(0).toString();
					tem_date = start_days.get(0).toString();

				} else {

					tem_rate = after_rates.get(i).toString();
					tem_date = start_days.get(i).toString();
					// temp_pre_date = start_days.get(i - 1).toString();
					temp_pre_date = predate;
					tem_pre_rate = before_rates.get(i).toString();

				}

				if ("3".equals(ht.get("ajdustStyle").toString())) {
					tem_date = ToolUtil.getYearFirstDate(tem_date);
				}

				// G17*(E11-E10)*(B24-B14)/360+G17*(E12-E11)*(B24-B14)/360+G17*(E14-E12)*(B24-B14)/360

				long ds = ToolUtil.getDateDiff(temp_pre_date, tem_date);
				double jgRate = Double.parseDouble(tem_rate)
						- Double.parseDouble(tem_pre_rate);
				double dtotalInter = jgRate / 100 * ds;

				System.out.println(dtotalInter);
				tem_interest = String.valueOf(dtotalInter
						+ Double.parseDouble(tem_interest));
			}
			// tem_interest = Tools.formatNumberDoubleTwo(tem_interest);
			System.out.println("tem_interest" + tem_interest);
			System.out.println(after_rates.get(after_rates.size() - 1)
					.toString()
					+ "==" + tem_date);

			// ���ڵļ����Ϣ���� ������ʱ�䣭�ϴε�Ϣ�����ڣ����µ�����

			// long ds_1 = ToolUtil.getDateDiff(txrq, start_days.get(
			// start_days.size() - 1).toString());

			long ds_1 = ToolUtil.getDateDiff(predate, txrq);
			double jgRate = Double.parseDouble(rateValue)
					- Double.parseDouble(after_rates
							.get(after_rates.size() - 1).toString());
			String first_interest = String.valueOf(ds_1 * (jgRate / 100));

			// long ds_d = ToolUtil.getDateDiff(dqdate, txrq);
			// first_interest = String.valueOf(Double
			// .parseDouble(first_interest)
			// + ds_d * Double.parseDouble(rateValue) / 100);

			first_interest = Tools.formatNumberDoubleTwo(String.valueOf((Double
					.parseDouble(first_interest) + Double
					.parseDouble(tem_interest))
					* dto));
			String totalCount = frp.getTotalCount(contract_id);

			// �µ����
			newRent = Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(first_corpus)
					* (1 + Double.parseDouble(rateValue) / 100
							* Integer.parseInt(totalCount) / 12
							* Integer.parseInt(income_number_year))
					/ (Integer.parseInt(totalCount)
							- Integer.parseInt(start_term) + 1)
					+ Double.parseDouble(first_interest)), Integer
					.parseInt(rentScale));

		} else {// ����ʱ��һ�ε�Ϣʱ

			String income_number_year = ht.get("income_number_year").toString();

			String totalCount = frp.getTotalCount(contract_id);

			// �������ֵ

			long jgDay = ToolUtil.getDateDiff(predate, txrq);
			String equipAmt = ht.get("equip_amt").toString();
			if (Double.parseDouble(year_rate) < 0.0000000000001) {
				year_rate = ht.get("year_rate").toString();
			}
			double jgInter = Double.parseDouble(equipAmt)
					* (jgDay)
					* (Double.parseDouble(rateValue) - Double
							.parseDouble(year_rate)) / 100 / 360;

			// �µ����
			newRent = Tools.formatNumberDoubleScale(String.valueOf(Double
					.parseDouble(first_corpus)
					* (1 + Double.parseDouble(rateValue) / 100
							* Integer.parseInt(totalCount) / 12
							* Integer.parseInt(income_number_year))
					/ (Integer.parseInt(totalCount)
							- Integer.parseInt(start_term) + 1) + jgInter),
					Integer.parseInt(rentScale));

		}

		// �õ�ԭ������
		old_corpus = frp.getDqCorpus(contract_id, start_term);

		// �õ��µ���Ϣ
		newInterest = Tools.formatNumberDoubleTwo(String.valueOf(Double
				.parseDouble(newRent)
				- Double.parseDouble(old_corpus)));

		// ���µ�һ�ڵ����ƻ���Ϣ
		frp.updateSignMarkerPlan(contract_id, start_term, newRent, newInterest,
				rateValue);

	}


	@SuppressWarnings("static-access")
	private String evalSetGrace(String contract_id, String txrq,
			String rateValue, Hashtable ht, String start_term_temp)
			throws Exception, SQLException {
		// /////
		for (int i = 1; i <= Integer.parseInt(ht.get("grace").toString()); i++) {// ѭ����������ڵ����ƻ�

			// �г�
			FundRentPlan frp = new FundRentPlan();
			String dqzj = frp.getDqZj(contract_id, start_term_temp);
			String equip_amt = Tools.formatNumberDoubleTwo(ht.get("equip_amt")
					.toString());
			String oldYearRate = ht.get("year_rate").toString();
			String newRent = "0";

			oldYearRate = frp.getPreRate(contract_id, start_term_temp);
			if ("0".equals(oldYearRate)) {
				oldYearRate = ht.get("year_rate").toString();
			}

			String rentScale = ht.get("rentScale").toString();

			if (i == 1) {// ��һ��ʱ,�����ǣ�����ֶμ�

				String dqdate = frp.getDqDate(contract_id, start_term_temp);
				// �������
				String days = String
						.valueOf(ToolUtil.getDateDiff(dqdate, txrq));
				String rates = Tools.formatNumberDoubleScale(String
						.valueOf((Double.parseDouble(rateValue) - Double
								.parseDouble(oldYearRate)) / 100 / 360), 12);
				// �µ����
				newRent = Tools.formatNumberDoubleScale(String.valueOf(Double
						.parseDouble(days)
						* Double.parseDouble(rates)
						* Double.parseDouble(equip_amt)
						+ Double.parseDouble(dqzj)), Integer
						.parseInt(rentScale));
			} else {

				// rateValue
				String income_number_year = ht.get("income_number_year")
						.toString();
				ToolUtil tu = new ToolUtil();
				String preRate = tu.getPreRate(rateValue, income_number_year);
				// �µ����
				newRent = Tools.formatNumberDoubleScale(String.valueOf(Double
						.parseDouble(preRate)
						* Double.parseDouble(equip_amt)), Integer
						.parseInt(rentScale));

			}

			// �õ�ԭ������
			String old_corpus = frp.getDqCorpus(contract_id, start_term_temp);

			// �õ��µ���Ϣ
			String newInterest = Tools.formatNumberDoubleTwo(String
					.valueOf(Double.parseDouble(newRent)
							- Double.parseDouble(old_corpus)));
			// ���µ�һ�ڵ����ƻ���Ϣ
			frp.updateSignMarkerPlan(contract_id, start_term_temp, newRent,
					newInterest, rateValue);

			start_term_temp = String
					.valueOf(Integer.parseInt(start_term_temp) + 1);
		}
		return start_term_temp;
	}


	/**
	 * �����ڴε���� ���� �г� ƽϢ��
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param rateValue
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceCROhterMarketBySet(String contract_id, String start_term,
			String rateValue) throws Exception {
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);

		FundRentPlan frp = new FundRentPlan();
		String total = frp.getTotalCount(contract_id);
		String rem_rent_list = String.valueOf(Integer.parseInt(total)
				- Integer.parseInt(start_term));

		String rentScale = ci.getRentScale(contract_id);
		String income_number_year = mp.get("income_number_year").toString();

		SetLawRentCaleUtil slrcu = new SetLawRentCaleUtil();
		// ����µ����list
		// ����б� �µ����ֻ���������й� �µ����list
		List rent_list = slrcu.getRentListByCount(mp.get("equip_amt")
				.toString(), total, rateValue, income_number_year, rentScale,
				rem_rent_list);

		// �г�����Ϣ�б�,ע���г��Ĳ��㱾�������Ĳ�һ��

		// ��ϢС��λ
		String newScale = "2";
		// �õ�����list
		List l_corpus_market = frp.getCorpsMarker(contract_id, String
				.valueOf(Integer.parseInt(start_term) + 1));
		// �õ��µ���Ϣ
		List inter_list = slrcu.getInterMarket(rent_list, l_corpus_market,
				newScale);

		// �������ƻ���
		frp.updateMarkerPlanBySet(contract_id, String.valueOf(Integer
				.parseInt(start_term) + 1), rent_list, inter_list, rateValue);

		// �޸��г���irr
		MarkerRentPlan mrp = new MarkerRentPlan();
		// ��ǰһ�ڿ�ʼ�õ��ֽ���
		mrp.processMarketIrr(contract_id, String.valueOf(Integer
				.parseInt(start_term) - 1));

	}


	/**
	 * 2010-12-09 �����г��ĵ�һ�����ƻ���Ϣ ƽϢ��ʱ ���� ����
	 * 
	 * @param contract_id
	 * @param txrq
	 * @param start_term
	 * @param rateValue
	 * @throws SQLException
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceFirstRentPlanBySetCYAndCN(String contract_id, String txrq,
			String start_term, String rateValue) throws SQLException, Exception {

		CoditionInfo ci = new CoditionInfo();
		Hashtable ht = ci.getProj_ConditionInfoByProj_id(contract_id);
		String start_term_temp = new String(start_term);

		if (ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term_temp)) {// �п�����ʱ

			// /////
			for (int i = 1; i <= Integer.parseInt(ht.get("grace").toString()); i++) {// ѭ����������ڵ����ƻ�

				// �г�
				FundRentPlan frp = new FundRentPlan();
				String equip_amt = Tools.formatNumberDoubleTwo(ht.get(
						"equip_amt").toString());

				String oldYearRate = ht.get("year_rate").toString();
				oldYearRate = frp.getPreRate(contract_id, start_term_temp);
				if ("0".equals(oldYearRate)) {
					oldYearRate = ht.get("year_rate").toString();
				}
				String rentScale = ht.get("rentScale").toString();
				String income_number_year = ht.get("income_number_year")
						.toString();
				String newRent = "0";

				if (i == 1) {
					String predate = frp.getPreDate(contract_id,
							start_term_temp);
					String sdate = txrq;
					sdate = txrq;
					// �������
					String days = String.valueOf(ToolUtil.getDateDiff(sdate,
							predate));
					// ���ʲ�ֵ
					String rates = Tools
							.formatNumberDoubleScale(String.valueOf((Double
									.parseDouble(rateValue) - Double
									.parseDouble(oldYearRate)) / 100 / 360), 12);

					// ///////////
					String total = String.valueOf(Integer.parseInt(frp
							.getTotalCount(contract_id))
							- Integer.parseInt(ht.get("grace").toString()));

					SetLawRentCaleUtil srcu = new SetLawRentCaleUtil();
					newRent = srcu.getRent(equip_amt, total, rateValue,
							income_number_year, rentScale);

					// �µ����
					newRent = Tools.formatNumberDoubleScale(String
							.valueOf(Double.parseDouble(days)
									* Double.parseDouble(rates)
									* Double.parseDouble(equip_amt) * -1
									+ Double.parseDouble(newRent)), Integer
							.parseInt(rentScale));

				} else {
					ToolUtil tu = new ToolUtil();
					String preRate = tu.getPreRate(rateValue,
							income_number_year);
					// �µ����
					newRent = Tools.formatNumberDoubleScale(String
							.valueOf(Double.parseDouble(preRate)
									* Double.parseDouble(equip_amt)), Integer
							.parseInt(rentScale));
				}

				// �õ�ԭ������
				String old_corpus = frp.getDqCorpus(contract_id,
						start_term_temp);

				// �õ��µ���Ϣ
				String newInterest = Tools.formatNumberDoubleTwo(String
						.valueOf(Double.parseDouble(newRent)
								- Double.parseDouble(old_corpus)));
				// ���µ�һ�ڵ����ƻ���Ϣ
				frp.updateSignMarkerPlan(contract_id, start_term_temp, newRent,
						newInterest, rateValue);
				start_term_temp = String.valueOf(Integer
						.parseInt(start_term_temp) + 1);

			}
		} else {// ��������ʱ

			getSetFirstInter(contract_id, start_term, rateValue, txrq, ht.get(
					"equip_amt").toString());

			// // �г�
			// FundRentPlan frp = new FundRentPlan();
			// String equip_amt =
			// Tools.formatNumberDoubleTwo(ht.get("equip_amt")
			// .toString());
			//
			// String oldYearRate = ht.get("year_rate").toString();
			// oldYearRate = frp.getPreRate(contract_id, start_term);
			// if ("0".equals(oldYearRate)) {
			// oldYearRate = ht.get("year_rate").toString();
			// }
			//
			// String rentScale = ht.get("rentScale").toString();
			// // String ajdustStyle = ht.get("ajdustStyle").toString();
			// String predate = frp.getPreDate(contract_id, start_term);
			// String sdate = txrq;
			// // if ("3".equals(ajdustStyle)) {
			// // // ���ݵ�Ϣ�յõ�������һ��
			// // sdate = ToolUtil.getYearFirstDate(txrq);
			// // }
			// // if ("1".equals(ajdustStyle)) {
			// // //�µĵ�һ��
			// // sdate = ToolUtil.getFirstDayByDate(txrq);
			// // }
			// sdate = txrq;
			// // �������
			// String days = String.valueOf(ToolUtil.getDateDiff(sdate,
			// predate));
			// // ���ʲ�ֵ
			// String rates = Tools.formatNumberDoubleScale(String
			// .valueOf((Double.parseDouble(rateValue) - Double
			// .parseDouble(oldYearRate)) / 100 / 360), 12);
			//
			// // ///////////
			// String total = frp.getTotalCount(contract_id);
			//
			// String income_number_year =
			// ht.get("income_number_year").toString();
			// SetLawRentCaleUtil srcu = new SetLawRentCaleUtil();
			// String newRent = srcu.getRent(equip_amt, total, rateValue,
			// income_number_year, rentScale);
			//
			// // �µ����
			// newRent = Tools.formatNumberDoubleScale(String.valueOf(Double
			// .parseDouble(days)
			// * Double.parseDouble(rates)
			// * Double.parseDouble(equip_amt)
			// * -1 + Double.parseDouble(newRent)), Integer
			// .parseInt(rentScale));
			//
			// // �õ�ԭ������
			// String old_corpus = frp.getDqCorpus(contract_id, start_term);
			//
			// // �õ��µ���Ϣ
			// String newInterest = Tools.formatNumberDoubleTwo(String
			// .valueOf(Double.parseDouble(newRent)
			// - Double.parseDouble(old_corpus)));
			// // ���µ�һ�ڵ����ƻ���Ϣ
			// frp.updateSignMarkerPlan(contract_id, start_term, newRent,
			// newInterest, rateValue);

		}

	}

}
