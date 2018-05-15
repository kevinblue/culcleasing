/**
 * com.tenwa.datasync.service
 */
package com.tenwa.culc.service1;

import com.tenwa.culc.bean.BeginInfoBean;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.log.LogWriter;

/**
 * Sql语句生成工具
 * 
 * @author Jaffe
 * 
 * Jun 25, 2011 Email:JaffeHe@hotmail.com
 */
public class SqlGenerateUtil1 {

	/**
	 * 插入Proj_condition_temp表的sql语句
	 * 
	 * @param conditionBean
	 * @return
	 */
	public static String generateInsertProjConditionTempSql(
			ConditionBean conditionBean) {
		StringBuffer sqlBuffer = new StringBuffer();

		// 插入前语句
		sqlBuffer
				.append(
						"insert into proj_condition_temp(doc_id,proj_id,equip_amt,currency,lease_money,first_payment_ratio,first_payment,caution_money_ratio,")
				.append(
						"caution_money,actual_fund,actual_fund_ratio,handling_charge_ratio,")
				.append(
						"handling_charge,management_fee,nominalprice,return_ratio,return_amt,rate_subsidy,before_interest,before_interest_type,discount_rate,")
				.append(
						"consulting_fee_out,consulting_fee_in,other_income,other_expenditure,income_number,income_number_year,lease_term,")
				.append(
						"settle_method,period_type,rate_float_type,rate_float_amt,adjust_style,year_rate,pena_rate,start_date,income_day,")
				.append(
						"end_date,rent_start_date,irr,plan_irr,free_defa_inter_day,insure_type,into_batch,")
				.append(
						"insure_money,assets_value,assess_adjust,ratio_param,creator,create_date,modify_date,modificator,")
				.append("invoice_type,StandardF,StandardIrr,insure_pay_type)");
		sqlBuffer.append("values(");

		// 拼接值
		sqlBuffer.append("'" + conditionBean.getDoc_id() + "','"
				+ conditionBean.getProj_id() + "','"
				+ conditionBean.getEquip_amt() + "','"
				+ conditionBean.getCurrency() + "','"
				+ conditionBean.getLease_money() + "','"
				+ conditionBean.getFirst_payment_ratio() + "','"
				+ conditionBean.getFirst_payment() + "','"
				+ conditionBean.getCaution_money_ratio() + "','"
				+ conditionBean.getCaution_money() + "','"
				+ conditionBean.getActual_fund() + "', '"
				+ conditionBean.getActual_fund_ratio() + "','"
				+ conditionBean.getHandling_charge_ratio() + "','"
				+ conditionBean.getHandling_charge() + "','"
				+ conditionBean.getManagement_fee() + "','"
				+ conditionBean.getNominalprice() + "','"
				+ conditionBean.getReturn_ratio() + "','"
				+ conditionBean.getReturn_amt() + "','"
				+ conditionBean.getRate_subsidy() + "','"
				+ conditionBean.getBefore_interest() + "','"
				+ conditionBean.getBefore_interest_type() + "','"
				+ conditionBean.getDiscount_rate() + "','"
				+ conditionBean.getConsulting_fee_out() + "','"
				+ conditionBean.getConsulting_fee_in() + "','"
				+ conditionBean.getOther_income() + "','"
				+ conditionBean.getOther_expenditure() + "','"
				+ conditionBean.getIncome_number() + "','"
				+ conditionBean.getIncome_number_year() + "','"
				+ conditionBean.getLease_term() + "','"
				+ conditionBean.getSettle_method() + "','"
				+ conditionBean.getPeriod_type() + "','"
				+ conditionBean.getRate_float_type() + "','"
				+ conditionBean.getRate_float_amt() + "','"
				+ conditionBean.getAdjust_style() + "','"
				+ conditionBean.getYear_rate() + "','"
				+ conditionBean.getPena_rate() + "','"
				+ conditionBean.getStart_date() + "','"
				+ conditionBean.getIncome_day() + "','"
				+ conditionBean.getEnd_date() + "','"
				+ conditionBean.getRent_start_date() + "','"
				+ conditionBean.getIrr() + "','" + conditionBean.getPlan_irr()
				+ "','" + conditionBean.getFree_defa_inter_day() + "','"
				+ conditionBean.getInsure_type() + "','"
				+ conditionBean.getInto_batch() + "','"
				+ conditionBean.getInsure_money() + "','"
				+ conditionBean.getAssets_value() + "','"
				+ conditionBean.getAssess_adjust() + "','"
				+ conditionBean.getRatio_param() + "','"
				+ conditionBean.getCreator() + "','"
				+ conditionBean.getCreate_date() + "','"
				+ conditionBean.getModify_date() + "','"
				+ conditionBean.getModificator() + "','"
				+ conditionBean.getInvoice_type() + "','"
				+ conditionBean.getStandardF() + "','"
				+ conditionBean.getStandardIrr() + "','"
				+ conditionBean.getInsure_pay_type() + "'");
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

		sqBuffer.append("select tax_type,tax_type_invoice from proj_condition_temp");
		sqBuffer.append(" where proj_id='" + proj_id + "' and doc_id='"
				+ doc_id + "'");
		System.out.println("tax_type======" + sqBuffer);
		return sqBuffer.toString();
	}

	public static String generateSelectCondTemp1(String proj_id) {

		StringBuffer sqBuffer = new StringBuffer();

		sqBuffer
				.append(
						"select equip_amt,currency,lease_money,first_payment_ratio,first_payment,caution_money_ratio,caution_money,")
				.append(
						"actual_fund,actual_fund_ratio,handling_charge_ratio,handling_charge,")
				.append(
						"management_fee,nominalprice,return_ratio,return_amt,rate_subsidy,before_interest,before_interest_type,discount_rate,consulting_fee_out,")
				.append(
						"consulting_fee_in,other_income,other_expenditure,income_number,income_number_year,lease_term,settle_method,period_type,")
				.append(
						"rate_float_type,rate_float_amt,adjust_style,year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,irr,plan_irr,free_defa_inter_day,")
				.append(
						"total_amt,amt_return,apply_contract_number,insure_type,into_batch,insure_money,assets_value,assess_adjust,ratio_param,")
				.append("creator,create_date,modify_date,modificator,")
				.append(
						"invoice_type,StandardF,StandardIrr,Insure_pay_type from proj_condition");
		sqBuffer.append(" where proj_id='" + proj_id + "'");

		return sqBuffer.toString();
	}

	/**
	 * 更新项目交易结构临时表
	 * 
	 * @param conditionBean
	 * @return
	 */
	public static String generateUpdateProjConditionTempSql(
			ConditionBean conditionBean) {
		StringBuffer sqlBuffer = new StringBuffer();

		// 插入前语句
		sqlBuffer.append(
				"update proj_condition_temp set equip_amt='"
						+ conditionBean.getEquip_amt() + "',currency='"
						+ conditionBean.getCurrency() + "',lease_money='"
						+ conditionBean.getLease_money()
						+ "',first_payment_ratio='"
						+ conditionBean.getFirst_payment_ratio()
						+ "',first_payment='"
						+ conditionBean.getFirst_payment()
						+ "',caution_money_ratio='"
						+ conditionBean.getCaution_money_ratio() + "',")
				.append(
						"caution_money='" + conditionBean.getCaution_money()
								+ "',actual_fund='"
								+ conditionBean.getActual_fund()
								+ "',actual_fund_ratio='"
								+ conditionBean.getActual_fund_ratio()
								+ "',handling_charge_ratio='"
								+ conditionBean.getHandling_charge_ratio()
								+ "',").append(
						"handling_charge='"
								+ conditionBean.getHandling_charge()
								+ "',management_fee='"
								+ conditionBean.getManagement_fee()
								+ "',nominalprice='"
								+ conditionBean.getNominalprice()
								+ "',return_ratio='"
								+ conditionBean.getReturn_ratio()
								+ "',return_amt='"
								+ conditionBean.getReturn_amt()
								+ "',rate_subsidy='"
								+ conditionBean.getRate_subsidy()
								+ "',before_interest='"
								+ conditionBean.getBefore_interest()
								+ "',discount_rate='"
								+ conditionBean.getDiscount_rate() + "',")
				.append(
						"consulting_fee_out='"
								+ conditionBean.getConsulting_fee_out()
								+ "',consulting_fee_in='"
								+ conditionBean.getConsulting_fee_in()
								+ "',other_income='"
								+ conditionBean.getOther_income()
								+ "',other_expenditure='"
								+ conditionBean.getOther_expenditure()
								+ "',income_number='"
								+ conditionBean.getIncome_number()
								+ "',income_number_year='"
								+ conditionBean.getIncome_number_year()
								+ "',lease_term='"
								+ conditionBean.getLease_term() + "',").append(
						"settle_method='" + conditionBean.getSettle_method()
								+ "',period_type='"
								+ conditionBean.getPeriod_type()
								+ "',rate_float_type='"
								+ conditionBean.getRate_float_type()
								+ "',rate_float_amt='"
								+ conditionBean.getRate_float_amt()
								+ "',adjust_style='"
								+ conditionBean.getAdjust_style()
								+ "',year_rate='"
								+ conditionBean.getYear_rate()
								+ "',pena_rate='"
								+ conditionBean.getPena_rate()
								+ "',start_date='"
								+ conditionBean.getStart_date()
								+ "',income_day='"
								+ conditionBean.getIncome_day() + "',").append(
						"end_date='" + conditionBean.getEnd_date()
								+ "',rent_start_date='"
								+ conditionBean.getRent_start_date()
								+ "',plan_irr='" + conditionBean.getPlan_irr()
								+ "',free_defa_inter_day='"
								+ conditionBean.getFree_defa_inter_day()
								+ "',insure_type='"
								+ conditionBean.getInsure_type()
								+ "',into_batch='"
								+ conditionBean.getInto_batch() + "',").append(
						"insure_money='" + conditionBean.getInsure_money()
								+ "',assets_value='"
								+ conditionBean.getAssets_value()
								+ "',assess_adjust='"
								+ conditionBean.getAssess_adjust()
								+ "',ratio_param='"
								+ conditionBean.getRatio_param()
								+ "',creator='" + conditionBean.getCreator()
								+ "',create_date='"
								+ conditionBean.getCreate_date()
								+ "',modify_date='"
								+ conditionBean.getModify_date()
								+ "',modificator='"
								+ conditionBean.getModificator()
								+ "',invoice_type='"
								+ conditionBean.getInvoice_type()
								+ "',StandardF='"
								+ conditionBean.getStandardF()
								+ "',StandardIrr='"
								+ conditionBean.getStandardIrr() + "' ");
		// 条件
		sqlBuffer.append(" where proj_id='" + conditionBean.getProj_id()
				+ "' and doc_id='" + conditionBean.getDoc_id() + "'");

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

		sqBuffer.append("select tax_type,tax_type_invoice from contract_condition_temp");
		sqBuffer.append(" where contract_id='" + contract_id + "' and doc_id='"
				+ doc_id + "'");

		return sqBuffer.toString();
	}

	/**
	 * 修改合同交易临时sql
	 * 
	 * @param conditionBean
	 * @return
	 */
	public static String generateUpdateProjConditionContractTempSql(
			ConditionBean conditionBean) {
		StringBuffer sqlBuffer = new StringBuffer();

		// 插入前语句
		sqlBuffer.append(
				"update contract_condition_temp set equip_amt='"
						+ conditionBean.getEquip_amt() + "',currency='"
						+ conditionBean.getCurrency() + "',lease_money='"
						+ conditionBean.getLease_money()
						+ "',first_payment_ratio='"
						+ conditionBean.getFirst_payment_ratio()
						+ "',first_payment='"
						+ conditionBean.getFirst_payment()
						+ "',caution_money_ratio='"
						+ conditionBean.getCaution_money_ratio() + "',")
				.append(
						"caution_money='" + conditionBean.getCaution_money()
								+ "',actual_fund='"
								+ conditionBean.getActual_fund()
								+ "',actual_fund_ratio='"
								+ conditionBean.getActual_fund_ratio()
								+ "',handling_charge_ratio='"
								+ conditionBean.getHandling_charge_ratio()
								+ "',").append(
						"handling_charge='"
								+ conditionBean.getHandling_charge()
								+ "',management_fee='"
								+ conditionBean.getManagement_fee()
								+ "',nominalprice='"
								+ conditionBean.getNominalprice()
								+ "',return_ratio='"
								+ conditionBean.getReturn_ratio()
								+ "',return_amt='"
								+ conditionBean.getReturn_amt()
								+ "',rate_subsidy='"
								+ conditionBean.getRate_subsidy()
								+ "',before_interest='"
								+ conditionBean.getBefore_interest()
								+ "',before_interest_type='"
								+ conditionBean.getBefore_interest_type()
								+ "',discount_rate='"
								+ conditionBean.getDiscount_rate() + "',")
				.append(
						"consulting_fee_out='"
								+ conditionBean.getConsulting_fee_out()
								+ "',consulting_fee_in='"
								+ conditionBean.getConsulting_fee_in()
								+ "',other_income='"
								+ conditionBean.getOther_income()
								+ "',other_expenditure='"
								+ conditionBean.getOther_expenditure()
								+ "',income_number='"
								+ conditionBean.getIncome_number()
								+ "',income_number_year='"
								+ conditionBean.getIncome_number_year()
								+ "',lease_term='"
								+ conditionBean.getLease_term() + "',").append(
						"settle_method='" + conditionBean.getSettle_method()
								+ "',period_type='"
								+ conditionBean.getPeriod_type()
								+ "',rate_float_type='"
								+ conditionBean.getRate_float_type()
								+ "',rate_float_amt='"
								+ conditionBean.getRate_float_amt()
								+ "',adjust_style='"
								+ conditionBean.getAdjust_style()
								+ "',year_rate='"
								+ conditionBean.getYear_rate()
								+ "',pena_rate='"
								+ conditionBean.getPena_rate()
								+ "',start_date='"
								+ conditionBean.getStart_date()
								+ "',income_day='"
								+ conditionBean.getIncome_day() + "',").append(
						"end_date='" + conditionBean.getEnd_date()
								+ "',rent_start_date='"
								+ conditionBean.getRent_start_date()
								+ "',irr='" + conditionBean.getIrr()
								+ "',plan_irr='" + conditionBean.getPlan_irr()
								+ "',free_defa_inter_day='"
								+ conditionBean.getFree_defa_inter_day()
								+ "',insure_type='"
								+ conditionBean.getInsure_type()
								+ "',into_batch='"
								+ conditionBean.getInto_batch() + "',").append(
						"insure_money='" + conditionBean.getInsure_money()
								+ "',assets_value='"
								+ conditionBean.getAssets_value()
								+ "',assess_adjust='"
								+ conditionBean.getAssess_adjust()
								+ "',ratio_param='"
								+ conditionBean.getRatio_param()
								+ "',creator='" + conditionBean.getCreator()
								+ "',create_date='"
								+ conditionBean.getCreate_date()
								+ "',modify_date='"
								+ conditionBean.getModify_date()
								+ "',modificator='"
								+ conditionBean.getModificator()
								+ "',invoice_type='"
								+ conditionBean.getInvoice_type()
								+ "',StandardF='"
								+ conditionBean.getStandardF()
								+ "',StandardIrr='"
								+ conditionBean.getStandardIrr()
								+ "',insure_pay_type='"
								+ conditionBean.getInsure_pay_type() + "' ");
		// 条件
		sqlBuffer.append(" where contract_id='"
				+ conditionBean.getContract_id() + "' and doc_id='"
				+ conditionBean.getDoc_id() + "'");

		return sqlBuffer.toString();
	}

	/**
	 * 合同交易结构临时表sql
	 * 
	 * @param conditionBean
	 * @return
	 */
	public static String generateInsertProjConditionContractTempSql(
			ConditionBean conditionBean) {
		StringBuffer sqlBuffer = new StringBuffer();

		// 插入前语句
		sqlBuffer
				.append(
						"insert into contract_condition_temp(doc_id,contract_id,equip_amt,currency,lease_money,first_payment_ratio,first_payment,caution_money_ratio,")
				.append(
						"caution_money,actual_fund,actual_fund_ratio,handling_charge_ratio,")
				.append(
						"handling_charge,management_fee,nominalprice,return_ratio,return_amt,rate_subsidy,before_interest,before_interest_type,discount_rate,")
				.append(
						"consulting_fee_out,consulting_fee_in,other_income,other_expenditure,income_number,income_number_year,lease_term,")
				.append(
						"settle_method,period_type,rate_float_type,rate_float_amt,adjust_style,year_rate,pena_rate,rent_start_date,start_date,income_day,")
				.append(
						"end_date,plan_irr,free_defa_inter_day,insure_type,into_batch,")
				.append(
						"insure_money,assets_value,assess_adjust,ratio_param,creator,create_date,modify_date,modificator,")
				.append("invoice_type,StandardF,StandardIrr)");
		sqlBuffer.append("values(");

		// 拼接值
		sqlBuffer.append("'" + conditionBean.getDoc_id() + "','"
				+ conditionBean.getContract_id() + "','"
				+ conditionBean.getEquip_amt() + "','"
				+ conditionBean.getCurrency() + "','"
				+ conditionBean.getLease_money() + "','"
				+ conditionBean.getFirst_payment_ratio() + "','"
				+ conditionBean.getFirst_payment() + "','"
				+ conditionBean.getCaution_money_ratio() + "','"
				+ conditionBean.getCaution_money() + "','"
				+ conditionBean.getActual_fund() + "', '"
				+ conditionBean.getActual_fund_ratio() + "','"
				+ conditionBean.getHandling_charge_ratio() + "','"
				+ conditionBean.getHandling_charge() + "','"
				+ conditionBean.getManagement_fee() + "','"
				+ conditionBean.getNominalprice() + "','"
				+ conditionBean.getReturn_ratio() + "','"
				+ conditionBean.getReturn_amt() + "','"
				+ conditionBean.getRate_subsidy() + "','"
				+ conditionBean.getBefore_interest() + "','"
				+ conditionBean.getBefore_interest_type() + "','"
				+ conditionBean.getDiscount_rate() + "','"
				+ conditionBean.getConsulting_fee_out() + "','"
				+ conditionBean.getConsulting_fee_in() + "','"
				+ conditionBean.getOther_income() + "','"
				+ conditionBean.getOther_expenditure() + "','"
				+ conditionBean.getIncome_number() + "','"
				+ conditionBean.getIncome_number_year() + "','"
				+ conditionBean.getLease_term() + "','"
				+ conditionBean.getSettle_method() + "','"
				+ conditionBean.getPeriod_type() + "','"
				+ conditionBean.getRate_float_type() + "','"
				+ conditionBean.getRate_float_amt() + "','"
				+ conditionBean.getAdjust_style() + "','"
				+ conditionBean.getYear_rate() + "','"
				+ conditionBean.getPena_rate() + "','"
				+ conditionBean.getRent_start_date() + "','"
				+ conditionBean.getStart_date() + "','"
				+ conditionBean.getIncome_day() + "','"
				+ conditionBean.getEnd_date() + "','"
				+ conditionBean.getPlan_irr() + "','"
				+ conditionBean.getFree_defa_inter_day() + "','"
				+ conditionBean.getInsure_type() + "','"
				+ conditionBean.getInto_batch() + "','"
				+ conditionBean.getInsure_money() + "','"
				+ conditionBean.getAssets_value() + "','"
				+ conditionBean.getAssess_adjust() + "','"
				+ conditionBean.getRatio_param() + "','"
				+ conditionBean.getCreator() + "','"
				+ conditionBean.getCreate_date() + "','"
				+ conditionBean.getModify_date() + "','"
				+ conditionBean.getModificator() + "','"
				+ conditionBean.getInvoice_type() + "','"
				+ conditionBean.getStandardF() + "','"
				+ conditionBean.getStandardIrr() + "'");
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
		StringBuffer sqlBuffer = new StringBuffer("Delete from begin_info_temp");
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
			BeginInfoBean beginInfoBean) {
		StringBuffer sqlBuffer = new StringBuffer();

		// 插入前语句
		sqlBuffer
				.append(
						"Insert into Begin_info_temp(doc_id,contract_id,begin_id,equip_amt,currency,lease_money,actual_fund,assets_value,income_number,")
				.append(
						"income_number_year,lease_term,settle_method,period_type,rate_float_type,rate_float_amt,adjust_style,is_open,")
				.append(
						"plan_bank_name,plan_bank_no,year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,plan_irr,fact_irr,")
				.append(
						"free_defa_inter_day,into_batch,ratio_param,invoice_type,creator,create_date,modify_date,modificator,begin_order_index,factoring)");
		sqlBuffer.append("values(");
		// 拼接值
		sqlBuffer.append("'" + beginInfoBean.getDoc_id() + "','"
				+ beginInfoBean.getContract_id() + "','"
				+ beginInfoBean.getBegin_id() + "','"
				+ beginInfoBean.getEquip_amt() + "','"
				+ beginInfoBean.getCurrency() + "','"
				+ beginInfoBean.getLease_money() + "','"
				+ beginInfoBean.getActual_fund() + "','"
				+ beginInfoBean.getAssets_value() + "','"
				+ beginInfoBean.getIncome_number() + "','"
				+ beginInfoBean.getIncome_number_year() + "','"
				+ beginInfoBean.getLease_term() + "','"
				+ beginInfoBean.getSettle_method() + "','"
				+ beginInfoBean.getPeriod_type() + "','"
				+ beginInfoBean.getRate_float_type() + "','"
				+ beginInfoBean.getRate_float_amt() + "','"
				+ beginInfoBean.getAdjust_style() + "','"
				+ beginInfoBean.getIs_open() + "','"
				+ beginInfoBean.getPlan_bank_name() + "','"
				+ beginInfoBean.getPlan_bank_no() + "','"
				+ beginInfoBean.getYear_rate() + "','"
				+ beginInfoBean.getPena_rate() + "','"
				+ beginInfoBean.getStart_date() + "','"
				+ beginInfoBean.getIncome_day() + "','"
				+ beginInfoBean.getEnd_date() + "','"
				+ beginInfoBean.getRent_start_date() + "','"
				+ beginInfoBean.getPlan_irr() + "','"
				+ beginInfoBean.getFact_irr() + "','"
				+ beginInfoBean.getFree_defa_inter_day() + "','"
				+ beginInfoBean.getInto_batch() + "','"
				+ beginInfoBean.getRatio_param() + "','"
				+ beginInfoBean.getInvoice_type() + "','"
				+ beginInfoBean.getCreator() + "','"
				+ beginInfoBean.getCreate_date() + "','"
				+ beginInfoBean.getModify_date() + "','"
				+ beginInfoBean.getModificator() + "','"
				+ beginInfoBean.getBegin_order_index() + "','"
				+ beginInfoBean.getFactoring() + "'");
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
	public static String generateSelectBeginInfoTemp(BeginInfoBean beginInfoBean) {
		StringBuffer sqBuffer = new StringBuffer();

		sqBuffer.append("Select tax_type,tax_type_invoice from begin_info_temp ");
		sqBuffer.append(" where begin_id='" + beginInfoBean.getBegin_id()
				+ "' and doc_id='" + beginInfoBean.getDoc_id() + "'");
		System.out.println("sqlstr===" + sqBuffer);
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
						"Select contract_id,begin_id,equip_amt,lease_money,actual_fund,assets_value,income_number,income_number_year,")
				.append(
						"lease_term,currency,settle_method,period_type,rate_float_type,rate_float_amt,ratio_param,adjust_style,is_open,")
				.append(
						"plan_bank_name,plan_bank_no,year_rate,pena_rate,start_date,income_day,end_date,plan_irr,fact_irr,invoice_type,rent_start_date,free_defa_inter_day,")
				.append(
						"into_batch,total_amt,amt_return,apply_contract_number,creator,create_date,modify_date,modificator")
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
						"select equip_amt,currency,lease_money,first_payment_ratio,first_payment,caution_money_ratio,caution_money,")
				.append(
						"actual_fund,actual_fund_ratio,handling_charge_ratio,handling_charge,")
				.append(
						"management_fee,nominalprice,return_ratio,return_amt,rate_subsidy,before_interest,before_interest_type,discount_rate,consulting_fee_out,")
				.append(
						"consulting_fee_in,other_income,other_expenditure,income_number,income_number_year,lease_term,settle_method,period_type,")
				.append(
						"rate_float_type,rate_float_amt,adjust_style,year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,irr,plan_irr,free_defa_inter_day,")
				.append(
						"total_amt,amt_return,apply_contract_number,insure_type,into_batch,insure_money,assets_value,assess_adjust,ratio_param,")
				.append(
						"creator,create_date,modify_date,modificator,invoice_type,insure_pay_type from contract_condition");
		sqBuffer.append(" where contract_id='" + contract_id + "'");
		return sqBuffer.toString();
	}

	/**
	 * 插入Begin_info_temp表sql
	 * 
	 * @param beginInfoBean
	 * @return
	 */
	public static String generateInsertUploadBeginInfoTempSql(
			BeginInfoBean beginInfoBean) {
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
						"Insert into Begin_info_temp(doc_id,contract_id,begin_id,equip_amt,currency,lease_money,actual_fund,assets_value,income_number,")
				.append(
						"income_number_year,lease_term,settle_method,period_type,rate_float_type,rate_float_amt,adjust_style,is_open,")
				.append(
						"plan_bank_name,plan_bank_no,year_rate,pena_rate,start_date,income_day,rent_start_date,plan_irr,")
				.append(
						"free_defa_inter_day,into_batch,ratio_param,creator,create_date,modify_date,modificator)");
		sqlBuffer.append("values(");
		// 拼接值
		sqlBuffer.append("'" + beginInfoBean.getDoc_id() + "','"
				+ beginInfoBean.getContract_id() + "','"
				+ beginInfoBean.getBegin_id() + "','"
				+ beginInfoBean.getEquip_amt() + "','"
				+ beginInfoBean.getCurrency() + "','"
				+ beginInfoBean.getLease_money() + "','"
				+ beginInfoBean.getActual_fund() + "','"
				+ beginInfoBean.getAssets_value() + "','"
				+ beginInfoBean.getIncome_number() + "','"
				+ beginInfoBean.getIncome_number_year() + "','"
				+ beginInfoBean.getLease_term() + "','"
				+ beginInfoBean.getSettle_method() + "','"
				+ beginInfoBean.getPeriod_type() + "','"
				+ beginInfoBean.getRate_float_type() + "','"
				+ beginInfoBean.getRate_float_amt() + "','"
				+ beginInfoBean.getAdjust_style() + "','"
				+ beginInfoBean.getIs_open() + "','"
				+ beginInfoBean.getPlan_bank_name() + "','"
				+ beginInfoBean.getPlan_bank_no() + "','"
				+ beginInfoBean.getYear_rate() + "','"
				+ beginInfoBean.getPena_rate() + "','"
				+ beginInfoBean.getStart_date() + "','"
				+ beginInfoBean.getIncome_day() + "','"
				+ beginInfoBean.getRent_start_date() + "','"
				+ beginInfoBean.getPlan_irr() + "','"
				+ beginInfoBean.getFree_defa_inter_day() + "','"
				+ beginInfoBean.getInto_batch() + "','"
				+ beginInfoBean.getRatio_param() + "','"
				+ beginInfoBean.getCreator() + "','"
				+ beginInfoBean.getCreate_date() + "','"
				+ beginInfoBean.getModify_date() + "','"
				+ beginInfoBean.getModificator() + "'");
		sqlBuffer.append(")");

		return sqlBuffer.toString();
	}
}
