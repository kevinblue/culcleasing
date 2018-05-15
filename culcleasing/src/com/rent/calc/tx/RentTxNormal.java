package com.rent.calc.tx;

import java.util.HashMap;
import java.util.List;

import com.Tools;


/**
 * 正常情况下的调息时
 * 
 * @author shf
 * 
 */
public class RentTxNormal {

	

	/**
	 * 重新计算租金,年利率变化时
	 * 
	 * @param mp
	 * @throws Exception
	 */

	public void calRentByNew(HashMap mp, String contract_id) throws Exception {

		// 得到新的租金
		RentTx rtx = new RentTx();
		// 正常情况下的租金，除了宽限期
		String rent = CalcUtil.getRentByPmt(mp);

		// 得到租金List,有宽限期则包含宽限期
		List retn_list = rtx.eqRentList(rent, mp.get("rem_rent_list")
				.toString(), mp);

		String nextTerm = mp.get("nextTerm").toString();
		String qzOrqm = mp.get("period_type").toString();
		String income_number_year = mp.get("income_number_year").toString();
		// 判断是不是第一期
		if (!"1".equals(nextTerm)) {// 不是从第一期,开始调
			qzOrqm = "-1";
		}
		System.out.println("剩余本金：" + mp.get("rem_corpus").toString());
		
		// 因为现金流是算出所有的现金流,///添加所有的前期款
		List cash_list = CalcUtil.getCashList(contract_id, nextTerm, mp.get(
				"period_type").toString(), retn_list, mp);

		// irr
		String irr = IrrCalc.getIRR(cash_list, income_number_year,
				income_number_year, String.valueOf(12 / Integer
						.parseInt(income_number_year)));
		irr = Tools.formatNumberDoubleScale(irr, 8);
		
	
		System.out.println(Double.parseDouble(irr)+"财务的irr：" + irr+"==" );
		String srate = Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(irr)/ (12 / Integer.parseInt(income_number_year))),8);

	
		// 得到利息列表,财务
		List interest_list = rtx.getInterestList(retn_list, mp
				.get("rem_corpus").toString(),srate, qzOrqm,mp);

		// 得到每一期的本金
		List corp_list = RentTx.getCorpusList(retn_list, interest_list,mp.get("rentScale").toString());

		// 得到每一期的本金余额
		List corp__overage_list = RentTx.getCorpusOvergeList(mp.get(
				"rem_corpus").toString(), corp_list,mp.get("rentScale").toString());
		
		
		
		

		// 计算市场的【市场本金，市场利息，市场本金余额】

		String retu_vale = mp.get("retu_vale").toString();
		// 得到每一期租金的利率
		retu_vale = CalcUtil.getPreRate(retu_vale, income_number_year);

		// 市场的利息列表,注意市场的测算本金与财务的不一样
		System.out.println("市场的剩余本金是：" + mp.get("corpus_market").toString());
		// 市场利息
		List l_inte_mark = rtx.getInterestList(retn_list, mp.get(
				"corpus_market").toString(), retu_vale, qzOrqm,mp);
		// 市场本金
		List l_corpus_market = RentTx.getCorpusList(retn_list, l_inte_mark,mp.get("rentScale").toString());
		// 市场本金余额
		List l_corpus_overage_market = RentTx.getCorpusOvergeList(mp.get(
				"corpus_market").toString(), l_corpus_market,mp.get("rentScale").toString());

		CalcUtil.printRentInfo(retn_list, interest_list, corp_list, corp__overage_list, l_inte_mark, l_corpus_market, l_corpus_overage_market);

		// 更新租金表
		CalcUtil.updateRentPlan(retn_list, interest_list, corp_list,
				corp__overage_list, l_inte_mark, l_corpus_market,
				l_corpus_overage_market, mp.get("proj_id").toString(), mp.get(
						"nextTerm").toString());

	}

	
}
