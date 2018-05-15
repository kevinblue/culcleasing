package com.tenwa.culc.calc.tx.util;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.calc.tx.Tx_DataCtrolUtil;
import com.tenwa.culc.calc.tx.Tx_RentInfoBox;
import com.tenwa.culc.calc.tx.zjcs.Tx_SetLawRentCaleUtil;


public class Tx_SettleLawUtil {

	/**
	 * @author toybaby 2011-07-20
	 * @param conditionBean
	 * @return
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public static Tx_RentInfoBox getRentInfoBox(String contract_id,String begin_id,Map<String,String> condition_Map){

		Tx_RentInfoBox rentInfoBox = new Tx_RentInfoBox();
		Tx_DataCtrolUtil tx_DataCtrolUtil = new Tx_DataCtrolUtil();
		// 租金测算商务条件
		String year_rate = condition_Map.get("year_rate");//调息后年利率
		//均息法商务条件仍采用调息之前的商务条件进行测算
		Map<String, String> oldCondition_Map = new HashMap<String, String>();
		try {
			//获得旧的商务条件
			oldCondition_Map = tx_DataCtrolUtil.getOldConditionMap(contract_id, begin_id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String lease_money = oldCondition_Map.get("lease_money");//剩余本金
		String lease_interval = oldCondition_Map.get("income_number_year");//租金间隔
		String lease_term = oldCondition_Map.get("lease_term");//全部期数
		String assets_value = oldCondition_Map.get("assets_value");//资产余值
		
		// 现金流部分调用

		Tx_SetLawRentCaleUtil slrcu = new Tx_SetLawRentCaleUtil();
		// 2010-12-08 rentScale-->newScale 除了租金之外的
		// 租金列表
		List rent_list = slrcu.getRentList(lease_money, assets_value,
				lease_term, year_rate, lease_interval, "0");
		System.out.println("租金计算完成");
		// 利息列表
		List inter_list = slrcu.getInterMarket(rent_list, lease_money, year_rate,
				lease_interval, "0");
		System.out.println("利息计算完成");
		// 得到本金list
		List corpus_market = slrcu.getCorpusList(rent_list, inter_list,
				lease_money, assets_value, "0");
		// 重新计算利息 目的为了处理最后一期剩余本金不为0的情况
		inter_list = slrcu.getNewInterList(rent_list, corpus_market,
				inter_list, "0");
		// 得到本金余额
		List corpusOverge_market = slrcu.getCorpusOvergeList(String
				.valueOf(lease_money), corpus_market,
				"0");

		/*
		 * 
		 * RentInfoBox 封装测算List
		 * 
		 */
		rentInfoBox.setL_rent(rent_list);
		rentInfoBox.setL_corpus(corpus_market);
		rentInfoBox.setL_interest(inter_list);
		rentInfoBox.setL_corpus_overage(corpusOverge_market);

		return rentInfoBox;

	}

}
