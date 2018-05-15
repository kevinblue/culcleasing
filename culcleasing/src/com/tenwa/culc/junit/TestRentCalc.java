/**
 * com.tenwa.culc.junit
 */
package com.tenwa.culc.junit;

import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.service.RentPlanService;

/**
 * @author Jaffe
 * 
 * Date:Jul 13, 2011 5:01:23 PM Email:JaffeHe@hotmail.com
 */
public class TestRentCalc {

	public static void main(String[] args) {
		// 初始化ConditionBean
		ConditionBean conditionBean = null;
		// 属性字段
		String proj_id = "CULCTEST000001";
		String doc_id = "JJJFFFFFRRRXXX9999";
		String equip_amt = "20000";// 设备金额
		String currency = "currency_type1";
		String lease_money = "18000";
		String first_payment = "2000";
		String caution_money = "0";
		String actual_fund = "18000";
		String actual_fund_ratio = "90.00";
		String handling_charge = "0";
		String management_fee = "0";
		String nominalprice = "0";
		String return_amt = "0";
		String rate_subsidy = "0";
		String before_interest = "0";
		String discount_rate = "0";
		String consulting_fee_out = "0";
		String consulting_fee_in = "0";
		String other_income = "0";
		String other_expenditure = "0";
		String income_number = "12";
		String income_number_year = "1";
		String lease_term = "12";
		String settle_method = "RentCalcType7";
		String period_type = "0";
		String rate_float_type = "0";
		String rate_float_amt = "0";
		String adjust_style = "0";
		String year_rate = "5.7";
		String pena_rate = "0";
		String start_date = "2010-07-15";
		String rent_start_date = "2010-07-06";
		String income_day = "15";
		String end_date = "0";
		String plan_irr = "0";
		String free_defa_inter_day = "0";
		String insure_type = "0";
		String into_batch = "0";
		String insure_money = "0";
		String assets_value = "0";
		String assess_adjust = "0";
		String ratio_param = "0";
		String creator = "00000";
		String create_date = "2011-07-13";
		String modify_date = "2011-07-13";
		String modificator = "00000";

		conditionBean = new ConditionBean(doc_id, proj_id, equip_amt, currency,
				lease_money, first_payment, caution_money, actual_fund,
				actual_fund_ratio, handling_charge, management_fee,
				nominalprice, return_amt, rate_subsidy, before_interest,
				discount_rate, consulting_fee_out, consulting_fee_in,
				other_income, other_expenditure, income_number,
				income_number_year, lease_term, settle_method, period_type,
				rate_float_type, rate_float_amt, adjust_style, year_rate,
				pena_rate, start_date, income_day, end_date,rent_start_date, plan_irr,
				free_defa_inter_day, insure_type, into_batch, insure_money,
				assets_value, assess_adjust, ratio_param, creator, create_date,
				modify_date, modificator);

		// 调用测算
		RentPlanService.calcRentPlan(conditionBean);

		// 输出调试
	}
}
