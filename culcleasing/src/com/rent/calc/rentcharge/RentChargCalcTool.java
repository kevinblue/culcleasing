package com.rent.calc.rentcharge;

import java.util.ArrayList;
import java.util.List;

import com.Tools;
import com.rent.calc.bg.RentCalc;
import com.rent.calc.tx.bg.FundRentPlan;

/**
 * 租金变更计算工具类
 * 
 * @author shf
 * 
 */
public class RentChargCalcTool {
	/**
	 * 是否只修改了偿还日
	 * 
	 * @param income_day
	 *            原来的偿还日
	 * @param newDate
	 *            新的偿还日
	 * @param income_number
	 *            期数
	 * @param startStages
	 *            变更开始日期
	 * @param newPhases
	 *            新的剩余变更期数
	 * @param year_rate
	 *            旧年利率
	 * @param newRate
	 *            新的年利率
	 * @return
	 */
	public boolean isChargePlanDate(String income_day, String newDate,
			String income_number, String startStages, String newPhases,
			String year_rate, String newRate) {

		return !income_day.equals(newDate)
				&& ((Integer.parseInt(income_number)
						- Integer.parseInt(startStages) + 1) == Integer
						.parseInt(newPhases))
				&& (Double.parseDouble(year_rate) == Double
						.parseDouble(newRate));
	}

	/**
	 * 是否只修改了年利率
	 * 
	 * @param income_day
	 *            原来的偿还日
	 * @param newDate
	 *            新的偿还日
	 * @param income_number
	 *            期数
	 * @param startStages
	 *            变更开始日期
	 * @param newPhases
	 *            新的剩余变更期数
	 * @param year_rate
	 *            旧年利率
	 * @param newRate
	 *            新的年利率
	 * @return
	 */
	public boolean isChargeYearRate(String income_day, String newDate,
			String income_number, String startStages, String newPhases,
			String year_rate, String newRate) {

		return income_day.equals(newDate)
				&& ((Integer.parseInt(income_number)
						- Integer.parseInt(startStages) + 1) == Integer
						.parseInt(newPhases))
				&& (Double.parseDouble(year_rate) != Double
						.parseDouble(newRate));
	}

	/**
	 * 改了年利率 剩余期数
	 * 
	 * @param income_day
	 *            原来的偿还日
	 * @param newDate
	 *            新的偿还日
	 * @param income_number
	 *            期数
	 * @param startStages
	 *            变更开始日期
	 * @param newPhases
	 *            新的剩余变更期数
	 * @param year_rate
	 *            旧年利率
	 * @param newRate
	 *            新的年利率
	 * @return
	 */
	public boolean isChargeYearRateAndPhases(String income_day, String newDate,
			String income_number, String startStages, String newPhases,
			String year_rate, String newRate) {

		return income_day.equals(newDate)
				&& ((Integer.parseInt(income_number)
						- Integer.parseInt(startStages) + 1) != Integer
						.parseInt(newPhases))
				&& (Double.parseDouble(year_rate) != Double
						.parseDouble(newRate));
	}

	/**
	 * // 改了年利率 剩余期数 每月租金偿还日
	 * 
	 * @param income_day
	 *            原来的偿还日
	 * @param newDate
	 *            新的偿还日
	 * @param income_number
	 *            期数
	 * @param startStages
	 *            变更开始日期
	 * @param newPhases
	 *            新的剩余变更期数
	 * @param year_rate
	 *            旧年利率
	 * @param newRate
	 *            新的年利率
	 * @return
	 */
	public boolean isChargeYearRateAndPhasesAndDate(String income_day,
			String newDate, String income_number, String startStages,
			String newPhases, String year_rate, String newRate) {

		return !income_day.equals(newDate)
				&& ((Integer.parseInt(income_number)
						- Integer.parseInt(startStages) + 1) != Integer
						.parseInt(newPhases))
				&& (Double.parseDouble(year_rate) != Double
						.parseDouble(newRate));
	}

	/**
	 * 期数，租金 租金列表
	 * 
	 * @param rent
	 * @param phase
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List getRentListByRentAndPhase(String rent, String phase) {
		List list = new ArrayList();
		for (int i = 0; i < Integer.parseInt(phase); i++) {
			list.add(rent);
		}
		return list;
	}

	/**
	 * 租金变更计划时间
	 * 
	 * @param contractId
	 * @param startStages
	 * @param newDate
	 * @param newPhases
	 * @param income_number_year
	 * @param l_date
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void getChargeDate(String contractId, String startStages,
			String newDate, String newPhases, String income_number_year,
			List l_date) throws Exception {
		// 更改租金计划计划时间
		FundRentPlan frp = new FundRentPlan();
		RentCalc rc = new RentCalc();
		String startDate = frp.getPreDate(contractId, String.valueOf(Integer
				.parseInt(startStages) + 1));
		startDate = rc.getNewDate(startDate, newDate);

		for (int i = 0; i < Integer.parseInt(newPhases); i++) {
			String addDate = Tools.dateAdd("month", i
					* Integer.parseInt(income_number_year), startDate);
			addDate = rc.getNewDate(addDate, newDate);

			l_date.add(addDate);
		}
	}
}
