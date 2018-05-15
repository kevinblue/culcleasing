package com.tenwa.culc.calc.tx.util;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.Tools;
import com.tenwa.culc.calc.tx.Tx_DataCtrolUtil;
import com.tenwa.culc.calc.tx.Tx_RentInfoBox;
/**
 * 
 * @author toybaby
 * Date:Feb 21, 2011 10:21:04 AM       Email: toybaby@mail2.tenwa.com.cn
 */
public class Tx_NotEqualCorpusUtil {

	/**
	 * 不等额本金调息测算
	 * 
	 * @param conditionBean
	 * @return
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public static Tx_RentInfoBox  getRentInfoBox(String contract_id,String begin_id,Map<String,String> condition_Map) throws SQLException {
		/**
		 * =======================================================
		 * 
		 * <pre>
		 * 先测算出相关的List数据
		 * </pre>
		 * 
		 * =======================================================
		 */
		Tx_RentInfoBox rentInfoBox = new Tx_RentInfoBox();
		@SuppressWarnings("unused")
		String lease_money = condition_Map.get("lease_money");//剩余本金
		String year_rate = condition_Map.get("year_rate");//调息后年利率
		String lease_interval = condition_Map.get("income_number_year");//租金间隔
//		String lease_term = condition_Map.get("income_number");//剩余期数
//		String period_type = condition_Map.get("period_type");//付租类型	
		// 新的租金计划
		String rent="0";
		String interest="0";
		
		List l_rent = new ArrayList();
		List l_interest = new ArrayList();
		//旧的租金计划
		List<String> l_old_corpus = new ArrayList();
		List<String> l_old_corpus_overage = new ArrayList();
		
		

		// *****************************************************************************************************
		// *** 不等额本金 调息测算 ****
		// *****************************************************************************************************
		//1.获得旧的租金计划
		//2.循环计算新的租金计划
		//3.进行封装，返回beanBox
		Map<String,List<String>> old_Rent_Map = new HashMap<String, List<String>>();
		Tx_DataCtrolUtil dataCtrol = new Tx_DataCtrolUtil();
		String rent_list_start = condition_Map.get("rent_list_start");//开始期数
		old_Rent_Map = dataCtrol.getRentInfoMap(contract_id, begin_id, rent_list_start);
		l_old_corpus = old_Rent_Map.get("l_corpus");
		l_old_corpus_overage = old_Rent_Map.get("corpus_overage");
		//计算期利率
		String rate = String.valueOf(Double.parseDouble(year_rate)/100/( 12/Integer.parseInt(lease_interval)));
		System.out.println("利率（测算时1）" + rate);
		rate = Tools.formatNumberDoubleScale(rate,6);
		
		//计算新的租金计划
		for (int i = 0; i < l_old_corpus.size(); i++) {
			interest = Tools.formatNumberDoubleTwo(String.valueOf((
					Double.parseDouble(l_old_corpus_overage.get(i))+Double.parseDouble(l_old_corpus.get(i)))*
					Double.parseDouble(rate)));
			rent = String.valueOf(Double.parseDouble(interest)+Double.parseDouble(l_old_corpus.get(i)));
			System.out.println("i="+i+" 本金="+l_old_corpus.get(i)+" 利息="+interest+"租金="+rent);
			
			l_rent.add(rent);
			l_interest.add(interest);
			
			
		}
		
//		for(int i=0;i<l_rent.size();i++){
//			System.out.println("rent="+l_rent.get(i)+"  corpus= "+l_corpus.get(i)+"  " +
//					"inter="+l_interest.get(i)+"   cor_overge="+l_corpus_overage.get(i));
//		}
		/*
		 * 
		 * RentInfoBox 封装测算List
		 * 
		 */
		rentInfoBox.setL_rent(l_rent);
		rentInfoBox.setL_corpus(l_old_corpus);
		rentInfoBox.setL_interest(l_interest);
		rentInfoBox.setL_corpus_overage(l_old_corpus_overage);
		return rentInfoBox;
		
	}		
	
}
