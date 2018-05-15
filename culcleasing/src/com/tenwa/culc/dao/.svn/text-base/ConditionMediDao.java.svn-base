package com.tenwa.culc.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.log4j.Logger;

import com.tenwa.culc.bean.ConditionMediBean;
import com.tenwa.culc.service.SqlFenerateConditionMediUtil;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.log.LogWriter;

public class ConditionMediDao {
	private static Logger log = Logger.getLogger(ConditionMediDao.class);


	// 公共参数
	private ResultSet rs = null;

	/**
	 * 将商务条件Bean插入proj_condition_temp表
	 * 
	 * @param conditionBean
	 * @return
	 * @throws SQLException
	 */
	public int insertConditionBeanIntoTempTable(
			ConditionMediBean conditionMediBean) throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlFenerateConditionMediUtil
				.generateInsertProjConditionTempSql(conditionMediBean);
		LogWriter.logDebug("保存上传conditionMediBean:" + sqlStr);
		// log.debug("___________" + sqlStr);

		flag = erpDataSource.executeUpdate(sqlStr);

		if (log.isDebugEnabled()) {
			log.debug("ConditionMediDao执行操作，影响结果：" + flag + "___Sql:" + sqlStr);
		}
		// 3.关闭资源
		erpDataSource.close();

		// 5.返回
		return flag;
	}

	/**
	 * 更新proj_condition_temp里数据
	 * 
	 * @param conditionMediBean
	 * @return
	 * @throws SQLException
	 */
	public int updateConditionMediBeanInTempTable(
			ConditionMediBean conditionMediBean) throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlFenerateConditionMediUtil
				.generateUpdateProjConditionTempSql(conditionMediBean);
		log.debug("___________" + sqlStr);

		flag = erpDataSource.executeUpdate(sqlStr);

		if (log.isDebugEnabled()) {
			log.debug("ConditionMediDao执行Update操作，影响结果：" + flag + "___Sql:"
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
		String sqlStr = "select id from proj_condition_medi_temp where proj_id='"
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
	public ConditionMediBean loadConditionMediBeanByKey(String proj_id,
			String doc_id) throws SQLException {
		ConditionMediBean conditionMediBean = new ConditionMediBean();
		conditionMediBean.setProj_id(proj_id);
		conditionMediBean.setDoc_id(doc_id);

		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlFenerateConditionMediUtil.generateSelectCondTemp(
				proj_id, doc_id);
		log.info("我要的载入" + sqlStr);
		rs = erpDataSource.executeQuery(sqlStr);
		if (rs.next()) {
			conditionMediBean.setEquip_amt(rs.getString("equip_amt"));
			conditionMediBean.setCurrency(rs.getString("currency"));
			conditionMediBean.setLease_money(rs.getString("lease_money"));
			conditionMediBean.setFirst_payment(rs.getString("first_payment"));
			conditionMediBean.setCaution_money(rs.getString("caution_money"));

			conditionMediBean.setActual_fund(rs.getString("actual_fund"));
			conditionMediBean.setCaution_deduction_money(rs
					.getString("caution_deduction_money"));
			conditionMediBean.setActual_fund(rs.getString("actual_fund"));
			conditionMediBean.setHandling_charge(rs
					.getString("handling_charge"));
			
			// ===22==return_amt
			conditionMediBean.setManagement_fee(rs.getString("management_fee"));
			conditionMediBean.setNominalprice(rs.getString("nominalprice"));
			conditionMediBean.setReturn_amt(rs.getString("return_amt"));
			conditionMediBean.setRate_subsidy(rs.getString("rate_subsidy"));

			conditionMediBean.setBefore_interest(rs
					.getString("before_interest"));
			conditionMediBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			conditionMediBean.setDiscount_rate(rs.getString("discount_rate"));
			conditionMediBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));
			System.out.println("我要测试输出:111111111111111");
			// ==33==
			conditionMediBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			conditionMediBean.setOther_income(rs.getString("other_income"));
			conditionMediBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			conditionMediBean.setIncome_number(rs.getString("income_number"));
			conditionMediBean.setIncome_number_year(rs
					.getString("income_number_year"));

			conditionMediBean.setLease_term(rs.getString("lease_term"));
			conditionMediBean.setYear_rate(rs.getString("year_rate"));
			conditionMediBean.setPena_rate(rs.getString("pena_rate"));
			conditionMediBean.setStart_date(rs.getString("start_date"));

			conditionMediBean.setIncome_day(rs.getString("income_day"));
			System.out.println("我要测试输出:222222222222222222222");
			// ==55==
			conditionMediBean.setRent_start_date(rs
					.getString("rent_start_date"));
			conditionMediBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// conditionMediBean.setAmt_return(rs.getString("amt_return"));
			conditionMediBean.setInsure_type(rs.getString("insure_type"));
			conditionMediBean.setInsure_money(rs.getString("insure_money"));
			System.out.println("我要测试输出:3333333333333333");
			// ==66==
			conditionMediBean.setInsure_pay_type(rs
					.getString("Insure_pay_type"));
			conditionMediBean.setIs_floor(rs.getString("is_floor"));
			conditionMediBean.setFloor_rent(rs.getString("floor_rent"));
			conditionMediBean.setManager_pay_type(rs
					.getString("manager_pay_type"));
			conditionMediBean.setCreator(rs.getString("creator"));
			conditionMediBean.setModify_date(rs.getString("modify_date"));
			conditionMediBean.setModificator(rs.getString("modificator"));
			conditionMediBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			conditionMediBean.setPlan_bank_name(rs.getString("plan_bank_name"));
			conditionMediBean.setPlan_bank_no(rs.getString("plan_bank_no"));
			System.out.println("我要测试输出:444444444444444");
			// 2012-03-28 Jaffe Add
			conditionMediBean.setRate_float_type(rs
					.getString("rate_float_type"));
			System.out.println("我要测试输出:00000000000");
			conditionMediBean.setRate_float_amt(String.valueOf(Double.parseDouble(rs.getString("rate_float_amt"))));
			System.out.println("我要测试输出:555555555555");
			conditionMediBean.setAdjust_style(rs.getString("adjust_style"));
			
			conditionMediBean.setInto_batch(rs.getString("into_batch"));
			conditionMediBean.setIs_open(rs.getString("is_open"));
			conditionMediBean.setSettle_method(rs.getString("settle_method"));
			
			conditionMediBean.setPeriod_type(rs.getString("period_type"));
			conditionMediBean.setYear_rate(rs.getString("year_rate"));
			conditionMediBean.setRatio_param(rs.getString("ratio_param"));

			log.debug("我要的" + conditionMediBean.getIs_floor());
		}

		// 3.关闭资源
		erpDataSource.close();

		return conditionMediBean;
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
		String sqlStr = "select id from proj_condition_Medi_temp where proj_id='"
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
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no)");
		sqlBuilder
				.append(
						"select'"
								+ doc_id
								+ "',proj_id,equip_amt,currency,lease_money,first_payment,caution_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,income_day,pena_rate,start_date,rent_start_date,")
				.append(
						"free_defa_inter_day,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no")
				.append(" from proj_condition_medi");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();

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
		String sqlStr = "select id from contract_condition_medi_temp where contract_id='"
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
						"insert into contract_condition_medi_temp(doc_id,contract_id,equip_amt,currency,lease_money,first_payment,caution_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,income_day,pena_rate,start_date,rent_start_date,")
				.append(
						"free_defa_inter_day,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no)");
		sqlBuilder
				.append(
						"select'"
								+ doc_id
								+ "','"
								+ contract_id
								+ "',equip_amt,currency,lease_money,first_payment,caution_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,income_day,pena_rate,start_date,rent_start_date,")
				.append(
						"free_defa_inter_day,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no from proj_condition_medi");
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
	public ConditionMediBean loadConditionContractBeanByKey(String contract_id,
			String doc_id) throws SQLException {
		ConditionMediBean conditionMediBean = new ConditionMediBean();
		conditionMediBean.setContract_id(contract_id);
		conditionMediBean.setDoc_id(doc_id);

		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlFenerateConditionMediUtil
				.generateSelectCondContractTemp(contract_id, doc_id);
		log.info("我要的载入合同" + sqlStr);
		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			conditionMediBean.setEquip_amt(rs.getString("equip_amt"));
			conditionMediBean.setCurrency(rs.getString("currency"));
			conditionMediBean.setLease_money(rs.getString("lease_money"));
			conditionMediBean.setFirst_payment(rs.getString("first_payment"));
			conditionMediBean.setCaution_money(rs.getString("caution_money"));

			conditionMediBean.setActual_fund(rs.getString("actual_fund"));
			conditionMediBean.setCaution_deduction_money(rs
					.getString("caution_deduction_money"));
			conditionMediBean.setActual_fund(rs.getString("actual_fund"));
			conditionMediBean.setHandling_charge(rs
					.getString("handling_charge"));

			// ===22==return_amt
			conditionMediBean.setManagement_fee(rs.getString("management_fee"));
			conditionMediBean.setNominalprice(rs.getString("nominalprice"));
			conditionMediBean.setReturn_amt(rs.getString("return_amt"));
			conditionMediBean.setRate_subsidy(rs.getString("rate_subsidy"));

			conditionMediBean.setBefore_interest(rs
					.getString("before_interest"));
			conditionMediBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			conditionMediBean.setDiscount_rate(rs.getString("discount_rate"));
			conditionMediBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));

			// ==33==
			conditionMediBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			conditionMediBean.setOther_income(rs.getString("other_income"));
			conditionMediBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			conditionMediBean.setIncome_number(rs.getString("income_number"));
			conditionMediBean.setIncome_number_year(rs
					.getString("income_number_year"));

			conditionMediBean.setLease_term(rs.getString("lease_term"));
			conditionMediBean.setYear_rate(rs.getString("year_rate"));
			conditionMediBean.setPena_rate(rs.getString("pena_rate"));
			conditionMediBean.setStart_date(rs.getString("start_date"));

			conditionMediBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			conditionMediBean.setRent_start_date(rs
					.getString("rent_start_date"));
			conditionMediBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// conditionMediBean.setAmt_return(rs.getString("amt_return"));
			conditionMediBean.setInsure_type(rs.getString("insure_type"));
			conditionMediBean.setInsure_money(rs.getString("insure_money"));

			// ==66==
			conditionMediBean.setInsure_pay_type(rs
					.getString("Insure_pay_type"));
			conditionMediBean.setIs_floor(rs.getString("is_floor"));
			conditionMediBean.setFloor_rent(rs.getString("floor_rent"));
			conditionMediBean.setManager_pay_type(rs
					.getString("manager_pay_type"));
			conditionMediBean.setCreator(rs.getString("creator"));
			conditionMediBean.setModify_date(rs.getString("modify_date"));
			conditionMediBean.setModificator(rs.getString("modificator"));
			conditionMediBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			// ==77==
			conditionMediBean.setPlan_bank_name(rs.getString("plan_bank_name"));
			conditionMediBean.setPlan_bank_no(rs.getString("plan_bank_no"));
			conditionMediBean.setPlan_bank_name(rs.getString("plan_bank_name"));
			conditionMediBean.setPlan_bank_no(rs.getString("plan_bank_no"));
			//新增2012-03-29
			conditionMediBean.setSettle_method(rs.getString("settle_method"));
			conditionMediBean.setRate_float_type(rs.getString("rate_float_type"));
			conditionMediBean.setRate_float_amt(String.valueOf(Double.parseDouble(rs.getString("rate_float_amt"))));
			//2012-03-29
			conditionMediBean.setRatio_param(rs.getString("ratio_param"));
			conditionMediBean.setAdjust_style(rs.getString("adjust_style"));
			conditionMediBean.setInto_batch(rs.getString("into_batch"));
			conditionMediBean.setIs_open(rs.getString("is_open"));

		}
		// 3.关闭资源
		erpDataSource.close();

		return conditionMediBean;
	}

	/**
	 * 加载合同交易结构 - 正式
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */

	public ConditionMediBean loadFactConditionContractBeanByKey(
			String contract_id) throws SQLException {
		ConditionMediBean conditionMediBean = new ConditionMediBean();
		conditionMediBean.setContract_id(contract_id);

		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlFenerateConditionMediUtil
				.generateSelectCondContract(contract_id);

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			conditionMediBean.setEquip_amt(rs.getString("equip_amt"));
			conditionMediBean.setCurrency(rs.getString("currency"));
			conditionMediBean.setLease_money(rs.getString("lease_money"));
			conditionMediBean.setFirst_payment(rs.getString("first_payment"));
			conditionMediBean.setCaution_money(rs.getString("caution_money"));

			conditionMediBean.setActual_fund(rs.getString("actual_fund"));
			conditionMediBean.setCaution_deduction_money(rs
					.getString("caution_deduction_money"));
			conditionMediBean.setActual_fund(rs.getString("actual_fund"));
			conditionMediBean.setHandling_charge(rs
					.getString("handling_charge"));

			// ===22==return_amt
			conditionMediBean.setManagement_fee(rs.getString("management_fee"));
			conditionMediBean.setNominalprice(rs.getString("nominalprice"));
			conditionMediBean.setReturn_amt(rs.getString("return_amt"));
			conditionMediBean.setRate_subsidy(rs.getString("rate_subsidy"));

			conditionMediBean.setBefore_interest(rs
					.getString("before_interest"));
			conditionMediBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			conditionMediBean.setDiscount_rate(rs.getString("discount_rate"));
			conditionMediBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));

			// ==33==
			conditionMediBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			conditionMediBean.setOther_income(rs.getString("other_income"));
			conditionMediBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			conditionMediBean.setIncome_number(rs.getString("income_number"));
			conditionMediBean.setIncome_number_year(rs
					.getString("income_number_year"));

			conditionMediBean.setLease_term(rs.getString("lease_term"));
			// conditionMediBean.setYear_rate(rs.getString("year_rate"));
			conditionMediBean.setPena_rate(rs.getString("pena_rate"));
			conditionMediBean.setStart_date(rs.getString("start_date"));

			conditionMediBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			conditionMediBean.setRent_start_date(rs
					.getString("rent_start_date"));
			conditionMediBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// conditionMediBean.setAmt_return(rs.getString("amt_return"));
			conditionMediBean.setInsure_type(rs.getString("insure_type"));
			conditionMediBean.setInsure_money(rs.getString("insure_money"));

			// ==66==
			conditionMediBean.setInsure_pay_type(rs
					.getString("Insure_pay_type"));
			conditionMediBean.setIs_floor(rs.getString("is_floor"));
			conditionMediBean.setFloor_rent(rs.getString("floor_rent"));
			conditionMediBean.setManager_pay_type(rs
					.getString("manager_pay_type"));
			conditionMediBean.setCreator(rs.getString("creator"));
			conditionMediBean.setModify_date(rs.getString("modify_date"));
			conditionMediBean.setModificator(rs.getString("modificator"));
			conditionMediBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			conditionMediBean.setPlan_bank_name(rs.getString("plan_bank_name"));
			conditionMediBean.setPlan_bank_no(rs.getString("plan_bank_no"));

		}
		// 3.关闭资源
		erpDataSource.close();

		return conditionMediBean;
	}

	/**
	 * 修改合同交易结构临时表
	 * 
	 * @param conditionMediBean
	 * @return
	 * @throws SQLException
	 */
	public int updateConditionContractBeanInTempTable(
			ConditionMediBean conditionMediBean) throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlFenerateConditionMediUtil
				.generateUpdateProjConditionContractTempSql(conditionMediBean);
		log.info("我要得更新：" + sqlStr);
		flag = erpDataSource.executeUpdate(sqlStr);

		if (log.isDebugEnabled()) {
			log.debug("ConditionMediDao执行Update操作，影响结果：" + flag + "___Sql:"
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
	 * @param conditionMediBean
	 * @return
	 * @throws SQLException
	 */
	public int insertConditionContractBeanIntoTempTable(
			ConditionMediBean conditionMediBean) throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlFenerateConditionMediUtil
				.generateInsertProjConditionContractTempSql(conditionMediBean);

		LogWriter.logDebug("ConditionMediDao执行操作，影响结果：" + flag + "___Sql:"
				+ sqlStr);
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
		String sqlStr = "select id from contract_condition_medi_temp where contract_id='"
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
						"insert into contract_condition_medi_temp(contract_id,doc_id,equip_amt,currency,lease_money,first_payment,caution_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,income_day,pena_rate,start_date,rent_start_date,")
				.append(
						"free_defa_inter_day,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no)");

		sqlBuilder
				.append(
						"select contract_id,'"
								+ doc_id
								+ "',equip_amt,currency,lease_money,first_payment,caution_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,income_day,pena_rate,start_date,rent_start_date,")
				.append(
						"free_defa_inter_day,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no  from contract_condition_medi");
		sqlBuilder.append(" where contract_id='" + contract_id + "'");
		sqlStr = sqlBuilder.toString();
		System.out.print("我要的" + sqlStr);
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
		String sqlStr = "Delete from proj_condition_medi_temp where proj_id='"
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
	public ConditionMediBean loadConditionContractBeanByContractId(
			String contract_id) throws SQLException {
		ConditionMediBean conditionMediBean = new ConditionMediBean();
		conditionMediBean.setContract_id(contract_id);

		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlFenerateConditionMediUtil
				.generateSelectCondContract(contract_id);

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			conditionMediBean.setEquip_amt(rs.getString("equip_amt"));
			conditionMediBean.setCurrency(rs.getString("currency"));
			conditionMediBean.setLease_money(rs.getString("lease_money"));
			conditionMediBean.setFirst_payment(rs.getString("first_payment"));
			conditionMediBean.setCaution_money(rs.getString("caution_money"));

			conditionMediBean.setActual_fund(rs.getString("actual_fund"));
			conditionMediBean.setCaution_deduction_money(rs
					.getString("caution_deduction_money"));
			conditionMediBean.setActual_fund(rs.getString("actual_fund"));
			conditionMediBean.setHandling_charge(rs
					.getString("handling_charge"));

			// ===22==return_amt
			conditionMediBean.setManagement_fee(rs.getString("management_fee"));
			conditionMediBean.setNominalprice(rs.getString("nominalprice"));
			conditionMediBean.setReturn_amt(rs.getString("return_amt"));
			conditionMediBean.setRate_subsidy(rs.getString("rate_subsidy"));

			conditionMediBean.setBefore_interest(rs
					.getString("before_interest"));
			conditionMediBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			conditionMediBean.setDiscount_rate(rs.getString("discount_rate"));
			conditionMediBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));

			// ==33==
			conditionMediBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			conditionMediBean.setOther_income(rs.getString("other_income"));
			conditionMediBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			conditionMediBean.setIncome_number(rs.getString("income_number"));
			conditionMediBean.setIncome_number_year(rs
					.getString("income_number_year"));

			conditionMediBean.setLease_term(rs.getString("lease_term"));
			// conditionMediBean.setYear_rate(rs.getString("year_rate"));
			conditionMediBean.setPena_rate(rs.getString("pena_rate"));
			conditionMediBean.setStart_date(rs.getString("start_date"));

			conditionMediBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			conditionMediBean.setRent_start_date(rs
					.getString("rent_start_date"));
			conditionMediBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// conditionMediBean.setAmt_return(rs.getString("amt_return"));
			conditionMediBean.setInsure_type(rs.getString("insure_type"));
			conditionMediBean.setInsure_money(rs.getString("insure_money"));

			// ==66==
			conditionMediBean.setInsure_pay_type(rs
					.getString("Insure_pay_type"));
			conditionMediBean.setIs_floor(rs.getString("is_floor"));
			conditionMediBean.setFloor_rent(rs.getString("floor_rent"));
			conditionMediBean.setManager_pay_type(rs
					.getString("manager_pay_type"));
			conditionMediBean.setCreator(rs.getString("setCreator"));
			conditionMediBean.setModify_date(rs.getString("modify_date"));
			conditionMediBean.setModificator(rs.getString("modificator"));
			conditionMediBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			conditionMediBean.setPlan_bank_name(rs.getString("plan_bank_name"));
			conditionMediBean.setPlan_bank_no(rs.getString("plan_bank_no"));

		}
		// 3.关闭资源
		erpDataSource.close();

		return conditionMediBean;
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
		String sqlStr = "select id from begin_info_medi_temp where contract_id='"
				+ contract_id
				+ "' and begin_id='"
				+ begin_id
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
						"Insert into begin_info_medi_temp(doc_id,contract_id,begin_id,equip_amt,currency,lease_money,")
				.append(
						"first_payment,caution_money,caution_deduction_money,actual_fund,handling_charge,management_fee,")
				.append(
						"nominalprice,return_amt,rate_subsidy,before_interest,before_interest_type,discount_rate,consulting_fee_out,")
				.append(
						"consulting_fee_in,other_income,other_expenditure,income_number,income_number_year,lease_term,year_rate,pena_rate,")
				.append(
						"start_date,income_day,rent_start_date,free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,")
				.append(
						"is_floor,floor_rent,manager_pay_type,creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no)");
		sqlBuilder
				.append(
						"select '"
								+ contract_id
								+ "','"
								+ begin_id
								+ "','"
								+ doc_id
								+ "',equip_amt,currency,lease_money,first_payment,caution_money,caution_deduction_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,year_rate,pena_rate,start_date,income_day,rent_start_date,")
				.append(
						"free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no");
		sqlBuilder.append(" from begin_info_medi where contract_id='"
				+ contract_id + "' and begin_id='" + begin_id + "'");
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
		String sqlStr = "Select id from contract_begin_info_medi where contract_id='"
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
						"Insert into begin_info_medi_temp(doc_id,contract_id,begin_id,equip_amt,currency,lease_money,")
				.append(
						"first_payment,caution_money,caution_deduction_money,actual_fund,handling_charge,management_fee,")
				.append(
						"nominalprice,return_amt,rate_subsidy,before_interest,before_interest_type,discount_rate,consulting_fee_out,")
				.append(
						"consulting_fee_in,other_income,other_expenditure,income_number,income_number_year,lease_term,year_rate,pena_rate,")
				.append(
						"start_date,income_day,rent_start_date,free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,")
				.append(
						"is_floor,floor_rent,manager_pay_type,creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no)");

		sqlBuilder
				.append(
						"select '"
								+ doc_id
								+ "','"
								+ contract_id
								+ "','"
								+ begin_id
								+ "',equip_amt,currency,lease_money,first_payment,caution_money,caution_deduction_money,")
				.append(
						"actual_fund,handling_charge,management_fee,nominalprice,return_amt,rate_subsidy,before_interest,")
				.append(
						"before_interest_type,discount_rate,consulting_fee_out,consulting_fee_in,other_income,other_expenditure,")
				.append(
						"income_number,income_number_year,lease_term,year_rate,pena_rate,start_date,income_day,rent_start_date,")
				.append(
						"free_defa_inter_day,amt_return,insure_type,insure_money,insure_pay_type,is_floor,floor_rent,manager_pay_type,")
				.append(
						"creator,create_date,modify_date,modificator,actual_fund_ratio,plan_bank_name,plan_bank_no");
		sqlBuilder.append(" from contract_condition_medi where contract_id='"
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
}