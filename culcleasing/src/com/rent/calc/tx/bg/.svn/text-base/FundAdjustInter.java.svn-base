package com.rent.calc.tx.bg;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import dbconn.Conn;

/**
 * 调息记录表
 * 
 * @author shf
 * 
 */
public class FundAdjustInter {

	/**
	 * 执行调息记录查询
	 * 
	 * @param sql
	 * @return
	 * @throws Exception
	 */

	@SuppressWarnings("unchecked")
	public Hashtable searcherRecoder(String contract_id,
			String rent_list_start, String adjustStyle) throws Exception {
		ResultSet rs = null;
		Conn conn = new Conn();
		Hashtable ht = new Hashtable();
		List start_date = new ArrayList();
		List before_rate = new ArrayList();
		List after_rate = new ArrayList();
		String sql = "";
		if (null != adjustStyle && "0".equals(adjustStyle)) { // 次日

			sql = "select faic.id,faic.contract_id,convert(varchar(10),fsi.start_date,120) start_date,faic.before_rate,faic.after_rate,faic.rent_list_start  from dbo.fund_adjust_interest_contract faic left join  dbo.fund_standard_interest fsi on faic.adjust_id=fsi.id where contract_id='"
					+ contract_id
					+ "' and rent_list_start='"
					+ rent_list_start
					
					+ "' and isnull(isHG,'') <> '是' "
					
					
					+ "   order by faic.id ";
		} else if (null != adjustStyle && "1".equals(adjustStyle)) {// 次月
			sql = "select faic.id,faic.contract_id,dbo.getMonthFirstDay(convert(varchar(10),dateadd(month,1,fsi.start_date),120)) start_date,faic.before_rate,faic.after_rate,faic.rent_list_start  from dbo.fund_adjust_interest_contract faic left join  dbo.fund_standard_interest fsi on faic.adjust_id=fsi.id where contract_id='"
					+ contract_id
					+ "' and rent_list_start='"
					+ rent_list_start
					+ "' and isnull(isHG,'') <> '是'   order by faic.id ";
		}else if (null != adjustStyle && "3".equals(adjustStyle)) {// 次年,取最新的利率值
		
			sql = "select faic.id,faic.contract_id,convert(varchar(10),fsi.start_date,120) start_date,faic.before_rate,faic.after_rate,faic.rent_list_start  from dbo.fund_adjust_interest_contract faic left join  dbo.fund_standard_interest fsi on faic.adjust_id=fsi.id where contract_id='"
				+ contract_id
				+ "' and rent_list_start='"
				+ rent_list_start
				+ "' and isnull(isHG,'') <> '是'   order by faic.id ";
			
		}

		System.out.println(sql);
		rs = conn.executeQuery(sql);
		while (rs.next()) {
			start_date.add(rs.getString("start_date"));
			before_rate.add(rs.getString("before_rate"));
			after_rate.add(rs.getString("after_rate"));
		}

		ht.put("start_date", start_date);
		ht.put("before_rate", before_rate);
		ht.put("after_rate", after_rate);

		ToolUtil.closeRSOrConn(rs, conn);

		return ht;
	}
}
