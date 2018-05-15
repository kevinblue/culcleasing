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
public class FundChargeDao {
	private static Logger log = Logger.getLogger(FundChargeDao.class);


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
	public int existsData(String contract_id, String doc_id)
			throws SQLException {
		int flag = 0;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from contract_fund_fund_charge_plan_temp where doc_id='"
				+ doc_id + "' and contract_id='" + contract_id + "'";
		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			flag = 1;
		}
		// 3.�ر���Դ
		erpDataSource.close();

		// 5.����
		return flag;
	}

	/**
	 * �����ݴ���Ŀ�ʽ�ƻ���������ͬ�ʽ�ƻ���ʱ�� + ����ǰ��
	 * 
	 * @param proj_id
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData(String proj_id, String contract_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
		StringBuffer sqlBuffer = new StringBuffer();
		sqlBuffer
				.append(
						"insert into contract_fund_fund_charge_plan_temp(payment_id,contract_id,doc_id,pay_type,fee_type,fee_num,")
				.append(
						"plan_date,plan_status,flag,plan_money,currency,pay_obj,pay_bank_name,pay_bank_no,")
				.append(
						"plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)")
				.append(
						"select payment_id,'"
								+ contract_id
								+ "','"
								+ doc_id
								+ "',pay_type,fee_type,fee_num,plan_date,plan_status,flag,plan_money,")
				.append(
						"currency,pay_obj,pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,")
				.append(
						"pay_way,fpnote,creator,create_date,modificator,modify_date from proj_fund_fund_charge_plan ")
				.append(" where proj_id='" + proj_id + "'");

		sqlStr = sqlBuffer.toString();
		// 2.2ִ�����ݿ���
		erpDataSource.executeUpdate(sqlStr);

		// 2.3���븶��ǰ��
		sqlStr = "insert into contract_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
		sqlStr += " select payment_id,'"
				+ doc_id
				+ "',pay_condition,status,remark from proj_fund_fund_charge_condition";
		sqlStr += " where payment_id in(select payment_id from proj_fund_fund_charge_plan where proj_id='"
				+ proj_id + "')";
		erpDataSource.executeUpdate(sqlStr);

		if (log.isDebugEnabled()) {
			log.debug("ִ���ʽ�ƻ����ݿ���,����ǰ�´��,��ͬ�ţ�" + contract_id);
		}

		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ��������ʱ�ж������Ƿ���Temp��ʱ�����
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
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from proj_fund_fund_charge_plan_temp where proj_id='"
				+ proj_id + "' and measure_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
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

	/**
	 * �ж����ݿ����Ƿ����
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
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from contract_fund_fund_charge_plan_temp where contract_id='"
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
		ERPDataSource erpDataSource=new ERPDataSource();
		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		// �����ͬ�ʽ�ƻ�
		sqlBuilder
				.append(
						"insert into contract_fund_fund_charge_plan_temp(payment_id,contract_id,doc_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,curr_plan_money,plan_money,")
				.append(
						"currency,pay_obj,pay_bank_name,pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)");

		sqlBuilder
				.append(
						"select payment_id,'"
								+ contract_id
								+ "','"
								+ doc_id
								+ "',pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,curr_plan_money,plan_money,currency,pay_obj,pay_bank_name,")
				.append(
						"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date")
				.append(" from proj_fund_fund_charge_plan ");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);

		// �����ͬ�ʽ𸶿�ǰ��
		sqlStr = "insert into contract_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
		sqlStr += " select payment_id,'"
				+ doc_id
				+ "',pay_condition,status,remark from proj_fund_fund_charge_condition";
		sqlStr += " where payment_id in(select payment_id from proj_fund_fund_charge_plan where proj_id='"
				+ proj_id + "')";
		erpDataSource.executeUpdate(sqlStr);

		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * �жϺ�ͬ�ʽ�ƻ������Ƿ����
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
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from contract_fund_fund_charge_plan_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * ��ͬ�ʽ�ƻ�����ͬ�ʽ𸶿�ǰ�����ݿ���
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTemp(String contract_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		// �����ͬ�ʽ�ƻ�
		sqlBuilder
				.append(
						"insert into contract_fund_fund_charge_plan_temp(payment_id,make_contract_id,contract_id,doc_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,curr_plan_money,plan_money,currency,pay_obj,pay_bank_name,")
				.append(
						"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,tax_type_invoice,creator,create_date,modificator,modify_date)");

		sqlBuilder
				.append(
						"select payment_id,make_contract_id,contract_id,'"
								+ doc_id
								+ "',pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,curr_plan_money,plan_money,currency,pay_obj,pay_bank_name,")
				.append(
						"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,tax_type_invoice,creator,create_date,modificator,modify_date")
				.append(" from contract_fund_fund_charge_plan ");
		sqlBuilder.append(" where contract_id='" + contract_id + "'");
		sqlStr = sqlBuilder.toString();
		System.out.println("ǩԼ��������ʽ�ƻ�������ʱ��SQL="+sqlStr);

		erpDataSource.executeUpdate(sqlStr);

		// �����ͬ�ʽ𸶿�ǰ��
		sqlStr = "insert into contract_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
		sqlStr += " select payment_id,'"
				+ doc_id
				+ "',pay_condition,status,remark from contract_fund_fund_charge_condition";
		sqlStr += " where payment_id in(select payment_id from contract_fund_fund_charge_plan where contract_id='"
				+ contract_id + "')";
		erpDataSource.executeUpdate(sqlStr);

		// 3.�ر���Դ
		erpDataSource.close();
	}
	/**
	 * ����2
	 * ��ͬ�ʽ�ƻ�����ͬ�ʽ𸶿�ǰ�����ݿ���
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTemp2(String contract_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		// �����ͬ�ʽ�ƻ�
		sqlBuilder
				.append(
						"insert into contract_fund_fund_charge_plan_temp(payment_id,contract_id,doc_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,curr_plan_money,plan_money,currency,pay_obj,pay_bank_name,")
				.append(
						"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)");

		sqlBuilder
				.append(
						"select payment_id,contract_id,'"
								+ doc_id
								+ "',pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,curr_plan_money,plan_money,currency,pay_obj,pay_bank_name,")
				.append(
						"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date")
				.append(" from contract_fund_fund_charge_plan ");
		sqlBuilder.append(" where plan_status='δ����' and contract_id='" + contract_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);

		// �����ͬ�ʽ𸶿�ǰ��
		sqlStr = "insert into contract_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
		sqlStr += " select payment_id,'"
				+ doc_id
				+ "',pay_condition,status,remark from contract_fund_fund_charge_condition";
		sqlStr += " where payment_id in(select payment_id from contract_fund_fund_charge_plan where contract_id='"
				+ contract_id + "')";
		erpDataSource.executeUpdate(sqlStr);

		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ��ͬ�ʽ�ƻ�δ�����ʽ����ݿ���
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTempZJJHSB(String contract_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		// �����ͬ�ʽ�ƻ� - δ���� - δ�ں���״̬�� isnull(flag,0)=0
		sqlBuilder
				.append(
						"insert into contract_fund_fund_charge_plan_temp(payment_id,contract_id,doc_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,plan_money,currency,pay_obj,pay_bank_name,")
				.append(
						"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)");

		sqlBuilder
				.append(
						"select payment_id,contract_id,'"
								+ doc_id
								+ "',pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,plan_money,currency,pay_obj,pay_bank_name,")
				.append(
						"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date")
				.append(" from contract_fund_fund_charge_plan ");
		sqlBuilder.append(" where contract_id='" + contract_id
				+ "' and plan_status='δ����' ");
		
		//2012-9-28 ���۹����޸�
		sqlBuilder.append(" Insert into contract_fund_fund_charge_ZK(fund_uuid,fund_zkuuid,doc_id) ");
		sqlBuilder.append(" Select fund_uuid,fund_zkuuid,'"+doc_id+"' from contract_fund_fund_charge_ZK where fund_uuid in(");
		sqlBuilder.append("Select payment_id from contract_fund_fund_charge_plan where contract_id='" + contract_id
				+ "' and plan_status='δ����' ) ");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		
		
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ���񷽰��޵� - ���ݿ���
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTempSWFAXD(String contract_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		// �����ͬ�ʽ�ƻ�
		sqlBuilder
				.append(
						"insert into contract_fund_fund_charge_plan_temp(payment_id,make_contract_id,contract_id,doc_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,plan_money,currency,pay_obj,pay_bank_name,")
				.append(
						"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)");

		sqlBuilder
				.append(
						"select payment_id,make_contract_id,contract_id,'"
								+ doc_id
								+ "',pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,plan_money,currency,pay_obj,pay_bank_name,")
				.append(
						"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date")
				.append(" from contract_fund_fund_charge_plan ");
		sqlBuilder.append(" where plan_status='δ����' and contract_id='"
				+ contract_id + "'");
		sqlStr = sqlBuilder.toString();
		System.out.println("���񷽰��޸�����copy SQL==="+sqlStr);
		erpDataSource.executeUpdate(sqlStr);

		// �����ͬ�ʽ𸶿�ǰ��
		sqlStr = "insert into contract_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
		sqlStr += " select payment_id,'"
				+ doc_id
				+ "',pay_condition,status,remark from contract_fund_fund_charge_condition";
		sqlStr += " where payment_id in(select payment_id from contract_fund_fund_charge_plan where plan_status='δ����' and contract_id='"
				+ contract_id + "')";
		erpDataSource.executeUpdate(sqlStr);

		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * ��ǰ��ȷ�� - ���ݿ���
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTempZQQQR(String contract_id, String doc_id)
			throws SQLException {
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		// �����ͬ�ʽ�ƻ�
		sqlBuilder
				.append(
						"insert into contract_fund_fund_charge_plan_temp(payment_id,make_contract_id,contract_id,doc_id,pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,plan_money,currency,pay_obj,pay_bank_name,")
				.append(
						"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date)");

		sqlBuilder
				.append(
						"select payment_id,make_contract_id,contract_id,'"
								+ doc_id
								+ "',pay_type,fee_type,fee_name,fee_num,plan_date,plan_status,flag,plan_money,currency,pay_obj,pay_bank_name,")
				.append(
						"pay_bank_no,plan_bank_name,plan_bank_no,pay_way,fpnote,creator,create_date,modificator,modify_date")
				.append(" from contract_fund_fund_charge_plan ");
		sqlBuilder.append(" where fee_type=22 and contract_id='"
				+ contract_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);

		// 3.�ر���Դ
		erpDataSource.close();
	}


}
