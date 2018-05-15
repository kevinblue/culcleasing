/**
 * com.tenwa.util
 */
package com.tenwa.util;

/**
 * ���ݿ��������࣬��temp��������ʽ��
 * 
 * @author Jaffe
 * 
 * Date:May 26, 2011 1:47:18 PM
 */
public class TableCopySqlUtil {

	/**
	 * ƴ��proj_condition�����ݿ�����proj_condition_temp��
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
				// �����ֶ��г�IRR date:2010-06-28
				.append(" ,lease_money_proportion  ")
				// �������ֶ� 2010-07-27�� �����ʶ����
				.append(" ,accountPrincipal   ")
				// ��ƺ��㱾�� �������ֶ� 2010-08-06��
				.append(" ,rentScale  ")
				// �������ֶ� 2010-08-20��34 Բ����
				.append(" ,liugprice   ")
				// ������ ��2010-09-21 ֮ǰ�������۸ĳ��ʲ���ֵ��35
				.append(" ,delay  ")
				// �������ֶ� 2010-10-20��36 �ӳ�����
				.append(" ,grace  ")
				// �������ֶ� 2010-10-20��37 ��������
				.append(" ,management_fee  ")
				// �������ֶ� 2010-11-11��38 �����
				.append(" ,ajdustStyle  ")
				// �������ֶ� 2010-11-23��39��Ϣ��ʽ
				.append(" ,amt_return  ")
				// �������ֶ� 2011-01-10��40 �豸�Ƿ��˻�
				.append(" ,into_batch  ")
				// �������ֶ� 2011-05-26��41 �Ƿ����������Ϣ
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
				.append("'" + doc_id + "'").append(" ,market_irr   ")// �����ֶ��г�IRR
				.append(" ,lease_money_proportion   ")// �������ֶ� 2010-07-27��
				// �����ʶ����
				.append(" ,accountPrincipal   ")// ��ƺ��㱾�� �������ֶ� 2010-08-06��
				.append(" ,rentScale  ")// �������ֶ� 2010-08-20��34 Բ����
				.append(" ,liugprice   ")// ������ ��2010-09-21 ֮ǰ�������۸ĳ��ʲ���ֵ��35
				.append(" ,delay  ")// �������ֶ� 2010-10-20��36 �ӳ�����
				.append(" ,grace  ")// �������ֶ� 2010-10-20��37 ��������
				.append(" ,management_fee  ")// �������ֶ� 2010-11-11��38 �����
				.append(" ,ajdustStyle  ")// �������ֶ� 2010-11-23��39��Ϣ��ʽ
				.append(" ,amt_return  ")// �������ֶ� 2011-01-10��40 �豸�Ƿ��˻�
				.append(" ,into_batch  ")// �������ֶ� 2011-05-26��41 �Ƿ����������Ϣ
				.append(" from  proj_condition ").append(
						"  where proj_id = '" + proj_id + "' ");
		return sql.toString();
	}

	/**
	 * ƴ����Ŀ���ƻ���ʱ������copy����Ŀ���ƻ���
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
