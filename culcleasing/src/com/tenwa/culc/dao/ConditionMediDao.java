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


	// ��������
	private ResultSet rs = null;

	/**
	 * ����������Bean����proj_condition_temp��
	 * 
	 * @param conditionBean
	 * @return
	 * @throws SQLException
	 */
	public int insertConditionBeanIntoTempTable(
			ConditionMediBean conditionMediBean) throws SQLException {
		int flag = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlFenerateConditionMediUtil
				.generateInsertProjConditionTempSql(conditionMediBean);
		LogWriter.logDebug("�����ϴ�conditionMediBean:" + sqlStr);
		// log.debug("___________" + sqlStr);

		flag = erpDataSource.executeUpdate(sqlStr);

		if (log.isDebugEnabled()) {
			log.debug("ConditionMediDaoִ�в�����Ӱ������" + flag + "___Sql:" + sqlStr);
		}
		// 3.�ر���Դ
		erpDataSource.close();

		// 5.����
		return flag;
	}

	/**
	 * ����proj_condition_temp������
	 * 
	 * @param conditionMediBean
	 * @return
	 * @throws SQLException
	 */
	public int updateConditionMediBeanInTempTable(
			ConditionMediBean conditionMediBean) throws SQLException {
		int flag = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlFenerateConditionMediUtil
				.generateUpdateProjConditionTempSql(conditionMediBean);
		log.debug("___________" + sqlStr);

		flag = erpDataSource.executeUpdate(sqlStr);

		if (log.isDebugEnabled()) {
			log.debug("ConditionMediDaoִ��Update������Ӱ������" + flag + "___Sql:"
					+ sqlStr);
		}
		// 3.�ر���Դ
		erpDataSource.close();

		// 5.����
		return flag;
	}

	/**
	 * �ж�proj_id\doc_id ��proj_condition_temp�Ƿ���ڣ����ڷ���upd�������ڷ���add
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public String judgeItemExist(String proj_id, String doc_id)
			throws SQLException {
		String resultVal = "";
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from proj_condition_medi_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			resultVal = "upd";
		} else {
			resultVal = "add";
		}
		// 3.�ر���Դ
		erpDataSource.close();

		return resultVal;
	}

	/**
	 * ����proj_id\doc_id��proj_condition_temp�������Լ��ص�Bean
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

		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlFenerateConditionMediUtil.generateSelectCondTemp(
				proj_id, doc_id);
		log.info("��Ҫ������" + sqlStr);
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
			System.out.println("��Ҫ�������:111111111111111");
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
			System.out.println("��Ҫ�������:222222222222222222222");
			// ==55==
			conditionMediBean.setRent_start_date(rs
					.getString("rent_start_date"));
			conditionMediBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// conditionMediBean.setAmt_return(rs.getString("amt_return"));
			conditionMediBean.setInsure_type(rs.getString("insure_type"));
			conditionMediBean.setInsure_money(rs.getString("insure_money"));
			System.out.println("��Ҫ�������:3333333333333333");
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
			System.out.println("��Ҫ�������:444444444444444");
			// 2012-03-28 Jaffe Add
			conditionMediBean.setRate_float_type(rs
					.getString("rate_float_type"));
			System.out.println("��Ҫ�������:00000000000");
			conditionMediBean.setRate_float_amt(String.valueOf(Double.parseDouble(rs.getString("rate_float_amt"))));
			System.out.println("��Ҫ�������:555555555555");
			conditionMediBean.setAdjust_style(rs.getString("adjust_style"));
			
			conditionMediBean.setInto_batch(rs.getString("into_batch"));
			conditionMediBean.setIs_open(rs.getString("is_open"));
			conditionMediBean.setSettle_method(rs.getString("settle_method"));
			
			conditionMediBean.setPeriod_type(rs.getString("period_type"));
			conditionMediBean.setYear_rate(rs.getString("year_rate"));
			conditionMediBean.setRatio_param(rs.getString("ratio_param"));

			log.debug("��Ҫ��" + conditionMediBean.getIs_floor());
		}

		// 3.�ر���Դ
		erpDataSource.close();

		return conditionMediBean;
	}

	/**
	 * ����proj_condition_temp��plan_irr
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @param markirr
	 * @return
	 * @throws SQLException
	 */
	public int updateConditionTempPlanIrrOper(String proj_id, String doc_id,
			String markirr) throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "update proj_condition_temp set plan_irr=" + markirr
				+ " where proj_id='" + proj_id + "' and doc_id = '" + doc_id
				+ "' ";
		sqlStr += " update proj_condition_temp set irr=" + markirr
				+ " where proj_id='" + proj_id + "' and doc_id = '" + doc_id
				+ "' and isnull(irr,0)<=0";

		int res = erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
		return res;
	}

	/**
	 * ɾ��ָ���Ľ��׽ṹ��ʱ������
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void delProjConditionTempData(String proj_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "delete from proj_condition_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";
		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ���̳�ʼ���ж������Ƿ����
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeDataExist(String proj_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from proj_condition_Medi_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * ���̳�ʼ��Proj_condition_temp������
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2Temp(String proj_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
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
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * �ж������Ƿ����
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeItemContractExist(String contract_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from contract_condition_medi_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * ���ݿ���
	 * 
	 * @param contract_id
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTemp(String contract_id, String proj_id,
			String doc_id) throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
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
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ���غ�ͬ���׽ṹ
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

		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlFenerateConditionMediUtil
				.generateSelectCondContractTemp(contract_id, doc_id);
		log.info("��Ҫ�������ͬ" + sqlStr);
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
			//����2012-03-29
			conditionMediBean.setSettle_method(rs.getString("settle_method"));
			conditionMediBean.setRate_float_type(rs.getString("rate_float_type"));
			conditionMediBean.setRate_float_amt(String.valueOf(Double.parseDouble(rs.getString("rate_float_amt"))));
			//2012-03-29
			conditionMediBean.setRatio_param(rs.getString("ratio_param"));
			conditionMediBean.setAdjust_style(rs.getString("adjust_style"));
			conditionMediBean.setInto_batch(rs.getString("into_batch"));
			conditionMediBean.setIs_open(rs.getString("is_open"));

		}
		// 3.�ر���Դ
		erpDataSource.close();

		return conditionMediBean;
	}

	/**
	 * ���غ�ͬ���׽ṹ - ��ʽ
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */

	public ConditionMediBean loadFactConditionContractBeanByKey(
			String contract_id) throws SQLException {
		ConditionMediBean conditionMediBean = new ConditionMediBean();
		conditionMediBean.setContract_id(contract_id);

		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
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
		// 3.�ر���Դ
		erpDataSource.close();

		return conditionMediBean;
	}

	/**
	 * �޸ĺ�ͬ���׽ṹ��ʱ��
	 * 
	 * @param conditionMediBean
	 * @return
	 * @throws SQLException
	 */
	public int updateConditionContractBeanInTempTable(
			ConditionMediBean conditionMediBean) throws SQLException {
		int flag = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlFenerateConditionMediUtil
				.generateUpdateProjConditionContractTempSql(conditionMediBean);
		log.info("��Ҫ�ø��£�" + sqlStr);
		flag = erpDataSource.executeUpdate(sqlStr);

		if (log.isDebugEnabled()) {
			log.debug("ConditionMediDaoִ��Update������Ӱ������" + flag + "___Sql:"
					+ sqlStr);
		}
		// 3.�ر���Դ
		erpDataSource.close();

		// 5.����
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
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "update contract_condition_temp set plan_irr="
				+ markirr + " where contract_id='" + contract_id
				+ "' and doc_id = '" + doc_id + "' ";
		int res = erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
		return res;
	}

	/**
	 * ɾ����ͬ���׽ṹ��ʱ��
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void delProjConditionContractTempData(String contract_id,
			String doc_id) throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "delete from contract_condition_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";
		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * �����ͬ���׽ṹ��ʱ��
	 * 
	 * @param conditionMediBean
	 * @return
	 * @throws SQLException
	 */
	public int insertConditionContractBeanIntoTempTable(
			ConditionMediBean conditionMediBean) throws SQLException {
		int flag = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlFenerateConditionMediUtil
				.generateInsertProjConditionContractTempSql(conditionMediBean);

		LogWriter.logDebug("ConditionMediDaoִ�в�����Ӱ������" + flag + "___Sql:"
				+ sqlStr);
		flag = erpDataSource.executeUpdate(sqlStr);

		// 3.�ر���Դ
		erpDataSource.close();

		// 5.����
		return flag;
	}

	/**
	 * �жϺ�ͬϵ�б��������Ƿ����
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeContractDataExist(String contract_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from contract_condition_medi_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * ��ͬ���׽ṹ���ݿ���
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTemp(String contract_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
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
		System.out.print("��Ҫ��" + sqlStr);
		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();

	}

	/**
	 * ɾ����Ŀ���׽ṹ��ʱ��
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteProjConditionTempData(String proj_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "Delete from proj_condition_medi_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";
		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ͨ��ContractId���ص�Bean
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */
	public ConditionMediBean loadConditionContractBeanByContractId(
			String contract_id) throws SQLException {
		ConditionMediBean conditionMediBean = new ConditionMediBean();
		conditionMediBean.setContract_id(contract_id);

		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
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
		// 3.�ر���Դ
		erpDataSource.close();

		return conditionMediBean;
	}

	/**
	 * �ж�[Begin_info_temp�Ƿ��������]
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
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from begin_info_medi_temp where contract_id='"
				+ contract_id
				+ "' and begin_id='"
				+ begin_id
				+ "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);

		flag = rs.next();

		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * ����[begin_info]������[begin_info_temp]
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyBeginData2Temp(String contract_id, String begin_id,
			String doc_id) throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
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

		LogWriter.logSqlStr("����� -> ���ݿ���", sqlStr);
		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * �жϵ�ǰ��ͬ�Ƿ�������
	 * 
	 * @param contractId
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeBeginType(String contractId) throws SQLException {
		boolean resultVal = false;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "Select id from contract_begin_info_medi where contract_id='"
				+ contractId + "' and is_more='��'";

		rs = erpDataSource.executeQuery(sqlStr);

		resultVal = rs.next();

		// 3.�ر���Դ
		erpDataSource.close();

		return resultVal;
	}

	/**
	 * �������̳�ʼ��ǩԼ�������ݵ�����[begin_info_temp]��Ϣ
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyContract2BeginData2Temp(String contract_id,
			String begin_id, String doc_id) throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
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

		LogWriter.logSqlStr("�������� ->һ���������ݳ�ʼ��", sqlStr);

		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ��ѯ��Ŀ��ʹ����Ŀ���
	 * 
	 * @param contractId
	 * @return
	 * @throws SQLException
	 */
	public String getUsedMoney(String contractId) throws SQLException {
		String usedMoney = "";
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "Select [dbo].[T_getSumEquipAmt]('" + contractId
				+ "') as used_money";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			usedMoney = rs.getString("used_money");
		}

		// 3.�ر���Դ
		erpDataSource.close();

		return usedMoney;
	}
}