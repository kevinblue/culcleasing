package com.tenwa.culc.calc.tx.zjcs;

import java.util.ArrayList;
import java.util.List;

import com.Tools;
import com.rent.calc.tx.bg.ToolUtil;

/**
 * 平息法租金测算工具类
 * 
 * @author shf
 * 
 */
public class Tx_SetLawRentCaleUtil {


	@SuppressWarnings({ "unused", "unchecked" })
	public List getCorpusList(List rent_list,List inte_list,String leas_money,String assets_value, String rentScale){
		List corpus_list = new ArrayList();
		String preCorpus="0";
		String total = "0";
		String tem_inter = "0";
		for (int i=0;i<rent_list.size();i++){
			if(i<rent_list.size()-1){
			preCorpus=Tools.formatNumberDoubleScale(String.valueOf(
					Double.parseDouble(rent_list.get(i).toString())-Double.parseDouble(inte_list.get(i).toString())),
					Integer.parseInt(rentScale));
				total = Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(total)+
						Double.parseDouble(preCorpus)),Integer.parseInt(rentScale));
			}else{
				preCorpus = Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(leas_money)-
						Double.parseDouble(total)-Double.parseDouble(assets_value)),Integer.parseInt(rentScale));
				tem_inter = Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(rent_list.get(i).toString())-
						Double.parseDouble(preCorpus)),Integer.parseInt(rentScale));
			}
			corpus_list.add(preCorpus);
			
		}
		return corpus_list;
	}
	
	
	/**
	 * function  在精度存在误差的情况下处理最后一期利息
	 * @param l_rent
	 * @param l_Corpus
	 * @param l_inter
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List  getNewInterList(List l_rent,List l_Corpus,List l_inter,String rentScale){
		String tem_inter = "0";
		tem_inter = Tools.formatNumberDoubleScale(String.valueOf(Double.parseDouble(
				l_rent.get(l_rent.size()-1).toString())-
				Double.parseDouble(l_Corpus.get(l_Corpus.size()-1).toString())),Integer.parseInt(rentScale));
		l_inter.set(l_rent.size()-1, tem_inter);
		return l_inter;
	}

	/**
	 * 每一期的租金值
	 * 
	 * @param leaseMoney
	 * @param income_number
	 * @param yearRate
	 * @param lease_interval
	 * @return
	 */
	@SuppressWarnings("static-access")
	public String getRent(String leaseMoney,String assets_value, String income_number,
			String yearRate, String lease_interval, String rentScale) {

		ToolUtil tu = new ToolUtil();
//		System.out.println("yearRate="+yearRate+"   lease_interval="+lease_interval);
		String preRate = Tools.formatNumberDoubleScale(tu.getPreRate(yearRate,
				lease_interval), 12);
//		System.out.println("平息法租金=("+leaseMoney+"+"+leaseMoney+"*"+preRate+"*"+income_number+")/"+income_number);
		return Tools.formatNumberDoubleScale(String
				.valueOf((Double.parseDouble(leaseMoney)-Double.parseDouble(assets_value) + Double
						.parseDouble(leaseMoney)
						* Double.parseDouble(preRate)
						* Integer.parseInt(income_number))
						/ Integer.parseInt(income_number)), Integer
				.parseInt(rentScale));

	}


	/**
	 * 得到租金列表
	 * 
	 * @param leaseMoney
	 * @param assets_value
	 * @param income_number
	 * @param yearRate
	 * @param lease_interval
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "static-access" })
	public List getRentList(String leaseMoney,String assets_value, String income_number,
			String yearRate, String lease_interval, String rentScale) {
		
		
		//2011-05-11延迟期改延迟月修改
		
		String rent = Tools.formatNumberDoubleScale(getRent(leaseMoney,assets_value,
				income_number, yearRate, lease_interval, rentScale), Integer
				.parseInt(rentScale));
		List rent_list = new ArrayList();
		// // 延迟期
		// for (int i = 0; i < Integer.parseInt(delay); i++) {
		// rent_list.add("0");
		// }
		// 宽限期
//		ToolUtil tu = new ToolUtil();
//		String preRate = Tools.formatNumberDoubleScale(tu.getPreRate(yearRate,
//				lease_interval), 12);
//		for (int i = 0; i < Integer.parseInt(grace); i++) {
//			rent_list.add(Tools
//					.formatNumberDoubleScale(String.valueOf(Double
//							.parseDouble(leaseMoney)
//							* Double.parseDouble(preRate)), Integer
//							.parseInt(rentScale)));
//		}

		for (int i = 0; i < Integer.parseInt(income_number); i++) {
			rent_list.add(rent);
		}
		return rent_list;

	}


	/**
	 * 利息计算
	 * 
	 * @param rent_list
	 * @param corpus_list
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getInterMarket(List rent_list, String lease_money, String year_rate,String lease_interval, 
			String rentScale) {

		List inter_list = new ArrayList();
		String c_rate = String.valueOf(Double.parseDouble(year_rate) / 12
				/ 100 * Integer.parseInt(lease_interval));// 利率
		for (int i = 0; i < rent_list.size(); i++) {
			String s_inter = String.valueOf(Double.parseDouble(lease_money)*Double.parseDouble(c_rate));
			inter_list.add(Tools.formatNumberDoubleScale(s_inter, Integer
					.parseInt(rentScale)));
		}
		return inter_list;
	}




	/**
	 * 
	 * @param rentList
	 *            租金list
	 * @param leaseMoney
	 *            要测算的本金
	 * @param calRate
	 *            计算的利率 qzOrqm 期初还是期未
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getInterestList(List rentList, String leaseMoney,
			String calRate, String qzOrqm, String rentScale, String grace,
			String delay) {
		
		//2011-05-11延迟期改延迟月修改
		System.out.println("传过来计算利率：" + calRate);
		// 用于保留利息
		List interests = new ArrayList();
		String corpus_total = "0";
		// 该期的利息
		String inte = "";
		String corpus = "";
		String corpus_overage = "";
		// 本金余额
		corpus_overage = Tools.formatNumberDoubleScale(leaseMoney, Integer
				.parseInt(rentScale));

		//int igrace = 0;
		for (int i = Integer.parseInt(grace); i < rentList.size(); i++) {// 循环租金list

			if ("1".equals(qzOrqm) && i == 0) {// 第一期且是期初时
				corpus = rentList.get(i).toString();
				inte = "0";
			} else {
				// 利息
				inte = String.valueOf(Double.parseDouble(corpus_overage)
						* Double.parseDouble(calRate));// 剩余本金*利率
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(rentScale));
				// 本金
				corpus = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(inte));// 租金-利息
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(rentScale));

			}

			// 最后一期的利息=剩余的利息总合,本金仍然=租金-利息
			if (i == rentList.size() - 1) {
				// 本金 --总的本金-以前的本金和
				corpus = String.valueOf(Double.parseDouble(leaseMoney)
						- Double.parseDouble(corpus_total));
				corpus = Tools.formatNumberDoubleScale(corpus, Integer
						.parseInt(rentScale));

				inte = String.valueOf(Double.parseDouble(rentList.get(i)
						.toString())
						- Double.parseDouble(corpus));
				inte = Tools.formatNumberDoubleScale(inte, Integer
						.parseInt(rentScale));

			}

			corpus_total = String.valueOf(Double.parseDouble(corpus_total)
					+ Double.parseDouble(corpus));
			corpus_total = Tools.formatNumberDoubleScale(corpus_total, Integer
					.parseInt(rentScale));

			// 本金余额
			corpus_overage = String.valueOf(Double.parseDouble(corpus_overage)
					- Double.parseDouble(corpus));
			corpus_overage = Tools.formatNumberDoubleScale(corpus_overage,
					Integer.parseInt(rentScale));
			// 添加list
			interests.add(inte);

		}

		return interests;
	}




	/**
	 * 
	 * @param leaseMoney总的本金
	 * @param corpusList
	 *            每一期的本金
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getCorpusOvergeList(String leaseMoney, List corpusList,
			String rentScale) {
		String total = "0";// 累积每一期的本金
		List corps = new ArrayList();

		for (int i = 0; i < corpusList.size(); i++) {

			total = String.valueOf(Double.parseDouble(total)
					+ Double.parseDouble(corpusList.get(i).toString()));
			total = Tools.formatNumberDoubleScale(total, Integer
					.parseInt(rentScale));

			double d = Double.parseDouble(leaseMoney)
					- Double.parseDouble(total);
			corps.add(Tools.formatNumberDoubleScale(String.valueOf(d), Integer
					.parseInt(rentScale)));

		}
		return corps;
	}

}
