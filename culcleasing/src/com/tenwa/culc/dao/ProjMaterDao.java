/**
 * com.tenwa.culc.dao
 */
package com.tenwa.culc.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.tenwa.culc.util.ERPDataSource;
/**
 * @author Jaffe
 * 
 * Date:Jul 14, 2011 10:34:25 AM Email:JaffeHe@hotmail.com
 */
public class ProjMaterDao {

	// ��������
	private ResultSet rs = null;

	/**
	 * �ж���Ŀ���������Ƿ��Ѿ�����
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
		String sqlStr = "select id from proj_document_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * ����Ŀ������ʽ�����ݿ�������ʱ��
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
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		sqlBuilder
				.append("insert into proj_document_temp(proj_id,doc_id,document_id,text_status,electron_status,remark)");
		sqlBuilder
				.append("select proj_id,'"
						+ doc_id
						+ "',document_id,text_status,electron_status,remark from proj_document");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();
System.out.println("aaaaa"+sqlStr);
		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * �ж�ǩԼ�������̷��������Ƿ����contract_document_temp
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
		String sqlStr = "select id from contract_document_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * ǩԼ�����������ݿ���
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
		sqlBuilder
				.append("insert into contract_document_temp(contract_id,doc_id,document_id,text_status,electron_status,remark)");
		sqlBuilder
				.append("select '"
						+ contract_id
						+ "','"
						+ doc_id
						+ "',document_id,text_status,electron_status,remark from proj_document");
		sqlBuilder.append(" where proj_id='" + proj_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

	/**
	 * �жϺ�ͬ�����Ƿ����
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeContractItemExist(String contract_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.��ȡ���ӡ��Ự
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.ƴ��sql��ִ�в���
		String sqlStr = "select id from contract_document_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.�ر���Դ
		erpDataSource.close();

		return flag;
	}

	/**
	 * ��ͬϵ�б����ݿ���
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
		sqlBuilder
				.append("insert into contract_document_temp(contract_id,doc_id,document_id,text_status,electron_status,remark)");
		sqlBuilder
				.append("select contract_id,'"
						+ doc_id
						+ "',document_id,text_status,electron_status,remark from contract_document");
		sqlBuilder.append(" where isnull(place_flag,0)=0 and contract_id='" + contract_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		// 3.�ر���Դ
		erpDataSource.close();
	}

}
