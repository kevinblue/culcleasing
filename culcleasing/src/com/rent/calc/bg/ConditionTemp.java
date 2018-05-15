package com.rent.calc.bg;

import java.sql.ResultSet;
import java.util.Hashtable;

import com.Tools;
import com.rent.calc.tx.bg.ToolUtil;

import dbconn.Conn;

public class ConditionTemp {
	/**
	 * ������Ŀ(��ͬ)��id ,docId,������ѯ���׽ṹ��Ϣ
	 * 
	 * @param proj_id
	 *            ��ͬ�ţ���Ŀ��
	 * @param columnName
	 *            ��ͬ�ţ���Ŀ������
	 * @param docId
	 *            ���̺�
	 * @param docColumnName
	 *            ��ͬ���̺���������Ŀ���̺�����
	 * @param tbName
	 *            ����Ӧ�ı���
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static Hashtable getProj_ConditionInfoByProj_id(String proj_id,
			String columnName, String docId, String docColumnName, String tbName)
			throws Exception {

		// ���ݿ��������
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
			hmp.put("rate_float_type", rs.getString("rate_float_type")); // ���ʸ�������
			// ��������(��)
			hmp.put("lease_term", rs.getString("lease_term"));
			// ���ⷽʽ,�꣬��
			hmp.put("income_number_year", rs.getString("income_number_year"));
			// �������
			hmp.put("income_number", rs.getString("income_number"));
			// ��������,�ڳ�����ĩ
			hmp.put("period_type", rs.getString("period_type"));
			// ���ʵ���ֵ
			hmp.put("rate_float_amt", rs.getString("rate_float_amt"));

			// measure_type�����㷽��
			hmp.put("measure_type", rs.getString("measure_type"));

			// ���ޱ�֤��
			hmp.put("caution_money", rs.getString("caution_money"));
			hmp.put("equip_amt", rs.getString("equip_amt"));
			// ������
			hmp.put("nominalprice", rs.getString("nominalprice"));
			hmp.put("year_rate", rs.getString("year_rate"));
			hmp.put("rentScale", rs.getString("rentScale"));
			hmp.put("income_day", rs.getString("income_day"));
			// �����ڣ��ӳٸ�������
			hmp.put("delay", rs.getString("delay"));
			hmp.put("grace", rs.getString("grace"));
			hmp.put("ajdustStyle", rs.getString("ajdustStyle"));// ��������ʽ

		}

		ToolUtil.closeRSOrConn(rs, conn);
		return hmp;

	}

	/**
	 * ���º�ͬ���г���irr��ֵ
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
	 * ���º�ͬ�Ĳ����irr��ֵ
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
