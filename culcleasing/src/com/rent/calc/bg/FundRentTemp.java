package com.rent.calc.bg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.Tools;
import com.rent.calc.tx.bg.ToolUtil;

import dbconn.Conn;

public class FundRentTemp {

	/**
	 * 市场租金计划
	 * 
	 * @param proj_id
	 * @param columnName
	 * @param docId
	 * @param docColumnName
	 * @param tbName
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public Hashtable getMarketPlanInfo(String proj_id, String columnName,
			String docId, String docColumnName, String tbName)
			throws Exception, SQLException {
		String sql = "";
		Conn conn = new Conn();

		// 计算市场的irr
		sql = "select convert(varchar(10),plan_date,120) plan_date,isnull(rent,0) rent,isnull(corpus_market,0) corpus_market,isnull(interest_market,0) interest_market,isnull(corpus_overage_market,0) corpus_overage_market from "
				+ tbName
				+ " where "
				+ columnName
				+ "='"
				+ proj_id
				+ "' and "
				+ docColumnName + "='" + docId + "'";
		;

		ResultSet rs = conn.executeQuery(sql);
		Hashtable ht = new Hashtable();

		List rent_list = new ArrayList();
		List l_date = new ArrayList();

		List corpus_market_list = new ArrayList();// 市场本金
		List inter_list = new ArrayList();// 市场利息
		List corpusOverge_market_list = new ArrayList();// 市场本金余额

		while (rs.next()) {
			rent_list.add(rs.getString("rent"));
			l_date.add(rs.getString("plan_date"));
			corpus_market_list.add(rs.getString("corpus_market"));
			inter_list.add(rs.getString("interest_market"));
			corpusOverge_market_list.add(rs.getString("corpus_overage_market"));
		}

		ht.put("l_date", l_date);// 计划日期
		ht.put("rent_list", rent_list);// 租金
		ht.put("corpus_market_list", corpus_market_list);// 市场本金
		ht.put("inter_list", inter_list);// 市场利息
		ht.put("corpusOverge_market_list", corpusOverge_market_list);// 市场本金余额

		ToolUtil.closeRSOrConn(rs, conn);
		return ht;
	}
	
	/**
	 * 更新财务租金计划表
	 * 
	 * @param proj_id
	 *            合同号
	 * @param start_term
	 *            开始日期
	 * @param interest
	 *            利息
	 * @param corpusList
	 *            本金
	 * @param corpusOvergeList
	 *            本金余额
	 * @throws Exception
	 */
	public void updateFinacPlan(String proj_id, String columnName,
			String docId, String docColumnName, String tbName,List interest, List corpusList,
			List corpusOvergeList) throws Exception {

		String sql = "";
		for (int i = 0; i < interest.size(); i++) {
			sql += "  update "+tbName+" set interest='"
				+ Tools.formatNumberDoubleTwo(interest.get(i).toString()) + "',corpus='"
				+ Tools.formatNumberDoubleTwo(corpusList.get(i).toString())
				+ "',corpus_overage='"
				+ Tools.formatNumberDoubleTwo(corpusOvergeList.get(i).toString())
				+ "' where rent_list=" + i + "+1 and "+columnName+"='"
				+ proj_id + "' and "+docColumnName+"='"+docId+"' ";
			// System.out.println(sql);
		}

		Conn conn = new Conn();
		conn.executeUpdate(sql);
		ToolUtil.closeRSOrConn(null, conn);

	}
	

}
