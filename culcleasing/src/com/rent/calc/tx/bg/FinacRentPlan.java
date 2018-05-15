package com.rent.calc.tx.bg;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;

/**
 * 财务租金计划处理
 * 
 * @author shf
 * 
 */
public class FinacRentPlan {

	/**
	 * 财务租金信息的更新
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
		if (!"2".equals(ajdustStyle)) {//非次期时
			  start_term_temp = new String(String.valueOf(Integer
					.parseInt(start_term) - 1));
		}
		
		if (ht.get("grace") != null
				&& Integer.parseInt(ht.get("grace").toString()) >= Integer
						.parseInt(start_term_temp)) {// 有宽限期时

			// 先进行对宽限期 的租金计划的处理
			for (int i = Integer.parseInt(start_term_temp); i <= Integer
					.parseInt(ht.get("grace").toString()); i++) {// 循环处理宽限期的租金计划
				FundRentPlan frp = new FundRentPlan();
				frp.proceFinacRentPlan(proj_id, start_term_temp);
				start_term_temp = String.valueOf(Integer
						.parseInt(start_term_temp) + 1);
			}

			//2011-04-15修改,宽限期不算irr计算
			start_term_temp=String.valueOf(Integer.parseInt(ht.get("grace").toString())+1);
		
			// 第一期处理 得到新的irr 除了次期的要处理第一期外，其余不要处理
			String new_irr = proceFirstRentPlanFinac(proj_id, txrq,
					start_term_temp);
			System.out.println("财务irr:"+new_irr);
			// 其他的期次处理
			proceCROhterFinace(proj_id, start_term_temp, new_irr);
			

		} else {// 正常测算时

			// 财务剩余本金
			
			if ("0".equals(ajdustStyle) || "1".equals(ajdustStyle) || "3".equals(ajdustStyle)) {//次日，次月，次年一次调息时
				  start_term_temp = new String(String.valueOf(Integer
						.parseInt(start_term) ));
			}
		
			

			FundRentPlan frp = new FundRentPlan();
			List flow = frp.getIrrFisrtSumCorpFina(proj_id, start_term_temp);
			// 求出新的租金列表
			flow = frp.getOtherFlowRent(proj_id, String.valueOf(Integer
					.parseInt(start_term_temp) - 1), flow);
			// 先求出新的财务irr的值
			Hashtable ht_jg = ci.getChjg(proj_id);
			String fina_irr = IrrCalc.getIRR(flow, ht_jg.get("chjg").toString(),
					ht_jg.get("zjjg").toString(), ht_jg.get("nhkcs").toString());
			fina_irr = Tools.formatNumberDoubleScale(fina_irr, 14);
			System.out.println("财务irr:"+fina_irr);
			// 更新财务irr的值
			ci.updateFinaIrr(proj_id, fina_irr);

			// 更新财务租金计划
			updateFinaceRentInfo(proj_id, start_term_temp, frp, flow, ci, ht_jg,
					fina_irr);

		}

	}

	/**
	 * 更新财务租金计划
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
		// 求出新的利息列表
		String scorps = "0";
		if (flow.size() > 0) {
			scorps = flow.get(0).toString();
		}
		if (scorps.indexOf("-") > -1) {
			scorps = scorps.substring(1);
		}
		// 计算的利率
		// irr值 / 年还款次数
		fina_irr = String.valueOf(Double.parseDouble(fina_irr)
				/ Integer.parseInt(ht.get("nhkcs").toString()));
		// 租金列表
		List new_rent = new ArrayList();

		new_rent = frp.getOtherFlowRent(proj_id, String.valueOf(Integer
				.parseInt(start_term) - 1), new_rent);
		String type = ci.getType(proj_id, start_term);
		String rentScale = ci.getRentScale(proj_id);
		// 2010-12-07 除了租金之外其余的保留二位小数
		rentScale = "2";
		List interest = CommonUtil.getInterestList(new_rent, scorps, fina_irr,
				type, rentScale);
		// 求出新的本金列表
		List corpusList = CommonUtil.getCorpusList(new_rent, interest,
				rentScale);
		// 求出新本金余额列表
		List corpusOvergeList = CommonUtil.getCorpusOvergeList(scorps,
				corpusList, rentScale);
		// 更新财务计划信息
		frp.processFinacePlan(proj_id, start_term, interest, corpusList,
				corpusOvergeList);
	}

	/**
	 * 财务租金计划修改
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
						.parseInt(start_term_temp)) {// 有宽限期时

			// 先进行对宽限期 的租金计划的处理
			for (int i = Integer.parseInt(start_term_temp); i <= Integer
					.parseInt(ht.get("grace").toString()); i++) {// 循环处理宽限期的租金计划
				FundRentPlan frp = new FundRentPlan();
				frp.proceFinacRentPlan(contract_id, start_term_temp);
				start_term_temp = String.valueOf(Integer
						.parseInt(start_term_temp) + 1);
			}

			
			//2011-04-15修改,宽限期不算irr计算
			start_term_temp=String.valueOf(Integer.parseInt(ht.get("grace").toString())+1);
			
			// 第一期处理 得到新的irr 除了次期的要处理第一期外，其余不要处理
			String new_irr = proceFirstRentPlanFinac(contract_id, txrq,
					start_term_temp);
			
		System.out.println("财务irr:"+new_irr);
			// 其他的期次处理
			proceCROhterFinace(contract_id, start_term_temp, new_irr);

		} else {// 正常测算时
			// 第一期处理 得到新的irr 除了次期的要处理第一期外，其余不要处理
			String new_irr = proceFirstRentPlanFinac(contract_id, txrq,
					start_term);
			
			System.out.println("财务irr:"+new_irr);
			// 其他的期次处理
			proceCROhterFinace(contract_id, start_term, new_irr);

		}

	}

	/**
	 * 财务irr处理
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
		// 财务剩余本金
		FundRentPlan frp = new FundRentPlan();
		List flow = frp.getIrrFisrtSumCorpFina(contract_id, start_term);

		// 其他期次租金值 2010-12-20修改
		// 先求出新的财务irr的值
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
		String othere_rent = start_term;
		if ("1".equals(mp.get("measure_type").toString())) {// 等额租金时
			othere_rent = String.valueOf(Integer.parseInt(start_term) - 1);
		}

		// 求出新的租金列表
		flow = frp.getOtherFlowRent(contract_id, othere_rent, flow);

		Hashtable ht = ci.getChjg(contract_id);
		String fina_irr = IrrCalc.getIRR(flow, ht.get("chjg").toString(), ht
				.get("zjjg").toString(), ht.get("nhkcs").toString());

		// 更新irr的值
		ci.updateFinaIrr(contract_id, fina_irr);
		return fina_irr;
	}

	/**
	 * 更新财务的第一期租金计划信息
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

		// 先得到新的irr
		
		String new_irr = proceFinacIrrValue(contract_id, start_term);
		new_irr = String.valueOf(Double.parseDouble(new_irr) * 100);
		System.out.println("财务irr:"+new_irr);

		// ///////////////////////////

//		// 调息计算期次
//		CoditionInfo ci = new CoditionInfo();
//		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
//
//		String ajdustStyle = mp.get("ajdustStyle").toString();
//		if ("2".equals(ajdustStyle)) { // 次期时
//			// 财务
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
//				// 得到原来本金
//				String old_corpus = frp.getDqCorpusFinac(contract_id, start_term);
//				String dqzj = frp.getDqZj(contract_id, start_term);
//				String dqcorpus = String.valueOf(Double.parseDouble(dqzj)
//						- Double.parseDouble(first_inter));
//
//				// 本金差值
//				String cha_old_new_corp = String.valueOf(Double
//						.parseDouble(dqcorpus)
//						- Double.parseDouble(old_corpus));
//				// 后面用于测算的剩余本金值
//				String total_corpus = String.valueOf(Double
//						.parseDouble(first_corpus)
//						+ Double.parseDouble(cha_old_new_corp));
//
//				// 修改 2010-12-07 剩余本金值 = 上一期的本金和值－这一期本金值
//				total_corpus = String.valueOf(Double.parseDouble(first_corpus)
//						- Double.parseDouble(dqcorpus));
//
//				// 更新第一期的租金计划信息
//				frp.updateSignFinacPlan(contract_id, start_term, first_inter,
//						dqcorpus, total_corpus);
//				
//			} else {
//				String first_corpus = frp.getTotalCorpusFinacByQc(contract_id,
//						start_term);
//				String first_inter = CommonUtil.getFirstInterest(contract_id, txrq,
//						start_term, new_irr, first_corpus);
//
//				// 得到原来本金
//				String old_corpus = frp.getDqCorpusFinac(contract_id, start_term);
//				String dqzj = frp.getDqZj(contract_id, start_term);
//				String dqcorpus = String.valueOf(Double.parseDouble(dqzj)
//						- Double.parseDouble(first_inter));
//
//				// 本金差值
//				String cha_old_new_corp = String.valueOf(Double
//						.parseDouble(dqcorpus)
//						- Double.parseDouble(old_corpus));
//				// 后面用于测算的剩余本金值
//				String total_corpus = String.valueOf(Double
//						.parseDouble(first_corpus)
//						+ Double.parseDouble(cha_old_new_corp));
//
//				// 修改 2010-12-07 剩余本金值 = 上一期的本金和值－这一期本金值
//				total_corpus = String.valueOf(Double.parseDouble(first_corpus)
//						- Double.parseDouble(dqcorpus));
//
//				// 更新第一期的租金计划信息
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
	 * 其他期次的租金 处理 财务
	 * 
	 * @param contract_id
	 * @param start_term
	 * @param rateValue
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public void proceCROhterFinace(String contract_id, String start_term,
			String rateValue) throws Exception {

		// 本金余额
		FundRentPlan frp = new FundRentPlan();

		// 2010-12-20 修改
		// 其他期次租金值 2010-12-20修改
		CoditionInfo ci = new CoditionInfo();
		Hashtable mp = ci.getProj_ConditionInfoByProj_id(contract_id);
		String othere_rent = start_term;
		if ("1".equals(mp.get("measure_type").toString())) {// 等额租金时
			othere_rent = String.valueOf(Integer.parseInt(start_term) - 1);
		}

		String remCorpus = frp
				.getTotalCorpusFinacByQc(contract_id, othere_rent);

		// 计算利息，本金，本金余额
		List rent_list = new ArrayList();
		rent_list = frp.getOtherFlowRent(contract_id, othere_rent, rent_list);
		String qzOrqm = ci.getType(contract_id, othere_rent);

		String rentScale = ci.getRentScale(contract_id);
		// 2010-12-07 除了租金之外其余的保留二位小数
		rentScale = "2";

		String income_number_year = mp.get("income_number_year").toString();
		String retu_vale = Tools.formatNumberDoubleScale(ToolUtil.getPreRate(
				rateValue, income_number_year), 12);

		List l_inte = CommonUtil.getInterestList(rent_list, remCorpus,
				retu_vale, qzOrqm, rentScale);

		// 本金
		List l_corpus = CommonUtil.getCorpusList(rent_list, l_inte, rentScale);
		// 本金余额
		List l_corpus_overage = CommonUtil.getCorpusOvergeList(remCorpus,
				l_corpus, rentScale);

		// 更新租金计划表
		frp
				.processFinacePlan(contract_id, String.valueOf(Integer
						.parseInt(othere_rent) + 1), l_inte, l_corpus,
						l_corpus_overage);

	}

}
