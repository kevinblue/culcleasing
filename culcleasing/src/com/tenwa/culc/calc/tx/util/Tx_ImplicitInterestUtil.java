package com.tenwa.culc.calc.tx.util;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tenwa.culc.calc.tx.Tx_DataCtrolUtil;
import com.tenwa.culc.calc.tx.Tx_RentInfoBox;
import com.Tools;
/**
 * 
 * @author toybaby
 * Date:Aug 18, 201111:46:51 AM       Email: toybaby@mail2.tenwa.com.cn
 */
public class Tx_ImplicitInterestUtil {
	/**返回隐含利率调息的rentInfoBox
	 * @param contract_id
	 * @param begin_id
	 * @param condition_Map
	 * @return
	 * @throws SQLException 
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	public Tx_RentInfoBox getRentInfoBox(String contract_id,String begin_id,String settle_method,Map condition_Map) throws SQLException{
		Tx_RentInfoBox rentInfoBox = new Tx_RentInfoBox();
		Tx_DataCtrolUtil dataCtrolUtil = new Tx_DataCtrolUtil();
		String rent_list_start = condition_Map.get("rent_list_start").toString();
		
		List<String> l_rent = new ArrayList<String>();//调息后新的租金计划
		List<String> l_new_rent = new ArrayList<String>();//调息后新的租金计划
		List<String> l_interest = new ArrayList<String>();//调息后新的利息计划
		List<String> l_corpus = new ArrayList<String>();//本金计划
		List<String> l_corpus_overage = new ArrayList<String>();//剩余本金
		Map<String, List<String>> rentInfo_Map = new HashMap<String, List<String>>();//租金，本金list
		//第一步:获得调息前的租金和本金list，
		rentInfo_Map = dataCtrolUtil.getRentInfoMap(contract_id, begin_id, rent_list_start);
		//第二步，测算调息之后的租金
		String after_rate=condition_Map.get("implicite_rate").toString();//调息后的隐含利率
		l_corpus = rentInfo_Map.get("l_corpus");
		l_rent = rentInfo_Map.get("l_rent");
		l_corpus_overage = rentInfo_Map.get("corpus_overage");
		l_new_rent = getNewRent(after_rate,l_rent,settle_method);
		//第三步，测算新的利息
		l_interest = getNewInterest(l_new_rent,l_corpus);
		//rentInfoBox 进行封装
		rentInfoBox.setL_rent(l_new_rent);
		rentInfoBox.setL_corpus(l_corpus);
		rentInfoBox.setL_interest(l_interest);
		rentInfoBox.setL_corpus_overage(l_corpus_overage);
		return rentInfoBox;
	}

	/**返回新的利息列表
	 * @param l_new_rent
	 * @param l_corpus
	 * @return
	 */
	public List<String> getNewInterest(List<String> l_new_rent,
			List<String> l_corpus) {
		List<String> l_interest = new ArrayList<String>();//调息后新的利息计划
		String interest="0";
		for(int i=0;i<l_new_rent.size();i++){
			//利息=租金-本金
			interest = Tools.formatNumberDoubleFour(String.valueOf(Double.parseDouble(l_new_rent.get(i))-
					Double.parseDouble(l_corpus.get(i))));
			l_interest.add(interest);
		}
		
		
		return l_interest;
	}

	/**
	 * 测算新的租金
	 * @param after_rate
	 * @param l_corpus
	 * @return
	 */
	public List<String> getNewRent(String after_rate, List<String> l_rent,String settle_method) {
		List<String> l_new_rent = new ArrayList<String>();
		String new_rent = "0";
		for(int i = 0; i<l_rent.size();i++){
			if("RentCalcType7".equals(settle_method)){//均息法时租金精确到元
				new_rent = Tools.formatNumberDoubleZero(String.valueOf(Double.parseDouble(
						l_rent.get(i))*Double.parseDouble(after_rate)));
				//System.out.println(new_rent+"="+l_rent.get(i)+"*"+after_rate);
			}else{//非均息法精确到小数点后两位
				new_rent = Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(
						l_rent.get(i))*Double.parseDouble(after_rate)));
				System.out.println(new_rent+"="+l_rent.get(i)+"*"+after_rate);
			}
			l_new_rent.add(new_rent);
		}
		return l_new_rent;
	}
}
