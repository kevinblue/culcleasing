package com.rent.calc.rentcharge;

import java.util.List;

import com.Tools;

public class RentChargeTool {
	/**
	 * 偿还日 与计划日期得到新的计划日期
	 * 
	 * @param plan_date
	 *            计划日期
	 * @param day
	 *            偿还日
	 * @return 新的租金计划日期
	 */

	public static String getNewDate(String plan_date, String day) {

		// 根据年月得到他的最后一天
		String year = plan_date.substring(0, plan_date.indexOf("-"));
		String month = plan_date.substring(plan_date.indexOf("-") + 1,
				plan_date.lastIndexOf("-"));
		String lastDay = Tools.getLastDayOfMonth(year, month);
		String u_day = "";

		u_day = day;
		if (Integer.parseInt(lastDay) <= Integer.parseInt(day)) {
			u_day = lastDay;
		}

		return year + "-" + month + "-" + u_day;
	}

	@SuppressWarnings("unchecked")
	public static List getNewPlanDates(List l_date, String day) {
		for (int i = 0; i < l_date.size(); i++) {
			l_date.set(i, getNewDate(l_date.get(i).toString(), day));
		}

		return l_date;
	}
	
	
	

	public static void main(String[] args) {
		System.out.println(getNewDate("2010-10-15", "36"));
	}

}
