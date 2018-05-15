/**
 * com.tenwa.culc.dao
 */
package com.tenwa.culc.dao1;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.tenwa.culc.bean.BeginInfoBean;
import com.tenwa.culc.bean.ConditionBean;
import com.tenwa.culc.service.SqlGenerateUtil;
import com.tenwa.culc.service1.SqlGenerateUtil1;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.log.LogWriter;

/**
 * 起租信息Dao操作
 * 
 * @author Jaffe
 * 
 * Date:Jul 25, 2011 8:20:09 PM Email:JaffeHe@hotmail.com
 */
public class BeginDao1 {

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

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil.generateDelBeginInfoTempData(begin_id,
				doc_id);
		erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 数据插入Begin_info_temp表
	 * 
	 * @param beginInfoBean
	 * @return
	 * @throws SQLException
	 */
	public int insertBeginBeanIntoTempTable(BeginInfoBean beginInfoBean)
			throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil
				.generateInsertBeginInfoTempSql(beginInfoBean);
		LogWriter.logDebug("你妹妹么萨达萨达"+sqlStr);
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
		String sqlStr = "select id from begin_info_temp where begin_id='"
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
	 * 加载BeginInfoBean
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public BeginInfoBean loadBeginInfoBeanByKey(BeginInfoBean beginInfoBean)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil1.generateSelectBeginInfoTemp(beginInfoBean);

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			beginInfoBean.setTax_type(rs.getString("tax_type"));
			beginInfoBean.setTax_type_invoice(rs.getString("tax_type_invoice"));
		}
		// 3.关闭资源
		erpDataSource.close();

		return beginInfoBean;
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
		String sqlStr = "select lease_money from contract_condition where contract_id='"
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
		String sqlStr = "select isnull(sum(isnull(lease_money,0)),0) as used_lease_money from begin_info where contract_id='"
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
	public String selectUsedLeaseMoneyB(String contract_id, String flow_date) throws SQLException {
		String resultVal = "";
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select isnull(sum(isnull(lease_money,0)),0) as used_lease_money from begin_info where contract_id='"
				+ contract_id + "' and convert(varchar(19),create_date,21)<convert(varchar(19),'"+flow_date+"',21) ";

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
	public int updateBeginInfoTempPlanIrrOper(String pri_id, String doc_id,
			String irr) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "Update begin_info_temp set plan_irr=" + irr
				+ " where begin_id='" + pri_id + "' and doc_id = '" + doc_id
				+ "' ";
		int res = erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
		return res;
	}

	/**
	 * 历史起租信息Bean
	 * 
	 * @param begin_id
	 * @return
	 * @throws SQLException
	 */
	public BeginInfoBean loadBeginInfoHisBeanByKey(String begin_id)
			throws SQLException {
		BeginInfoBean beginInfoBean = new BeginInfoBean();
		beginInfoBean.setBegin_id(begin_id);

		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil.generateSelectBeginInfoHis(begin_id);

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			beginInfoBean.setContract_id(rs.getString("contract_id"));
			beginInfoBean.setEquip_amt(rs.getString("equip_amt"));
			beginInfoBean.setCurrency(rs.getString("currency"));
			beginInfoBean.setLease_money(rs.getString("lease_money"));
			// ==22==
			beginInfoBean.setActual_fund(rs.getString("actual_fund"));
			beginInfoBean.setAssets_value(rs.getString("assets_value"));
			beginInfoBean.setPlan_bank_name(rs.getString("plan_bank_name"));
			beginInfoBean.setPlan_bank_no(rs.getString("plan_bank_no"));
			// ==33==
			beginInfoBean.setIncome_number(rs.getString("income_number"));
			beginInfoBean.setIncome_number_year(rs
					.getString("income_number_year"));
			beginInfoBean.setLease_term(rs.getString("lease_term"));
			beginInfoBean.setSettle_method(rs.getString("settle_method"));
			beginInfoBean.setPeriod_type(rs.getString("period_type"));
			// ==44==
			beginInfoBean.setRate_float_type(rs.getString("rate_float_type"));
			beginInfoBean.setRate_float_amt(rs.getString("rate_float_amt"));
			beginInfoBean.setAdjust_style(rs.getString("adjust_style"));
			beginInfoBean.setIs_open(rs.getString("is_open"));
			beginInfoBean.setRatio_param(rs.getString("ratio_param"));
			beginInfoBean.setYear_rate(rs.getString("year_rate"));
			beginInfoBean.setPena_rate(rs.getString("pena_rate"));
			beginInfoBean.setStart_date(rs.getString("start_date"));
			beginInfoBean.setIncome_day(rs.getString("income_day"));
			// ==55==
			beginInfoBean.setEnd_date(rs.getString("end_date"));
			beginInfoBean.setRent_start_date(rs.getString("rent_start_date"));
			beginInfoBean.setFree_defa_inter_day(rs
					.getString("free_defa_inter_day"));
			beginInfoBean.setPlan_irr(rs.getString("plan_irr"));
			beginInfoBean.setFact_irr(rs.getString("fact_irr"));
			beginInfoBean.setInvoice_type(rs.getString("invoice_type"));
			beginInfoBean.setInto_batch(rs.getString("into_batch"));
		}
		// 3.关闭资源
		erpDataSource.close();

		return beginInfoBean;
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
		String sqlStr = "Delete from begin_info_temp where contract_id='"
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
	public int insertBean2BeginIntoTempTable(BeginInfoBean beginInfoBean)
			throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();
		// 2.拼接sql，执行插入
		String sqlStr = SqlGenerateUtil
				.generateInsertUploadBeginInfoTempSql(beginInfoBean);

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
		String sqlStr = "Select isnull(count(id),0)+1 as order_index from begin_info where contract_id='"
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
	/**
	 * 更新tax_type字段
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public int updateTaxTypeToBeginTemp(BeginInfoBean beginInfoBean)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder.append("update begin_info_temp set tax_type='"
				+ beginInfoBean.getTax_type() + "' where contract_id='"
				+ beginInfoBean.getContract_id() + "' and doc_id='"
				+ beginInfoBean.getDoc_id() + "' and begin_id='"+beginInfoBean.getBegin_id()+"'");
		sqlStr = sqlBuilder.toString();
		System.out.println("sssss" + sqlStr);
		int res = erpDataSource.executeUpdate(sqlStr);
		// 3.关闭资源
		erpDataSource.close();
		return res;

	}

}
