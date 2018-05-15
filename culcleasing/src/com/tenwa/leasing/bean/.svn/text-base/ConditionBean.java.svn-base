package com.tenwa.leasing.bean;


import java.util.Hashtable;


/**
 * 交易结构临时表，正式表数据查询 项目名称：iulcleasing 类名称：ConditionBean 类描述： 创建人：史鸿飞 创建时间：2011-2-9
 * 下午01:55:35 修改人：史鸿飞 修改时间：2011-2-9 下午01:55:35 修改备注：
 * 
 * @version
 */
public class ConditionBean {

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
	public static Hashtable getConditionInfoByTbName(String proj_id,
			String columnName, String docId, String docColumnName, String tbName)
			throws Exception {

		String sql = " 	select isnull(income_day,0) income_day, isnull(ajdustStyle,'') ajdustStyle,isnull(rentScale,0) rentScale,isnull(nominalprice,0) nominalprice,isnull(consulting_fee,0) consulting_fee,isnull(lease_money,0) lease_money,measure_type,isnull(equip_amt,0) equip_amt,rate_float_type,isnull(start_date,getdate()) start_date,isnull(caution_money,0) caution_money,isnull(year_rate,0) year_rate,isnull(handling_charge,0)handling_charge,isnull(lease_term,0)lease_term,isnull(income_number_year,0) income_number_year, isnull(income_number,0) income_number, period_type,isnull(rate_float_amt,0)rate_float_amt,isnull(delay,0) delay,isnull(grace,0) grace from "
				+ tbName
				+ " where "
				+ columnName
				+ "='"
				+ proj_id
				+ "' and "
				+ docColumnName + "='" + docId + "'";
		return CommBean.getSignBean(sql);
	}
}
