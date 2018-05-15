/**
 * com.tenwa.culc.service
 */
package com.tenwa.culc.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tenwa.culc.util.ERPDataSource;

/**
 * 资金计划Dao
 * 
 * @author Jaffe
 * 
 * Date:Jul 6, 2011 4:38:28 PM Email:JaffeHe@hotmail.com
 */
public class CustAccountDao {
	private static Logger log = Logger.getLogger(CustAccountDao.class);


	// 公共参数
	private ResultSet rs = null;

	/**
	 * 判断是否有数据存在
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean existsData(String contract_id, String doc_id, int state)
			throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();
		
		String sqlStr = "";
		
		// 2.拼接sql，执行插入
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
		// 3.关闭资源
		erpDataSource.close();

		// 5.返回
		return flag;
	}
	
	/**
	 * 判断是否有数据存在
	 * 
	 * @param proj_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean existsProjData(String proj_id, String doc_id,int state)
			throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();
		String sqlStr = "";
		// 2.拼接sql，执行查询
		if(state == 0){//查询项目临时表
			sqlStr = "select id from proj_cust_account_temp where doc_id='" + doc_id + "' and proj_id='" + proj_id + "' ";
		}else{//查询项目正式表
			sqlStr = "select id from proj_cust_account where proj_id='" + proj_id + "' ";
		}
		System.out.println("银行帐号初始化判断 SQLSTR=="+sqlStr);
		rs = erpDataSource.executeQuery(sqlStr);
		if(rs.next()){
			flag = true;
		}
		// 3.关闭资源
		erpDataSource.close();

		// 5.返回
		return flag;
	}

	/**
	 * 流程启动，插入临时表(暂停使用)
	 * 
	 * @param proj_id
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData(String contract_id,String cust_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
	

		// 2.3插入付款前提
		sqlStr = "insert into contract_cust_account_temp(contract_id,doc_id,account_id,create_date,memo)";
		sqlStr += " select '"+contract_id+"','"
				+ doc_id
				+ "',account_id,getdate(),memo from proj_cust_account where proj_id='"+cust_id+"'";
		
		erpDataSource.executeUpdate(sqlStr);
		System.out.println("行银行帐号sqlStr======"+sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("执行银行帐号数据拷贝,合同号：" + contract_id);
		}

		// 3.关闭资源
		erpDataSource.close();
	}
	
	/**
	 * 流程启动，插入临时表
	 * 从项目正式表拷贝到项目临时表
	 * @param proj_id
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyDataToProjTemp(String proj_id,String cust_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
	

		// 2.3插入付款前提
		sqlStr = "insert into proj_cust_account_temp(proj_id,doc_id,account_id,create_date,memo)";
		sqlStr += " select '"+proj_id+"','"
				+ doc_id
				+ "',account_id,getdate(),memo from proj_cust_account where proj_id='"+proj_id+"'";
		
		erpDataSource.executeUpdate(sqlStr);
		System.out.println("行银行帐号sqlStr======"+sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("执行银行帐号数据拷贝,合同号：" + proj_id);
		}

		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 流程启动，插入临时表
	 * 从合同正式表拷贝到合同临时表
	 * @param proj_id
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyDataToContractTemp(String contract_id,String cust_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
	

		// 2.3插入付款前提
		sqlStr = "insert into contract_cust_account_temp(contract_id,doc_id,account_id,create_date,memo)";
		sqlStr += " select '"+contract_id+"','"
				+ doc_id
				+ "',account_id,getdate(),memo from contract_cust_account where contract_id='"+contract_id+"'";
		
		erpDataSource.executeUpdate(sqlStr);
		System.out.println("行银行帐号sqlStr======"+sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("执行银行帐号数据拷贝,合同号：" + contract_id);
		}

		// 3.关闭资源
		erpDataSource.close();
	}
	
	/**
	 * 流程启动，插入临时表
	 * 从合同正式表拷贝到项目临时表
	 * @param proj_id
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyDataFromProjToContractTemp(String contract_id,String cust_id, String doc_id,String proj_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
	

		// 2.3插入付款前提
		sqlStr = "insert into contract_cust_account_temp(contract_id,doc_id,account_id,create_date,memo)";
		sqlStr += " select '"+contract_id+"','"
				+ doc_id
				+ "',account_id,getdate(),memo from proj_cust_account where proj_id='"+proj_id+"'";
		
		erpDataSource.executeUpdate(sqlStr);
		System.out.println("行银行帐号sqlStr======"+sqlStr);
		if (log.isDebugEnabled()) {
			log.debug("执行银行帐号数据拷贝,合同号：" + contract_id);
		}

		// 3.关闭资源
		erpDataSource.close();
	}
	
	
	/**
	 * 流程初始化将正式表数据拷贝到Temp表，从[proj_fund_fund_charge_plan] -->
	 * [proj_fund_fund_charge_plan_temp]
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
		// 2.1插入资金计划数据
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
		// 2.2插入资金付款前提数据
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
		// 3.关闭资源
		erpDataSource.close();
	}

	


}
