package com.tenwa.culc.calc.tx.util;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.Tools;
import com.tenwa.culc.calc.tx.Tx_DataCtrolUtil_BGZ;
import com.tenwa.culc.calc.tx.Tx_RentInfoBox;


/**
 * 
 * @author toybaby
 * Date:2016-06-26 22：55       Email: toybaby@mail2.tenwa.com.cn
 */
public class Tx_NotEqualRentUtil {
	
	/*public static void main(String[] args) {
		Map<String, String> condition_Map = new HashMap<String, String>(); 
		Tx_DataCtrolUtil tx_DataCtrolUtil = new Tx_DataCtrolUtil();//初始化数据库数据处理类
		try {
			condition_Map = tx_DataCtrolUtil.getConditionInfo("13CULC202173L58","13CULC202173L5847","129");
			System.out.println("map-------------------:"+condition_Map.toString());
			Tx_RentInfoBox Tx_RentInfoBox = getRentInfoBox("13CULC202173L58","13CULC202173L5847",condition_Map,"129");
			System.out.println(Tx_RentInfoBox.toString());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/

	/**
	 * 不等额租金调息测算
	 * 
	 * @param conditionBean
	 * @return
	 * @throws SQLException 
	 * @throws ParseException 
	 * @throws ParseException 
	 */
	@SuppressWarnings("unchecked")
	public static Tx_RentInfoBox  getRentInfoBox(String contract_id,String begin_id,Map<String,String> condition_Map,String txId) throws SQLException{
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
		
		List<String> l_rent = new ArrayList();
		List<String> l_corpus = new ArrayList();
		List<String> l_interest = new ArrayList();
		List<String> l_corpus_overage = new ArrayList();
		//旧的租金计划
		List<String> l_old_rent = new ArrayList();
		List<String> l_old_corpus = new ArrayList();
		List<String> l_old_corpus_overage = new ArrayList();
		List<String> l_old_rent_date = new ArrayList();
		
		//推算用临时租金计划
		List<Double> l_temp_corpus = new ArrayList();
		List<Double> l_temp_corpus_overage = new ArrayList();
		
		
		

		// *****************************************************************************************************
		// *** 不等额租金 调息测算 ****
		// *****************************************************************************************************
		//1.获得旧的租金计划
		//2.循环计算新的租金计划
		//3.进行封装，返回beanBox
		Map<String,List<String>> old_Rent_Map = new HashMap<String, List<String>>();
		Tx_DataCtrolUtil_BGZ dataCtrol = new Tx_DataCtrolUtil_BGZ();
		String rent_list_start = condition_Map.get("rent_list_start");//开始期数
		String adjust_id = txId;//调息id
		old_Rent_Map = dataCtrol.getRentInfoMap(contract_id, begin_id, rent_list_start,txId);
		l_old_rent = old_Rent_Map.get("l_rent");
		l_old_corpus = old_Rent_Map.get("l_corpus");
		l_old_corpus_overage = old_Rent_Map.get("corpus_overage");
		l_old_rent_date = old_Rent_Map.get("l_old_rent_date");
		String startDate = (String)old_Rent_Map.get("startDate").get(0);//调用getRentAdjust方法的参数当期计划时间
		
		//计算期利率
		String rate = String.valueOf(Double.parseDouble(year_rate)/100/( 12/Integer.parseInt(lease_interval)));
		System.out.println("利率（测算时1）" + rate);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
		rate = Tools.formatNumberDoubleScale(rate,10);
		
		//计算总的剩余本金
		String currLeaseMoney = Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(l_old_corpus.get(0))+Double.parseDouble(l_old_corpus_overage.get(0))));
		System.out.println("测算前总的剩余本金currLeaseMoney="+currLeaseMoney);
		Double final_currLeaseMoney = Double.parseDouble(l_old_corpus.get(0))+Double.parseDouble(l_old_corpus_overage.get(0));;
		for (int i = 0; i < l_old_corpus.size(); i++) {
			if(i==0){
				System.out.println("测算第1条记录时 currLeaseMoney="+Double.parseDouble(currLeaseMoney)+"利率="+Double.parseDouble(rate)+"结果为"+Double.parseDouble(currLeaseMoney)*Double.parseDouble(rate));
			}
			System.out.println("第一计算过程中每期剩作本金="+currLeaseMoney+"每期租金="+l_old_rent.get(i)+"每期利息="+Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(currLeaseMoney)*Double.parseDouble(rate))));
			currLeaseMoney = Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(currLeaseMoney)- (Double.parseDouble(l_old_rent.get(i))-Double.parseDouble(Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(currLeaseMoney)*Double.parseDouble(rate)))))));
		}
		
		System.out.println("计算常量前的差额本金currLeaseMoney="+currLeaseMoney);
		//获得调息开始时间
		AdjustRentUtil adjustrentutil= new AdjustRentUtil();
		String date2=startDate;
		String tmpRent = (adjustrentutil.getRentAdjust(l_old_rent,l_old_rent_date,year_rate,lease_money,"0",startDate)).toString();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		//计算新的租金计划
		for (int i = 0; i < l_old_corpus.size(); i++) {
			String date1=l_old_rent_date.get(i);
			l_rent.add(Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(l_old_rent.get(i))+Double.parseDouble(tmpRent))));
			int cou=0;
			try {
				if(i==0){
					cou=DateUtils.getBetweenMonths(sdf.parse(date2),sdf.parse(date1));
				}else{
					cou=DateUtils.getBetweenMonths(sdf.parse(l_old_rent_date.get(i-1)),sdf.parse(l_old_rent_date.get(i)));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			String newrate= String.valueOf(Double.parseDouble(year_rate)/100/12*(cou==0?1:cou));
			l_interest.add(Tools.formatNumberDoubleTwo(String.valueOf(final_currLeaseMoney*Double.parseDouble(newrate))));
			l_corpus.add(Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(l_rent.get(i))-Double.parseDouble(l_interest.get(i)))));
			final_currLeaseMoney = final_currLeaseMoney-Double.parseDouble(l_corpus.get(i));
			l_corpus_overage.add(Tools.formatNumberDoubleTwo(String.valueOf(final_currLeaseMoney)));
			//如果最后一期，单独处理剩本本金为0，把角分差放到利息中。
			if(i==l_old_corpus.size()-1){
				l_interest.set(i, Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(l_interest.get(i))-Double.parseDouble(l_corpus_overage.get(i)))));
				l_corpus.set(i, Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(l_corpus.get(i))+Double.parseDouble(l_corpus_overage.get(i)))));
				l_corpus_overage.set(i, "0.00");
			}
			
			System.out.println("i="+i+"租金="+l_rent.get(i)+" 本金="+l_corpus.get(i)+" 利息="+l_interest.get(i)+" 剩余本金="+final_currLeaseMoney+" 期利率"+newrate);
			
		}
		
		/*
		 * 
		 * RentInfoBox 封装测算List
		 * 
		 */
		rentInfoBox.setL_rent(l_rent);
		rentInfoBox.setL_corpus(l_corpus);
		rentInfoBox.setL_interest(l_interest);
		rentInfoBox.setL_corpus_overage(l_corpus_overage);
		return rentInfoBox;
		
	}		
	
}
