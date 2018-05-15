package com.tenwa.culc.service;

/**
 * com.tenwa.datasync.service
 */
import com.tenwa.culc.bean.BeginInfoMediBean;
import com.tenwa.culc.bean.ConditionMediBean;

public class SqlFenerateConditionMediUtil {

	/**
	 * 插入Proj_condition_temp表的sql语句
	 * 
	 * @param conditionBean
	 * @return
	 */
	public static String generateInsertProjConditionTempSql(
			ConditionMediBean conditionMediBean) {
		StringBuffer sqlBuffer = new StringBuffer();

		// 插入前语句
		sqlBuffer
				.append(
						"insert into proj_condition_medi_temp(doc_id,proj_id,equip_amt,currency,lease_money,first_payment,caution_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,income_day,pena_rate,start_date,rent_start_date,")
				.append(
						"free_defa_inter_day,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no,");
		// 2012-3-28 Jaffe Add
		sqlBuffer
				.append("rate_float_type,rate_float_amt,adjust_style,into_batch,is_open,settle_method,period_type,year_rate,ratio_param)");

		sqlBuffer.append("values(");

		// 拼接值
		sqlBuffer.append("'"
				+ conditionMediBean.getDoc_id()
				+ "','"
				+ conditionMediBean.getProj_id()
				+ "','"

				+ conditionMediBean.getEquip_amt()
				+ "','"
				+ conditionMediBean.getCurrency()
				+ "','"
				+ conditionMediBean.getLease_money()
				+ "','"
				+ conditionMediBean.getFirst_payment()
				+ "','"
				// ==11==
				+ conditionMediBean.getCaution_money()
				+ "','"
				+ conditionMediBean.getActual_fund()
				+ "', '"
				+ conditionMediBean.getHandling_charge()
				+ "','"
				// ==22==
				+ conditionMediBean.getManagement_fee()
				+ "','"
				+ conditionMediBean.getNominalprice()
				+ "','"
				+ conditionMediBean.getReturn_amt()
				+ "','"
				+ conditionMediBean.getRate_subsidy()
				+ "','"
				+ conditionMediBean.getBefore_interest()
				+ "','"
				// ==33==
				+ conditionMediBean.getBefore_interest_type()
				+ "','"
				+ conditionMediBean.getDiscount_rate()
				+ "','"
				+ conditionMediBean.getConsulting_fee_out()
				+ "','"
				+ conditionMediBean.getConsulting_fee_in()
				+ "','"
				+ conditionMediBean.getOther_income()
				+ "','"
				// ==44==
				+ conditionMediBean.getOther_expenditure()
				+ "','"
				+ conditionMediBean.getIncome_number()
				+ "','"
				+ conditionMediBean.getIncome_number_year()
				+ "','"
				+ conditionMediBean.getLease_term()
				+ "','"
				+ conditionMediBean.getIncome_day()
				+ "','"
				// + conditionMediBean.getYear_rate() + "','"
				+ conditionMediBean.getPena_rate()
				+ "','"
				+ conditionMediBean.getStart_date()
				+ "','"
				// + conditionMediBean.getIncome_day() + "','"
				+ conditionMediBean.getRent_start_date()
				+ "','"
				// ==55==
				+ conditionMediBean.getFree_defa_inter_day()
				+ "','"
				// +conditionMediBean.getAmt_return() + "','"
				+ conditionMediBean.getInsure_type()
				+ "','"
				+ conditionMediBean.getInsure_money()
				+ "','"
				+ conditionMediBean.getInsure_pay_type()
				+ "','"
				// ==77==
				+ conditionMediBean.getIs_floor()
				+ "','"
				+ conditionMediBean.getFloor_rent()
				+ "','"
				+ conditionMediBean.getManager_pay_type()
				+ "','"

				// ==88==

				+ conditionMediBean.getCreator() + "','"
				+ conditionMediBean.getCreate_date() + "','"
				+ conditionMediBean.getModify_date() + "','"
				+ conditionMediBean.getModificator() + "','"
				+ conditionMediBean.getActual_fund_ratio() + "','"
				+ conditionMediBean.getPlan_bank_name() + "','"
				+ conditionMediBean.getPlan_bank_no() + "',");
		// 2012-3-28 Jaffe Add
		sqlBuffer.append("'" + conditionMediBean.getRate_float_type() + "','"
				+ conditionMediBean.getRate_float_amt() + "','"
				+ conditionMediBean.getAdjust_style() + "','"
				+ conditionMediBean.getInto_batch() + "'," + "'"
				+ conditionMediBean.getIs_open() + "','"
				+ conditionMediBean.getSettle_method() + "','"
				+ conditionMediBean.getPeriod_type() + "','"
				+ conditionMediBean.getYear_rate() + "','"
				+ conditionMediBean.getRatio_param() + "'");
		sqlBuffer.append(")");

		return sqlBuffer.toString();
	}

	/**
	 * 生成查询proj_condition_temp的Sql语句
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 */
	public static String generateSelectCondTemp(String proj_id, String doc_id) {

		StringBuffer sqBuffer = new StringBuffer();
		//
		// sqBuffer
		// .append(
		// "select
		// equip_amt,currency,lease_money,first_payment,caution_money,caution_deduction_money,")
		// .append(
		// "actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
		// .append(
		// "before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
		// .append(
		// "income_number,income_number_year,lease_term,year_rate,pena_rate,start_date,income_day,rent_start_date,")
		// .append(
		// "free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
		// .append(
		// "creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no
		// from proj_condition_medi_temp");
		// sqBuffer.append(" where proj_id='" + proj_id + "' and doc_id='"
		// + doc_id + "'");

		sqBuffer
				.append("Select * from proj_condition_medi_temp where proj_id='"
						+ proj_id + "' and doc_id='" + doc_id + "'");

		return sqBuffer.toString();
	}

	
	public static String generateSelectCondTemp(String proj_id) {

		StringBuffer sqBuffer = new StringBuffer();

		sqBuffer
				.append(
						"select equip_amt,currency,lease_money,first_payment,caution_money,caution_deduction_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,year_rate,pena_rate,start_date,income_day,rent_start_date,")
				.append(
						"free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no from proj_condition_medi");
		sqBuffer.append(" where proj_id='" + proj_id + "'");

		return sqBuffer.toString();
	}

	/**
	 * 更新项目交易结构临时表
	 * 
	 * @param conditionMediBean
	 * @return
	 */
	public static String generateUpdateProjConditionTempSql(
			ConditionMediBean conditionMediBean) {
		StringBuffer sqlBuffer = new StringBuffer();

		// 插入前语句
		sqlBuffer.append(
				"update proj_condition_temp set equip_amt='"
						+ conditionMediBean.getEquip_amt() + "',currency='"
						+ conditionMediBean.getCurrency() + "',lease_money='"
						+ conditionMediBean.getLease_money()
						+ "',first_payment='"
						+ conditionMediBean.getFirst_payment()
						+ "',caution_money='"
						+ conditionMediBean.getCaution_money() + "',")

		.append(
				"caution_deduction_money='"
						+ conditionMediBean.getCaution_deduction_money()
						+ "',actual_fund='"
						+ conditionMediBean.getActual_fund()
						+ "',handling_charge='"
						+ conditionMediBean.getHandling_charge()
						+ "',management_fee='"
						+ conditionMediBean.getManagement_fee() + "',").append(
				"nominalprice='" + conditionMediBean.getNominalprice()
						+ "',return_amt='" + conditionMediBean.getReturn_amt()
						+ "',rate_subsidy='"
						+ conditionMediBean.getRate_subsidy()
						+ "',before_interest='"
						+ conditionMediBean.getBefore_interest()
						+ "',before_interest_type='"
						+ conditionMediBean.getBefore_interest_type()
						+ "',discount_rate='"
						+ conditionMediBean.getDiscount_rate()
						+ "',consulting_fee_out='"
						+ conditionMediBean.getConsulting_fee_out()
						+ "',consulting_fee_in='"
						+ conditionMediBean.getConsulting_fee_in() + "',")
				.append(
						"other_income='"
								+ conditionMediBean.getOther_income()
								+ "',other_expenditure='"
								+ conditionMediBean.getOther_expenditure()
								+ "',income_number='"
								+ conditionMediBean.getIncome_number()
								+ "',income_number_year='"
								+ conditionMediBean.getIncome_number_year()
								+ "',lease_term='"
								+ conditionMediBean.getLease_term()
								// + "',year_rate='" +
								// conditionMediBean.getYear_rate()
								+ "',pena_rate='"
								+ conditionMediBean.getPena_rate() + "',")
				.append(
						"start_date='"
								+ conditionMediBean.getStart_date()
								+ "',income_day='"
								+ conditionMediBean.getIncome_day()
								+ "',rent_start_date='"
								+ conditionMediBean.getRent_start_date()
								+ "',free_defa_inter_day='"
								+ conditionMediBean.getFree_defa_inter_day()
								// + "',amt_return='" +
								// conditionMediBean.getAmt_return()
								+ "',insure_type='"
								+ conditionMediBean.getInsure_type()
								+ "',insure_money='"
								+ conditionMediBean.getInsure_money()
								+ "',insure_pay_type='"
								+ conditionMediBean.getInsure_pay_type()
								+ "',is_floor='"
								+ conditionMediBean.getIs_floor() + "',")
				.append(
						"floor_rent='" + conditionMediBean.getFloor_rent()
								+ "',manager_pay_type='"
								+ conditionMediBean.getManager_pay_type()
								+ "',creator='"
								+ conditionMediBean.getCreator()
								+ "',create_date='"
								+ conditionMediBean.getCreate_date()
								+ "',modify_date='"
								+ conditionMediBean.getModify_date()
								+ "',modificator='"
								+ conditionMediBean.getModificator()
								+ "',actual_fund_ratio='"
								+ conditionMediBean.getActual_fund_ratio()
								+ "',plan_bank_name='"
								+ conditionMediBean.getPlan_bank_name()
								+ "',plan_bank_no='"
								+ conditionMediBean.getPlan_bank_no() + "'");
		// 条件
		sqlBuffer.append(" where proj_id='" + conditionMediBean.getProj_id()
				+ "' and doc_id='" + conditionMediBean.getDoc_id() + "'");

		return sqlBuffer.toString();
	}

	/**
	 * 合同交易sql
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 */
	public static String generateSelectCondContractTemp(String contract_id,
			String doc_id) {
		StringBuffer sqBuffer = new StringBuffer();
		sqBuffer
				.append(
						"select equip_amt,currency,lease_money,first_payment,caution_money,caution_deduction_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,year_rate,pena_rate,start_date,income_day,rent_start_date,")
				.append(
						"free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no,plan_bank_name,plan_bank_no," +
						"settle_method,rate_float_type,rate_float_amt,ratio_param,is_open,adjust_style,into_batch from contract_condition_medi_temp");
		sqBuffer.append(" where contract_id='" + contract_id + "' and doc_id='"
				+ doc_id + "'");

		return sqBuffer.toString();
	}

	/**
	 * 修改合同交易临时sql
	 * 
	 * @param conditionMediBean
	 * @return
	 */
	public static String generateUpdateProjConditionContractTempSql(
			ConditionMediBean conditionMediBean) {
		StringBuffer sqlBuffer = new StringBuffer();

		// 插入前语句
		sqlBuffer.append(
				"update contract_condition_medi_temp set equip_amt='"
						+ conditionMediBean.getEquip_amt() + "',currency='"
						+ conditionMediBean.getCurrency() + "',lease_money='"
						+ conditionMediBean.getLease_money()
						+ "',first_payment='"
						+ conditionMediBean.getFirst_payment()
						+ "',caution_money='"
						+ conditionMediBean.getCaution_money() + "',")

		.append(
		// "caution_deduction_money='" +
				// conditionMediBean.getCaution_deduction_money()
				"actual_fund='" + conditionMediBean.getActual_fund()
						+ "',handling_charge='"
						+ conditionMediBean.getHandling_charge()
						+ "',management_fee='"
						+ conditionMediBean.getManagement_fee() + "',").append(
				"nominalprice='" + conditionMediBean.getNominalprice()
						+ "',return_amt='" + conditionMediBean.getReturn_amt()
						+ "',rate_subsidy='"
						+ conditionMediBean.getRate_subsidy()
						+ "',before_interest='"
						+ conditionMediBean.getBefore_interest()
						+ "',before_interest_type='"
						+ conditionMediBean.getBefore_interest_type()
						+ "',discount_rate='"
						+ conditionMediBean.getDiscount_rate()
						+ "',consulting_fee_out='"
						+ conditionMediBean.getConsulting_fee_out()
						+ "',consulting_fee_in='"
						+ conditionMediBean.getConsulting_fee_in() + "',")
				.append(
						"other_income='"
								+ conditionMediBean.getOther_income()
								+ "',other_expenditure='"
								+ conditionMediBean.getOther_expenditure()
								+ "',income_number='"
								+ conditionMediBean.getIncome_number()
								+ "',income_number_year='"
								+ conditionMediBean.getIncome_number_year()
								+ "',lease_term='"
								+ conditionMediBean.getLease_term()
								// + "',year_rate='" +
								// conditionMediBean.getYear_rate()
								+ "',pena_rate='"
								+ conditionMediBean.getPena_rate() + "',")
				.append(
						"start_date='"
								+ conditionMediBean.getStart_date()
								+ "',income_day='"
								+ conditionMediBean.getIncome_day()
								+ "',rent_start_date='"
								+ conditionMediBean.getRent_start_date()
								+ "',free_defa_inter_day='"
								+ conditionMediBean.getFree_defa_inter_day()
								// + "',amt_return='" +
								// conditionMediBean.getAmt_return()
								+ "',insure_type='"
								+ conditionMediBean.getInsure_type()
								+ "',insure_money='"
								+ conditionMediBean.getInsure_money()
								+ "',insure_pay_type='"
								+ conditionMediBean.getInsure_pay_type()
								+ "',is_floor='"
								+ conditionMediBean.getIs_floor() + "',")
				.append(
						"floor_rent='" + conditionMediBean.getFloor_rent()
								+ "',manager_pay_type='"
								+ conditionMediBean.getManager_pay_type()
								+ "',creator='"
								+ conditionMediBean.getCreator()
								+ "',create_date='"
								+ conditionMediBean.getCreate_date()
								+ "',modify_date='"
								+ conditionMediBean.getModify_date()
								+ "',modificator='"
								+ conditionMediBean.getModificator()
								+ "',actual_fund_ratio='"
								+ conditionMediBean.getActual_fund_ratio()
								+ "',plan_bank_name='"
								+ conditionMediBean.getPlan_bank_name()
								+ "',plan_bank_no='"
								+ conditionMediBean.getPlan_bank_no()
								+ "',settle_method='"+conditionMediBean.getSettle_method()
								+"',rate_float_type='"+conditionMediBean.getRate_float_type()
								+"',rate_float_amt='"+conditionMediBean.getRate_float_amt()
								+"',ratio_param='"+conditionMediBean.getRatio_param()
								+"',is_open='"+conditionMediBean.getIs_open()
								+"',adjust_style='"+conditionMediBean.getAdjust_style()
								+"',into_batch='"+conditionMediBean.getInto_batch()
								+"',year_rate='"+conditionMediBean.getYear_rate()+"'");
		// 条件
		sqlBuffer.append(" where contract_id='"
				+ conditionMediBean.getContract_id() + "' and doc_id='"
				+ conditionMediBean.getDoc_id() + "'");

		return sqlBuffer.toString();
	}

	/**
	 * 合同交易结构临时表sql
	 * 
	 * @param conditionMediBean
	 * @return
	 */
	public static String generateInsertProjConditionContractTempSql(
			ConditionMediBean conditionMediBean) {
		StringBuffer sqlBuffer = new StringBuffer();

		// 插入前语句
		sqlBuffer
				.append(
						"insert into proj_condition_medi_temp(contract_id,doc_id,equip_amt,currency,lease_money,first_payment,caution_money,caution_deduction_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,year_rate,pena_rate,start_date,income_day,rent_start_date,")
				.append(
						"free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no)");
		sqlBuffer.append("values(");

		// 拼接值
		sqlBuffer.append("'"
				+ conditionMediBean.getDoc_id()
				+ "','"
				+ conditionMediBean.getContract_id()
				+ "','"

				+ conditionMediBean.getEquip_amt()
				+ "','"
				+ conditionMediBean.getCurrency()
				+ "','"
				+ conditionMediBean.getLease_money()
				+ "','"
				+ conditionMediBean.getFirst_payment()
				+ "','"
				// ==11==
				+ conditionMediBean.getCaution_money()
				+ "','"
				+ conditionMediBean.getCaution_deduction_money()
				+ "','"
				+ conditionMediBean.getActual_fund()
				+ "', '"
				+ conditionMediBean.getHandling_charge()
				+ "','"
				// ==22==
				+ conditionMediBean.getManagement_fee()
				+ "','"
				+ conditionMediBean.getNominalprice()
				+ "','"
				+ conditionMediBean.getReturn_amt()
				+ "','"
				+ conditionMediBean.getRate_subsidy()
				+ "','"
				+ conditionMediBean.getBefore_interest()
				+ "','"
				// ==33==
				+ conditionMediBean.getBefore_interest_type()
				+ "','"
				+ conditionMediBean.getDiscount_rate()
				+ "','"
				+ conditionMediBean.getConsulting_fee_out()
				+ "','"
				+ conditionMediBean.getConsulting_fee_in()
				+ "','"
				+ conditionMediBean.getOther_income()
				+ "','"
				// ==44==
				+ conditionMediBean.getOther_expenditure()
				+ "','"
				+ conditionMediBean.getRent_start_date()
				+ "','"
				+ conditionMediBean.getStart_date()
				+ "','"
				+ conditionMediBean.getIncome_day()
				+ "','"
				// ==55==
				+ conditionMediBean.getIncome_number()
				+ "','"
				+ conditionMediBean.getIncome_number_year()
				+ "','"
				+ conditionMediBean.getLease_term()
				+ "','"
				+ conditionMediBean.getPena_rate()
				+ "','"
				// + conditionMediBean.getYear_rate() + "','"

				// ==66==
				+ conditionMediBean.getFree_defa_inter_day()
				+ "','"
				// +conditionMediBean.getAmt_return() + "','"
				+ conditionMediBean.getInsure_type()
				+ "','"
				+ conditionMediBean.getInsure_pay_type()
				+ "','"
				+ conditionMediBean.getInsure_money()
				+ "','"
				// ==77==
				+ conditionMediBean.getIs_floor()
				+ "','"
				+ conditionMediBean.getFloor_rent()
				+ "','"
				+ conditionMediBean.getIncome_day()
				+ "','"
				// ==88==
				+ conditionMediBean.getManager_pay_type() + "','"
				+ conditionMediBean.getCreator() + "','"
				+ conditionMediBean.getCreate_date() + "','"
				+ conditionMediBean.getModify_date() + "','"
				+ conditionMediBean.getModificator() + "','"
				+ conditionMediBean.getActual_fund_ratio() + "','"
				+ conditionMediBean.getPlan_bank_name() + "','"
				+ conditionMediBean.getPlan_bank_no() + "'");
		sqlBuffer.append(")");

		return sqlBuffer.toString();
	}

	/**
	 * 删除begin_info_temp表数据
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static String generateDelBeginInfoTempData(String begin_id,
			String doc_id) {
		StringBuffer sqlBuffer = new StringBuffer(
				"Delete from begin_info_medi_temp");
		sqlBuffer.append(" where begin_id='" + begin_id + "' and doc_id='"
				+ doc_id + "'");

		return sqlBuffer.toString();
	}

	/**
	 * Insert begin_info_temp Sql
	 * 
	 * @param beginInfoBean
	 * @return
	 */
	public static String generateInsertBeginInfoTempSql(
			BeginInfoMediBean beginInfomediBean) {
		StringBuffer sqlBuffer = new StringBuffer();

		// 插入前语句
		sqlBuffer
				.append(
						"insert into Begin_info_Medi_temp(doc_id,contract_id,begin_id,equip_amt,currency,lease_money,first_payment,caution_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,income_day,pena_rate,start_date,rent_start_date,")
				.append(
						"free_defa_inter_day,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no,begin_order_index)");
		sqlBuffer.append("values(");
		// 拼接值
		sqlBuffer.append("'"
				+ beginInfomediBean.getDoc_id()
				+ "','"
				+ beginInfomediBean.getContract_id()
				+ "','"
				+ beginInfomediBean.getBegin_id()
				+ "','"

				+ beginInfomediBean.getEquip_amt()
				+ "','"
				+ beginInfomediBean.getCurrency()
				+ "','"
				+ beginInfomediBean.getLease_money()
				+ "','"
				+ beginInfomediBean.getFirst_payment()
				+ "','"
				// ==11==
				+ beginInfomediBean.getCaution_money()
				+ "','"
				+ beginInfomediBean.getActual_fund()
				+ "', '"
				+ beginInfomediBean.getHandling_charge()
				+ "','"
				// ==22==
				+ beginInfomediBean.getManagement_fee()
				+ "','"
				+ beginInfomediBean.getNominalprice()
				+ "','"
				+ beginInfomediBean.getReturn_amt()
				+ "','"
				+ beginInfomediBean.getRate_subsidy()
				+ "','"
				+ beginInfomediBean.getBefore_interest()
				+ "','"
				// ==33==
				+ beginInfomediBean.getBefore_interest_type()
				+ "','"
				+ beginInfomediBean.getDiscount_rate()
				+ "','"
				+ beginInfomediBean.getConsulting_fee_out()
				+ "','"
				+ beginInfomediBean.getConsulting_fee_in()
				+ "','"
				+ beginInfomediBean.getOther_income()
				+ "','"
				// ==44==
				+ beginInfomediBean.getOther_expenditure()
				+ "','"
				+ beginInfomediBean.getIncome_number()
				+ "','"
				+ beginInfomediBean.getIncome_number_year()
				+ "','"
				+ beginInfomediBean.getLease_term()
				+ "','"
				+ beginInfomediBean.getIncome_day()
				+ "','"
				// + beginInfomediBean.getYear_rate() + "','"
				+ beginInfomediBean.getPena_rate()
				+ "','"
				+ beginInfomediBean.getStart_date()
				+ "','"
				// + beginInfomediBean.getIncome_day() + "','"
				+ beginInfomediBean.getRent_start_date()
				+ "','"
				// ==55==
				+ beginInfomediBean.getFree_defa_inter_day()
				+ "','"
				// +beginInfomediBean.getAmt_return() + "','"
				+ beginInfomediBean.getInsure_type()
				+ "','"
				+ beginInfomediBean.getInsure_money()
				+ "','"
				+ beginInfomediBean.getInsure_pay_type()
				+ "','"
				// ==77==
				+ beginInfomediBean.getIs_floor()
				+ "','"
				+ beginInfomediBean.getFloor_rent()
				+ "','"
				+ beginInfomediBean.getManager_pay_type()
				+ "','"

				// ==88==

				+ beginInfomediBean.getCreator() + "','"
				+ beginInfomediBean.getCreate_date() + "','"
				+ beginInfomediBean.getModify_date() + "','"
				+ beginInfomediBean.getModificator() + "','"
				+ beginInfomediBean.getActual_fund_ratio() + "','"
				+ beginInfomediBean.getPlan_bank_name() + "','"
				+ beginInfomediBean.getPlan_bank_no() + "','"
				+ beginInfomediBean.getBegin_order_index() + "'");
		sqlBuffer.append(")");

		return sqlBuffer.toString();
	}

	/**
	 * 查询BeginInfoTemp Sql
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static String generateSelectBeginInfoTemp(String begin_id,
			String doc_id) {
		StringBuffer sqBuffer = new StringBuffer();

		sqBuffer
				.append(
						"select contract_id,doc_id,begin_id,equip_amt,currency,lease_money,first_payment,caution_money,caution_deduction_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,year_rate,pena_rate,start_date,income_day,rent_start_date,")
				.append(
						"free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no,plan_bank_name,plan_bank_no,begin_order_index from begin_info_medi_temp");
		sqBuffer.append(" where begin_id='" + begin_id + "' and doc_id='"
				+ doc_id + "'");

		return sqBuffer.toString();
	}

	/**
	 * 查询BeginInfoTemp Sql
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static String generateSelectBeginInfo(String begin_id) {
		StringBuffer sqBuffer = new StringBuffer();

		sqBuffer
				.append(
						"select contract_id,begin_id,equip_amt,currency,lease_money,first_payment,caution_money,caution_deduction_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,year_rate,pena_rate,start_date,income_day,rent_start_date,")
				.append(
						"free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no,plan_bank_name,plan_bank_no,begin_order_index from begin_info_medi");
		sqBuffer.append(" where begin_id='" + begin_id + "'");

		return sqBuffer.toString();
	}

	/**
	 * 删除 dbo.fund_rent_plan_temp2 dbo.fund_rent_plan_his2
	 * dbo.fund_rent_plan_before2 表数据
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 */
	public static String generateDelRentBeginDataSql(String begin_id,
			String doc_id) {
		StringBuffer sqBuffer = new StringBuffer();

		sqBuffer.append(" Delete from fund_rent_plan_temp where begin_id='"
				+ begin_id + "' and doc_id='" + doc_id + "' ");
		// sqBuffer.append(" Delete from fund_rent_plan_his where begin_id='"
		// + begin_id + "' and doc_id='" + doc_id + "' ");
		// sqBuffer.append(" Delete from fund_rent_plan_before where begin_id='"
		// + begin_id + "' and doc_id='" + doc_id + "' ");

		return sqBuffer.toString();
	}

	/**
	 * 查询[begin_info]数据
	 * 
	 * @param begin_id
	 * @return
	 */
	public static String generateSelectBeginInfoHis(String begin_id) {
		StringBuffer sqBuffer = new StringBuffer();

		sqBuffer
				.append(
						"select contract_id,doc_id,begin_id,equip_amt,currency,lease_money,first_payment,caution_money,caution_deduction_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,year_rate,pena_rate,start_date,income_day,rent_start_date,")
				.append(
						"free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no,plan_bank_name,plan_bank_no,begin_order_index")
				.append(" from begin_info ");
		sqBuffer.append(" where begin_id='" + begin_id + "'");

		return sqBuffer.toString();
	}

	/**
	 * 查询[Contract_Condition]表
	 * 
	 * @param contract_id
	 * @return
	 */
	public static String generateSelectCondContract(String contract_id) {
		StringBuffer sqBuffer = new StringBuffer();

		sqBuffer
				.append(
						"select equip_amt,currency,lease_money,first_payment,caution_money,caution_deduction_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,year_rate,pena_rate,start_date,income_day,rent_start_date,")
				.append(
						"free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no from contract_condition_medi");
		sqBuffer.append(" where contract_id='" + contract_id + "'");
		System.out.println("====================test"+sqBuffer);

		return sqBuffer.toString();
	}

	/**
	 * 插入Begin_info_temp表sql
	 * 
	 * @param beginInfoBean
	 * @return
	 */
	public static String generateInsertUploadBeginInfoTempSql(
			BeginInfoMediBean beginInfomediBean) {
		StringBuffer sqlBuffer = new StringBuffer();

		// // 插入前语句
		// sqlBuffer
		// .append(
		// "Insert into
		// Begin_info_temp(doc_id,contract_id,begin_id,equip_amt,currency,lease_money,actual_fund,assets_value,income_number,")
		// .append(
		// "income_number_year,lease_term,settle_method,period_type,year_rate,start_date,income_day,rent_start_date,plan_irr,")
		// .append(
		// "ratio_param,creator,create_date,modify_date,modificator)");
		// sqlBuffer.append("values(");
		// // 拼接值
		// sqlBuffer.append("'" + beginInfoBean.getDoc_id() + "','"
		// + beginInfoBean.getContract_id() + "','"
		// + beginInfoBean.getBegin_id() + "','"
		// + beginInfoBean.getEquip_amt() + "','"
		// + beginInfoBean.getCurrency() + "','"
		// + beginInfoBean.getLease_money() + "','"
		// + beginInfoBean.getActual_fund() + "','"
		// + beginInfoBean.getAssets_value() + "','"
		// + beginInfoBean.getIncome_number() + "','"
		// + beginInfoBean.getIncome_number_year() + "','"
		// + beginInfoBean.getLease_term() + "','"
		// + beginInfoBean.getSettle_method() + "','"
		// + beginInfoBean.getPeriod_type() + "','"
		// + beginInfoBean.getYear_rate() + "','"
		// + beginInfoBean.getStart_date() + "','"
		// + beginInfoBean.getIncome_day() + "','"
		// + beginInfoBean.getRent_start_date() + "','"
		// + beginInfoBean.getPlan_irr() + "','"
		// + beginInfoBean.getRatio_param() + "','"
		// + beginInfoBean.getCreator() + "','"
		// + beginInfoBean.getCreate_date() + "','"
		// + beginInfoBean.getModify_date() + "','"
		// + beginInfoBean.getModificator() + "'");
		// sqlBuffer.append(")");

		// 插入前语句
		sqlBuffer
				.append(
						"insert into Begin_info_Medi_temp(contract_id,doc_id,begin_id,equip_amt,currency,lease_money,first_payment,caution_money,caution_deduction_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,year_rate,pena_rate,start_date,income_day,rent_start_date,")
				.append(
						"free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no,begin_order_index)");
		// 拼接值
		sqlBuffer.append("'"
				+ beginInfomediBean.getDoc_id()
				+ "','"
				+ beginInfomediBean.getContract_id()
				+ "','"
				+ beginInfomediBean.getBegin_id()
				+ "','"
				+ beginInfomediBean.getEquip_amt()
				+ "','"
				+ beginInfomediBean.getCurrency()
				+ "','"
				+ beginInfomediBean.getLease_money()
				+ "','"
				+ beginInfomediBean.getFirst_payment()
				+ "','"
				// ==11==
				+ beginInfomediBean.getCaution_money()
				+ "','"
				+ beginInfomediBean.getCaution_deduction_money()
				+ "','"
				+ beginInfomediBean.getActual_fund()
				+ "', '"
				+ beginInfomediBean.getHandling_charge()
				+ "','"
				// ==22==
				+ beginInfomediBean.getManagement_fee()
				+ "','"
				+ beginInfomediBean.getNominalprice()
				+ "','"
				+ beginInfomediBean.getReturn_amt()
				+ "','"
				+ beginInfomediBean.getRate_subsidy()
				+ "','"
				+ beginInfomediBean.getBefore_interest()
				+ "','"
				// ==33==
				+ beginInfomediBean.getBefore_interest_type()
				+ "','"
				+ beginInfomediBean.getDiscount_rate()
				+ "','"
				+ beginInfomediBean.getConsulting_fee_out()
				+ "','"
				+ beginInfomediBean.getConsulting_fee_in()
				+ "','"
				+ beginInfomediBean.getOther_income()
				+ "','"
				// ==44==
				+ beginInfomediBean.getOther_expenditure()
				+ "','"
				+ beginInfomediBean.getRent_start_date()
				+ "','"
				+ beginInfomediBean.getStart_date()
				+ "','"
				+ beginInfomediBean.getIncome_day()
				+ "','"
				// ==55==
				+ beginInfomediBean.getIncome_number()
				+ "','"
				+ beginInfomediBean.getIncome_number_year()
				+ "','"
				+ beginInfomediBean.getLease_term()
				+ "','"
				+ beginInfomediBean.getPena_rate()
				+ "','"
				// + conditionMediBean.getYear_rate() + "','"

				// ==66==
				+ beginInfomediBean.getFree_defa_inter_day()
				+ "','"
				// +conditionMediBean.getAmt_return() + "','"
				+ beginInfomediBean.getInsure_type()
				+ "','"
				+ beginInfomediBean.getInsure_pay_type()
				+ "','"
				+ beginInfomediBean.getInsure_money()
				+ "','"
				// ==77==
				+ beginInfomediBean.getIs_floor()
				+ "','"
				+ beginInfomediBean.getFloor_rent()
				+ "','"
				+ beginInfomediBean.getIncome_day()
				+ "','"
				// ==88==
				+ beginInfomediBean.getManager_pay_type() + "','"
				+ beginInfomediBean.getCreator() + "','"
				+ beginInfomediBean.getCreate_date() + "','"
				+ beginInfomediBean.getModify_date() + "','"
				+ beginInfomediBean.getModificator() + "','"
				+ beginInfomediBean.getActual_fund_ratio() + "','"
				+ beginInfomediBean.getPlan_bank_name() + "','"
				+ beginInfomediBean.getPlan_bank_no() + "','"
				+ beginInfomediBean.getBegin_order_index() + "'");
		sqlBuffer.append(")");

		return sqlBuffer.toString();
	}
}
