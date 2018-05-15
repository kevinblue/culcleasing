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
 * ������ϢDao����
 * 
 * @author Jaffe
 * 
 * Date:Jul 25, 2011 8:20:09 PM Email:JaffeHe@hotmail.com
 */
public class BeginDao1 {

	// ��������
	private ResultSet rs = null;

	/**
	 * ɾ��������Ϣ����
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteBeginInfoTempData(String begin_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlGenerateUtil.generateDelBeginInfoTempData(begin_id,
				doc_id);
		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ���ݲ���Begin_info_temp��
	 * 
	 * @param beginInfoBean
	 * @return
	 * @throws SQLException
	 */
	public int insertBeginBeanIntoTempTable(BeginInfoBean beginInfoBean)
			throws SQLException {
		int flag = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlGenerateUtil
				.generateInsertBeginInfoTempSql(beginInfoBean);
		LogWriter.logDebug("������ô��������"+sqlStr);
		flag = erpDataSource.executeUpdate(sqlStr);
		LogWriter.logDebug("BeginDaoִ�в�����Ӱ������" + flag + "___Sql:" + sqlStr);

		// 3.�ر���Դ
		erpDataSource.close();

		// 5.����
		return flag;
	}

	/**
	 * �ж�begin_info_temp���������Ƿ����
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public String judgeItemExist(String begin_id, String doc_id)
			throws SQLException {
		String resultVal = "";
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from begin_info_temp where begin_id='"
				+ begin_id + "' and doc_id='" + doc_id + "'";

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
	 * ����BeginInfoBean
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public BeginInfoBean loadBeginInfoBeanByKey(BeginInfoBean beginInfoBean)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlGenerateUtil1.generateSelectBeginInfoTemp(beginInfoBean);

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			beginInfoBean.setTax_type(rs.getString("tax_type"));
			beginInfoBean.setTax_type_invoice(rs.getString("tax_type_invoice"));
		}
		// 3.�ر���Դ
		erpDataSource.close();

		return beginInfoBean;
	}

	/**
	 * �ú�ͬ���ޱ���
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */
	public String selectTotalLeaseMoney(String contract_id) throws SQLException {
		String resultVal = "";
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select lease_money from contract_condition where contract_id='"
				+ contract_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			resultVal = rs.getString("lease_money");
		} else {
			resultVal = "0";
		}
		// 3.�ر���Դ
		erpDataSource.close();
		return resultVal;
	}

	/**
	 * �ú�ͬ����������ޱ���
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */
	public String selectUsedLeaseMoney(String contract_id) throws SQLException {
		String resultVal = "";
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select isnull(sum(isnull(lease_money,0)),0) as used_lease_money from begin_info where contract_id='"
				+ contract_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			resultVal = rs.getString("used_lease_money");
		} else {
			resultVal = "0";
		}
		// 3.�ر���Դ
		erpDataSource.close();

		return resultVal;
	}
	
	/**
	 * �ú�ͬ����������ޱ���
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */
	public String selectUsedLeaseMoneyB(String contract_id, String flow_date) throws SQLException {
		String resultVal = "";
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select isnull(sum(isnull(lease_money,0)),0) as used_lease_money from begin_info where contract_id='"
				+ contract_id + "' and convert(varchar(19),create_date,21)<convert(varchar(19),'"+flow_date+"',21) ";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			resultVal = rs.getString("used_lease_money");
		} else {
			resultVal = "0";
		}
		// 3.�ر���Դ
		erpDataSource.close();
		return resultVal;
	}

	/**
	 * ����Begin_info_temp����plan_irr�ֶ�
	 * 
	 * @param pri_id
	 * @param doc_id
	 * @param irr
	 * @return
	 * @throws SQLException
	 */
	public int updateBeginInfoTempPlanIrrOper(String pri_id, String doc_id,
			String irr) throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "Update begin_info_temp set plan_irr=" + irr
				+ " where begin_id='" + pri_id + "' and doc_id = '" + doc_id
				+ "' ";
		int res = erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
		return res;
	}

	/**
	 * ��ʷ������ϢBean
	 * 
	 * @param begin_id
	 * @return
	 * @throws SQLException
	 */
	public BeginInfoBean loadBeginInfoHisBeanByKey(String begin_id)
			throws SQLException {
		BeginInfoBean beginInfoBean = new BeginInfoBean();
		beginInfoBean.setBegin_id(begin_id);

		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
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
		// 3.�ر���Դ
		erpDataSource.close();

		return beginInfoBean;
	}

	/**
	 * ɾ��Begin_info_temp������
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void delBeginInfoTempData(String contract_id, String begin_id,
			String doc_id) throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "Delete from begin_info_temp where contract_id='"
				+ contract_id + "' and begin_id='" + begin_id
				+ "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * �������ݵ�begin_info_temp��
	 * 
	 * @param beginInfoBean
	 * @return
	 * @throws SQLException
	 */
	public int insertBean2BeginIntoTempTable(BeginInfoBean beginInfoBean)
			throws SQLException {
		int flag = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();
		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlGenerateUtil
				.generateInsertUploadBeginInfoTempSql(beginInfoBean);

		LogWriter.logSqlStr("�������� - >�ϴ�����begin_info_temp", sqlStr);
		flag = erpDataSource.executeUpdate(sqlStr);
		LogWriter.logDebug("�����ϴ���BeginDaoִ�в�����Ӱ������" + flag + "___Sql:"
				+ sqlStr);

		// 3.�ر���Դ
		erpDataSource.close();

		// 5.����
		return flag;
	}

	/**
	 * ��ѯ��ͬ�������к�
	 * 
	 * @param contract_id
	 * @return
	 * @throws SQLException
	 */
	public int selectBeginOrderIndex(String contract_id) throws SQLException {
		int resultVal = 1;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "Select isnull(count(id),0)+1 as order_index from begin_info where contract_id='"
				+ contract_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			resultVal = rs.getInt("order_index");
		} else {
			resultVal = 1;
		}
		// 3.�ر���Դ
		erpDataSource.close();

		return resultVal;
	}
	/**
	 * ����tax_type�ֶ�
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public int updateTaxTypeToBeginTemp(BeginInfoBean beginInfoBean)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder.append("update begin_info_temp set tax_type='"
				+ beginInfoBean.getTax_type() + "' where contract_id='"
				+ beginInfoBean.getContract_id() + "' and doc_id='"
				+ beginInfoBean.getDoc_id() + "' and begin_id='"+beginInfoBean.getBegin_id()+"'");
		sqlStr = sqlBuilder.toString();
		System.out.println("sssss" + sqlStr);
		int res = erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
		return res;

	}

}
