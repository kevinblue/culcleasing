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

	// 公共参数
	private ResultSet rs = null;

	/**
	 * 判断项目资料数据是否已经存在
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeItemExist(String proj_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from proj_document_temp where proj_id='"
				+ proj_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 将项目资料正式表数据拷贝到临时表
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2Temp(String proj_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
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
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 判断签约审批流程发起数据是否存在contract_document_temp
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
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from contract_document_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 签约审批流程数据拷贝
	 * 
	 * @param contract_id
	 * @param proj_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTemp(String contract_id, String proj_id,
			String doc_id) throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
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
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 判断合同资料是否存在
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeContractItemExist(String contract_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from contract_document_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 合同系列表数据拷贝
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTemp(String contract_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
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
		// 3.关闭资源
		erpDataSource.close();
	}

}
