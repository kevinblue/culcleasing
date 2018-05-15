package com.tenwa.leasing.dao.rent.tranrate;

import com.tenwa.leasing.dao.Conn;
import com.tenwa.leasing.dao.DaoUtil;


/**
 * 租金计划历史记录
 * 
 * @author shf
 * 
 */
public class FundRentHis {
	/**
	 * 添加租金计划调息前历史记录
	 * 
	 * @param adjustId
	 * @param projs
	 * @param contract_id
	 * @throws Exception
	 */

	public void addRentHisBeforeInfo(String adjustId, String contract_id)
			throws Exception {
		Conn conn = new Conn();
		String sql = " delete fund_rent_plan_his where contract_id='"
				+ contract_id
				+ "' and mod_reason='调息' and measure_id='"
				+ adjustId
				+ "' and status='前' 	insert into dbo.fund_rent_plan_his(interest_market,corpus_market,corpus_overage_market,contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,mod_reason,measure_id,status) select interest_market,corpus_market,corpus_overage_market, contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,'调息','"
				+ adjustId + "','前' from fund_rent_plan 	 where contract_id='"
				+ contract_id + "' order by rent_list";
		conn.executeUpdate(sql);
		DaoUtil.closeRSOrConn(null, conn);
	}

	/**
	 * 添加租金计划调息后历史记录
	 * 
	 * @param adjustId
	 * @param projs
	 * @param contract_id
	 * @throws Exception
	 */

	public void addRentHisAfterInfo(String adjustId, String contract_id)
			throws Exception {
		Conn conn = new Conn();
		String upd_sql = " delete fund_rent_plan_his where contract_id='"
				+ contract_id
				+ "' and mod_reason='调息' and measure_id='"
				+ adjustId
				+ "' and status='后'   insert into dbo.fund_rent_plan_his(interest_market,corpus_market,corpus_overage_market,contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,mod_reason,measure_id,status) select interest_market,corpus_market,corpus_overage_market, contract_id,rent_list,plan_status,plan_date,rent,corpus,year_rate,interest,corpus_overage,'调息','"
				+ adjustId + "','后' from fund_rent_plan where contract_id='"
				+ contract_id + "' order by rent_list ";
		conn.executeUpdate(upd_sql);
		DaoUtil.closeRSOrConn(null, conn);
	}

}
