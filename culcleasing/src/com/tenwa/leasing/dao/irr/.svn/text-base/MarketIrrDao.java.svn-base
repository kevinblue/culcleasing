package com.tenwa.leasing.dao.irr;


import com.tenwa.leasing.dao.Conn;
import com.tenwa.leasing.dao.DaoUtil;
import com.tenwa.leasing.util.NumTools;

/**
 * 市场irr dao处理 项目名称：iulcleasing 类名称：MarketIrrDao 类描述： 创建人：史鸿飞 创建时间：2011-2-9
 * 下午02:04:25 修改人：史鸿飞 修改时间：2011-2-9 下午02:04:25 修改备注：
 * 
 * @version
 */
public class MarketIrrDao {
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
				+ NumTools.formatNumberDoubleScale(irr, 8) + "*100  where "
				+ columnName + "='" + proj_id + "' and " + docColumnName + "='"
				+ docId + "'";
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}
	
	/**
	 * 更新合同的市场的irr的值
	 * 
	 * @param contract_id
	 * @param irr
	 * @throws Exception
	 */
	public void updateMarkerIrr(String contract_id, String irr)
			throws Exception {
		String sql = "";
		Conn conn = new Conn();
		sql = "update contract_condition set market_irr_old=market_irr, market_irr="+NumTools.formatNumberDoubleScale(irr,8)+"*100  where contract_id='"
				+ contract_id + "'";
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}
	
}
