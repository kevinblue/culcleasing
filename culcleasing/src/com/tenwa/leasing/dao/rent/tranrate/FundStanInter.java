package com.tenwa.leasing.dao.rent.tranrate;

import java.sql.ResultSet;
import java.util.Hashtable;

import com.tenwa.leasing.dao.Conn;
import com.tenwa.leasing.dao.DaoUtil;



/**
 * 央行调息基准表
 * 
 * @author shf
 * 
 */
public class FundStanInter {

	/**
	 * 固定调整租金金额
	 * 
	 * @param lease_term
	 *            期限
	 * @param adjust_value
	 *            添加的值
	 * @param adjust
	 *            基准率信息
	 * @return 每期要添加的租金的值
	 */
	public String getFixed(String lease_term, String adjust_value,
			Hashtable adjust) {

		double rate_d = 0.0;
		if ("6".equals(lease_term)) {// 六个月时
			rate_d = (Double.parseDouble(adjust.get("rate_half").toString()) / 0.01)
					* (Double.parseDouble(adjust_value));

		} else if ("12".equals(lease_term)) {// 一年时
			rate_d = (Double.parseDouble(adjust.get("rate_one").toString()) / 0.01)
					* (Double.parseDouble(adjust_value));
		} else if (Integer.parseInt(lease_term) > 12
				&& Integer.parseInt(lease_term) < 37) {// 二年到三年之间时
			rate_d = (Double.parseDouble(adjust.get("rate_three").toString()) / 0.01)
					* (Double.parseDouble(adjust_value));

		} else if (Integer.parseInt(lease_term) > 36
				&& Integer.parseInt(lease_term) < 61) {// 四，五年之间时
			rate_d = (Double.parseDouble(adjust.get("rate_five").toString()) / 0.01)
					* (Double.parseDouble(adjust_value));
		} else if (Integer.parseInt(lease_term) > 60) {// 五年以上时
			rate_d = (Double.parseDouble(adjust.get("rate_abovefive")
					.toString()) / 0.01)
					* (Double.parseDouble(adjust_value));
		} else {
			rate_d = 0.0;
		}
		// 返回每一期租金所应加的值
		return String.valueOf(rate_d);
	}

	/**
	 * 按央行利率加点
	 * 
	 * @param lease_term
	 *            期限
	 * @param adjust_point
	 * 
	 * @return
	 */
	public String getRateByPoint(String lease_term, String adjust_point,
			Hashtable adjust) {

		String rate_ = "0";
		@SuppressWarnings("unused")
		String rate_half = "0";
		if ("6".equals(lease_term)) {// 六个月时
			rate_ = adjust.get("base_rate_half").toString();
			rate_half = adjust.get("rate_half").toString();

		} else if ("12".equals(lease_term)) {// 一年时
			rate_ = adjust.get("base_rate_one").toString();
			rate_half = adjust.get("rate_one").toString();

		} else if (Integer.parseInt(lease_term) > 12
				&& Integer.parseInt(lease_term) < 37) {// 二年到三年之间时
			rate_ = adjust.get("base_rate_three").toString();
			rate_half = adjust.get("rate_three").toString();

		} else if (Integer.parseInt(lease_term) > 36
				&& Integer.parseInt(lease_term) < 61) {// 四，五年之间时
			rate_ = adjust.get("base_rate_five").toString();
			rate_half = adjust.get("rate_five").toString();

		} else if (Integer.parseInt(lease_term) > 60) {// 五年以上时
			rate_ = adjust.get("base_rate_abovefive").toString();
			rate_half = adjust.get("rate_abovefive").toString();

		} else {
			rate_ = "0";
		}
		// 计算他的利率值,在央行的基础上加多少点
		rate_ = String.valueOf(Double.parseDouble(rate_)
				+ Double.parseDouble(adjust_point));
		// 返回的是%之多少
		return rate_;
	}

	/**
	 * 按央行利率浮动比率
	 * 
	 * @param lease_term
	 *            交易结构表期限
	 * @param adjust
	 *            调整利率值信息
	 * @return 相应的利率
	 * 
	 * ：（央行基础利率 + 幅度）× 调整系数
	 */
	public String getRateByBaseRate(String lease_term, Hashtable adjust,
			String adjust_point) {

		String rate_ = "0";
		if ("6".equals(lease_term)) {// 六个月时
			rate_ = adjust.get("base_rate_half").toString();
			// rate_=String.valueOf(Double.parseDouble(rate_)+Double.parseDouble(adjust.get("rate_half").toString()));

		} else if ("12".equals(lease_term)) {// 一年时
			rate_ = adjust.get("base_rate_one").toString();
			// rate_=String.valueOf(Double.parseDouble(rate_)+Double.parseDouble(adjust.get("rate_one").toString()));

		} else if (Integer.parseInt(lease_term) > 12
				&& Integer.parseInt(lease_term) < 37) {// 二年到三年之间时
			rate_ = adjust.get("base_rate_three").toString();
			// rate_=String.valueOf(Double.parseDouble(rate_)+Double.parseDouble(adjust.get("rate_three").toString()));

		} else if (Integer.parseInt(lease_term) > 36
				&& Integer.parseInt(lease_term) < 61) {// 四，五年之间时
			rate_ = adjust.get("base_rate_five").toString();
			// rate_=String.valueOf(Double.parseDouble(rate_)+Double.parseDouble(adjust.get("rate_five").toString()));

		} else if (Integer.parseInt(lease_term) > 60) {// 五年以上时
			rate_ = adjust.get("base_rate_abovefive").toString();
			// rate_=String.valueOf(Double.parseDouble(rate_)+Double.parseDouble(adjust.get("rate_abovefive").toString()));

		} else {
			rate_ = "0";
		}
		// 计算他的利率值
		rate_ = String.valueOf(Double.parseDouble(rate_)
				* Double.parseDouble(adjust_point));
		// 返回的是%之多少
		return rate_;
	}

	/**
	 * 
	 * @param adjustId
	 *            利率调整id
	 * @return 利率调整信息
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Hashtable getAdjustInterInfo(String adjustId) throws Exception {
		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		String sql = " 	select  start_date,isnull(rate_half,0) rate_half,isnull(rate_one,0) rate_one,isnull(rate_three,0) rate_three,isnull(rate_five,0) rate_five,isnull(rate_abovefive,0) rate_abovefive, isnull(base_rate_half,0) base_rate_half,isnull(base_rate_one,0) base_rate_one,isnull(base_rate_three,0) base_rate_three,isnull(base_rate_five,0) base_rate_five,isnull(base_rate_abovefive,0) base_rate_abovefive  from fund_standard_interest where id='"
				+ adjustId + "' ";

		Hashtable hmp = new Hashtable();
		rs = conn.executeQuery(sql);
		if (rs.next()) {
			hmp.put("start_date", rs.getString("start_date"));
			hmp.put("rate_half", rs.getString("rate_half"));
			hmp.put("rate_one", rs.getString("rate_one"));
			hmp.put("rate_three", rs.getString("rate_three"));

			hmp.put("rate_five", rs.getString("rate_five"));
			hmp.put("rate_abovefive", rs.getString("rate_abovefive"));
			hmp.put("base_rate_half", rs.getString("base_rate_half"));
			hmp.put("base_rate_one", rs.getString("base_rate_one"));

			hmp.put("base_rate_three", rs.getString("base_rate_three"));
			hmp.put("base_rate_five", rs.getString("base_rate_five"));
			hmp.put("base_rate_abovefive", rs.getString("base_rate_abovefive"));
		}
		DaoUtil.closeRSOrConn(rs, conn);
		return hmp;
	}

	/**
	 * 添加值添加修改租金调息记录
	 * 
	 * @param startTerm
	 * @param adjustId
	 * @param contract_id
	 * @param addValue
	 * @throws Exception
	 */
	public void insertFixValueData(String startTerm, String adjustId,
			String contract_id, String addValue) throws Exception {
		Conn conn = new Conn();
		String ins_sql = "insert into fund_adjust_interest_contract(adjust_flag,rent_list_start,adjust_id,contract_id,adjust_amt)  select '是','";
		ins_sql += startTerm + "','" + adjustId + "','" + contract_id + "','"
				+ addValue + "'";
		conn.executeUpdate(ins_sql);
		DaoUtil.closeRSOrConn(null, conn);
	}

	/**
	 * 陈了固定值的调息方式 添加修改租金调息记录
	 * 
	 * @param startTerm
	 * @param adjustId
	 * @param contract_id
	 * @param addValue
	 * @throws Exception
	 */
	public void insertValueData(String startTerm, String adjustId,
			String contract_id, String x_year_rate, String old_year_rate)
			throws Exception {
		
		//从租金计划表中取老的利率
		FundRentPlan frp = new FundRentPlan();
		String year_rate = frp.getPreRate(contract_id, startTerm);
		
		if ("0".equals(year_rate)) {
			year_rate = old_year_rate;
		}
		
		
		Conn conn = new Conn();
		String ins_sql = " delete fund_adjust_interest_contract where contract_id='"+contract_id+"' and adjust_id='"+adjustId+"' insert into fund_adjust_interest_contract(adjust_flag,before_rate,after_rate,rent_list_start,adjust_id,contract_id,plan_irr_old,plan_irr,market_irr,market_irr_old) select '是',";
		ins_sql += "'" + year_rate + "','" + x_year_rate + "','"
				+ startTerm + "','" + adjustId + "','" + contract_id + "',plan_irr_old,plan_irr,market_irr,market_irr_old from contract_condition where contract_id='"+contract_id+"'";
		System.out.println("ins_sql:"+ins_sql);
		conn.executeUpdate(ins_sql);
		
		//更新交易结构表  201116
//		CoditionInfo cd = new CoditionInfo();
//		cd.updateYearRate(contract_id,x_year_rate);
		
		DaoUtil.closeRSOrConn(null, conn);
	}
	
	
	
	/**
	 * 按央行利率加点
	 * 
	 * @param lease_term
	 *            期限
	 * @param adjust_point
	 * 
	 * @return
	 */
	public String getRateBySett(String oldYearRate,String lease_term,Hashtable adjust) {

		String rate_ = "0";
		@SuppressWarnings("unused")
		String rate_half = "0";
		if ("6".equals(lease_term)) {// 六个月时
			//rate_ = adjust.get("base_rate_half").toString();
			rate_half = adjust.get("rate_half").toString();

		} else if ("12".equals(lease_term)) {// 一年时
			//rate_ = adjust.get("base_rate_one").toString();
			rate_half = adjust.get("rate_one").toString();

		} else if (Integer.parseInt(lease_term) > 12
				&& Integer.parseInt(lease_term) < 37) {// 二年到三年之间时
			//rate_ = adjust.get("base_rate_three").toString();
		 	rate_half = adjust.get("rate_three").toString();

		} else if (Integer.parseInt(lease_term) > 36
				&& Integer.parseInt(lease_term) < 61) {// 四，五年之间时
			//rate_ = adjust.get("base_rate_five").toString();
			rate_half = adjust.get("rate_five").toString();

		} else if (Integer.parseInt(lease_term) > 60) {// 五年以上时
			//rate_ = adjust.get("base_rate_abovefive").toString();
			rate_half = adjust.get("rate_abovefive").toString();

		} else {
			rate_ = "0";
		}
		// 计算他的利率值,在央行的基础上加多少点
		rate_ = String.valueOf(Double.parseDouble(rate_half)
				+ Double.parseDouble(oldYearRate));
		// 返回的是%之多少
		return rate_;
	}
	

}
