/**
 * com.tenwa.culc.dao
 */
package com.tenwa.culc.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.service.SqlGenerateUtil;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.log.LogWriter;

/**
 * 交易结构Dao操作
 * 
 * @author Jaffe
 * 
 * Date:Jun 27, 2011 2:33:39 PM Email:JaffeHe@hotmail.com
 */
public class ConditionDao {
	private static Logger log = Logger.getLogger(ConditionDao.class);

	// 公共参数
	private ResultSet rs = null;

	/**
	 * 将商务条件Bean插入proj_condition_temp表
	 * 
	 * @param conditionBean
	 * @return
	 * @throws SQLException
	 */
	public int insertConditionBeanIntoTempTable(ConditionBean conditionBean)
			throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil
				.generateInsertProjConditionTempSql(conditionBean);
		LogWriter.logDebug("保存上传ConditionBean:" + sqlStr);
		// log.debug("___________" + sqlStr);

		flag = erpDataSource.executeUpdate(sqlStr);

		if (log.isDebugEnabled()) {
			log.debug("ConditionDao执行操作，影响结果：" + flag + "___Sql:" + sqlStr);
		}
		// 3.关闭资源
		erpDataSource.close();

		// 5.返回
		return flag;
	}

	/**
	 * 更新proj_condition_temp里数据
	 * 
	 * @param conditionBean
	 * @return
	 * @throws SQLException
	 */
	public int updateConditionBeanInTempTable(ConditionBean conditionBean)
			throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil
				.generateUpdateProjConditionTempSql(conditionBean);
		log.debug("___________" + sqlStr);

		flag = erpDataSource.executeUpdate(sqlStr);

		if (log.isDebugEnabled()) {
			log.debug("ConditionDao执行Update操作，影响结果：" + flag + "___Sql:"
					+ sqlStr);
		}
		// 3.关闭资源
		erpDataSource.close();

		// 5.返回
		return flag;
	}

	/**
	 * 判断proj_id\doc_id 在proj_condition_temp是否存在，存在返回upd、不存在返回add
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public String judgeItemExist(String proj_id, String doc_id)
			throws SQLException {
		String resultVal = "";
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from proj_condition_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			resultVal = "upd";
		} else {
			resultVal = "add";
		}
		// 3.关闭资源
		erpDataSource.close();

		return resultVal;
	}

	/**
	 * 根据proj_id\doc_id从proj_condition_temp查找属性加载到Bean
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public ConditionBean loadConditionBeanByKey(String proj_id, String doc_id)
			throws SQLException {
		ConditionBean conditionBean = new ConditionBean();
		conditionBean.setProj_id(proj_id);
		conditionBean.setDoc_id(doc_id);

		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil.generateSelectCondTemp(proj_id, doc_id);

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			conditionBean.setEquip_amt(rs.getString("equip_amt"));
			conditionBean.setCurrency(rs.getString("currency"));
			conditionBean.setLease_money(rs.getString("lease_money"));
			conditionBean.setFirst_payment_ratio(rs
					.getString("first_payment_ratio"));
			conditionBean.setFirst_payment(rs.getString("first_payment"));
			conditionBean.setCaution_money_ratio(rs
					.getString("caution_money_ratio"));
			conditionBean.setCaution_money(rs.getString("caution_money"));
			conditionBean.setActual_fund(rs.getString("actual_fund"));
			conditionBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			conditionBean.setHandling_charge_ratio(rs
					.getString("handling_charge_ratio"));
			conditionBean.setHandling_charge(rs.getString("handling_charge"));
			// ===22==
			conditionBean.setManagement_fee(rs.getString("management_fee"));
			conditionBean.setNominalprice(rs.getString("nominalprice"));
			conditionBean.setReturn_ratio(rs.getString("return_ratio"));
			conditionBean.setReturn_amt(rs.getString("return_amt"));
			conditionBean.setRate_subsidy(rs.getString("rate_subsidy"));
			conditionBean.setBefore_interest(rs.getString("before_interest"));
			conditionBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			conditionBean.setDiscount_rate(rs.getString("discount_rate"));
			conditionBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));
			// ==33==
			conditionBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			conditionBean.setOther_income(rs.getString("other_income"));
			conditionBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			conditionBean.setIncome_number(rs.getString("income_number"));
			conditionBean.setIncome_number_year(rs
					.getString("income_number_year"));
			conditionBean.setLease_term(rs.getString("lease_term"));
			conditionBean.setSettle_method(rs.getString("settle_method"));
			conditionBean.setPeriod_type(rs.getString("period_type"));
			// ==44==
			conditionBean.setRate_float_type(rs.getString("rate_float_type"));
			conditionBean.setRate_float_amt(String.valueOf(rs.getString("rate_float_amt")));
			conditionBean.setAdjust_style(rs.getString("adjust_style"));
			conditionBean.setYear_rate(rs.getString("year_rate"));
			conditionBean.setPena_rate(rs.getString("pena_rate"));
			conditionBean.setStart_date(rs.getString("start_date"));
			conditionBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			conditionBean.setEnd_date(rs.getString("end_date"));
			conditionBean.setRent_start_date(rs.getString("rent_start_date"));
			conditionBean.setIrr(rs.getString("irr"));
			conditionBean.setPlan_irr(rs.getString("plan_irr"));
			conditionBean.setInsure_type(rs.getString("insure_type"));
			conditionBean.setInto_batch(rs.getString("into_batch"));
			conditionBean.setInsure_money(rs.getString("insure_money"));
			conditionBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// ==66==
			conditionBean.setAssets_value(rs.getString("assets_value"));
			conditionBean.setAssess_adjust(rs.getString("assess_adjust"));
			conditionBean.setRatio_param(rs.getString("ratio_param"));
			// ==77==
			conditionBean.setInvoice_type(rs.getString("invoice_type"));
			conditionBean.setStandardF(rs.getString("StandardF"));
			conditionBean.setStandardIrr(rs.getString("StandardIrr"));
			// ==88==
			conditionBean.setInsure_pay_type(rs.getString("Insure_pay_type"));

		}
		// 3.关闭资源
		erpDataSource.close();

		return conditionBean;
	}

	public ConditionBean loadConditionBeanByKey1(String proj_id)
			throws SQLException {
		ConditionBean conditionBean = new ConditionBean();
		conditionBean.setProj_id(proj_id);
		//conditionBean.setDoc_id(doc_id);

		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil.generateSelectCondTemp1(proj_id);

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			conditionBean.setEquip_amt(rs.getString("equip_amt"));
			conditionBean.setCurrency(rs.getString("currency"));
			conditionBean.setLease_money(rs.getString("lease_money"));
			conditionBean.setFirst_payment_ratio(rs
					.getString("first_payment_ratio"));
			conditionBean.setFirst_payment(rs.getString("first_payment"));
			conditionBean.setCaution_money_ratio(rs
					.getString("caution_money_ratio"));
			conditionBean.setCaution_money(rs.getString("caution_money"));
			conditionBean.setActual_fund(rs.getString("actual_fund"));
			conditionBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			conditionBean.setHandling_charge_ratio(rs
					.getString("handling_charge_ratio"));
			conditionBean.setHandling_charge(rs.getString("handling_charge"));
			// ===22==
			conditionBean.setManagement_fee(rs.getString("management_fee"));
			conditionBean.setNominalprice(rs.getString("nominalprice"));
			conditionBean.setReturn_ratio(rs.getString("return_ratio"));
			conditionBean.setReturn_amt(rs.getString("return_amt"));
			conditionBean.setRate_subsidy(rs.getString("rate_subsidy"));
			conditionBean.setBefore_interest(rs.getString("before_interest"));
			conditionBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			conditionBean.setDiscount_rate(rs.getString("discount_rate"));
			conditionBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));
			// ==33==
			conditionBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			conditionBean.setOther_income(rs.getString("other_income"));
			conditionBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			conditionBean.setIncome_number(rs.getString("income_number"));
			conditionBean.setIncome_number_year(rs
					.getString("income_number_year"));
			conditionBean.setLease_term(rs.getString("lease_term"));
			conditionBean.setSettle_method(rs.getString("settle_method"));
			conditionBean.setPeriod_type(rs.getString("period_type"));
			// ==44==
			conditionBean.setRate_float_type(rs.getString("rate_float_type"));
			conditionBean.setRate_float_amt(rs.getString("rate_float_amt"));
			conditionBean.setAdjust_style(rs.getString("adjust_style"));
			conditionBean.setYear_rate(rs.getString("year_rate"));
			conditionBean.setPena_rate(rs.getString("pena_rate"));
			conditionBean.setStart_date(rs.getString("start_date"));
			conditionBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			conditionBean.setEnd_date(rs.getString("end_date"));
			conditionBean.setRent_start_date(rs.getString("rent_start_date"));
			conditionBean.setIrr(rs.getString("irr"));
			conditionBean.setPlan_irr(rs.getString("plan_irr"));
			conditionBean.setInsure_type(rs.getString("insure_type"));
			conditionBean.setInto_batch(rs.getString("into_batch"));
			conditionBean.setInsure_money(rs.getString("insure_money"));
			conditionBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// ==66==
			conditionBean.setAssets_value(rs.getString("assets_value"));
			conditionBean.setAssess_adjust(rs.getString("assess_adjust"));
			conditionBean.setRatio_param(rs.getString("ratio_param"));
			// ==77==
			conditionBean.setInvoice_type(rs.getString("invoice_type"));
			conditionBean.setStandardF(rs.getString("StandardF"));
			conditionBean.setStandardIrr(rs.getString("StandardIrr"));
			// ==88==
			conditionBean.setInsure_pay_type(rs.getString("Insure_pay_type"));

		}
		// 3.关闭资源
		erpDataSource.close();

		return conditionBean;
	}

	/**
	 * 更新proj_condition_temp表plan_irr
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @param markirr
	 * @return
	 * @throws SQLException
	 */
	public int updateConditionTempPlanIrrOper(String proj_id, String doc_id,
			String markirr) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "update proj_condition_temp set plan_irr=" + markirr
				+ " where proj_id='" + proj_id + "' and doc_id = '" + doc_id
				+ "' ";
		sqlStr += " update proj_condition_temp set irr=" + markirr
				+ " where proj_id='" + proj_id + "' and doc_id = '" + doc_id
				+ "' and isnull(irr,0)<=0";

		int res = erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
		return res;
	}

	/**
	 * 删除指定的交易结构临时表数据
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void delProjConditionTempData(String proj_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "delete from proj_condition_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";
		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 流程初始化判断数据是否存在
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeDataExist(String proj_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from proj_condition_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 流程初始化Proj_condition_temp表数据
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2Temp(String proj_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"Insert into proj_condition_temp(proj_id,doc_id,equip_amt,currency,lease_money,first_payment_ratio,first_payment,")
				.append(
						"caution_money_ratio,caution_money,caution_deduction_ratio,caution_deduction_money,actual_fund,")
				.append(
						"actual_fund_ratio,handling_charge_ratio,handling_charge,management_fee,nominalprice,return_ratio,return_amt,")
				.append(
						"rate_subsidy,before_interest,before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,")
				.append(
						"other_expenditure,income_number,income_number_year,lease_term,settle_method,period_type,rate_float_type,")
				.append(
						"rate_float_amt,adjust_style,year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,irr,")
				.append(
						"plan_irr,free_defa_inter_day,total_amt,amt_return,apply_contract_number,insure_type,into_batch,")
				.append(
						"insure_money,assets_value,assess_adjust,ratio_param,creator,create_date,modify_date,modificator,")
				.append("invoice_type,StandardF,StandardIrr)");
		sqlBuilder
				.append(
						"select proj_id,'"
								+ doc_id
								+ "',equip_amt,currency,lease_money,first_payment_ratio,first_payment,")
				.append(
						"caution_money_ratio,caution_money,caution_deduction_ratio,caution_deduction_money,actual_fund,")
				.append(
						"actual_fund_ratio,handling_charge_ratio,handling_charge,management_fee,nominalprice,return_ratio,return_amt,")
				.append(
						"rate_subsidy,before_interest,before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,")
				.append(
						"other_expenditure,income_number,income_number_year,lease_term,settle_method,period_type,rate_float_type,")
				.append(
						"rate_float_amt,adjust_style,year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,irr,")
				.append(
						"plan_irr,free_defa_inter_day,total_amt,amt_return,apply_contract_number,insure_type,into_batch,")
				.append(
						"insure_money,assets_value,assess_adjust,ratio_param,creator,create_date,modify_date,modificator,")
				.append("invoice_type,StandardF,StandardIrr").append(
						" from proj_condition");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();
System.out.println(sqlStr);
		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 判断数据是否存在
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeItemContractExist(String contract_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from contract_condition_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 数据拷贝
	 * 
	 * @param contract_id
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTemp(String contract_id, String proj_id,
			String doc_id) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"insert into contract_condition_temp(contract_id,doc_id,equip_amt,currency,lease_money,first_payment_ratio,first_payment,caution_money_ratio,caution_money,")
				.append(
						"caution_deduction_ratio,caution_deduction_money,actual_fund,actual_fund_ratio,handling_charge_ratio,")
				.append(
						"handling_charge,management_fee,nominalprice,return_ratio,return_amt,rate_subsidy,before_interest,before_interest_type,discount_rate,")
				.append(
						"consulting_fee_out,consulting_fee_in,other_income,other_expenditure,income_number,income_number_year,lease_term,settle_method,")
				.append(
						"period_type,rate_float_type,rate_float_amt,adjust_style,year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,")
				.append(
						"irr,plan_irr,free_defa_inter_day,total_amt,amt_return,apply_contract_number,insure_type,into_batch,insure_money,assets_value,")
				.append(
						"assess_adjust,ratio_param,creator,create_date,modify_date,modificator,")
				.append("invoice_type,StandardF,StandardIrr)");
		sqlBuilder
				.append(
						"select '"
								+ contract_id
								+ "','"
								+ doc_id
								+ "',equip_amt,currency,lease_money,first_payment_ratio,first_payment,caution_money_ratio,caution_money,")
				.append(
						"caution_deduction_ratio,caution_deduction_money,actual_fund,actual_fund_ratio,handling_charge_ratio,")
				.append(
						"handling_charge,management_fee,nominalprice,return_ratio,return_amt,rate_subsidy,before_interest,before_interest_type,discount_rate,")
				.append(
						"consulting_fee_out,consulting_fee_in,other_income,other_expenditure,income_number,income_number_year,lease_term,settle_method,")
				.append(
						"period_type,rate_float_type,rate_float_amt,adjust_style,year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,")
				.append(
						"irr,plan_irr,free_defa_inter_day,total_amt,amt_return,apply_contract_number,insure_type,into_batch,insure_money,assets_value,")
				.append(
						"assess_adjust,ratio_param,creator,create_date,modify_date,modificator,invoice_type,StandardF,StandardIrr from proj_condition");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 加载合同交易结构
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public ConditionBean loadConditionContractBeanByKey(String contract_id,
			String doc_id) throws SQLException {
		ConditionBean conditionBean = new ConditionBean();
		conditionBean.setContract_id(contract_id);
		conditionBean.setDoc_id(doc_id);

		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil.generateSelectCondContractTemp(
				contract_id, doc_id);

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			conditionBean.setEquip_amt(rs.getString("equip_amt"));
			conditionBean.setCurrency(rs.getString("currency"));
			conditionBean.setLease_money(rs.getString("lease_money"));
			conditionBean.setFirst_payment_ratio(rs
					.getString("first_payment_ratio"));
			conditionBean.setFirst_payment(rs.getString("first_payment"));
			conditionBean.setCaution_money_ratio(rs
					.getString("caution_money_ratio"));
			conditionBean.setCaution_money(rs.getString("caution_money"));
			conditionBean.setActual_fund(rs.getString("actual_fund"));
			conditionBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			conditionBean.setHandling_charge_ratio(rs
					.getString("handling_charge_ratio"));
			conditionBean.setHandling_charge(rs.getString("handling_charge"));
			// ===22==
			conditionBean.setManagement_fee(rs.getString("management_fee"));
			conditionBean.setNominalprice(rs.getString("nominalprice"));
			conditionBean.setReturn_ratio(rs.getString("return_ratio"));
			conditionBean.setReturn_amt(rs.getString("return_amt"));
			conditionBean.setRate_subsidy(rs.getString("rate_subsidy"));
			conditionBean.setBefore_interest(rs.getString("before_interest"));
			conditionBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			conditionBean.setDiscount_rate(rs.getString("discount_rate"));
			conditionBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));
			// ==33==
			conditionBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			conditionBean.setOther_income(rs.getString("other_income"));
			conditionBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			conditionBean.setIncome_number(rs.getString("income_number"));
			conditionBean.setIncome_number_year(rs
					.getString("income_number_year"));
			conditionBean.setLease_term(rs.getString("lease_term"));
			conditionBean.setSettle_method(rs.getString("settle_method"));
			conditionBean.setPeriod_type(rs.getString("period_type"));
			// ==44==
			conditionBean.setRate_float_type(rs.getString("rate_float_type"));
			
			conditionBean.setRate_float_amt(String.valueOf(Double.parseDouble(rs.getString("rate_float_amt"))));
			System.out.println("==============="+Double.parseDouble(conditionBean.getRate_float_amt()));
			System.out.println("==============="+Double.parseDouble(rs.getString("rate_float_amt")));
			conditionBean.setAdjust_style(rs.getString("adjust_style"));
			conditionBean.setYear_rate(rs.getString("year_rate"));
			conditionBean.setPena_rate(rs.getString("pena_rate"));
			conditionBean.setStart_date(rs.getString("start_date"));
			conditionBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			conditionBean.setEnd_date(rs.getString("end_date"));
			conditionBean.setRent_start_date(rs.getString("rent_start_date"));
			conditionBean.setIrr(rs.getString("irr"));
			conditionBean.setPlan_irr(rs.getString("plan_irr"));
			conditionBean.setInsure_type(rs.getString("insure_type"));
			conditionBean.setInto_batch(rs.getString("into_batch"));
			conditionBean.setInsure_money(rs.getString("insure_money"));
			conditionBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// ==66==
			conditionBean.setAssets_value(rs.getString("assets_value"));
			conditionBean.setAssess_adjust(rs.getString("assess_adjust"));
			conditionBean.setRatio_param(rs.getString("ratio_param"));
			// ==77==
			conditionBean.setInvoice_type(rs.getString("invoice_type"));
			conditionBean.setStandardF(rs.getString("StandardF"));
			conditionBean.setStandardIrr(rs.getString("StandardIrr"));
			// ==88==
			conditionBean.setInsure_pay_type(rs.getString("Insure_pay_type"));

		}
		// 3.关闭资源
		erpDataSource.close();

		return conditionBean;
	}

	/**
	 * 加载合同交易结构 - 正式
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */

	public ConditionBean loadFactConditionContractBeanByKey(String contract_id)
			throws SQLException {
		ConditionBean conditionBean = new ConditionBean();
		conditionBean.setContract_id(contract_id);

		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil.generateSelectCondContract(contract_id);

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			conditionBean.setEquip_amt(rs.getString("equip_amt"));
			conditionBean.setCurrency(rs.getString("currency"));
			conditionBean.setLease_money(rs.getString("lease_money"));
			conditionBean.setFirst_payment_ratio(rs
					.getString("first_payment_ratio"));
			conditionBean.setFirst_payment(rs.getString("first_payment"));
			conditionBean.setCaution_money_ratio(rs
					.getString("caution_money_ratio"));
			conditionBean.setCaution_money(rs.getString("caution_money"));
			conditionBean.setActual_fund(rs.getString("actual_fund"));
			conditionBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			conditionBean.setHandling_charge_ratio(rs
					.getString("handling_charge_ratio"));
			conditionBean.setHandling_charge(rs.getString("handling_charge"));
			// ===22==
			conditionBean.setManagement_fee(rs.getString("management_fee"));
			conditionBean.setNominalprice(rs.getString("nominalprice"));
			conditionBean.setReturn_ratio(rs.getString("return_ratio"));
			conditionBean.setReturn_amt(rs.getString("return_amt"));
			conditionBean.setRate_subsidy(rs.getString("rate_subsidy"));
			conditionBean.setBefore_interest(rs.getString("before_interest"));
			conditionBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			conditionBean.setDiscount_rate(rs.getString("discount_rate"));
			conditionBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));
			// ==33==
			conditionBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			conditionBean.setOther_income(rs.getString("other_income"));
			conditionBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			conditionBean.setIncome_number(rs.getString("income_number"));
			conditionBean.setIncome_number_year(rs
					.getString("income_number_year"));
			conditionBean.setLease_term(rs.getString("lease_term"));
			conditionBean.setSettle_method(rs.getString("settle_method"));
			conditionBean.setPeriod_type(rs.getString("period_type"));
			// ==44==
			conditionBean.setRate_float_type(rs.getString("rate_float_type"));
			conditionBean.setRate_float_amt(rs.getString("rate_float_amt"));
			conditionBean.setAdjust_style(rs.getString("adjust_style"));
			conditionBean.setYear_rate(rs.getString("year_rate"));
			conditionBean.setPena_rate(rs.getString("pena_rate"));
			conditionBean.setStart_date(rs.getString("start_date"));
			conditionBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			conditionBean.setEnd_date(rs.getString("end_date"));
			conditionBean.setRent_start_date(rs.getString("rent_start_date"));
			conditionBean.setIrr(rs.getString("irr"));
			conditionBean.setPlan_irr(rs.getString("plan_irr"));
			conditionBean.setInsure_type(rs.getString("insure_type"));
			conditionBean.setInto_batch(rs.getString("into_batch"));
			conditionBean.setInsure_money(rs.getString("insure_money"));
			conditionBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// ==66==
			conditionBean.setAssets_value(rs.getString("assets_value"));
			conditionBean.setAssess_adjust(rs.getString("assess_adjust"));
			conditionBean.setRatio_param(rs.getString("ratio_param"));
			// ==77==
			conditionBean.setInvoice_type(rs.getString("invoice_type"));
			conditionBean.setStandardF(rs.getString("StandardF"));
			conditionBean.setStandardIrr(rs.getString("StandardIrr"));

		}
		// 3.关闭资源
		erpDataSource.close();

		return conditionBean;
	}

	/**
	 * 修改合同交易结构临时表
	 * 
	 * @param conditionBean
	 * @return
	 * @throws SQLException
	 */
	public int updateConditionContractBeanInTempTable(
			ConditionBean conditionBean) throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil
				.generateUpdateProjConditionContractTempSql(conditionBean);

		flag = erpDataSource.executeUpdate(sqlStr);

		if (log.isDebugEnabled()) {
			log.debug("ConditionDao执行Update操作，影响结果：" + flag + "___Sql:"
					+ sqlStr);
		}
		// 3.关闭资源
		erpDataSource.close();

		// 5.返回
		return flag;
	}

	/**
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @param markirr
	 * @return
	 * @throws SQLException
	 */
	public int updateConditionContractTempPlanIrrOper(String contract_id,
			String doc_id, String markirr) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "update contract_condition_temp set plan_irr="
				+ markirr + " where contract_id='" + contract_id
				+ "' and doc_id = '" + doc_id + "' ";
		int res = erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
		return res;
	}

	/**
	 * 删除合同交易结构临时表
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void delProjConditionContractTempData(String contract_id,
			String doc_id) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "delete from contract_condition_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";
		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 保存合同交易结构临时表
	 * 
	 * @param conditionBean
	 * @return
	 * @throws SQLException
	 */
	public int insertConditionContractBeanIntoTempTable(
			ConditionBean conditionBean) throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil
				.generateInsertProjConditionContractTempSql(conditionBean);
		LogWriter
				.logDebug("ConditionDao执行操作，影响结果：" + flag + "___Sql:" + sqlStr);
		flag = erpDataSource.executeUpdate(sqlStr);

		// 3.关闭资源
		erpDataSource.close();

		// 5.返回
		return flag;
	}

	/**
	 * 判断合同系列表中数据是否存在
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeContractDataExist(String contract_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from contract_condition_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 合同交易结构数据拷贝
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTemp(String contract_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"insert into contract_condition_temp(contract_id,doc_id,equip_amt,currency,lease_money,first_payment_ratio,first_payment,caution_money_ratio,caution_money,")
				.append(
						"caution_deduction_ratio,caution_deduction_money,actual_fund,actual_fund_ratio,handling_charge_ratio,")
				.append(
						"handling_charge,management_fee,nominalprice,return_ratio,return_amt,rate_subsidy,before_interest,before_interest_type,discount_rate,")
				.append(
						"consulting_fee_out,consulting_fee_in,other_income,other_expenditure,income_number,income_number_year,lease_term,settle_method,")
				.append(
						"period_type,rate_float_type,rate_float_amt,adjust_style,year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,")
				.append(
						"irr,plan_irr,free_defa_inter_day,total_amt,amt_return,apply_contract_number,insure_type,into_batch,insure_money,assets_value,")
				.append(
						"assess_adjust,ratio_param,creator,create_date,modify_date,modificator,")
				.append("invoice_type,StandardF,StandardIrr)");

		sqlBuilder
				.append(
						"select contract_id,'"
								+ doc_id
								+ "',equip_amt,currency,lease_money,first_payment_ratio,first_payment,caution_money_ratio,caution_money,")
				.append(
						"caution_deduction_ratio,caution_deduction_money,actual_fund,actual_fund_ratio,handling_charge_ratio,")
				.append(
						"handling_charge,management_fee,nominalprice,return_ratio,return_amt,rate_subsidy,before_interest,before_interest_type,discount_rate,")
				.append(
						"consulting_fee_out,consulting_fee_in,other_income,other_expenditure,income_number,income_number_year,lease_term,settle_method,")
				.append(
						"period_type,rate_float_type,rate_float_amt,adjust_style,year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,")
				.append(
						"irr,plan_irr,free_defa_inter_day,total_amt,amt_return,apply_contract_number,insure_type,into_batch,insure_money,assets_value,")
				.append(
						"assess_adjust,ratio_param,creator,create_date,modify_date,modificator,invoice_type,StandardF,StandardIrr from contract_condition");
		sqlBuilder.append(" where contract_id='" + contract_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();

	}

	/**
	 * 删除项目交易结构临时表
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteProjConditionTempData(String proj_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "Delete from proj_condition_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";
		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 通过ContractId加载到Bean
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */
	public ConditionBean loadConditionContractBeanByContractId(
			String contract_id) throws SQLException {
		ConditionBean conditionBean = new ConditionBean();
		conditionBean.setContract_id(contract_id);

		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil.generateSelectCondContract(contract_id);

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			conditionBean.setEquip_amt(rs.getString("equip_amt"));
			conditionBean.setCurrency(rs.getString("currency"));
			conditionBean.setLease_money(rs.getString("lease_money"));
			conditionBean.setFirst_payment_ratio(rs
					.getString("first_payment_ratio"));
			conditionBean.setFirst_payment(rs.getString("first_payment"));
			conditionBean.setCaution_money_ratio(rs
					.getString("caution_money_ratio"));
			conditionBean.setCaution_money(rs.getString("caution_money"));
			conditionBean.setActual_fund(rs.getString("actual_fund"));
			conditionBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			conditionBean.setHandling_charge_ratio(rs
					.getString("handling_charge_ratio"));
			conditionBean.setHandling_charge(rs.getString("handling_charge"));
			// ===22==
			conditionBean.setManagement_fee(rs.getString("management_fee"));
			conditionBean.setNominalprice(rs.getString("nominalprice"));
			conditionBean.setReturn_ratio(rs.getString("return_ratio"));
			conditionBean.setReturn_amt(rs.getString("return_amt"));
			conditionBean.setRate_subsidy(rs.getString("rate_subsidy"));
			conditionBean.setBefore_interest(rs.getString("before_interest"));
			conditionBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			conditionBean.setDiscount_rate(rs.getString("discount_rate"));
			conditionBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));
			// ==33==
			conditionBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			conditionBean.setOther_income(rs.getString("other_income"));
			conditionBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			conditionBean.setIncome_number(rs.getString("income_number"));
			conditionBean.setIncome_number_year(rs
					.getString("income_number_year"));
			conditionBean.setLease_term(rs.getString("lease_term"));
			conditionBean.setSettle_method(rs.getString("settle_method"));
			conditionBean.setPeriod_type(rs.getString("period_type"));
			// ==44==
			conditionBean.setRate_float_type(rs.getString("rate_float_type"));
			conditionBean.setRate_float_amt(rs.getString("rate_float_amt"));
			conditionBean.setAdjust_style(rs.getString("adjust_style"));
			conditionBean.setYear_rate(rs.getString("year_rate"));
			conditionBean.setPena_rate(rs.getString("pena_rate"));
			conditionBean.setStart_date(rs.getString("start_date"));
			conditionBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			conditionBean.setEnd_date(rs.getString("end_date"));
			conditionBean.setRent_start_date(rs.getString("rent_start_date"));
			conditionBean.setPlan_irr(rs.getString("plan_irr"));
			conditionBean.setInsure_type(rs.getString("insure_type"));
			conditionBean.setInto_batch(rs.getString("into_batch"));
			conditionBean.setInsure_money(rs.getString("insure_money"));
			conditionBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// ==66==
			conditionBean.setAssets_value(rs.getString("assets_value"));
			conditionBean.setAssess_adjust(rs.getString("assess_adjust"));
			conditionBean.setRatio_param(rs.getString("ratio_param"));
			// ==77==
			conditionBean.setInvoice_type(rs.getString("invoice_type"));
			// conditionBean.setStandardF(rs.getString("StandardF"));
			// conditionBean.setStandardIrr(rs.getString("StandardIrr"));
			conditionBean.setInsure_pay_type(rs.getString("insure_pay_type"));

		}
		// 3.关闭资源
		erpDataSource.close();

		return conditionBean;
	}

	/**
	 * 判断[Begin_info_temp是否存在数据]
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeBeginDataExist(String contract_id, String begin_id,
			String doc_id) throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from begin_info_temp where contract_id='"
				+ contract_id + "' and begin_id='" + begin_id
				+ "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);

		flag = rs.next();

		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 拷贝[begin_info]拷贝到[begin_info_temp]
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyBeginData2Temp(String contract_id, String begin_id,
			String doc_id) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();

		sqlBuilder
				.append(
						"Insert into begin_info_temp(contract_id,begin_id,doc_id,equip_amt,lease_money,actual_fund,assets_value,income_number,")
				.append(
						"income_number_year,lease_term,currency,settle_method,period_type,rate_float_type,")
				.append(
						"rate_float_amt,adjust_style,is_open,plan_bank_name,plan_bank_no,plan_irr,fact_irr,")
				.append(
						"year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,free_defa_inter_day,")
				.append(
						"into_batch,ratio_param,total_amt,amt_return,apply_contract_number,factoring,creator,create_date,modify_date,modificator,begin_order_index,")
				.append("invoice_type,tax_type,tax_type_invoice )");
		sqlBuilder
				.append(
						"select '"
								+ contract_id
								+ "','"
								+ begin_id
								+ "','"
								+ doc_id
								+ "',equip_amt,lease_money,actual_fund,assets_value,income_number,")
				.append(
						"income_number_year,lease_term,currency,settle_method,period_type,rate_float_type,")
				.append(
						"rate_float_amt,adjust_style,is_open,plan_bank_name,plan_bank_no,plan_irr,fact_irr,")
				.append(
						"year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,free_defa_inter_day,")
				.append(
						"into_batch,ratio_param,total_amt,amt_return,apply_contract_number,factoring,creator,create_date,modify_date,modificator,begin_order_index,invoice_type,tax_type,tax_type_invoice ");
		sqlBuilder.append(" from begin_info where contract_id='" + contract_id
				+ "' and begin_id='" + begin_id + "'");
		sqlStr = sqlBuilder.toString();

		LogWriter.logSqlStr("租金变更 -> 数据拷贝", sqlStr);
		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 判断当前合同是否多次起租
	 * 
	 * @param contractId
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeBeginType(String contractId) throws SQLException {
		boolean resultVal = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.拼接sql，执行插入
		String sqlStr = "Select id from contract_begin_info where contract_id='"
				+ contractId + "' and is_more='是'";

		rs = erpDataSource.executeQuery(sqlStr);

		resultVal = rs.next();

		// 3.关闭资源
		erpDataSource.close();

		return resultVal;
	}

	/**
	 * 起租流程初始化签约审批数据到起租[begin_info_temp]信息
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyContract2BeginData2Temp(String contract_id,
			String begin_id, String doc_id) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();

		sqlBuilder
				.append(
						"Insert into begin_info_temp(contract_id,begin_id,doc_id,equip_amt,lease_money,actual_fund,assets_value,income_number,")
				.append(
						"income_number_year,lease_term,currency,settle_method,period_type,rate_float_type,")
				.append(
						"rate_float_amt,adjust_style,is_open,plan_bank_name,plan_bank_no,plan_irr,fact_irr,")
				.append(
						"year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,free_defa_inter_day,")
				.append(
						"into_batch,ratio_param,total_amt,amt_return,apply_contract_number,invoice_type,creator,create_date,modify_date,modificator)");
		sqlBuilder
				.append(
						"select '"
								+ contract_id
								+ "','"
								+ begin_id
								+ "','"
								+ doc_id
								+ "',equip_amt,lease_money,actual_fund,assets_value,income_number,")
				.append(
						"income_number_year,lease_term,currency,settle_method,period_type,rate_float_type,")
				.append("rate_float_amt,adjust_style,'','','',plan_irr,irr,")
				.append(
						"year_rate,pena_rate,start_date,income_day,end_date,rent_start_date,free_defa_inter_day,")
				.append(
						"into_batch,ratio_param,total_amt,amt_return,apply_contract_number,invoice_type,creator,create_date,modify_date,modificator");
		sqlBuilder.append(" from contract_condition where contract_id='"
				+ contract_id + "'");

		sqlStr = sqlBuilder.toString();

		LogWriter.logSqlStr("起租流程 ->一次起租数据初始化", sqlStr);

		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 查询项目已使用项目金额
	 * 
	 * @param contractId
	 * @return
	 * @throws SQLException
	 */
	public String getUsedMoney(String contractId) throws SQLException {
		String usedMoney = "";
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "Select [dbo].[T_getSumEquipAmt]('" + contractId
				+ "') as used_money";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			usedMoney = rs.getString("used_money");
		}

		// 3.关闭资源
		erpDataSource.close();

		return usedMoney;
	}
	public static void main(String[] args) {
		System.out.println(String.valueOf(Double.parseDouble("10.1234567898")));
	}
}
