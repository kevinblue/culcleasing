/**
 * com.tenwa.util
 */
package com.tenwa.util;

/**
 * 数据拷贝工具类，从temp表拷贝到正式表
 * 
 * @author Jaffe
 * 
 * Date:May 26, 2011 1:47:18 PM
 */
public class TableCopySqlUtil {

	/**
	 * 拼接proj_condition表数据拷贝到proj_condition_temp表
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 */
	public static String getSqlProjConditionToProjConditionTemp(String proj_id,
			String doc_id) {
		StringBuffer sql = new StringBuffer();
		sql
				.append(" INSERT INTO proj_condition_temp  ")
				.append(
						" (proj_id ,currency ,equip_amt ,lease_money ,lease_term ")
				.append(" ,income_number_year,income_number,year_rate ")
				.append(" ,rate_float_type,period_type,income_day ")
				.append(" ,start_date,first_payment,caution_money ")
				.append(" ,handling_charge,return_amt,nominalprice ")
				.append(" ,pena_rate,net_lease_money,plan_irr ")
				.append(" ,measure_type,creator,create_date ")
				.append(
						" ,modificator,modify_date,before_interest,rate_adjustment_modulus ")
				.append(" ,other_income,other_expenditure,rate_float_amt ")
				.append(" ,measure_id ")
				.append(" ,market_irr  ")
				// 新增字段市场IRR date:2010-06-28
				.append(" ,lease_money_proportion  ")
				// 【新增字段 2010-07-27】 净融资额比例
				.append(" ,accountPrincipal   ")
				// 会计核算本金 【新增字段 2010-08-06】
				.append(" ,rentScale  ")
				// 【新增字段 2010-08-20】34 圆整到
				.append(" ,liugprice   ")
				// 留购价 【2010-09-21 之前的留购价改成资产于值】35
				.append(" ,delay  ")
				// 【新增字段 2010-10-20】36 延迟期数
				.append(" ,grace  ")
				// 【新增字段 2010-10-20】37 宽限期数
				.append(" ,management_fee  ")
				// 【新增字段 2010-11-11】38 管理费
				.append(" ,ajdustStyle  ")
				// 【新增字段 2010-11-23】39调息方式
				.append(" ,amt_return  ")
				// 【新增字段 2011-01-10】40 设备是否退还
				.append(" ,into_batch  ")
				// 【新增字段 2011-05-26】41 是否参与批量调息
				.append("  )")
				.append(" select  ")
				.append(
						" proj_id ,currency ,equip_amt ,lease_money ,lease_term ,income_number_year,income_number,year_rate")
				.append(
						" ,rate_float_type,period_type,income_day,start_date,first_payment,caution_money ")
				.append(
						" ,handling_charge,return_amt,nominalprice,pena_rate,net_lease_money,plan_irr,measure_type,creator,create_date ")
				.append(
						" ,modificator,modify_date,before_interest,rate_adjustment_modulus ")
				.append(" ,other_income,other_expenditure,rate_float_amt, ")
				.append("'" + doc_id + "'").append(" ,market_irr   ")// 新增字段市场IRR
				.append(" ,lease_money_proportion   ")// 【新增字段 2010-07-27】
				// 净融资额比例
				.append(" ,accountPrincipal   ")// 会计核算本金 【新增字段 2010-08-06】
				.append(" ,rentScale  ")// 【新增字段 2010-08-20】34 圆整到
				.append(" ,liugprice   ")// 留购价 【2010-09-21 之前的留购价改成资产于值】35
				.append(" ,delay  ")// 【新增字段 2010-10-20】36 延迟期数
				.append(" ,grace  ")// 【新增字段 2010-10-20】37 宽限期数
				.append(" ,management_fee  ")// 【新增字段 2010-11-11】38 管理费
				.append(" ,ajdustStyle  ")// 【新增字段 2010-11-23】39调息方式
				.append(" ,amt_return  ")// 【新增字段 2011-01-10】40 设备是否退还
				.append(" ,into_batch  ")// 【新增字段 2011-05-26】41 是否参与批量调息
				.append(" from  proj_condition ").append(
						"  where proj_id = '" + proj_id + "' ");
		return sql.toString();
	}

	/**
	 * 拼接项目租金计划临时表数据copy到项目租金计划表
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 */
	public static String getSqlFundRentPlanProjToFundRentPlanProjTemp(
			String proj_id, String doc_id) {
		StringBuffer sql = new StringBuffer();
		sql
				.append(" INSERT INTO fund_rent_plan_proj_temp( ")
				.append(" doc_id,measure_date,proj_id,rent_list,plan_date")
				.append(" ,rent,corpus,year_rate,interest,rent_overage")
				.append(" ,corpus_overage,interest_overage,penalty_overage,penalty ")
				.append(" ,creator,create_date,modificator,modify_date) ")
				.append(" select '"+doc_id+"',measure_date")
				.append(" ,proj_id,rent_list,plan_date")
				.append(" ,rent,corpus,year_rate,interest,rent_overage")
				.append(" ,corpus_overage,interest_overage,penalty_overage,penalty ")
				.append(" ,creator,create_date,modificator,modify_date ")
				.append(" from fund_rent_plan_proj ")
				.append("  where  proj_id = '" + proj_id+ "' order by rent_list");
		
		return sql.toString();
	}
	
}
