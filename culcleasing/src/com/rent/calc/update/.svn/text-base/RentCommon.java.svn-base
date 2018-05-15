package com.rent.calc.update;

import java.util.ArrayList;
import java.util.List;

import com.Tools;

/**
 * 租金测算的公共类(等额或等本测算的公共类)
 * 
 * @author Administrator
 * 
 */
public abstract class RentCommon {
	

	/**
	 * 得到租金的测算第一个日期
	 * 
	 * @param type
	 *            0 期末 1 期初
	 * @param lease_interval
	 *            租金偿还间隔(按月份)
	 * @param plan_date
	 * @return
	 */
	@SuppressWarnings("unused")
	protected String getStartDate(String type, String lease_interval,
			String plan_date) {
		// 如果是期末则第一期租金日期=放款日期+间隔月数,如果是调息或者是变更之类的把type:不传0,只传1其他大于0的数
		String start_date = plan_date;
		if (type.equals("0")) {// 期末时
			start_date = Tools.dateAdd("month", Integer
					.parseInt(lease_interval), plan_date);
		}
		System.out.println("第一期时间:" + start_date);
		return start_date;
	}
	
	/**
	 * 得到正确的测算的本金,因为在调息的情况下有可能测算值为负
	 * 
	 * @param lease_money
	 *            要测算的本金值
	 * @return
	 */
	protected String judgeLeaseMoney(String lease_money) {
		String lease_money_ = "";
		lease_money_ = lease_money;

		// 租赁本金存在负数是(调息或者是其他的测算时)
		if (lease_money.length() > 0 && lease_money.indexOf("-") > -1) {
			lease_money_ = lease_money.substring(1, lease_money.length());
		}

		return lease_money_;
	}


	/**
	 * 
	 * @param calcRate
	 *            所要计算的年利率或都是irr之类的
	 * @param lease_interval
	 *            租金间隔
	 * @return
	 */
	@SuppressWarnings("unused")
	protected String getPreRate(String calcRate, String lease_interval) {

		return String.valueOf(Double.parseDouble(calcRate) / 12 / 100
				* Integer.parseInt(lease_interval));
	}
	
	/**
	 * 得到租金偿还时间的list
	 * 
	 * @param rentList
	 * @param type
	 * @param lease_interval
	 * @param plan_date
	 * @return
	 */
	@SuppressWarnings("unchecked")
	protected List getPlanDateList(List rentList, String type,
			String lease_interval, String plan_date) {
		// 如果是期末则第一期租金日期=放款日期+间隔月数
		String start_date = getStartDate(type, lease_interval, plan_date);
		List l_date = new ArrayList();
		for (int i = 0; i < rentList.size(); i++) {
			l_date.add(Tools.dateAdd("month", i
					* Integer.parseInt(lease_interval), start_date));
		}

		return l_date;
	}
	
	/**
	 * 
	 * @param leaseMoney总的本金
	 * @param corpusList
	 *            本金
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getCorpusOvergeList(String leaseMoney, List corpusList) {
		String total = "0";// 累积每一期的本金
		List corps = new ArrayList();

		for (int i = 0; i < corpusList.size(); i++) {

			total = String.valueOf(Double.parseDouble(total)
					+ Double.parseDouble(corpusList.get(i).toString()));
			total = Tools.formatNumberDoubleScale(total, Integer
					.parseInt(ConstantInfo.MONEYSCALE));

			double d = Double.parseDouble(leaseMoney)
					- Double.parseDouble(total);
			corps.add(Tools.formatNumberDoubleScale(String.valueOf(d), Integer
					.parseInt(ConstantInfo.MONEYSCALE)));

		}
		return corps;
	}



}
