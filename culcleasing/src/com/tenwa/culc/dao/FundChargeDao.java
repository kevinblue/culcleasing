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
public class FundChargeDao {
	private static Logger log = Logger.getLogger(FundChargeDao.class);


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
	public int existsData(String contract_id, String doc_id)
			throws SQLException {
		int flag = 0;
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from contract_fund_fund_charge_plan_temp where doc_id='"
				+ doc_id + "' and contract_id='" + contract_id + "'";
		rs = erpDataSource.executeQuery(sqlStr);

		if (rs.next()) {
			flag = 1;
		}
		// 3.关闭资源
		erpDataSource.close();

		// 5.返回
		return flag;
	}

	/**
	 * 将数据从项目资金计划表拷贝到合同资金计划临时表 + 付款前提
	 * 
	 * @param proj_id
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData(String proj_id, String contract_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
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
		// 2.2执行数据拷贝
		erpDataSource.executeUpdate(sqlStr);

		// 2.3插入付款前提
		sqlStr = "insert into contract_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
		sqlStr += " select payment_id,'"
				+ doc_id
				+ "',pay_condition,status,remark from proj_fund_fund_charge_condition";
		sqlStr += " where payment_id in(select payment_id from proj_fund_fund_charge_plan where proj_id='"
				+ proj_id + "')";
		erpDataSource.executeUpdate(sqlStr);

		if (log.isDebugEnabled()) {
			log.debug("执行资金计划数据拷贝,付款前提拷贝,合同号：" + contract_id);
		}

		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 流程启动时判断数据是否在Temp临时表存在
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
		String sqlStr = "select id from proj_fund_fund_charge_plan_temp where proj_id='"
				+ proj_id + "' and measure_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
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

	/**
	 * 判断数据库中是否存在
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
		String sqlStr = "select id from contract_fund_fund_charge_plan_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;

	}

	/**
	 * 数据拷贝
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
		// 插入合同资金计划
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

		// 插入合同资金付款前提
		sqlStr = "insert into contract_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
		sqlStr += " select payment_id,'"
				+ doc_id
				+ "',pay_condition,status,remark from proj_fund_fund_charge_condition";
		sqlStr += " where payment_id in(select payment_id from proj_fund_fund_charge_plan where proj_id='"
				+ proj_id + "')";
		erpDataSource.executeUpdate(sqlStr);

		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 判断合同资金计划数据是否存在
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @return
	 * @throws SQLException
	 */
	public boolean judgeContractDataExist(String contract_id, String doc_id)
			throws SQLException {
		boolean flag = false;
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "select id from contract_fund_fund_charge_plan_temp where contract_id='"
				+ contract_id + "' and doc_id='" + doc_id + "'";

		rs = erpDataSource.executeQuery(sqlStr);
		flag = rs.next();
		// 3.关闭资源
		erpDataSource.close();

		return flag;
	}

	/**
	 * 合同资金计划、合同资金付款前提数据拷贝
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
		// 插入合同资金计划
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
		System.out.println("签约变更流程资金计划插入临时表SQL="+sqlStr);

		erpDataSource.executeUpdate(sqlStr);

		// 插入合同资金付款前提
		sqlStr = "insert into contract_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
		sqlStr += " select payment_id,'"
				+ doc_id
				+ "',pay_condition,status,remark from contract_fund_fund_charge_condition";
		sqlStr += " where payment_id in(select payment_id from contract_fund_fund_charge_plan where contract_id='"
				+ contract_id + "')";
		erpDataSource.executeUpdate(sqlStr);

		// 3.关闭资源
		erpDataSource.close();
	}
	/**
	 * 方案2
	 * 合同资金计划、合同资金付款前提数据拷贝
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTemp2(String contract_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		// 插入合同资金计划
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
		sqlBuilder.append(" where plan_status='未核销' and contract_id='" + contract_id + "'");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);

		// 插入合同资金付款前提
		sqlStr = "insert into contract_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
		sqlStr += " select payment_id,'"
				+ doc_id
				+ "',pay_condition,status,remark from contract_fund_fund_charge_condition";
		sqlStr += " where payment_id in(select payment_id from contract_fund_fund_charge_plan where contract_id='"
				+ contract_id + "')";
		erpDataSource.executeUpdate(sqlStr);

		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 合同资金计划未核销资金数据拷贝
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTempZJJHSB(String contract_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		// 插入合同资金计划 - 未核销 - 未在核销状态中 isnull(flag,0)=0
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
				+ "' and plan_status='未核销' ");
		
		//2012-9-28 坐扣关联修改
		sqlBuilder.append(" Insert into contract_fund_fund_charge_ZK(fund_uuid,fund_zkuuid,doc_id) ");
		sqlBuilder.append(" Select fund_uuid,fund_zkuuid,'"+doc_id+"' from contract_fund_fund_charge_ZK where fund_uuid in(");
		sqlBuilder.append("Select payment_id from contract_fund_fund_charge_plan where contract_id='" + contract_id
				+ "' and plan_status='未核销' ) ");
		sqlStr = sqlBuilder.toString();

		erpDataSource.executeUpdate(sqlStr);
		
		
		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 商务方案修地 - 数据拷贝
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTempSWFAXD(String contract_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		// 插入合同资金计划
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
		sqlBuilder.append(" where plan_status='未核销' and contract_id='"
				+ contract_id + "'");
		sqlStr = sqlBuilder.toString();
		System.out.println("商务方案修改数据copy SQL==="+sqlStr);
		erpDataSource.executeUpdate(sqlStr);

		// 插入合同资金付款前提
		sqlStr = "insert into contract_fund_fund_charge_condition_temp(payment_id,doc_id,pay_condition,status,remark)";
		sqlStr += " select payment_id,'"
				+ doc_id
				+ "',pay_condition,status,remark from contract_fund_fund_charge_condition";
		sqlStr += " where payment_id in(select payment_id from contract_fund_fund_charge_plan where plan_status='未核销' and contract_id='"
				+ contract_id + "')";
		erpDataSource.executeUpdate(sqlStr);

		// 3.关闭资源
		erpDataSource.close();
	}

	/**
	 * 租前期确认 - 数据拷贝
	 * 
	 * @param contract_id
	 * @param doc_id
	 * @throws SQLException
	 */
	public void copyData2ContractTempZQQQR(String contract_id, String doc_id)
			throws SQLException {
		// 1.获取连接、会话
		ERPDataSource erpDataSource=new ERPDataSource();

		// 2.拼接sql，执行插入
		String sqlStr = "";
		StringBuilder sqlBuilder = new StringBuilder();
		// 插入合同资金计划
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

		// 3.关闭资源
		erpDataSource.close();
	}


}
