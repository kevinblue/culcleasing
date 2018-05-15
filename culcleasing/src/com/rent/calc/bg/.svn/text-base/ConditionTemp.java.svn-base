package com.rent.calc.bg;

import java.sql.ResultSet;
import java.util.Hashtable;

import com.Tools;
import com.rent.calc.tx.bg.ToolUtil;

import dbconn.Conn;

public class ConditionTemp {
	/**
	 * 根据项目(合同)的id ,docId,表名查询交易结构信息
	 * 
	 * @param proj_id
	 *            合同号，项目号
	 * @param columnName
	 *            合同号，项目号列名
	 * @param docId
	 *            流程号
	 * @param docColumnName
	 *            合同流程号列名，项目流程号列名
	 * @param tbName
	 *            所对应的表名
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static Hashtable getProj_ConditionInfoByProj_id(String proj_id,
			String columnName, String docId, String docColumnName, String tbName)
			throws Exception {

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		String sql = " 	select isnull(income_day,0) income_day, isnull(ajdustStyle,'') ajdustStyle,isnull(rentScale,0) rentScale,isnull(nominalprice,0) nominalprice,isnull(consulting_fee,0) consulting_fee,isnull(lease_money,0) lease_money,measure_type,isnull(equip_amt,0) equip_amt,rate_float_type,isnull(start_date,getdate()) start_date,isnull(caution_money,0) caution_money,isnull(year_rate,0) year_rate,isnull(handling_charge,0)handling_charge,isnull(lease_term,0)lease_term,isnull(income_number_year,0) income_number_year, isnull(income_number,0) income_number, period_type,isnull(rate_float_amt,0)rate_float_amt,isnull(delay,0) delay,isnull(grace,0) grace from "
				+ tbName
				+ " where "
				+ columnName
				+ "='"
				+ proj_id
				+ "' and "
				+ docColumnName + "='" + docId + "'";

		Hashtable hmp = new Hashtable();

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			hmp.put("rate_float_type", rs.getString("rate_float_type")); // 利率浮动类型
			// 租赁期限(月)
			hmp.put("lease_term", rs.getString("lease_term"));
			// 付租方式,年，季
			hmp.put("income_number_year", rs.getString("income_number_year"));
			// 还租次数
			hmp.put("income_number", rs.getString("income_number"));
			// 付租类型,期初或期末
			hmp.put("period_type", rs.getString("period_type"));
			// 利率调整值
			hmp.put("rate_float_amt", rs.getString("rate_float_amt"));

			// measure_type租金计算方法
			hmp.put("measure_type", rs.getString("measure_type"));

			// 租赁保证金
			hmp.put("caution_money", rs.getString("caution_money"));
			hmp.put("equip_amt", rs.getString("equip_amt"));
			// 留购价
			hmp.put("nominalprice", rs.getString("nominalprice"));
			hmp.put("year_rate", rs.getString("year_rate"));
			hmp.put("rentScale", rs.getString("rentScale"));
			hmp.put("income_day", rs.getString("income_day"));
			// 宽限期，延迟付款期数
			hmp.put("delay", rs.getString("delay"));
			hmp.put("grace", rs.getString("grace"));
			hmp.put("ajdustStyle", rs.getString("ajdustStyle"));// 租金调整方式

		}

		ToolUtil.closeRSOrConn(rs, conn);
		return hmp;

	}

	/**
	 * 更新合同的市场的irr的值
	 * 
	 * @param proj_id
	 * @param columnName
	 * @param docId
	 * @param docColumnName
	 * @param tbName
	 * @param irr
	 * @throws Exception
	 */
	public void updateMarkerIrr(String proj_id, String columnName,
			String docId, String docColumnName, String tbName, String irr)
			throws Exception {
		String sql = "";
		Conn conn = new Conn();
		sql = "update " + tbName + " set market_irr="
				+ Tools.formatNumberDoubleScale(irr, 8) + "*100  where "
				+ columnName + "='" + proj_id + "' and " + docColumnName
				+ "='" + docId + "'";
		conn.executeUpdate(sql);
		ToolUtil.closeRSOrConn(null, conn);

	}

	/**
	 * 更新合同的财务的irr的值
	 * 
	 * @param proj_id
	 * @param columnName
	 * @param docId
	 * @param docColumnName
	 * @param tbName
	 * @param irr
	 * @throws Exception
	 */
	public void updateFinaIrr(String proj_id, String columnName, String docId,
			String docColumnName, String tbName, String irr) throws Exception {
		String sql = "";
		Conn conn = new Conn();
		sql = "update " + tbName + " set plan_irr="
				+ Tools.formatNumberDoubleScale(irr, 8) + "*100  where "
				+ columnName + "='" + proj_id + "' and " + docColumnName
				+ "='" + docId + "'";
		conn.executeUpdate(sql);
		ToolUtil.closeRSOrConn(null, conn);

	}

}
