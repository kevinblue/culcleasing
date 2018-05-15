/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tenwa.culc.util.ERPDataSource;

/**
 * �ʽ�ƻ�Dao
 * 
 * @author Jaffe
 * 
 * Date:Jul 6, 2011 4:38:28 PM Email:JaffeHe@hotmail.com
 */
public class CustAccountDao {
	private static Logger log = Logger.getLogger(CustAccountDao.class);


	// ��������
	private ResultSet rs = null;

	/**
	 * �ж��Ƿ������ݴ���
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean existsData(String contract_id, String doc_id, int state)
			throws SQLException {
		boolean flag = false;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();
		
		String sqlStr = "";
		
		// 2.ƴ��sql��ִ�в���
		if(state == 0){
			sqlStr = "select id from contract_cust_account_temp where doc_id='"
					+ doc_id + "' and contract_id='" + contract_id + "' ";
		}else{
			sqlStr = "select id from contract_cust_account where contract_id='" + contract_id + "' ";
		}
			
		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			flag = true;
		}
		// 3.�ر���Դ
		erpDataSource.close();

		// 5.����
		return flag;
	}
	
	/**
	 * �ж��Ƿ������ݴ���
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean existsProjData(String proj_id, String doc_id,int state)
			throws SQLException {
		boolean flag = false;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();
		String sqlStr = "";
		// 2.ƴ��sql��ִ�в�ѯ
		if(state == 0){//��ѯ��Ŀ��ʱ��
			sqlStr = "select id from proj_cust_account_temp where doc_id='" + doc_id + "' and proj_id='" + proj_id + "' ";
		}else{//��ѯ��Ŀ��ʽ��
			sqlStr = "select id from proj_cust_account where proj_id='" + proj_id + "' ";
		}
		System.out.println("�����ʺų�ʼ���ж� SQLSTR=="+sqlStr);
		rs = erpDataSource.executeQuery(sqlStr);
		if(rs.next()){
			flag = true;
		}
		// 3.�ر���Դ
		erpDataSource.close();

		// 5.����
		return flag;
	}

	/**
	 * ����������������ʱ��(��ͣʹ��)
	 * 
	 * @param proj_id
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData(String contract_id,String cust_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
	

		// 2.3���븶��ǰ��
		sqlStr = "insert into contract_cust_account_temp(contract_id,doc_id,account_id,create_date,memo)";
		sqlStr += " select '"+contract_id+"','"
				+ doc_id
				+ "',account_id,getdate(),memo from proj_cust_account where proj_id='"+cust_id+"'";
		
		erpDataSource.executeUpdate(sqlStr);
		System.out.println("�������ʺ�sqlStr======"+sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("ִ�������ʺ����ݿ���,��ͬ�ţ�" + contract_id);
		}

		// 3.�ر���Դ
		erpDataSource.close();
	}
	
	/**
	 * ����������������ʱ��
	 * ����Ŀ��ʽ��������Ŀ��ʱ��
	 * @param proj_id
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyDataToProjTemp(String proj_id,String cust_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
	

		// 2.3���븶��ǰ��
		sqlStr = "insert into proj_cust_account_temp(proj_id,doc_id,account_id,create_date,memo)";
		sqlStr += " select '"+proj_id+"','"
				+ doc_id
				+ "',account_id,getdate(),memo from proj_cust_account where proj_id='"+proj_id+"'";
		
		erpDataSource.executeUpdate(sqlStr);
		System.out.println("�������ʺ�sqlStr======"+sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("ִ�������ʺ����ݿ���,��ͬ�ţ�" + proj_id);
		}

		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ����������������ʱ��
	 * �Ӻ�ͬ��ʽ��������ͬ��ʱ��
	 * @param proj_id
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyDataToContractTemp(String contract_id,String cust_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
	

		// 2.3���븶��ǰ��
		sqlStr = "insert into contract_cust_account_temp(contract_id,doc_id,account_id,create_date,memo)";
		sqlStr += " select '"+contract_id+"','"
				+ doc_id
				+ "',account_id,getdate(),memo from contract_cust_account where contract_id='"+contract_id+"'";
		
		erpDataSource.executeUpdate(sqlStr);
		System.out.println("�������ʺ�sqlStr======"+sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("ִ�������ʺ����ݿ���,��ͬ�ţ�" + contract_id);
		}

		// 3.�ر���Դ
		erpDataSource.close();
	}
	
	/**
	 * ����������������ʱ��
	 * �Ӻ�ͬ��ʽ��������Ŀ��ʱ��
	 * @param proj_id
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyDataFromProjToContractTemp(String contract_id,String cust_id, String doc_id,String proj_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
	

		// 2.3���븶��ǰ��
		sqlStr = "insert into contract_cust_account_temp(contract_id,doc_id,account_id,create_date,memo)";
		sqlStr += " select '"+contract_id+"','"
				+ doc_id
				+ "',account_id,getdate(),memo from proj_cust_account where proj_id='"+proj_id+"'";
		
		erpDataSource.executeUpdate(sqlStr);
		System.out.println("�������ʺ�sqlStr======"+sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("ִ�������ʺ����ݿ���,��ͬ�ţ�" + contract_id);
		}

		// 3.�ر���Դ
		erpDataSource.close();
	}
	
	
	/**
	 * ���̳�ʼ������ʽ�����ݿ�����Temp����[proj_fund_fund_charge_plan] -->
	 * [proj_fund_fund_charge_plan_temp]
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2Temp(String proj_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		// 2.1�����ʽ�ƻ�����
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"Insert into proj_fund_fund_charge_plan_temp(payment_id,measure_id,proj_id,pay_type,fee_type,fee_name,fee_num,")
				.append(
						"plan_date,plan_status,flag,curr_plan_money,plan_money,currency,pay_obj,pay_bank_name,pay_bank_no,")
				.append(
						"plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)");
		sqlBuilder
				.append(
						"select payment_id,'"
								+ doc_id
								+ "',proj_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,curr_plan_money,plan_money,")
				.append(
						"currency,pay_obj,pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,")
				.append(
						"pay_way,fpnote,creator,create_date,modificator,modify_date")
				.append(" from proj_fund_fund_charge_plan");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		// 2.2�����ʽ𸶿�ǰ������
		sqlBuilder = new StringBuilder();
		sqlBuilder
				.append(
						"Insert into proj_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)")
				.append(
						"select payment_id,'"
								+ doc_id
								+ "',pay_condition,status,remark from proj_fund_fund_charge_condition");
		sqlBuilder.append(" where payment_id in(").append(
				"select payment_id from proj_fund_fund_charge_plan where proj_id='"
						+ proj_id + "'").append(")");
		sqlStr = sqlBuilder.toString();
		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	


}
