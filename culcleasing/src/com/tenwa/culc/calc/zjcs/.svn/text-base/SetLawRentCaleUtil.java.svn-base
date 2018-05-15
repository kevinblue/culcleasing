package com.tenwa.culc.calc.zjcs;

import java.util.ArrayList;
import java.util.List;

import com.Tools;
import com.tenwa.culc.calc.zjcs.IrrCal;
import com.rent.calc.tx.bg.ToolUtil;

/**
 * 平息法租金测算工具类
 * 
 * @author shf
 * 
 */
public class SetLawRentCaleUtil {

	/**
	 * 得到第一期的日期
	 * 
	 * @param type
	 *            付租类型
	 * @param lease_interval
	 *            间隔数
	 * @param plan_date
	 *            计划日期
	 * @return
	 */
	public String getFirstDate(String type, String lease_interval,
			String plan_date) {
		// 如果是期末则第一期租金日期=放款日期+间隔月数
		String start_date = plan_date;
		String day = "";
		if (start_date.indexOf("-") > -1) {// 得到日
			day = start_date.substring(start_date.lastIndexOf("-") + 1,
					start_date.length());
		}

		if (type.equals("0")) {
			start_date = getNewDate(start_date, day);
			start_date = Tools.dateAdd("month", Integer
					.parseInt(lease_interval), start_date);
		}

		System.out.println("第一期时间:" + start_date);
		return start_date;
	}


	/**
	 * 
	 * @param rentList
	 *            租金 list
	 * @param perType
	 *            期初还是期未
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getPlanDateList(List rentList, String perType,
			String lease_interval, String plan_date, String grace, String delay) {
		
		
		//2011-05-11延迟期改延迟月修改
		delay="0";
		
		// 如果是期末则第一期租金日期=放款日期+间隔月数
		String start_date = getFirstDate(perType, lease_interval, plan_date);
		String day = "";
		if (start_date.indexOf("-") > -1) {// 得到日
			day = plan_date.substring(plan_date.lastIndexOf("-") + 1, plan_date
					.length());
		}
		List l_date = new ArrayList();
		// 延迟期日期处理
		start_date = Tools.dateAdd("month", Integer.parseInt(delay)
				* Integer.parseInt(lease_interval), start_date);

		for (int i = 0; i < rentList.size(); i++) {
			String addDate = Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), start_date);
			addDate = getNewDate(addDate, day);

			l_date.add(addDate);
		}

		return l_date;
	}


	/**
	 * 判断根据年月得到到实际每月的最大 天数
	 * 
	 * @param start_date
	 * @param day
	 * @return
	 */
	public String getNewDate(String start_date, String day) {

		// 根据年月得到他的最后一天
		String year = start_date.substring(0, start_date.indexOf("-"));
		String month = start_date.substring(start_date.indexOf("-") + 1,
				start_date.lastIndexOf("-"));
		String lastDay = Tools.getLastDayOfMonth(year, month);
		String u_day = "";

		u_day = day;
		if (Integer.parseInt(lastDay) <= Integer.parseInt(day)) {
			u_day = lastDay;
		}

		return year + "-" + month + "-" + u_day;
	}


//	/**
//	 * 得到本金List(老算法)
//	 * 
//	 * @param leaseMoney
//	 * @param income_number
//	 * @return
//	 */
//	@SuppressWarnings("unchecked")
//	public List getCorpusList(String leaseMoney,String assets_value, String income_number,
//			String rentScale, String grace, String delay) {
//		
//		
//		//2011-05-11延迟期改延迟月修改
//		delay="0";
//		
//
//		String total = "0";// 累积每一期的本金
//		String preCorpus = Tools.formatNumberDoubleScale(String.valueOf((Double
//				.parseDouble(leaseMoney)-Double.parseDouble(assets_value))
//				/ Double.parseDouble(income_number)), Integer
//				.parseInt(rentScale));
//		List corpus_list = new ArrayList();
//
//		// 添加宽限期,延迟期的本金值
//		for (int i = 0; i < Integer.parseInt(grace); i++) {
//			corpus_list.add("0");
//		}
//
//		String newcorpus = "0";
//		for (int i = 0; i < Integer.parseInt(income_number); i++) {
//			newcorpus = preCorpus;
//			if (i == Integer.parseInt(income_number) - 1) {
//				newcorpus = Tools.formatNumberDoubleScale(String.valueOf(Double
//						.parseDouble(leaseMoney)
//						- Double.parseDouble(total)), Integer
//						.parseInt(rentScale));
//			}
//
//			corpus_list.add(newcorpus);
//			total = Tools.formatNumberDoubleScale(String.valueOf(Double
//					.parseDouble(total)
//					+ Double.parseDouble(preCorpus)), Integer
//					.parseInt(rentScale));
//
//		}
//
//		return corpus_list;
//	}
	@SuppressWarnings("unchecked")
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
	@SuppressWarnings("unchecked")
	public List getRentList(String leaseMoney,String assets_value, String income_number,
			String yearRate, String lease_interval, String rentScale,
			String grace, String delay) {
		
		
		//2011-05-11延迟期改延迟月修改
		delay="0";
		
		String rent = Tools.formatNumberDoubleScale(getRent(leaseMoney,assets_value,
				income_number, yearRate, lease_interval, rentScale), Integer
				.parseInt(rentScale));
		List rent_list = new ArrayList();
		// // 延迟期
		// for (int i = 0; i < Integer.parseInt(delay); i++) {
		// rent_list.add("0");
		// }
		// 宽限期
		ToolUtil tu = new ToolUtil();
		String preRate = Tools.formatNumberDoubleScale(tu.getPreRate(yearRate,
				lease_interval), 12);
		for (int i = 0; i < Integer.parseInt(grace); i++) {
			rent_list.add(Tools
					.formatNumberDoubleScale(String.valueOf(Double
							.parseDouble(leaseMoney)
							* Double.parseDouble(preRate)), Integer
							.parseInt(rentScale)));
		}

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
			//老算法（平息法）
//			String s_inter = String.valueOf(Double.parseDouble(Tools
//					.formatNumberDoubleScale(rent_list.get(i).toString(),
//							Integer.parseInt(rentScale)))
//					- Double.parseDouble(Tools.formatNumberDoubleScale(
//							corpus_list.get(i).toString(), Integer
//									.parseInt(rentScale))));
			String s_inter = String.valueOf(Double.parseDouble(lease_money)*Double.parseDouble(c_rate));
			inter_list.add(Tools.formatNumberDoubleScale(s_inter, Integer
					.parseInt(rentScale)));
		}
		return inter_list;
	}


	/**
	 * 得到irr
	 * 
	 * @param firstMoney
	 * @param rent_list
	 * @param lease_interval
	 * @param type
	 * @param grace
	 *            宽限期
	 * 
	 * @return
	 */

	@SuppressWarnings("unchecked")
	public String getIrr(String firstMoney, List rent_list,String caution_money,String assets_value,
			String Other_expenditure,String lease_interval, String type, String delay, String grace) {
		
		//2011-05-11延迟期改延迟月修改
		delay="0";
		
		List new_list = new ArrayList();
		int i = 0;
		if ("1".equals(type)) {// 先付时
			i++;
			new_list.add(Tools.formatNumberDoubleTwo(String.valueOf(Double
					.parseDouble(firstMoney)
					+ Double.parseDouble(rent_list.get(0).toString()))));
		} else {
			new_list.add(Tools.formatNumberDoubleTwo(firstMoney));
		}

		// 2011-04－15注释
		// //先添加延迟的租金现金流
		// for (int j = 0; j < Integer.parseInt(delay); j++) {
		// new_list.add("0");
		// }

		// 2011-04－15添加不从宽限期开始算现金流irr
		//i=i+Integer.parseInt(grace);
		

		for (; i < rent_list.size(); i++) {
			if(i<(rent_list.size()-1)){
				new_list.add(rent_list.get(i));
			}else{//最后一期现金流考虑资产余值
				new_list.add(Tools.formatNumberDoubleTwo(String.valueOf(Double.parseDouble(rent_list.get(i).toString())-
						Double.parseDouble(caution_money)+Double.parseDouble(assets_value)+
						Double.parseDouble(Other_expenditure))));
			}
		}
//		for(int j=0;j<new_list.size();j++){
//			System.out.println("new_list="+new_list.get(j));
//		}
		IrrCal ic = new IrrCal();
		String irr = Tools.formatNumberDoubleScale(ic.getIRR(new_list,
				lease_interval, lease_interval, String.valueOf(12 / Integer
						.parseInt(lease_interval))), 4);
		return irr;
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
		delay="0";
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

		// 宽限期 延迟
		// int igrace = Integer.parseInt(grace) + Integer.parseInt(delay);
		// int igrace = Integer.parseInt(delay);
		// if (igrace > 0) {
		// //igrace--;
		// }
		// /延迟
		// for (int i = 0; i < Integer.parseInt(delay); i++) {
		// interests.add("0");
		// }

		// 宽限期
		 for (int i = 0; i < Integer.parseInt(grace); i++) {
		 interests.add(rentList.get(i));
		 }
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
	 * @param rentList
	 *            租金 list
	 * @param inteList
	 *            利息list
	 * @return
	 */

//	@SuppressWarnings("unchecked")
//	public List getCorpusList(List rentList, List inteList, String rentScale,
//			String grace, String delay) {
//		
//		
//		//2011-05-11延迟期改延迟月修改
//		delay="0";
//		List corpus_list = new ArrayList();
//		// 宽限期
//		// int igrace = Integer.parseInt(grace) + Integer.parseInt(delay);
//		// if (igrace > 0) {
//		// igrace--;
//		// }
//		// for (int i = 0; i < Integer.parseInt(grace) +
//		// Integer.parseInt(delay); i++) {
//		// corpus_list.add("0");
//		// }
//		int igrace = 0;
//		for (int i = igrace; i < rentList.size(); i++) {
//
//			corpus_list.add(Tools.formatNumberDoubleScale(String.valueOf(Double
//					.parseDouble(rentList.get(i).toString())
//					- Double.parseDouble(inteList.get(i).toString())), Integer
//					.parseInt(rentScale)));
//
//		}
//		return corpus_list;
//	}


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


	/**
	 * 得到租金列表 指定有多少个租金值
	 * 
	 * @param leaseMoney
	 * @param income_number
	 * @param yearRate
	 * @param lease_interval
	 * @return
	 */
//	@SuppressWarnings("unchecked")
//	public List getRentListByCount(String leaseMoney, String income_number,
//			String yearRate, String lease_interval, String rentScale, String qs) {
//
//		String rent = Tools.formatNumberDoubleScale(getRent(leaseMoney,
//				income_number, yearRate, lease_interval, rentScale), Integer
//				.parseInt(rentScale));
//		List rent_list = new ArrayList();
//		for (int i = 0; i < Integer.parseInt(qs); i++) {
//			rent_list.add(rent);
//		}
//
//		return rent_list;
//	}


	public static void main(String[] args) {
		SetLawRentCaleUtil sr = new SetLawRentCaleUtil();
//		System.out.println(sr.getRent("1000000", "24", "9.05", "1", "3"));
	}

}
