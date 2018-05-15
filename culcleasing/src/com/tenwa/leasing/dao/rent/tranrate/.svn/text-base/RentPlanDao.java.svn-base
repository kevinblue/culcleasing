package com.tenwa.leasing.dao.rent.tranrate;

import java.sql.ResultSet;
import java.util.List;

import com.tenwa.leasing.dao.Conn;
import com.tenwa.leasing.dao.DaoUtil;

/**
 * 调息时租金计划测算dao 项目名称：iulcleasing 类名称：RentPlanDao 类描述： 创建人：史鸿飞 创建时间：2011-2-10
 * 上午09:42:46 修改人：史鸿飞 修改时间：2011-2-10 上午09:42:46 修改备注：
 * 
 * @version
 */
public class RentPlanDao {

	/**
	 * 
	 * @Title: updateRentPlan
	 * @Description:
	 * @param
	 * @param rentList新的租金列表
	 * @param
	 * @param interestList新的利息列表
	 * @param
	 * @param corpus新的本金列表
	 * @param
	 * @param corpus_overage新的本金余额列表
	 * @param
	 * @param contract_id合同号
	 * @param
	 * @param startTerm调息开始期
	 * @param
	 * @throws Exception
	 * @return void
	 * @throws
	 */
	public static void updateRentPlan(List rentList, List interestList,
			List corpus, List corpus_overage, String contract_id,
			String startTerm) throws Exception {

		// 所要更新的记录
		String sql = "select id,rent_list from fund_rent_plan where contract_id='"
				+ contract_id
				+ "' and rent_list>='"
				+ startTerm
				+ "' order by rent_list ";

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		rs = conn.executeQuery(sql);
		// 构造所要执行的sql语句
		sql = "   ";
		int i = 0;// 用于租金,本金等数据的提取
		while (rs.next()) {
			sql += " update fund_rent_plan set rent='"
					+ rentList.get(i).toString() + "',corpus='"
					+ corpus.get(i).toString() + "',interest='"
					+ interestList.get(i).toString() + "',corpus_overage='"
					+ corpus_overage.get(i).toString() + "' where id='"
					+ rs.getString("id") + "' ";
			i++;
		}
		// 执行更新操作
		conn.executeUpdate(sql);
		// 关闭连接
		DaoUtil.closeRSOrConn(rs, conn);

	}

	/**
	 * 更新租金计划表
	 * @Title: updateRentPlan 
	 * @Description: 
	 * @param @param rentList
	 * @param @param interestList
	 * @param @param corpus
	 * @param @param corpus_overage
	 * @param @param interestList_mark
	 * @param @param corpus_mark
	 * @param @param corpus_overage_market
	 * @param @param contract_id
	 * @param @param startTerm
	 * @param @throws Exception    
	 * @return void   
	 * @throws
	 */

	public static void updateRentPlan(List rentList, List interestList,
			List corpus, List corpus_overage, List interestList_mark,
			List corpus_mark, List corpus_overage_market, String contract_id,
			String startTerm) throws Exception {

		// 所要更新的记录
		String sql = "select id,rent_list from fund_rent_plan where contract_id='"
				+ contract_id
				+ "' and rent_list>='"
				+ startTerm
				+ "' order by rent_list ";

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		rs = conn.executeQuery(sql);
		// 构造所要执行的sql语句
		sql = "   ";
		int i = 0;// 用于租金,本金等数据的提取
		while (rs.next()) {
			sql += " update fund_rent_plan set rent='"
					+ rentList.get(i).toString() + "',corpus='"
					+ corpus.get(i).toString() + "',interest='"
					+ interestList.get(i).toString() + "',corpus_overage='"

					+ corpus_overage.get(i).toString() + "',interest_market='"
					+ interestList_mark.get(i).toString() + "',corpus_market='"
					+ corpus_mark.get(i).toString()
					+ "',corpus_overage_market='"

					+ corpus_overage_market.get(i).toString() + "' where id='"
					+ rs.getString("id") + "' ";
			i++;
		}
		// 执行更新操作
		conn.executeUpdate(sql);
		// 关闭连接
		DaoUtil.closeRSOrConn(rs, conn);

	}

}
