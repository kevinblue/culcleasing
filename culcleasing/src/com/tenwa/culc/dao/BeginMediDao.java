/**
 * com.tenwa.culc.dao
 */
package com.tenwa.culc.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import com.tenwa.culc.bean.BeginInfoMediBean;
import com.tenwa.culc.service.SqlFenerateConditionMediUtil;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.log.LogWriter;

/**
 * 起租信息Dao操作
 * 
 * @author Jaffe
 * 
 *         Date:Jul 25, 2011 8:20:09 PM Email:JaffeHe@hotmail.com
 */
public class BeginMediDao {

	// 公共参数
	private ResultSet rs = null;

	/**
	 * 删除起租信息数据
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteBeginInfoTempData(String begin_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行删除
		String sqlStr = SqlFenerateConditionMediUtil
				.generateDelBeginInfoTempData(begin_id, doc_id);
		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 数据插入Begin_info_Medi_temp表
	 * 
	 * @param beginInfoMediBean
	 * @return
	 * @throws SQLException
	 */
	public int insertBeginBeanIntoTempTable(BeginInfoMediBean beginInfomediBean)
			throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlFenerateConditionMediUtil
				.generateInsertBeginInfoTempSql(beginInfomediBean);
		LogWriter.logDebug("你妹妹么萨达萨达" + sqlStr);
		flag = erpDataSource.executeUpdate(sqlStr);
		LogWriter.logDebug("BeginDao执行操作，影响结果：" + flag + "___Sql:" + sqlStr);

		// 3.关闭资源
		erpDataSource.close();

		// 5.返回
		return flag;
	}

	/**
	 * 判断begin_info_temp表中数据是否存在
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public String judgeItemExist(String begin_id, String doc_id)
			throws SQLException {
		String resultVal = "";
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();
		// 2.拼接sql，执行插入
		String sqlStr = "select id from begin_info_Medi_temp where begin_id='"
				+ begin_id + "' and doc_id='" + doc_id + "'";

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
	 * 判断begin_info_temp表中数据是否存在
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public String judgeItemExist1(String begin_id)
			throws SQLException {
		String resultVal = "";
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from begin_info_Medi where begin_id='"
				+ begin_id + "'";

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
	 * 加载BeginInfoBean
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public BeginInfoMediBean loadBeginInfoBeanByKey(String begin_id,
			String doc_id) throws SQLException {
		LogWriter.logDebug("进入到了loadBeginInfoBeanByKey");
		BeginInfoMediBean beginInfomediBean = new BeginInfoMediBean();
		LogWriter.logDebug("1ghg");
		beginInfomediBean.setBegin_id(begin_id);
		LogWriter.logDebug("2ghgh");
		beginInfomediBean.setDoc_id(doc_id);
		LogWriter.logDebug("3ghgh");

		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		LogWriter.logDebug("进入到插入SqlFenerateConditionMediUtil");
		String sqlStr = SqlFenerateConditionMediUtil
				.generateSelectBeginInfoTemp(begin_id, doc_id);
		LogWriter.logDebug("查询sql"+sqlStr);
		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			beginInfomediBean.setContract_id(rs.getString("contract_id"));
			beginInfomediBean.setDoc_id(rs.getString("doc_id"));
			beginInfomediBean.setBegin_id(rs.getString("begin_id"));

			beginInfomediBean.setEquip_amt(rs.getString("equip_amt"));
			beginInfomediBean.setCurrency(rs.getString("currency"));
			beginInfomediBean.setLease_money(rs.getString("lease_money"));
			beginInfomediBean.setFirst_payment(rs.getString("first_payment"));
			beginInfomediBean.setCaution_money(rs.getString("caution_money"));

			beginInfomediBean.setActual_fund(rs.getString("actual_fund"));
			beginInfomediBean.setCaution_deduction_money(rs.getString("caution_deduction_money"));
			beginInfomediBean.setActual_fund(rs.getString("actual_fund"));
			beginInfomediBean.setHandling_charge(rs
					.getString("handling_charge"));

			// ===22==return_amt
			beginInfomediBean.setManagement_fee(rs.getString("management_fee"));
			beginInfomediBean.setNominalprice(rs.getString("nominalprice"));
			beginInfomediBean.setReturn_amt(rs.getString("return_amt"));
			beginInfomediBean.setRate_subsidy(rs.getString("rate_subsidy"));

			beginInfomediBean.setBefore_interest(rs
					.getString("before_interest"));
			beginInfomediBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			beginInfomediBean.setDiscount_rate(rs.getString("discount_rate"));
			beginInfomediBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));

			// ==33==
			beginInfomediBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			beginInfomediBean.setOther_income(rs.getString("other_income"));
			beginInfomediBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			beginInfomediBean.setIncome_number(rs.getString("income_number"));
			beginInfomediBean.setIncome_number_year(rs
					.getString("income_number_year"));

			beginInfomediBean.setLease_term(rs.getString("lease_term"));
			// beginInfomediBean.setYear_rate(rs.getString("year_rate"));
			beginInfomediBean.setPena_rate(rs.getString("pena_rate"));
			beginInfomediBean.setStart_date(rs.getString("start_date"));

			beginInfomediBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			beginInfomediBean.setRent_start_date(rs
					.getString("rent_start_date"));
			beginInfomediBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// beginInfomediBean.setAmt_return(rs.getString("amt_return"));
			beginInfomediBean.setInsure_type(rs.getString("insure_type"));
			beginInfomediBean.setInsure_money(rs.getString("insure_money"));

			// ==66==
			beginInfomediBean.setInsure_pay_type(rs
					.getString("Insure_pay_type"));
			beginInfomediBean.setIs_floor(rs.getString("is_floor"));
			beginInfomediBean.setFloor_rent(rs.getString("floor_rent"));
			beginInfomediBean.setManager_pay_type(rs
					.getString("manager_pay_type"));
			beginInfomediBean.setCreator(rs.getString("creator"));
			beginInfomediBean.setModify_date(rs.getString("modify_date"));
			beginInfomediBean.setModificator(rs.getString("modificator"));
			beginInfomediBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			beginInfomediBean.setPlan_bank_name(rs.getString("plan_bank_name"));
			beginInfomediBean.setPlan_bank_no(rs.getString("plan_bank_no"));
			beginInfomediBean.setBegin_order_index(rs.getString("begin_order_index"));
		}
		// 3.关闭资源
		erpDataSource.close();
		return beginInfomediBean;
	}
	/**
	 * 加载BeginInfoBean
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public BeginInfoMediBean loadBeginInfoBeanByKey1(String begin_id) throws SQLException {
		LogWriter.logDebug("进入到了loadBeginInfoBeanByKey");
		BeginInfoMediBean beginInfomediBean = new BeginInfoMediBean();
		LogWriter.logDebug("1ghg");
		beginInfomediBean.setBegin_id(begin_id);
		LogWriter.logDebug("2ghgh");


		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		LogWriter.logDebug("进入到插入SqlFenerateConditionMediUtil");
		String sqlStr = SqlFenerateConditionMediUtil
				.generateSelectBeginInfo(begin_id);
		LogWriter.logDebug("查询sql"+sqlStr);
		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			beginInfomediBean.setContract_id(rs.getString("contract_id"));
			beginInfomediBean.setBegin_id(rs.getString("begin_id"));

			beginInfomediBean.setEquip_amt(rs.getString("equip_amt"));
			beginInfomediBean.setCurrency(rs.getString("currency"));
			beginInfomediBean.setLease_money(rs.getString("lease_money"));
			beginInfomediBean.setFirst_payment(rs.getString("first_payment"));
			beginInfomediBean.setCaution_money(rs.getString("caution_money"));

			beginInfomediBean.setActual_fund(rs.getString("actual_fund"));
			beginInfomediBean.setCaution_deduction_money(rs.getString("caution_deduction_money"));
			beginInfomediBean.setActual_fund(rs.getString("actual_fund"));
			beginInfomediBean.setHandling_charge(rs
					.getString("handling_charge"));

			// ===22==return_amt
			beginInfomediBean.setManagement_fee(rs.getString("management_fee"));
			beginInfomediBean.setNominalprice(rs.getString("nominalprice"));
			beginInfomediBean.setReturn_amt(rs.getString("return_amt"));
			beginInfomediBean.setRate_subsidy(rs.getString("rate_subsidy"));

			beginInfomediBean.setBefore_interest(rs
					.getString("before_interest"));
			beginInfomediBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			beginInfomediBean.setDiscount_rate(rs.getString("discount_rate"));
			beginInfomediBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));

			// ==33==
			beginInfomediBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			beginInfomediBean.setOther_income(rs.getString("other_income"));
			beginInfomediBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			beginInfomediBean.setIncome_number(rs.getString("income_number"));
			beginInfomediBean.setIncome_number_year(rs
					.getString("income_number_year"));

			beginInfomediBean.setLease_term(rs.getString("lease_term"));
			// beginInfomediBean.setYear_rate(rs.getString("year_rate"));
			beginInfomediBean.setPena_rate(rs.getString("pena_rate"));
			beginInfomediBean.setStart_date(rs.getString("start_date"));

			beginInfomediBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			beginInfomediBean.setRent_start_date(rs
					.getString("rent_start_date"));
			beginInfomediBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// beginInfomediBean.setAmt_return(rs.getString("amt_return"));
			beginInfomediBean.setInsure_type(rs.getString("insure_type"));
			beginInfomediBean.setInsure_money(rs.getString("insure_money"));

			// ==66==
			beginInfomediBean.setInsure_pay_type(rs
					.getString("Insure_pay_type"));
			beginInfomediBean.setIs_floor(rs.getString("is_floor"));
			beginInfomediBean.setFloor_rent(rs.getString("floor_rent"));
			beginInfomediBean.setManager_pay_type(rs
					.getString("manager_pay_type"));
			beginInfomediBean.setCreator(rs.getString("creator"));
			beginInfomediBean.setModify_date(rs.getString("modify_date"));
			beginInfomediBean.setModificator(rs.getString("modificator"));
			beginInfomediBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			beginInfomediBean.setPlan_bank_name(rs.getString("plan_bank_name"));
			beginInfomediBean.setPlan_bank_no(rs.getString("plan_bank_no"));
			beginInfomediBean.setBegin_order_index(rs.getString("begin_order_index"));
		}
		// 3.关闭资源
		erpDataSource.close();

		return beginInfomediBean;
	}

	/**
	 * 该合同租赁本金
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */
	public String selectTotalLeaseMoney(String contract_id) throws SQLException {
		String resultVal = "";
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select lease_money from contract_condition_medi where contract_id='"
				+ contract_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			resultVal = rs.getString("lease_money");
		} else {
			resultVal = "0";
		}
		// 3.关闭资源
		erpDataSource.close();

		return resultVal;
	}

	/**
	 * 该合同已起租的租赁本金
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */
	public String selectUsedLeaseMoney(String contract_id) throws SQLException {
		String resultVal = "";
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select isnull(sum(isnull(lease_money,0)),0) as used_lease_money from begin_info_medi where contract_id='"
				+ contract_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			resultVal = rs.getString("used_lease_money");
		} else {
			resultVal = "0";
		}
		// 3.关闭资源
		erpDataSource.close();

		return resultVal;
	}

	/**
	 * 该合同已起租的租赁本金
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */
	public String selectUsedLeaseMoneyB(String contract_id, String flow_date)
			throws SQLException {
		String resultVal = "";
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select isnull(sum(isnull(lease_money,0)),0) as used_lease_money from begin_info_medi where contract_id='"
				+ contract_id
				+ "' and convert(varchar(19),create_date,21)<convert(varchar(19),'"
				+ flow_date + "',21) ";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			resultVal = rs.getString("used_lease_money");
		} else {
			resultVal = "0";
		}
		// 3.关闭资源
		erpDataSource.close();

		return resultVal;
	}

	/**
	 * 更新Begin_info_temp表中plan_irr字段
	 * 
	 * @param pri_id
	 * @param doc_id
	 * @param irr
	 * @return
	 * @throws SQLException
	 */
	// public int updateBeginInfoTempPlanIrrOper(String pri_id, String doc_id,
	// String irr) throws SQLException {
	// // 1.获取连接、会话
	// conn = hostDataSource.getConnection();
	// stmt = conn.createStatement();
	//
	// // 2.拼接sql，执行插入
	// String sqlStr = "Update begin_info_medi_temp set plan_irr=" + irr
	// + " where begin_id='" + pri_id + "' and doc_id = '" + doc_id
	// + "' ";
	// int res = stmt.executeUpdate(sqlStr);
	// // 3.关闭资源
	// erpDataSource.close();
	// return res;
	// }

	/**
	 * 历史起租信息Bean
	 * 
	 * @param begin_id
	 * @return
	 * @throws SQLException
	 */
	public BeginInfoMediBean loadBeginInfoHisBeanByKey(String begin_id)
			throws SQLException {
		BeginInfoMediBean beginInfomediBean = new BeginInfoMediBean();
		beginInfomediBean.setBegin_id(begin_id);

		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlFenerateConditionMediUtil
				.generateSelectBeginInfoHis(begin_id);

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			beginInfomediBean.setContract_id(rs.getString("contract_id"));
			beginInfomediBean.setDoc_id(rs.getString("docId"));
			beginInfomediBean.setBegin_id(rs.getString("beginId"));
			beginInfomediBean.setEquip_amt(rs.getString("equip_amt"));
			beginInfomediBean.setCurrency(rs.getString("currency"));
			beginInfomediBean.setLease_money(rs.getString("lease_money"));
			beginInfomediBean.setFirst_payment(rs.getString("first_payment"));
			beginInfomediBean.setCaution_money(rs.getString("caution_money"));

			beginInfomediBean.setActual_fund(rs.getString("actual_fund"));
			beginInfomediBean.setCaution_deduction_money(rs
					.getString("caution_deduction_money"));
			beginInfomediBean.setActual_fund(rs.getString("actual_fund"));
			beginInfomediBean.setHandling_charge(rs
					.getString("handling_charge"));

			// ===22==return_amt
			beginInfomediBean.setManagement_fee(rs.getString("management_fee"));
			beginInfomediBean.setNominalprice(rs.getString("nominalprice"));
			beginInfomediBean.setReturn_amt(rs.getString("return_amt"));
			beginInfomediBean.setRate_subsidy(rs.getString("rate_subsidy"));

			beginInfomediBean.setBefore_interest(rs
					.getString("before_interest"));
			beginInfomediBean.setBefore_interest_type(rs
					.getString("before_interest_type"));
			beginInfomediBean.setDiscount_rate(rs.getString("discount_rate"));
			beginInfomediBean.setConsulting_fee_out(rs
					.getString("consulting_fee_out"));

			// ==33==
			beginInfomediBean.setConsulting_fee_in(rs
					.getString("consulting_fee_in"));
			beginInfomediBean.setOther_income(rs.getString("other_income"));
			beginInfomediBean.setOther_expenditure(rs
					.getString("other_expenditure"));
			beginInfomediBean.setIncome_number(rs.getString("income_number"));
			beginInfomediBean.setIncome_number_year(rs
					.getString("income_number_year"));

			beginInfomediBean.setLease_term(rs.getString("lease_term"));
			// beginInfomediBean.setYear_rate(rs.getString("year_rate"));
			beginInfomediBean.setPena_rate(rs.getString("pena_rate"));
			beginInfomediBean.setStart_date(rs.getString("start_date"));

			beginInfomediBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			beginInfomediBean.setRent_start_date(rs
					.getString("rent_start_date"));
			beginInfomediBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			// beginInfomediBean.setAmt_return(rs.getString("amt_return"));
			beginInfomediBean.setInsure_type(rs.getString("insure_type"));
			beginInfomediBean.setInsure_money(rs.getString("insure_money"));

			// ==66==
			beginInfomediBean.setInsure_pay_type(rs
					.getString("Insure_pay_type"));
			beginInfomediBean.setIs_floor(rs.getString("is_floor"));
			beginInfomediBean.setFloor_rent(rs.getString("floor_rent"));
			beginInfomediBean.setManager_pay_type(rs
					.getString("manager_pay_type"));
			beginInfomediBean.setCreator(rs.getString("creator"));
			beginInfomediBean.setModify_date(rs.getString("modify_date"));
			beginInfomediBean.setModificator(rs.getString("modificator"));
			beginInfomediBean.setActual_fund_ratio(rs
					.getString("actual_fund_ratio"));
			beginInfomediBean.setPlan_bank_name(rs.getString("plan_bank_name"));
			beginInfomediBean.setPlan_bank_no(rs.getString("plan_bank_no"));
			beginInfomediBean.setBegin_order_index(rs.getString("begin_order_index"));
		}
		// 3.关闭资源
		erpDataSource.close();

		return beginInfomediBean;
	}

	/**
	 * 删除Begin_info_temp表数据
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void delBeginInfoTempData(String contract_id, String begin_id,
			String doc_id) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "Delete from begin_info_medi_temp where contract_id='"
				+ contract_id + "' and begin_id='" + begin_id
				+ "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 保存数据到begin_info_temp表
	 * 
	 * @param beginInfoBean
	 * @return
	 * @throws SQLException
	 */
	public int insertBean2BeginIntoTempTable(BeginInfoMediBean beginInfomediBean)
			throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlFenerateConditionMediUtil
				.generateInsertUploadBeginInfoTempSql(beginInfomediBean);

		LogWriter.logSqlStr("起租流程 - >上传保存begin_info_temp", sqlStr);
		flag = erpDataSource.executeUpdate(sqlStr);
		LogWriter.logDebug("起租上传，BeginDao执行操作，影响结果：" + flag + "___Sql:"
				+ sqlStr);

		// 3.关闭资源
		erpDataSource.close();

		// 5.返回
		return flag;
	}

	/**
	 * 查询合同起租序列号
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */
	public int selectBeginOrderIndex(String contract_id) throws SQLException {
		int resultVal = 1;
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "Select isnull(count(id),0)+1 as order_index from begin_info_medi where contract_id='"
				+ contract_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			resultVal = rs.getInt("order_index");
		} else {
			resultVal = 1;
		}
		// 3.关闭资源
		erpDataSource.close();

		return resultVal;
	}
}
