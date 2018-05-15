package com.rent.calc.tx.bg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Hashtable;

import com.Tools;



import dbconn.Conn;

/**
 * 交易结构信息
 * 
 * @author shf
 * 
 */
public class CoditionInfo {

	/**
	 * 根据合同的浮点类型判断是不是应该进行调整
	 * 
	 * @param contract
	 * @return
	 * @throws Exception
	 */
	public boolean getContractFloatType(String contractId) throws Exception {

		boolean b = false;

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		// 等额本金，与固定利率不调
		String sql = " select count(*) from contract_condition where contract_id='"
				+ contractId
				+ "' and rate_float_type in ('3') or measure_type ='2' and measure_type<>'3' and measure_type<>'0'";

		rs = conn.executeQuery(sql);
		if (rs.next()) {
			if (rs.getInt(1) > 0) {
				b = true;// 不须调整时
			}
		}

		ToolUtil.closeRSOrConn(rs, conn);
		return b;

	}
	
	
	/**
	 * 更新合同的市场的irr的值
	 * 
	 * @param contract_id
	 * @param irr
	 * @throws Exception
	 */
	public void updateYearRate(String contract_id, String year_rate)
			throws Exception {
		String sql = "";
		Conn conn = new Conn();
		sql = "update contract_condition set year_rate="+year_rate+"  where contract_id='"
				+ contract_id + "'";
		conn.executeUpdate(sql);
		ToolUtil.closeRSOrConn(null, conn);

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
		sql = "update contract_condition set market_irr_old=market_irr, market_irr="+Tools.formatNumberDoubleScale(irr,8)+"*100  where contract_id='"
				+ contract_id + "'";
		conn.executeUpdate(sql);
		ToolUtil.closeRSOrConn(null, conn);

	}

	/**
	 * 更新合同的财务的irr的值
	 * 
	 * @param contract_id
	 * @param irr
	 * @throws Exception
	 */
	public void updateFinaIrr(String contract_id, String irr) throws Exception {
		String sql = "";
		Conn conn = new Conn();
		sql = "update contract_condition set plan_irr_old=plan_irr,plan_irr="+Tools.formatNumberDoubleScale(irr,8)+"*100  where contract_id='"
				+ contract_id + "'";
		conn.executeUpdate(sql);
		ToolUtil.closeRSOrConn(null, conn);

	}

	/**
	 * 期初 期末
	 * 
	 * @param proj_id
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String getType(String proj_id, String start_term) throws Exception {

		ResultSet rs = null;
		Conn conn = new Conn();
		String period_type = "0";

		String sql = "select isnull(period_type,0) period_type from contract_condition where contract_id='"
				+ proj_id + "'";
		rs = conn.executeQuery(sql);
		if (rs.next()) {
			period_type = rs.getString("period_type");

		}
		if (!"1".equals(start_term)) {
			period_type = "-1";
		}
		ToolUtil.closeRSOrConn(rs, conn);
		return period_type;
	}

	/**
	 * 精确到的小数位
	 * 
	 * @param proj_id
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String getRentScale(String proj_id) throws Exception {

		ResultSet rs = null;
		Conn conn = new Conn();
		String rentScale = "0";

		String sql = "select isnull(rentScale,0) rentScale from contract_condition where contract_id='"
				+ proj_id + "'";
		rs = conn.executeQuery(sql);
		if (rs.next()) {
			rentScale = rs.getString("rentScale");

		}

		ToolUtil.closeRSOrConn(rs, conn);
		return rentScale;
	}

	/**
	 * 偿还计划，租金间隔，年还款次数
	 * 
	 * @param proj_id
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Hashtable getChjg(String proj_id) throws Exception {
		String sql = "";
		String chjg = "0";
		String zjjg = "0";
		String nhkcs = "0";
		ResultSet rs = null;
		Conn conn = new Conn();
		Hashtable ht = new Hashtable();

		sql = "select isnull(income_number_year,0) chjg ,isnull(income_number_year,0) zjjg from contract_condition where contract_id='"
				+ proj_id + "'";
		rs = conn.executeQuery(sql);
		if (rs.next()) {
			chjg = rs.getString("chjg");
			zjjg = rs.getString("zjjg");
			ht.put("chjg", chjg);
			ht.put("zjjg", zjjg);
		}
		if (!"0".equals(chjg)) {
			nhkcs = String.valueOf(12 / Integer.parseInt(chjg));
		}
		ht.put("nhkcs", nhkcs);

		ToolUtil.closeRSOrConn(rs, conn);

		return ht;
	}

	/**
	 * 根据合同号得到 他的调息方式
	 * 
	 * @param contract_id
	 * @return
	 * @throws Exception
	 */
	public String getAdjustSty(String contract_id) throws Exception {

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;

		// 得到这个项目是不是普通的调息方式还是根据租金调整方式进行调息
		String sql = " select isnull(ajdustStyle,'') from dbo.contract_condition where contract_id='"
				+ contract_id + "' ";
		rs = conn.executeQuery(sql);
		String adjustStyle = "";
		if (rs.next()) {
			adjustStyle = rs.getString(1);
		}
		ToolUtil.closeRSOrConn(rs, conn);
		return adjustStyle;
	}

	/**
	 * 根据合同号得到 他的年利率
	 * 
	 * @param contract_id
	 * @return
	 * @throws Exception
	 */
	public String getYearRate(String contract_id) throws Exception {

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;

		// 得到这个项目是不是普通的调息方式还是根据租金调整方式进行调息
		String sql = " select isnull(year_rate,'0') year_rate from dbo.contract_condition where contract_id='"
				+ contract_id + "' ";
		rs = conn.executeQuery(sql);
		String year_rate = "0";
		if (rs.next()) {
			year_rate = rs.getString(1);
		}
		ToolUtil.closeRSOrConn(rs, conn);
		return year_rate;
	}

	/**
	 * 根据合同号得到 rate_float_type,lease_term,rate_float_amt
	 * 
	 * @param contract_id
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Hashtable getRateType(String contract_id) throws Exception {

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		Hashtable ht = new Hashtable();

		// 得到这个项目是不是普通的调息方式还是根据租金调整方式进行调息
		String sql = " select isnull(rate_float_type,'') rate_float_type,isnull(lease_term,0) lease_term,isnull(rate_float_amt,0) rate_float_amt from dbo.contract_condition where contract_id='"
				+ contract_id + "' ";
		rs = conn.executeQuery(sql);

		if (rs.next()) {
			ht.put("rate_float_type", rs.getString("rate_float_type"));
			ht.put("lease_term", rs.getString("lease_term"));
			ht.put("rate_float_amt", rs.getString("rate_float_amt"));
		}
		ToolUtil.closeRSOrConn(rs, conn);
		return ht;
	}

	/**
	 * 根据项目(合同)的id查询项目（合同）交易结构信息
	 * 
	 * @param proj_id
	 * @param term
	 *            从第几期开始算剩余本金
	 * @return
	 * @throws Exception
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public static Hashtable getProj_ConditionInfoByProj_id(String proj_id)
			throws Exception {

		// 数据库操作对象
		Conn conn = new Conn();
		ResultSet rs = null;
		String sql = " 	select convert(varchar(10),isnull(start_date,getdate()),120) start_date ,isnull(income_day,0) income_day, isnull(ajdustStyle,'') ajdustStyle,isnull(rentScale,0) rentScale,isnull(nominalprice,0) nominalprice,isnull(consulting_fee,0) consulting_fee,isnull(lease_money,0) lease_money,measure_type,(isnull(equip_amt,0)-isnull(first_payment,0)) equip_amt,rate_float_type,isnull(start_date,getdate()) start_date,isnull(caution_money,0) caution_money,isnull(year_rate,0) year_rate,isnull(handling_charge,0)handling_charge,isnull(lease_term,0)lease_term,isnull(income_number_year,0) income_number_year, isnull(income_number,0) income_number, period_type,isnull(rate_float_amt,0)rate_float_amt,isnull(delay,0) delay,isnull(grace,0) grace from contract_condition where contract_id='"
				+ proj_id + "'";

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
			hmp.put("start_date", rs.getString("start_date"));// 起租日期
			
			String newStartDate = rs.getString("start_date");
			//起租日期重新构建,将现有的起租日期的年月截取出来,再加上支付日
			if (rs.getString("start_date") != null && !"".equals(rs.getString("start_date"))) {
				newStartDate = rs.getString("start_date").substring(0,rs.getString("start_date").lastIndexOf("-"));
				newStartDate= newStartDate+"-"+rs.getString("income_day");
			}
			
			if (rs.getString("delay")!=null && !"".equals(rs.getString("delay")) && Integer.parseInt(rs.getString("delay"))>0 && (rs.getString("period_type")!=null && !"".equals(rs.getString("period_type")))) {
			//如果有延迟期,则加上延迟期考虑到期初,期末的概念
			newStartDate = Tools.dateAdd("month", Integer.parseInt(rs.getString("delay"))-Integer.parseInt(rs.getString("period_type")), newStartDate);
			}
			
			System.out.println("新的起租日是:"+newStartDate);
			hmp.put("start_date", newStartDate);// 起租日期

		}

		ToolUtil.closeRSOrConn(rs, conn);
		return hmp;

	}

}
