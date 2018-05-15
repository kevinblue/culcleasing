/**
 * com.tenwa.culc.dao
 */
package com.tenwa.culc.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;

import com.tenwa.culc.bean.RentPlanBean;
import com.tenwa.culc.service.SqlGenerateUtil;
import com.tenwa.culc.util.ERPDataSource;
import com.tenwa.log.LogWriter;

/**
 * RentPlanDao����
 * 
 * @author Jaffe
 * 
 * Date:Jul 12, 2011 1:19:53 PM Email:JaffeHe@hotmail.com
 */
public class RentPlanDao {
	private static Logger log = Logger.getLogger(RentPlanDao.class);
	// ��������
	private ResultSet rs = null;

	/**
	 * ������Ŀ���ƻ���ʱ������
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateFundRentPlanProjTempData(List<RentPlanBean> rentPlanList)
			throws SQLException {
		int resVal = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.ѭ���������
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			RentPlanBean rentPlanBean = rentPlanList.get(i);
			sqlStr = "insert into fund_rent_plan_proj_temp(proj_id,doc_id,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,corpus,year_rate,interest,corpus_overage,create_date)";
			sqlStr += "values(";
			sqlStr += "'" + rentPlanBean.getProj_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','" + rentPlanBean.getCorpus()
					+ "','" + rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getCreate_date() + "'";
			sqlStr += ")";

			resVal += erpDataSource.executeUpdate(sqlStr);
		}
		// 3.�ر���Դ
		erpDataSource.close();

		return resVal;
	}

	/**
	 * ����ҽ�ƹ�����Ŀ�ƻ���ʱ������
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateMediProjRentListData(List<RentPlanBean> rentPlanList)
			throws SQLException {
		int resVal = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.ѭ���������
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			RentPlanBean rentPlanBean = rentPlanList.get(i);
			sqlStr = "insert into fund_rent_plan_proj_bd_medi_temp(proj_id,doc_id,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,corpus,year_rate,interest,corpus_overage,plan_bank_name,plan_bank_no,create_date)";
			sqlStr += "values(";
			sqlStr += "'" + rentPlanBean.getProj_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','" + rentPlanBean.getCorpus()
					+ "','" + rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getPlan_bank_name() + "','"
					+ rentPlanBean.getPlan_bank_no() + "','"
					+ rentPlanBean.getCreate_date() + "'";
			sqlStr += ")";
			System.out.println("Sql::::"+sqlStr);
			resVal += erpDataSource.executeUpdate(sqlStr);
		}
		// 3.�ر���Դ
		erpDataSource.close();

		return resVal;
	}

	
	/**
	 * ����ҽ�ƹ�����Ŀ�ƻ���ʱ������
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateMediContRentListData(List<RentPlanBean> rentPlanList)
			throws SQLException {
		int resVal = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.ѭ���������
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			RentPlanBean rentPlanBean = rentPlanList.get(i);
			sqlStr = "insert into fund_rent_plan_contract_bd_medi_temp(contract_id,doc_id,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,corpus,year_rate,interest,corpus_overage,plan_bank_name,plan_bank_no,create_date)";
			sqlStr += "values(";
			sqlStr += "'" + rentPlanBean.getContract_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','" + rentPlanBean.getCorpus()
					+ "','" + rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getPlan_bank_name() + "','"
					+ rentPlanBean.getPlan_bank_no() + "','"
					+ rentPlanBean.getCreate_date() + "'";
			sqlStr += ")";
			System.out.println("Sql::::"+sqlStr);
			resVal += erpDataSource.executeUpdate(sqlStr);
		}
		// 3.�ر���Դ
		erpDataSource.close();

		return resVal;
	}

	/**
	 * ɾ����ʱ��ʷ����
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentPlanProjTempHisData(String proj_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "delete from fund_rent_plan_proj_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("ִ��ɾ��fund_rent_plan_proj_temp�ɹ�");
		}
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ɾ����ʱ��ʷ����-ҽ�ƹ�����Ŀ���ƻ�
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteMediProjRentListData(String proj_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "delete from fund_rent_plan_proj_bd_medi_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("ִ��ɾ��[fund_rent_plan_proj_bd_medi_temp]�ɹ�");
		}
		// 3.�ر���Դ
		erpDataSource.close();
	}
	
	/**
	 * ɾ����ʱ��ʷ����-ҽ�ƹ�����Ŀ���ƻ�
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteMediContRentListData(String contract_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "delete from fund_rent_plan_contract_bd_medi_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("ִ��ɾ��[fund_rent_plan_proj_bd_medi_temp]�ɹ�");
		}
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ɾ������ʱ��ʷ���� ��������
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentListBeginHisData(String begin_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// dbo.fund_rent_plan_temp2
		// dbo.fund_rent_plan_his2
		// dbo.fund_rent_plan_before2
		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlGenerateUtil.generateDelRentBeginDataSql(begin_id,
				doc_id);

		erpDataSource.executeUpdate(sqlStr);
		LogWriter.logDebug("ִ��ɾ��[fund_rent_plan_temp]�ɹ�");
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ���̳�ʼ���ж����ƻ���ʱ�������Ƿ����
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeItemExist(String proj_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from fund_rent_plan_proj_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * ��ʼ��������Ŀ���ƻ���ʱ������
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
						"Insert into fund_rent_plan_proj_temp(proj_id,doc_id,rent_list,plan_date,plan_status,curr_rent,rent,corpus,")
				.append(
						"year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,curr_penalty,")
				.append("penalty,creator,create_date,modificator,modify_date)");
		sqlBuilder
				.append(
						"select proj_id,'"
								+ doc_id
								+ "',rent_list,plan_date,plan_status,curr_rent,rent,corpus,")
				.append(
						"year_rate,interest,rent_overage,corpus_overage,interest_overage,penalty_overage,curr_penalty,")
				.append(
						"penalty,creator,create_date,modificator,modify_date from fund_rent_plan_proj");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();
		
		System.out.println("test----------------"+sqlStr);

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
		String sqlStr = "select id from fund_rent_plan_contract_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	public void copyData2ContractTemp(String contract_id, String proj_id,
			String doc_id) throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"insert into fund_rent_plan_contract_temp(contract_id,doc_id,rent_list,plan_date,plan_status,curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,")
				.append(
						"interest_overage,penalty_overage,curr_penalty,penalty,creator,create_date,modificator,modify_date)");
		sqlBuilder
				.append(
						"select '"
								+ contract_id
								+ "','"
								+ doc_id
								+ "',rent_list,plan_date,plan_status,curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,")
				.append(
						"interest_overage,penalty_overage,curr_penalty,penalty,creator,create_date,modificator,modify_date from fund_rent_plan_proj ");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();

	}

	/**
	 * ɾ����ͬ���ƻ�
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentPlanContractTempHisData(String contract_id,
			String doc_id) throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.ƴ��sql��ִ�в���
		String sqlStr = "delete from fund_rent_plan_contract_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		erpDataSource.executeUpdate(sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("ִ��ɾ��fund_rent_plan_contract_temp�ɹ�");
		}
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * �����ͬ���ƻ�
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateFundRentPlanContractTempData(
			List<RentPlanBean> rentPlanList) throws SQLException {
		int resVal = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.ѭ���������
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			RentPlanBean rentPlanBean = rentPlanList.get(i);
			sqlStr = "insert into fund_rent_plan_contract_temp(contract_id,doc_id,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,corpus,year_rate,interest,corpus_overage,create_date)";
			sqlStr += "values(";
			sqlStr += "'" + rentPlanBean.getContract_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','" + rentPlanBean.getCorpus()
					+ "','" + rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getCreate_date() + "'";
			sqlStr += ")";

			resVal += erpDataSource.executeUpdate(sqlStr);
		}
		// 3.�ر���Դ
		erpDataSource.close();

		return resVal;
	}

	/**
	 * �жϺ�ͬ���ƻ������Ƿ����
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
		String sqlStr = "select id from fund_rent_plan_contract_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * ��ͬ���ƻ����ݿ���
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
						"insert into fund_rent_plan_contract_temp(contract_id,doc_id,rent_list,plan_date,plan_status,curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,")
				.append(
						"interest_overage,penalty_overage,curr_penalty,penalty,creator,create_date,modificator,modify_date)");
		sqlBuilder
				.append(
						"select contract_id,'"
								+ doc_id
								+ "',rent_list,plan_date,plan_status,curr_rent,rent,corpus,year_rate,interest,rent_overage,corpus_overage,")
				.append(
						"interest_overage,penalty_overage,curr_penalty,penalty,creator,create_date,modificator,modify_date from fund_rent_plan_contract ");
		sqlBuilder.append(" where contract_id='" + contract_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ����[fund_rent_plan_temp][fund_rent_plan_his][fund_rent_plan_before]����
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateRentListBeginData(List<RentPlanBean> rentPlanList)
			throws SQLException {
		int resVal = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2 ѭ������
		// [fund_rent_plan_temp][fund_rent_plan_his][fund_rent_plan_before] ��
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			RentPlanBean rentPlanBean = rentPlanList.get(i);

			// fund_rent_plan_temp ���ƻ���ʱ��
			sqlStr = "  insert into fund_rent_plan_temp(contract_id,begin_id,doc_id,measure_date,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,curr_corpus,corpus,year_rate,curr_interest,interest,corpus_overage,plan_bank_name,plan_bank_no,create_date)";
			sqlStr += " values(";
			sqlStr += "'" + rentPlanBean.getContract_id() + "','"
					+ rentPlanBean.getBegin_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getMeasure_date() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','"
					+ rentPlanBean.getCurr_corpus() + "','"
					+ rentPlanBean.getCorpus() + "','"
					+ rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getCurr_interest() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getPlan_bank_name() + "','"
					+ rentPlanBean.getPlan_bank_no() + "','"
					+ rentPlanBean.getCreate_date() + "'";
			sqlStr += ") ";
			System.out.println("���ƻ���ʱ��===="+sqlStr);

			resVal += erpDataSource.executeUpdate(sqlStr);
		}

		// 3.�ر���Դ
		erpDataSource.close();

		return resVal;
	}

	/**
	 * �ж����������[fund_rent_plan_temp]�Ƿ��������
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeBeginItemExist(String contract_id, String begin_id,
			String doc_id) throws SQLException {
		boolean flag = false;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from fund_rent_plan_temp where contract_id='"
				+ contract_id
				+ "' and begin_id='"
				+ begin_id
				+ "' and oth_remark='�����ǰ' and doc_id='" + doc_id + "'";

		LogWriter.logSqlStr("�����->�ж����ݴ���", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * ��������̿������ƻ���ʽ���ݵ�[fund_rent_plan_temp]
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyBeginRentData2Temp(String contract_id, String begin_id,
			String doc_id) throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"Insert into fund_rent_plan_temp(contract_id,begin_id,doc_id,measure_date,rent_list,plan_date,pena_plan_date,curr_rent,rent,curr_corpus,corpus,")
				.append(
						"year_rate,curr_interest,interest,rent_overage,corpus_overage,interest_overage,curr_penalty,penalty,")
				.append(
						"penalty_overage,plan_status,pena_status,plan_bank_name,plan_bank_no,mod_stuff,mod_status,")
				.append(
						"mod_reason,creator,create_date,modificator,modify_date,oth_remark)");

		sqlBuilder
				.append(
						"Select contract_id,begin_id,'"
								+ doc_id
								+ "',getdate(),rent_list,plan_date,pena_plan_date,curr_rent,rent,curr_corpus,corpus,")
				.append(
						"year_rate,curr_interest,interest,rent_overage,corpus_overage,interest_overage,curr_penalty,penalty,")
				.append(
						"penalty_overage,plan_status,pena_status,plan_bank_name,plan_bank_no,mod_stuff,mod_status,")
				.append(
						"mod_reason,creator,create_date,modificator,modify_date,'�����ǰ' ")
				.append(
						" From fund_rent_plan where contract_id='"
								+ contract_id + "' and begin_id='" + begin_id
								+ "'");

		sqlStr = sqlBuilder.toString();

		LogWriter.logSqlStr("�����->��ʱ���ݿ���", sqlStr);

		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * �ж���[fund_rent_plan_temp]�Ƿ��������
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeRentTempItemExist(String contract_id, String begin_id,
			String doc_id) throws SQLException {
		boolean flag = false;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from fund_rent_plan_temp where contract_id='"
				+ contract_id
				+ "' and begin_id='"
				+ begin_id
				+ "' and doc_id='" + doc_id + "'";

		LogWriter.logSqlStr("��������->�ж����ݴ���", sqlStr);

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * �������� - ���ƻ������ݳ�ʼ��[fund_rent_plan_temp]
	 * 
	 * @param contract_id
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyContract2BeginRentData2Temp(String contract_id,
			String begin_id, String doc_id) throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"Insert into fund_rent_plan_temp(contract_id,begin_id,doc_id,measure_date,rent_list,plan_date,pena_plan_date,curr_rent,rent,curr_corpus,corpus,")
				.append(
						"year_rate,curr_interest,interest,rent_overage,corpus_overage,interest_overage,curr_penalty,penalty,")
				.append(
						"penalty_overage,plan_status,pena_status,plan_bank_name,plan_bank_no,mod_stuff,mod_status,")
				.append(
						"mod_reason,creator,create_date,modificator,modify_date)");
		sqlBuilder
				.append(
						"Select contract_id,'"
								+ begin_id
								+ "','"
								+ doc_id
								+ "',getdate(),rent_list,plan_date,'',curr_rent,rent,corpus,corpus,")
				.append(
						"year_rate,interest,interest,rent_overage,corpus_overage,interest_overage,curr_penalty,penalty,")
				.append("penalty_overage,plan_status,'','','','','',").append(
						"'',creator,getdate(),modificator,modify_date ")
				.append(
						" From fund_rent_plan_contract where contract_id='"
								+ contract_id + "'");

		sqlStr = sqlBuilder.toString();

		LogWriter.logSqlStr("��������->��ʱ���ݿ���", sqlStr);

		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ɾ��[fund_rent_plan_temp]������
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentPlanBeginTempHisData(String begin_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();
		// dbo.fund_rent_plan_temp
		// dbo.fund_rent_plan_his
		// dbo.fund_rent_plan_before
		// 2.ƴ��sql��ִ�в���
		String sqlStr = SqlGenerateUtil.generateDelRentBeginDataSql(begin_id,
				doc_id);
		LogWriter.logSqlStr("��������-�ϴ����", sqlStr);
		erpDataSource.executeUpdate(sqlStr);
		LogWriter
				.logDebug("ִ��ɾ��[fund_rent_plan_temp][fund_rent_plan_his][fund_rent_plan_before]�ɹ�");
		// 3.�ر���Դ
		erpDataSource.close();

	}

	/**
	 * ���������
	 * 
	 * @param begin_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void deleteRentChangeBeginTempData(String begin_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "Delete from fund_rent_plan_temp where begin_id='"
				+ begin_id + "' and doc_id='" + doc_id
				+ "' and oth_remark='�������'";
		LogWriter.logSqlStr("���������-ɾ���ϴ���ʷ", sqlStr);
		erpDataSource.executeUpdate(sqlStr);
		LogWriter.logDebug("ִ��ɾ��[fund_rent_plan_temp]�ɹ�");
		// 3.�ر���Դ
		erpDataSource.close();

	}

	/**
	 * �������������������
	 * 
	 * @param rentPlanList
	 * @return
	 * @throws SQLException
	 */
	public int updateRentChangeListBeginData(List<RentPlanBean> rentPlanList)
			throws SQLException {
		int resVal = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource = new ERPDataSource();
		// 2 ѭ������
		// [fund_rent_plan_temp] ��
		RentPlanBean rentPlanBean = null;
		String sqlStr = "";
		for (int i = 0; i < rentPlanList.size(); i++) {
			rentPlanBean = rentPlanList.get(i);
			// fund_rent_plan_temp ���ƻ���ʱ��
			sqlStr = "  insert into fund_rent_plan_temp(contract_id,begin_id,doc_id,measure_date,rent_list,plan_date,plan_status,";
			sqlStr += " curr_rent,rent,curr_corpus,corpus,year_rate,curr_interest,interest,corpus_overage,plan_bank_name,plan_bank_no,create_date,oth_remark)";
			sqlStr += " values(";
			sqlStr += "'" + rentPlanBean.getContract_id() + "','"
					+ rentPlanBean.getBegin_id() + "','"
					+ rentPlanBean.getDoc_id() + "','"
					+ rentPlanBean.getMeasure_date() + "','"
					+ rentPlanBean.getRent_list() + "','"
					+ rentPlanBean.getPlan_date() + "','"
					+ rentPlanBean.getPlan_status() + "','"
					+ rentPlanBean.getCurr_rent() + "','"
					+ rentPlanBean.getRent() + "','"
					+ rentPlanBean.getCurr_corpus() + "','"
					+ rentPlanBean.getCorpus() + "','"
					+ rentPlanBean.getYear_rate() + "','"
					+ rentPlanBean.getCurr_interest() + "','"
					+ rentPlanBean.getInterest() + "','"
					+ rentPlanBean.getCorpus_overage() + "','"
					+ rentPlanBean.getPlan_bank_name() + "','"
					+ rentPlanBean.getPlan_bank_no() + "','"
					+ rentPlanBean.getCreate_date() + "','�������'";
			sqlStr += ") ";

			resVal += erpDataSource.executeUpdate(sqlStr);
		}

		// 3.�ر���Դ
		erpDataSource.close();

		return resVal;
	}
}
