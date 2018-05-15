package com.tenwa.leasing.dao.irr;


 
import com.tenwa.leasing.dao.Conn;
import com.tenwa.leasing.dao.DaoUtil;
import com.tenwa.leasing.util.NumTools;

public class FinaIrrDao {
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
				+ NumTools.formatNumberDoubleScale(irr, 8) + "*100  where "
				+ columnName + "='" + proj_id + "' and " + docColumnName + "='"
				+ docId + "'";
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}
	
	
	/**
	 * ���º�ͬ�Ĳ����irr��ֵ
	 * 
	 * @param contract_id
	 * @param irr
	 * @throws Exception
	 */
	public void updateFinaIrr(String contract_id, String irr) throws Exception {
		String sql = "";
		Conn conn = new Conn();
		sql = "update contract_condition set plan_irr_old=plan_irr,plan_irr="+NumTools.formatNumberDoubleScale(irr,8)+"*100  where contract_id='"
				+ contract_id + "'";
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);

	}
	
}
