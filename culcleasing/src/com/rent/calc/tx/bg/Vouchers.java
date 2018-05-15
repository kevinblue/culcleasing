package com.rent.calc.tx.bg;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.Tools;

import dbconn.Conn;

/**
 * 
 * @author SHIHONGFEI
 * @version 1.0
 * @copyright (C) TENWA 2011
 * @date 2011-4-8
 * @desc TODO (todo-list 调息凭证操作)
 */
public class Vouchers {

	/**
	 * 
	 * TODO (todo-list todo-list 调息时凭证数据生成)
	 * 
	 * @param contract_id
	 *            合同号
	 * @param dept_id部门ID
	 * @param evidence_no业务系统凭证号dbo.evidenceNo_create(操作id)
	 * @param cust_id客户编号
	 * @param account_name账户名
	 * @param fee_id费用类型ID列
	 * @param fee_money金额
	 *            利息差额
	 * @param oper_type操作类型1
	 *            借 2贷 1,2
	 * @param row行数(批量合同序列第一第二第三)
	 * @param Subject_number课目编号借(第一次调用):
	 *            153101 贷(第二次调用):153201
	 * @return
	 * @throws Exception
	 */
	public boolean processVouch(String contract_id, String dept_id,
			String evidence_no, String cust_id, String account_name,
			String fee_id, String oper_type, String row, String Subject_number,
			String adjust_id) throws Exception {

		// 得到前后利息差
		String fee_money = getContractInterBalance(contract_id, adjust_id);
		// 数据库操作对象
		Conn conn = new Conn();
		// 等额本金，与固定利率不调
		String sql = " EXECUTE insert_evidence_info '央行调息'  ,'" + contract_id + "'  ,'"
				+ dept_id + "'  ,'" + evidence_no + "'";
		sql += ",'" + Tools.getSystemDate(0) + "'  ,'" + cust_id + "'  ,'"
				+ account_name + "'  ,'" + fee_id + "'  ,'" + fee_money
				+ "'  ,'" + oper_type + "'";
		sql += ",'" + row + "'  ,'" + Subject_number
				+ "'  ,'央行调息调整（cust）租金'  ,''  ,''  ,'0100'";

		System.out.println("调息凭证执行sql:" + sql);
		conn.executeUpdate(sql);
		ToolUtil.closeRSOrConn(null, conn);
		return true;

	}


	/**
	 * 
	 * TODO (todo-list todo-list 得到调息前后利息差)
	 * 
	 * @param contractId
	 * @param adjust_id
	 * @return
	 * @throws Exception
	 */
	public String getContractInterBalance(String contractId, String adjust_id)
			throws Exception {

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		String end_interest = "";
		StringBuffer sql = new StringBuffer();
		sql
				.append(" select (sum(case status when '后' then interest end) ")
				.append(" - ")
				.append(
						" sum(case status when '前' then interest end) )as end_interest ")
				.append(" from fund_rent_plan_his  ").append(
						" where  mod_reason = '调息' ").append(
						" and measure_id = '" + adjust_id + "' ").append(
						" and  contract_id = '" + contractId + "' ");
		rs = conn.executeQuery(sql.toString());
		if (rs.next()) {
			end_interest = getZeroStr(rs.getString("end_interest"));
		}
		ToolUtil.closeRSOrConn(rs, conn);
		return end_interest;

	}


	/**
	 * 
	 * TODO (todo-list todo-list 财务凭证号生成)
	 * @return
	 * @throws Exception
	 */
	public String getVouchNumber() throws Exception {
		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		String vouchNumber = "";
		StringBuffer sql = new StringBuffer();
		sql.append("select dbo.evidenceNo_create() number");
		
		
		rs = conn.executeQuery(sql.toString());
		if (rs.next()) {
			vouchNumber = getZeroStr(rs.getString("number"));
		}
		ToolUtil.closeRSOrConn(rs, conn);
		return vouchNumber;
	}


	public String getZeroStr(String value) {
		try {
			String temp_n = value;
			if (temp_n == null || temp_n.equals("") || temp_n.equals("null")) {
				temp_n = "0";
			}
			return temp_n;
		} catch (Exception e) {

		}
		return "0";
	}

}
